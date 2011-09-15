#!/usr/bin/perl

use strict;
use warnings;

use Bio::SearchIO;

my ($blast_file) = shift @ARGV;

my $search_io = Bio::SearchIO->new(-file   => $blast_file,
                                   -format => 'blasttable') or die "Blast file parsing failed.";

while (my $result = $search_io->next_result) {
   print $result->query_length, "\n";
}




