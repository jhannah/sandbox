#! env perl

# One-time(ish) fetcher: pulls the archive.org item metadata once and caches
# the byte size + runtime of every .mp3 to metadata.json, so the feed generator
# (have_gun_will_travel.pl) never has to touch the network. Re-run this only
# when the episode list or the source item changes.
#
# Everything lives in a single archive.org item, so there are no folders to
# iterate (unlike the GarrisonKeillor project's fetcher).

use 5.40.0;
use HTTP::Tiny;
use JSON::PP;

my $ITEM = 'OTRR_Have_Gun_Singles';   # matches per_ep_root_url in the generator
my $OUT  = 'metadata.json';

my $url = "https://archive.org/metadata/$ITEM";
say "Fetching $url";
my $res = HTTP::Tiny->new->get($url);
die "  Failed: $res->{status} $res->{reason}\n" unless $res->{success};

my $data = decode_json($res->{content});
my %meta;   # filename => { size => N, length => secs }
for my $f (@{ $data->{files} || [] }) {
  next unless ($f->{name} // '') =~ /\.mp3$/i;
  $meta{ $f->{name} } = { size => $f->{size}, length => $f->{length} };
}
say scalar(keys %meta) . " mp3 file(s)";

open my $out, '>', $OUT or die "Can't write $OUT: $!\n";
print $out JSON::PP->new->utf8->canonical->pretty->encode(\%meta);
close $out;
say "Wrote $OUT";
