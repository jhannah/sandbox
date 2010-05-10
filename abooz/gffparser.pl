use Bio::FeatureIO::gff;
use Bio::SeqFeature::Annotated;
open($fh,"chr01_Canonical.gff3") or die "can't open file $!";

my $featureOut = Bio::FeatureIO->new(
    -format => 'gff',
    -version => 3,
    -fh => $fh,
    -validate_terms => 0, #boolean. validate ontology terms online?  default 0 (false).
  );
#@features= $featureOut->next_feature_group;
my @toplevel_features;
           while (my @fg = $featureOut->next_feature_group) {
               push(@toplevel_features, @fg);
           }
print @toplevel_features;



