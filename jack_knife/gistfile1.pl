use strict;
use warnings;
 
use HTML::TreeBuilder::XPath;
 
my $url = "http://www.youtube.com/results?search_query=run+flo+rida";
 
my $tree = HTML::TreeBuilder::XPath->new_from_url($url);
 
my $anchor = $tree->findnodes('//ol[@id="search-results"]//h3[@class="yt-lockup2-title"]/a/@href');
print $anchor->[0]->getValue;

