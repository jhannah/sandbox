use strict;
use warnings;

use Bio::LocatableSeq;
use Bio::SimpleAlign;
use Bio::AlignIO;

my $aln = Bio::SimpleAlign->new();
my $seq = Bio::LocatableSeq->new(-id => 'testseq', -seq => 'CATGTAGATAG');
$aln->add_seq($seq);
$aln->get_seq_by_pos(1)->display_id("1");
my $outAln = Bio::AlignIO->new("-file" => ">test.fasta", "-format" => "fasta");
$outAln->write_aln($aln);

exit (0);
