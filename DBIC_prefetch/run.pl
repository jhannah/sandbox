#!/usr/bin/perl

use strict;
use lib 'lib';
use My::Schema;

my $foo_rs = My::Schema->connect('dbi:SQLite:dbname=demo.sqlite3', undef, undef)->resultset('Foo')->search(
   {},
   {
      join     => 'bars',
      prefetch => 'bars',
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

