#!/usr/bin/perl -w

use strict;
use Bio::DB::EntrezGene;
use Bio::EnsEMBL::Registry;

my $id = '54806';
my $db = new Bio::DB::EntrezGene;
my $seq = $db->get_Seq_by_id($id);
my $ac = $seq->annotation;

my ($chr,$from,$to); 
for my $ann ($ac->get_Annotations('chromosome')) {
   $chr = $ann->value;
}
for my $ann ($ac->get_Annotations('dblink')) {
   if ($ann->database eq "Evidence Viewer") {
      # get the sequence identifier, the start, and the stop
      ($from,$to) = $ann->url =~ /from=(\d+)&to=(\d+)/;
   }
}
printf("chr%s %s..%s\n", $chr, $from, $to);

my $registry = 'Bio::EnsEMBL::Registry';

$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

my $slice_adaptor = $registry->get_adaptor( 'Human', 'Core', 'Slice' );

my $slice = $slice_adaptor->fetch_by_region( 'chromosome', $chr, $from - 100000, $to + 100000 );
print $slice->seq;

