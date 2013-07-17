use strict;
use Bio::SeqIO;

my $seqin = Bio::SeqIO->new(-file   => "sample.fasta", 
                            -format => "fasta");

while (my $seq = $seqin->next_seq) {
    my ($dbSNP) = ($seq->desc =~ / dbSNP:(\d+)/);
    printf "%s %s %s\n", 
        $seq->id, $dbSNP, $seq->seq;
}


__END__

0  Bio::Seq=HASH(0x7f8cb99d42a8)
   'primary_id' => 0000000069
   'primary_seq' => Bio::PrimarySeq=HASH(0x7f8cb9cd3340)
      'alphabet' => 'protein'
      'desc' => '| XR_017086 | 27..86 | | .. | dbSNP:116484317 | 55 | T/I | ?'
      'display_id' => 0000000069
      'length' => 20
      'primary_id' => 0000000069
      'seq' => 'PWPLWKCTRTAGRFLFFLRG'

