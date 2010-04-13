use Bio::SeqIO;

my $in = Bio::SeqIO->new(-file=>"NP_032443.gbk", -format=>"genbank");
my $seq = $in->next_seq;
print $seq->species->species;


