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
# say $mech->content();
# say "-" x 50;
$tree->parse_content( $mech->content() ) or die $!;

# my $url = $tree->find('//*[@id="defaultFooter"]/div/div[4]/a[1]');
foreach my $subtree ($tree->findnodes('//*[@id="defaultFooter"]//*[@href]')) {
   # say $subtree->as_XML_indented;

   # So now we call HTML::Element methods on this tree...
   # e.g.: https://metacpan.org/module/HTML::Element#attr
   say $subtree->attr('href');
   say "-" x 50;
}


