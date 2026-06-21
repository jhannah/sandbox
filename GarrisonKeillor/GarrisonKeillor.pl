#! env perl

use 5.40.0;
use Template;
use POSIX qw(strftime);
use Time::Local qw(timegm);
use JSON::PP;

# The feed is driven entirely by the cached archive.org metadata (built by
# fetch_metadata.pl) -- every .mp3 across all the source items becomes an
# episode, so there is no hand-maintained track list. This generator never
# touches the network.
my $META = 'metadata.json';
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

# Gather every track from the metadata. The episode number (01-75) is the
# numeric prefix of each filename; the title is whatever follows, minus the
# "-Garrison Keillor.mp3" suffix.
my @records;
for my $folder (keys %$metadata) {
  for my $filename (keys %{ $metadata->{$folder} }) {
    # 01-Pontoon Boat-Garrison Keillor.mp3   /   13 Rotten Apples-Garrison Keillor.mp3
    my ($ep_number, $title) = split /[- ]/, $filename, 2;
    $title =~ s/\-Garrison Keillor\.mp3$//;
    push @records, {
      folder    => $folder,
      filename  => $filename,
      ep_number => $ep_number,
      title     => $title,
    };
  }
}

# Emit in episode-number order, attaching real size + runtime and a synthetic
# pub_date. We don't know the real per-track date, so stagger one day per
# episode from the base; players that sort by pubDate then keep episode order.
my @episodes;
for my $r (sort { $a->{ep_number} <=> $b->{ep_number} } @records) {
  my $epoch    = $base_epoch + ($r->{ep_number} - 1) * 86400;
  my $pub_date = strftime('%a, %d %b %Y %H:%M:%S +0000', gmtime($epoch));

  my $meta = $metadata->{ $r->{folder} }{ $r->{filename} };
  my $size     = $meta->{size};
  my $duration = defined $meta->{length} ? hms($meta->{length}) : "0:20:00";

  push @episodes, {
    filename  => $r->{filename},
    title     => $r->{title},
    pub_date  => $pub_date,
    ep_number => $r->{ep_number},
    folder    => $r->{folder},
    size      => $size,
    duration  => $duration,
  };
}

my $tt = Template->new({
  INTERPOLATE => 1,
}) || die "$Template::ERROR\n";

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
