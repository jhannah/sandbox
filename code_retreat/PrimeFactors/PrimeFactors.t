use strict;
use warnings;
use Test::More;
use PrimeFactors;

ok(my $p = PrimeFactors->new());
my %expect = (
   1     => [],
   2     => [2],
   3     => [3],
   4     => [2,2],
   6     => [2,3],
   9     => [3,3],
   12564 => [2,2,3,3,349],
);
foreach my $e (sort numerically keys %expect) {
   is_deeply($p->generate($e), $expect{$e}, "primes of $e");
} 

sub numerically { $a <=> $b };

done_testing();

