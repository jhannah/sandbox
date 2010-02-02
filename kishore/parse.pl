use strict;
use Bio::SearchIO; 
my $in = new Bio::SearchIO(-format => 'blast', 
                           -file   => 'blastout.txt');
while( my $result = $in->next_result ) {
  ## $result is a Bio::Search::Result::ResultI compliant object
  while( my $hit = $result->next_hit ) {
    print "---NEW HIT---\n";
    ## $hit is a Bio::Search::Hit::HitI compliant object
    while( my $hsp = $hit->next_hsp ) {
      ## $hsp is a Bio::Search::HSP::HSPI compliant object
      if( $hsp->length('total') > 50 ) {
        if ( $hsp->percent_identity >= 75 ) {
          print 
            "Query=",             $result->query_name,        "\n",
            "Hit=",               $hit->name,                 "\n",
            "Length=",            $hsp->length('total'),      "\n",
            "Percent_id=",        $hsp->percent_identity,     "\n",
            "fraq_identical=",    $hsp->frac_identical,       "\n",
            "hit_description=",   $hit->description,          "\n",
            "query_description=", $result->query_description, "\n",
            "query_string=   ",   $hsp->query_string,         "\n",
            "homology_string=",   $hsp->homology_string,      "\n",
            "hit_string=     ",   $hsp->hit_string,           "\n",
            "\n\n";
        }
      }
    }  
  }
}

