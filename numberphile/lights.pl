#! env perl

# The Light Switch Problem - Numberphile
# https://www.youtube.com/watch?v=-UBDRX6bk-A

use 5.36.0;

my @state;
for (0..99) {
  $state[$_] = 1;
}
say join "", @state;

foreach my $p (2..100) {    # person
  foreach my $s (0..99) {  # switch
    unless ($s % $p) {
      $state[$s - 1] =~ tr/01/10/;
    }
  }
  say join "", @state;
}
