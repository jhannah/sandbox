#!/usr/bin/perl -w

use strict;
use Bio::Perl;
use Bio::DB::EntrezGene;
use Bio::DB::GenBank;
use Bio::SeqIO;

my $id = '54806';
my $db = new Bio::DB::EntrezGene;
my $seq = $db->get_Seq_by_id($id);
my $ac = $seq->annotation;

my ($contig,$from,$to); 
for my $ann ($ac->get_Annotations('dblink')) {
	if ($ann->database eq "Evidence Viewer") {
                # get the sequence identifier, the start, and the stop
		($contig,$from,$to) = $ann->url =~ 
		  /contig=([^&]+).+from=(\d+)&to=(\d+)/;
	}
}
printf("Contig: %s %s..%s\n", $contig, $from, $to);



# Start Bio::SeqIO factory
my $outfile = Bio::SeqIO->new(-file => '> temp.txt',
                           -format => 'genbank');
my @seqs = ();
my $strand = 1;
# Below is from Bio::DB::GenBank POD, with some modifications
my $factory = Bio::DB::GenBank->new(-format => 'genbank',
                               -seq_start => $from,    # X bp upstream
                               -seq_stop => $to,       # X bp downstream
                               -strand => $strand,     # 1=plus, 2=minus
                              );
my $seqin = $factory->get_Seq_by_acc($contig);
# store away files
$outfile->write_seq($seqin);
# may take lots of memory if you have many seqfeatures
push @seqs, $seqin; 
sleep 3;  # don't irritate NCBI

 
# from HOWTO:Feature-Annotation; gives seq annotation
foreach my $seq (@seqs) { 
    print $seq->accession_number,"\t",
           $seq->length,"\n"; 
    for my $feat_object ($seq->get_SeqFeatures) {
        next unless $feat_object->primary_tag eq "CDS";
        print "primary tag: ", $feat_object->primary_tag, "\n";          
            for my $tag ($feat_object->get_all_tags) {             
            print "  tag: ", $tag, "\n"; 
                for my $value ($feat_object->get_tag_values($tag)) {                
                print "    value: ", $value, "\n";             
            }          
        }       
    }
}

