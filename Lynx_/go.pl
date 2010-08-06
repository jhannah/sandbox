#!/usr/bin/perl -w
use strict;
use warnings;
use Bio::Index::Blast;

my $file = shift;


print STDERR "Indexing blast files.\n";
my $indexfile = $file . ".index";
my $index
    = Bio::Index::Blast->new( -filename => $indexfile, -write_flag => 1 );

$index->make_index($file);

my $result = $index->fetch_report('kb8_rep_c2');
my $id = $result->query_name();

print "$id\n";

