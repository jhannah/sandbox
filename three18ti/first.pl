use strict;
use 5.10.0;

my @in = ('foo   1', 'bar       2');
my @out = map { /(\S+)/ } @in;

# Cleaner than these, ya?
#    map { ($_) = split/\s+/, }
#    map { (split/\s+/)[0] }

say "[" . (join "|", @out) . "]";


