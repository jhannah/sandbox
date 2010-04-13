use strict;
use warnings;

package Foo;
sub new { bless {} }
sub right { return (0, 1, 2, Foo->new, 4); }
sub attr  { return "hello there"; }

package main;
my $pos = Foo->new;
print [$pos->right]->[3]->attr;

