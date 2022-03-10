use 5.10.0;
use strict;
use warnings;
use XML::Twig;
use JSON;

my $out_hashref = {
  meta => {
    api        => "saveorder",
    "username" => "api",
    "password" => "....",
  },
  header => {
    program => "jackprogram",
  },
  lines => [ ],
};

my $twig = XML::Twig->new();
$twig->parsefile('2903.xml');
my $root = $twig->root;

my $order_id = $root->first_child('OrderHeader')->first_child('Id')->text;
say "Order ID $order_id";

foreach my $line ($root->first_child('Lines')->children('Line')) {
  my $qty = $line->first_child('ExecQty')->text;
  foreach my $item ($line->children('Item')) {
    foreach my $part_number ($item->first_child('PartNumbers')->children('PartNumber')) {
      my $partnum = $part_number->first_child('PartNumber')->text;
      push @{$out_hashref->{lines}}, {
        partnum => $partnum,
        qty     => $qty,
      }
    }
  }
}

print JSON->new->pretty->encode($out_hashref);


