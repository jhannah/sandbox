package q1;

use strict;

sub hibachi {
   my ($n) = @_;
   my @series = (2,2,2);
   while (@series < $n) {
      push @series, ($series[-1] * $series[-2] * $series[-3]);
   }
   return @series;
}

1;
