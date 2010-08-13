#!/usr/bin/perl

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

unlink("demo.sqlite3");
system("sqlite3 demo.sqlite3 < demo.sql");


make_schema_at(
    'My::Schema',
    { debug => 1,
      dump_directory => './lib',
    },
    [ 'dbi:SQLite:dbname=demo.sqlite3', undef, undef ],
);




