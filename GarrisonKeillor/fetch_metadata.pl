#! env perl

# One-time(ish) fetcher: reads the folder (archive.org item) list from
# tracks.txt, pulls each item's metadata from archive.org once, and caches the
# byte size + runtime of every .mp3 to metadata.json. Re-run only when the
# track list changes. GarrisonKeillor.pl then reads metadata.json offline.

use 5.40.0;
use HTTP::Tiny;
use JSON::PP;

my $TRACKS = 'tracks.txt';
my $OUT    = 'metadata.json';

# Unique folders, in first-seen order, from the track list.
open my $fh, '<', $TRACKS or die "Can't read $TRACKS: $!\n";
my (@folders, %seen);
while (<$fh>) {
  chomp;
  next unless /\w/;
  my ($folder) = split m{/}, $_, 2;
  push @folders, $folder unless $seen{$folder}++;
}
close $fh;

my $http = HTTP::Tiny->new;
my %meta;   # folder => { filename => { size => N, length => secs } }
for my $folder (@folders) {
  my $url = "https://archive.org/metadata/$folder";
  say "Fetching $url";
  my $res = $http->get($url);
  die "  Failed: $res->{status} $res->{reason}\n" unless $res->{success};
  my $data = decode_json($res->{content});
  my $n = 0;
  for my $f (@{ $data->{files} || [] }) {
    next unless ($f->{name} // '') =~ /\.mp3$/i;
    $meta{$folder}{ $f->{name} } = { size => $f->{size}, length => $f->{length} };
    $n++;
  }
  say "  $n mp3 file(s)";
}

open my $out, '>', $OUT or die "Can't write $OUT: $!\n";
print $out JSON::PP->new->canonical->pretty->encode(\%meta);
close $out;
say "Wrote $OUT";
