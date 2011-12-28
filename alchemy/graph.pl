use strict;
use 5.10.0;

open my $in, '<', 'combinations.txt' or die;
<$in>; <$in>;  # discard headers
while (<$in>) {
   chomp;
   s/\d+\. +//;
   my ($result, $terms) = split / *= */;
   my @terms = split / *\+ */, $terms;
   say "[$result] = [" . (join '],[', @terms) . "]";
}

