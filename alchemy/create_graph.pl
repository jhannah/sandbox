use strict;
use 5.10.0;
use GraphViz;

my $g = GraphViz->new(
   rankdir => 1,    # left to right instead of top to bottom
);
open my $out, '>', 'alchemy.png' or die;

my $cnt;
open my $in, '<', 'combinations.txt' or die;
<$in>; <$in>;  # discard headers
while (<$in>) {
   chomp;
   s/\d+\. +//;
   tr/A-Z/a-z/;
   my ($result, $terms) = split / *= */;
   my @terms = split / *\+ */, $terms;
   say "[$result] = [" . (join '],[', @terms) . "]";
   $g->add_node($result);
   foreach my $term (@terms) {
      $g->add_node($term);
      $g->add_edge($term => $result);
   }
   # last if ($cnt++ == 100);
}

print $out $g->as_png;


