#!/usr/bin/perl

use IPC::Open3;

print "child here\n";
open3(\*CHLD_IN, my $output, \*CHLD_ERR, "df -k 2>&1");
while (<$output>) {
   print $_;
}


