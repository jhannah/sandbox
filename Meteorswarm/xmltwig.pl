#!/usr/bin/perl

# Little XML::Twig demo for Meteorswarm
# by Jay Hannah - http://bioperl.org/wiki/User:Jhannah
#
# Pipe XML files into this program like so:
#    cat medicago_chr0_20080103.xml | perl xmltwig.pl

use strict;
use XML::Twig;

# Grab all STDIN into $xml
local $/ = undef;
my $xml = <>;

my $twig = XML::Twig->new();
$twig->parse($xml);
my $root = $twig->root;

my @x = $root->get_xpath('ASSEMBLY/GENE_LIST/PROTEIN_CODING/TU');
foreach my $x (@x) {
   printf(
      "%s %s %s\n", 
      $x->first_child('FEAT_NAME')->text,
      $x->first_child('COORDSET')->first_child('END5')->text,
      $x->first_child('COORDSET')->first_child('END3')->text,
   );
}

 



