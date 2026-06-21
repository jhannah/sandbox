#! env perl

use 5.40.0;
use Template;
use POSIX qw(strftime);
use Time::Local qw(timegm);
use JSON::PP;

# Track list and cached archive.org metadata are the two inputs. The metadata
# (byte size + runtime per file) is fetched separately by fetch_metadata.pl so
# this generator never touches the network. Re-run fetch_metadata.pl whenever
# tracks.txt changes.
my $TRACKS = 'tracks.txt';
my $META   = 'metadata.json';

open my $mfh, '<', $META
  or die "Can't read $META: $! (run ./fetch_metadata.pl first)\n";
my $metadata = decode_json(do { local $/; <$mfh> });
close $mfh;

# Placeholder base date: noon UTC on 1989-01-01. Noon (not midnight) so that
# converting to a US timezone can't roll the displayed date back a day.
my $base_epoch = timegm(0, 0, 12, 1, 0, 1989 - 1900);

# Format seconds as H:MM:SS (or M:SS when under an hour) for itunes:duration.
sub hms {
  my ($secs) = @_;
  $secs = int($secs + 0.5);
  my ($h, $m, $s) = (int($secs / 3600), int(($secs % 3600) / 60), $secs % 60);
  return $h ? sprintf('%d:%02d:%02d', $h, $m, $s) : sprintf('%d:%02d', $m, $s);
}

my $tt = Template->new({
  INTERPOLATE => 1,
}) || die "$Template::ERROR\n";

my @episodes;
open my $tfh, '<', $TRACKS or die "Can't read $TRACKS: $!\n";
while (<$tfh>) {
  chomp;
  next unless /\w/;
  # GarrisonKeillor-MoreNewsFromLakeWobegon/01-Pontoon Boat-Garrison Keillor.mp3
  my ($folder, $filename) = split m{/}, $_, 2;
  my ($ep_number, $title) = split /[- ]/, $filename, 2;
  $title =~ s/\-Garrison Keillor\.mp3$//;

  # We don't actually know the real date per track. Stagger one day per episode
  # from the base so players that sort by pubDate keep them in episode order.
  my $epoch = $base_epoch + ($ep_number - 1) * 86400;
  my $pub_date = strftime('%a, %d %b %Y %H:%M:%S +0000', gmtime($epoch));

  # Real byte size and runtime from the cached archive.org metadata.
  my $meta = $metadata->{$folder}{$filename};
  warn "No cached metadata for $folder/$filename\n" unless $meta;
  my $size     = $meta ? $meta->{size} : 0;
  my $duration = ($meta && defined $meta->{length}) ? hms($meta->{length}) : "0:20:00";

  push @episodes, {
    filename  => $filename,
    title     => $title,
    pub_date  => $pub_date,
    ep_number => $ep_number,
    folder    => $folder,
    size      => $size,
    duration  => $duration,
  };
}
close $tfh;

my $vars = {
  title      => 'Garrison Keillor Archive - News from Lake Wobegon',
  owner_name => 'Garrison Keillor',
  # Drew didn't unload any square image I can use. Podcast players need square images.
  # So use this square image from another Internet Archive uploader:
  image      => 'https://archive.org/download/garrison-keillor/Garrison%20Keillor.png',
  link       => 'https://archive.org/details/GarrisonKeillor-MoreNewsFromLakeWobegon',
  summary    => 'Thanks to my fiance\'s spectacular (and nearly all out of print) Garrison Keillor audio collection, we thus begin a series of Garrison Keillor Archives from 1989. Contains many excellent and classic recitations by Mr. Keillor. Internet Archive\'d by Drew Evan Dobbs.',
  per_ep_root_url => 'https://archive.org/download',
  episodes   => [ @episodes ],
};

$tt->process('feed.rss.tt', $vars, 'GarrisonKeillor.rss')
  || die $tt->error(), "\n";
