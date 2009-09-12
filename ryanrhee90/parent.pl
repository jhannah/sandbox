#!/usr/bin/perl

use IPC::Open3;

print "launching child\n";
open3(\*CHLD_IN, my $output, \*CHLD_ERR, "perl child.pl 2>&1");
while (<$output>) {
   print $_;
}


