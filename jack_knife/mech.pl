use warnings;
use strict;
use WWW::Mechanize;
use WWW::Mechanize::Firefox;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;
use List::MoreUtils qw(uniq);
use DBI;
use DBD::mysql;
use Data::Dumper;
use Win32::Process::List;
#use DB::single;

#initialiZe objects
#my $mech = WWW::Mechanize::Firefox->new( launch => 'C:\Program Files (x86)\Mozilla Firefox\firefox.exe', );
my $tree= HTML::TreeBuilder::XPath->new();
my $mech = WWW::Mechanize->new();



			


				my $page = $mech->get("http://m.yahoo.com");
				my $num = int(rand(80)) + 8;
				my $parsed = $tree->parse_content( $mech->content() );
				#print Dumper $parsed;
				my $url = $tree->find('//*[@id="defaultFooter"]/div/div[4]/a[1]');
				print Dumper $url;


