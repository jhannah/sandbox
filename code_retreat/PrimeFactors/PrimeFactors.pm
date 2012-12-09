package PrimeFactors;
use Moose;

sub generate {
   my ($self, $num) = @_;
   my @rval;
   my $candidate = 2;
   while ($num > 1) {
      while ($num % $candidate == 0) {
         push @rval, $candidate;
         $num /= $candidate;
      }
      $candidate++;
   }
   if ($num > 1) {
      push @rval, $num;
   }
   return [ sort numerically @rval ];
}

sub numerically { $a <=> $b };
1;

