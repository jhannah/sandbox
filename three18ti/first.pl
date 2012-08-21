use strict;
use 5.10.0;

my @in = ('foo   1', 'bar       2');
my @out = map { /(\S+)/ } @in;
say "[" . (join "|", @out) . "]";
 
