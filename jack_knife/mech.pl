use 5.12.1;
use WWW::Mechanize;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;
use Data::Dumper;
binmode(STDOUT, ":utf8");

#initialiZe objects
my $tree= HTML::TreeBuilder::XPath->new();
my $mech = WWW::Mechanize->new();

my $page = $mech->get("http://m.yahoo.com");
# say Dumper $mech->content();
$tree->parse_content( $mech->content() ) or die $!;
# say $tree->as_XML_indented;

# my $url = $tree->find('//*[@id="defaultFooter"]/div/div[4]/a[1]');
say Dumper $tree->findnodes('//*[@id="defaultFooter"]/div/div[4]');
# say Dumper $url;


