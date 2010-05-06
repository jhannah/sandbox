use Bio::FeatureIO::gff;
use Bio::SeqFeature::Annotated;
open($fh,"test.gff");

my $featureOut = Bio::FeatureIO->new(
    -format => 'gff',
    -version => 3,
    -fh => $fh,
    -validate_terms => 0, #boolean. validate ontology terms online?  default 0 (false).
  );
my $feature = $featureOut->next_feature;
print $feature->type()."\n";
print $feature->seq_id()."\n";

