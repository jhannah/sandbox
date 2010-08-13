#!/usr/bin/perl

use strict;
use lib 'lib';
use My::Schema;

my $rs = My::Schema->connect('dbi:SQLite:dbname=demo.sqlite3', undef, undef)->resultset('Foo')->search(
   {},
   {
      join     => 'bar',
      prefetch => 'bar',
   }
);
while (my $row = $rs->next) {
   printf "%s\n", $row->bar->id;
}

