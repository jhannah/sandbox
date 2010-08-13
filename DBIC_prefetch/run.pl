#!/usr/bin/perl

use strict;
use lib 'lib';
use My::Schema;

my $schema = My::Schema->connect(
   'dbi:SQLite:dbname=demo.sqlite3', undef, undef
);

my $foo_rs = $schema->resultset('Foo')->search(
   {},
   {
      join     => 'bars',
      prefetch => 'bars',
      order_by => 'me.id',
   }
);

while (my $foo = $foo_rs->next) {
   printf "%s\n", $foo->id;
   if (my $bar_rs = $foo->bars) {
      while (my $bar = $bar_rs->next) {
         printf "   %s\n", $bar->desc;
      }
   }
}

