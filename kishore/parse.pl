use strict;
use Bio::SearchIO; 
my $in = new Bio::SearchIO(-format => 'blast', 
                           -file   => 'blastout.txt');
while( my $result = $in->next_result ) {
  ## $result is a Bio::Search::Result::ResultI compliant object
  while( my $hit = $result->next_hit ) {
    ## $hit is a Bio::Search::Hit::HitI compliant object
    while( my $hsp = $hit->next_hsp ) {
      ## $hsp is a Bio::Search::HSP::HSPI compliant object
      if( $hsp->length('total') > 50 ) {
        if ( $hsp->percent_identity >= 75 ) {
          print "Query=",   $result->query_name,
            " Hit=",        $hit->name,
            " Length=",     $hsp->length('total'),
            " Percent_id=", $hsp->percent_identity,
            " fraq_identical=", $hsp->frac_identical, "\n";
        }
      }
    }  
  }
}

