use 5.12.1;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Data::Dumper;
 
my $mech = WWW::Mechanize->new();
 
my $page = $mech->get("http://www.bbc.co.uk/news/uk-politics-21847226");
my $content = $mech->content;		 
my $tree = HTML::TreeBuilder::XPath->new_from_content($content);
my $src = $tree->findnodes( '//*[@id="main-content"]/div[2]/div[1]/div[2]/img/@src');
say $src->[0]->getValue;


