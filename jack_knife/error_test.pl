use strict;
use warnings;
 
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
 
my $mech = WWW::Mechanize->new();
my $tree= HTML::TreeBuilder::XPath->new();
 
  			my $page = $mech->get("http://yahoo.com");
				my $num = int(rand(80)) + 8;
				#print $mech->content;
				my $parsed = $tree->parse( $mech->content );
				print $parsed;
				#print Dumper $parsed;
				my $anchor = $parsed->findnodes('/html/body/div[2]/div[2]/div[2]/a[1]/');
				print $anchor->[1]->getValue;


