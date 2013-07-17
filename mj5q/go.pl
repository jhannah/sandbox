# Quick demo for Maximilian JamesonLee <jamesonleem@vcu.edu>
use strict;
use Bio::SeqIO;

# Memorize all rsids
# These files should be small-ish, always fit in available RAM
my $all_rsids = {};
my $file = "7R.MDR.SNP130_dropped.txt";
open my $in, $file, or die "Can't open $file";
while (<$in>) {
   chomp;
   my @line = split /\t/;
   my $rsid = $line[1];
   $rsid =~ s/rs//;
   $all_rsids->{$rsid} = \@line;
}
my @keys = sort { $a <=> $b } keys %$all_rsids;
printf "We have memorized %d rsids, from '%d' to '%d'\n",
    scalar(@keys),
    shift @keys,
    pop @keys;
    

# Scan a fasta file (several GBs)
my $seqin = Bio::SeqIO->new(-file   => "sample_fasta_file.txt", 
                            -format => "fasta");
while (my $seq = $seqin->next_seq) {
    my ($dbSNP) = ($seq->desc =~ / dbSNP:(\d+)/);
    printf "%s %s %s\n", 
        $dbSNP, $seq->id, $seq->seq;
    if ($all_rsids->{$dbSNP}) {
        printf "Found a match! %s %s %s\n", 
            $seq->id, $dbSNP, $seq->seq;
    }
}


__END__

Here's what a $seq looks like in the debugger:

0  Bio::Seq=HASH(0x7f8cb99d42a8)
   'primary_id' => 0000000069
   'primary_seq' => Bio::PrimarySeq=HASH(0x7f8cb9cd3340)
      'alphabet' => 'protein'
      'desc' => '| XR_017086 | 27..86 | | .. | dbSNP:116484317 | 55 | T/I | ?'
      'display_id' => 0000000069
      'length' => 20
      'primary_id' => 0000000069
      'seq' => 'PWPLWKCTRTAGRFLFFLRG'

