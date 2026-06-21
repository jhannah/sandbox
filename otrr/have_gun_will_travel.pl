#! env perl

use 5.40.0;
use Template;
use JSON::PP;
use Encode qw(encode_utf8);
use POSIX qw(strftime);
use Time::Local qw(timegm);

# The feed is driven entirely by the cached archive.org metadata (built by
# fetch_metadata.pl) -- every .mp3 in the item becomes an episode. decode_json
# returns filenames as character strings, so re-encode the keys to UTF-8 bytes;
# the rest of this program works in bytes (the em-dash in "Have Gun—Will Travel"
# is multi-byte), which is also what gets written to the feed.
my $META = 'metadata.json';
open my $mfh, '<', $META
  or die "Can't read $META: $! (run ./fetch_metadata.pl first)\n";
my $raw = decode_json(do { local $/; <$mfh> });
close $mfh;
my %meta = map { encode_utf8($_) => $raw->{$_} } keys %$raw;

# YYYY-MM-DD -> epoch at noon UTC (noon so a US-timezone conversion can't roll
# the displayed date back a day). Full 4-digit year: Time::Local maps 0-99 via a
# sliding window (58 would become 2058), but treats >=1000 as a literal year.
sub iso_to_epoch {
  my ($iso) = @_;
  my ($y, $m, $d) = split /-/, $iso;
  return timegm(0, 0, 12, $d, $m - 1, $y);
}

# epoch -> the RFC 822 date string RSS requires.
sub rfc822 {
  return strftime('%a, %d %b %Y %H:%M:%S +0000', gmtime shift);
}

# Seconds -> H:MM:SS for itunes:duration.
sub hms {
  my $s = int($_[0] + 0.5);
  return sprintf '%d:%02d:%02d', int($s / 3600), int(($s % 3600) / 60), $s % 60;
}

# Pull (iso_date, episode_number, title) out of a filename. Three shapes:
#   1. dated broadcast: "Have Gun—Will Travel 1958-11-23 (001) Strange Vendetta.mp3"
#   2. numbered extra:  "00 OTRR Introduction.mp3" (intro/synopsis/biographies)
#   3. bare name:       "Ben Wright Biography.mp3"
# Only shape 1 has a real broadcast date and episode number.
sub parse_filename {
  my ($filename) = @_;
  if (my ($iso, $num, $title) = $filename =~ /Have Gun—Will Travel ([\d-]+) \((\d+)\) (.+)\.mp3$/) {
    $num =~ s/^0+(?=\d)//;   # 001 -> 1, 000 -> 0
    return ($iso, $num, $title);
  }
  if (my ($title) = $filename =~ /^\d+\s+(.+)\.mp3$/) {
    return (undef, undef, $title);
  }
  (my $title = $filename) =~ s/\.mp3$//;
  return (undef, undef, $title);
}

# Build a record per file. Dated files get their real broadcast epoch; the
# dateless extras are assigned sequential pre-series dates below so they sort
# ahead of the broadcasts in podcast players (which order by pubDate).
my @records;
for my $filename (keys %meta) {
  my ($iso, $num, $title) = parse_filename($filename);
  push @records, {
    filename  => $filename,
    title     => $title,
    ep_number => $num,
    epoch     => defined $iso ? iso_to_epoch($iso) : undef,
  };
}

# Assign the dateless extras dates starting 1958-10-01 (well before the first
# broadcast), one day apart, in filename order so the intro/synopsis/bios lead.
my $extra_epoch = timegm(0, 0, 12, 1, 9, 1958);
for my $r (sort { $a->{filename} cmp $b->{filename} } grep { !defined $_->{epoch} } @records) {
  $r->{epoch} = $extra_epoch;
  $extra_epoch += 86400;
}

# Emit in chronological order, attaching real size + runtime from the metadata.
my @episodes;
for my $r (sort { $a->{epoch} <=> $b->{epoch} } @records) {
  my $m = $meta{ $r->{filename} };
  push @episodes, {
    filename  => $r->{filename},
    title     => $r->{title},
    ep_number => $r->{ep_number},
    pub_date  => rfc822($r->{epoch}),
    size      => $m->{size},
    duration  => hms($m->{length}),
  };
}

my $tt = Template->new({
  # INCLUDE_PATH => 'templates',
  INTERPOLATE  => 1,
}) || die "$Template::ERROR\n";

my $vars = {
  title      => 'Have Gun Will Travel',
  owner_name => 'Old-Time Radio Researchers',
  image      => 'https://archive.org/download/OTRR_Maintained_Have_Gun_Will_Travel/OTRR_Maintained_Have_Gun_Will_Travel.jpg',
  link       => 'https://www.otrr.org/',
  summary    => 'Radio program that aired 1958-1960. Long description here: https://archive.org/details/OTRR_Maintained_Have_Gun_Will_Travel',
  per_ep_root_url => 'https://archive.org/download/OTRR_Have_Gun_Singles',
  episodes   => [ @episodes ],
};

$tt->process('feed.rss.tt', $vars, 'have_gun_will_travel.rss')
  || die $tt->error(), "\n";
