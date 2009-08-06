use strict;
use Bio::SeqIO;
 
my $format = shift;
die "No format specified" unless $format;
 
my $seqin = Bio::SeqIO->new(-fh => \*STDIN,
                             -format => $format);
 
while(my $seqObj = $seqin-> next_seq){
        for my $featObj ($seqObj->get_SeqFeatures) {
                print "primary tag: ", $featObj->primary_tag, "\n";
                for my $tag ($featObj->get_all_tags) {
                        print " tag: ", $tag, "\n";
                        for my $value
                                ($featObj->get_tag_values($tag)) {
                                print " value: ", $value, "\n";
                        }
                }
        }
}

