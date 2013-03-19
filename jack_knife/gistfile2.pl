use strict;
use warnings;
 
use HTML::TreeBuilder::XPath;
 
my $url = "http://www.m.yahoo.com";
 
my $tree = HTML::TreeBuilder::XPath->new_from_url($url);
 
my $anchor = $tree->findnodes('//*[@id="defaultFooter"]/div/div[4]/a[2]/@href');
print $anchor->[0]->getValue;

