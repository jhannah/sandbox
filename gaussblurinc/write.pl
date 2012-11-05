use strict; 
use warnings;
use 5.10.0;

open my $fh, ">", "$ENV{HOME}/txt/file.txt" or die $!;
say $fh "hi" or die;

