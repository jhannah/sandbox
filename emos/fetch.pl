use Bio::Perl;

my $out = Bio::SeqIO->new(-format => 'fasta', -file => '>out.fasta');
foreach my $id (qw( DISC1 ACE ACTC )) {
   my $seq = get_sequence('refseq', $id);
   $out->write_seq($seq);
}

