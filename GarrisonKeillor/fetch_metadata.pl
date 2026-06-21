#! env perl

# One-time(ish) fetcher: pulls each archive.org item's metadata once and caches
# the byte size + runtime of every .mp3 to metadata.json, keyed by folder. The
# generator (GarrisonKeillor.pl) then reads metadata.json offline and builds the
# whole feed from it -- there is no hand-maintained track list. Re-run this only
# when the set of source items changes.

use 5.40.0;
use HTTP::Tiny;
use JSON::PP;

# The archive.org items (download folders) that make up the feed, in order. The
# per-track episode numbers (01-75) are embedded in the filenames within these.
my @folders = qw(
  GarrisonKeillor-MoreNewsFromLakeWobegon
  GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet
  GarrisonKeillorArchiveVol.03-GospelBirdsPt2
  GarrisonKeillorArchive04-20thAnniversary-4-CDset
  GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1
  GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes
);

my $OUT = 'metadata.json';

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
print $out JSON::PP->new->utf8->canonical->pretty->encode(\%meta);
close $out;
say "Wrote $OUT";
