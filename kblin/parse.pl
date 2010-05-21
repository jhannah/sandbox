use Bio::SearchIO;
use Data::Dumper;

my $sHMMFilename = 'new.hmm';

     # Open HMMer-Report
      my $oHMMReport = Bio::SearchIO->new ('-file'     =>  $sHMMFilename,
                                           '-format'   =>  'hmmer');
      # Cycle through results
      while (my $oHMMResult=$oHMMReport->next_result) {
        print "processing ", Dumper(\$oHMMResult) ,"\n";
        while (my $oHMMerHit=$oHMMResult->next_hit) {
          print "processing $oHMMerHit\n";
          while (my $oHMMerHsp=$oHMMerHit->next_hsp) {
            print "processing $oHMMerHsp\n";

            # Skip hit if it has a too high E-value or too low score
            if (($oHMMerHsp->evalue > $fEvalue) or
                ($oHMMerHsp->score < $fScore)) {
              next;
            }

            if ($bVerbose) {
              print "processing $sHMMFilename\n";
            }
          }
        }
      }

print "done.\n";
