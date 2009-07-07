use Bio::Perl;

my $out = Bio::SeqIO->new(-format => 'fasta', -file => '>out.fasta');
foreach my $id (qw( ENSG00000162946 )) {
   my $seq = get_sequence('embl', $id);
   $out->write_seq($seq);
}

