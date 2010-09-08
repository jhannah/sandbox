use strict;
use warnings;

open my $in, "input.txt" or die;
my @entry;
while (<$in>) {
   chomp;
   # print "[$_]\n";
   last if /^#!#END$/;
   push @entry, $_;
}

print join "\n", @entry;
print "\n";

