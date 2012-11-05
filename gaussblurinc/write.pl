use strict; 
use warnings;
use 5.10.0;

my $home = `echo ~`;
chomp $home;
my $file = "$home/txt/file.txt";
say "Writing $file...";
open my $fh, ">", $file or die $!;
say $fh "hi" or die;

