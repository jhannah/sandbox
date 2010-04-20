#! /usr/bin/perl
use strict;
use warnings;
use WWW::Mechanize::Cached;
use HTML::TreeBuilder;
use Cache::FileCache;

#
# Run this script once as it is. Then, remove one of the $target's below, and re-run it.
# From the output you'll see that the entry Immediately After the removed entry is no 
# longer retrieved from the cache.
#

my @targets = ( 'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=24231&searchname=', # 104 Holgate Road
                'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=16469&searchname=', # Age Concern Sheffield
                'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=19691&searchname=', # Access Space
                'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=16440&searchname=', # Action for Stannington
                'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=23009&searchname=', # Activity Sheffield Council
                'http://www.sheffieldhelpyourself.org.uk/full_search_new.asp?group=24630&searchname='  # Activity Sheffield Over 50s
              );

my $cache = new Cache::FileCache( { 'namespace' => 'shef',
                                        'cache_root' => "./shef",
                                        'cache_depth' => 8,
                                        'default_expires' => '1d'
                                    } );

my $mech = WWW::Mechanize::Cached->new( cache => $cache );

for( my $i = 0; $i <= $#targets ; $i++ ) {
  # Prepare the tree...
  my $tree = HTML::TreeBuilder->new;
  $tree->parse( $mech->get( $targets[$i] )->content );
  $tree->eof;
  $tree->objectify_text();
  
  my $name_heading = $tree->look_down( 'text', qr/Organisation Name/ );
  my $org_name = $name_heading->look_up( '_tag', 'td' )->right->look_down( '_tag', '~text' );
  print $org_name->address("0.1.0.3.1.1.2.0.1.0.0.0")->attr('text') . ": ";
  if( $mech->is_cached() ) { print "this WAS cached.\n" } else { print "this was NOT cached.\n" };
}

1;

