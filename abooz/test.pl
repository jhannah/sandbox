use Bio::FeatureIO::gff;
use Bio::SeqFeature::Annotated;
open($fh,"test.gff");

my $featureIn = Bio::FeatureIO->new(
    -format => 'gff',
    -version => 3,
    -fh => $fh,
    -validate_terms => 0, #boolean. validate ontology terms online?  default 0 (false).
  );

while (my $feat_object = $featureIn->next_feature) {
   print "primary tag: ", $feat_object->primary_tag, "\n";          
   for my $tag ($feat_object->get_all_tags) {             
      print "  tag: ", $tag, "\n";             
      for my $value ($feat_object->get_tag_values($tag)) {                
         print "    value: ", $value, "\n";             
      }          
   }  
}


