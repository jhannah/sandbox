#!/usr/bin/perl 
use strict;
use warnings;
use LWP::Simple;
use DBI;
use Bio::DB::GenPept;
use Bio::DB::Taxonomy;
use Bio::Seq;
use Bio::DB::EUtilities;
use Bio::DB::Taxonomy::entrez;


my $gpeptfactory;
# http://www.ncbi.nlm.nih.gov/nuccore/33090006
my @genbank_na_acc = qw(AY331142);   # NOPE
@genbank_na_acc = qw(33090006);      # YES
my $j = scalar @genbank_na_acc;
my $retry = 0;
my $file2 = 'na_data.gb';
my $file3 = 'code_test.txt';
my $retmax;
my $retstart;
my $history;


RETRIEVE_FOR_NA: system("rm $file3\n"); #na_data.gb




eval{
	$gpeptfactory = Bio::DB::EUtilities->new(
			-eutil => 'epost',
			-db => 'nuccore',
			-rettype => 'gbwithparts',
			-retmode => 'text',
			-tool    => 'VKCDB_Update',
			-email   => 'pat.boutet@gmail.com',
			-id => \@genbank_na_acc,
			-keep_histories => 1,
			);
	
};
 if ($@) {
        die "Server error on na post: $@.  Try again later" if $retry == 5;
        print STDERR "$@\n";
        print STDERR "Server error on na post, redo #$retry\n";
        $retry++;
        sleep(5);
        goto RETRIEVE_FOR_NA;
    }

    
    
    if ($history = $gpeptfactory->next_History) {
    print "Posted successfully\n";
    print "WebEnv    : ",$history->get_webenv,"\n";
    print "Query_key : ",$history->get_query_key,"\n";
}
    


    $gpeptfactory = Bio::DB::EUtilities->new(
						 -eutil => 'efetch',
                         -db => 'nuccore',
                         -tool    => 'VKCDB_Update',
        				 -email   => 'pat.boutet@gmail.com',
                         -rettype => 'gbwithparts',
                         -retmode => 'text',
                         -history => $history,
                         );
                         
#print "Finished efetch of records.\n";

$retry = 0; 
( $retmax, $retstart ) = ( 100, 0 );

#retrieve the results in blocks of 100 records to avoid overloading the servers
GITEST:while ($retstart < $j){
	
$gpeptfactory -> set_parameters(
				-retstart => $retstart,
                -retmax => $retmax,
				-rettype => 'gbwithparts',
                -retmode => 'text',
);


#This evaluation is set up to allow the script to try to get the results 5X since the
#server or the transfer can fail easily and otherwise the script stops with an error

RETRIEVE_NA_SEQS:
eval {$gpeptfactory->get_Response (-file => $file2)};

if ($@) {
    die "Server error on na record retrieve: $@.  Try again later" if $retry == 5;
    print STDERR "$@\n";
    print STDERR "Server error on na record retrieve, redo #$retry\n";
    $retry++;
    system ("rm $file2\n");
    sleep(5);
    goto GITEST;
}

#Once the results are successfully retrieved the contents of the temporary holding file
#$file2 are read in and written to the file that holds the complete results of
#the search, $file.

else {
	my $top = $retmax + $retstart;
    print "NA record retrieve successful for records $retstart to $top.\n";
    open( TEMP, "$file2" ) || die "Can not open $file2.\n";
            while (<TEMP>) {
                if (/temporarily unavailable/si) {
                    close TEMP;
                    goto GITEST;
                }
            }
            close TEMP;
            my $retend = $retstart + $retmax - 1;
            open (TEMP, "$file2")|| die "Can not open the temporary buffer file $file2.\n";
            open( DATA, ">>$file3" )    || die "Can not open $file3.\n";
            while (<TEMP>) {
                print DATA $_;
            }
            close DATA;
            close TEMP;

            print "Loaded entries $retstart through $retend on retry #$retry.\n";

            $retstart += $retmax;
            $retry = 0;
}

}


print "Finished Eutilities nucleic acid record recovery.\n";
       
print "end of script";


