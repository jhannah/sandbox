use strict;
use XML::Twig;

my $twig = XML::Twig->new();
$twig->parsefile('input.xml');
my $root = $twig->root;
foreach my $imp ($root->children('important')) {
   my $name = $imp->att('name');
   my $arg  = $imp->first_child('imp_arg')->att('arg');
   my $ele  = $imp->first_child('imp_element')->text;
   print join ",", $name, $arg, $ele;
   print "\n";
}




