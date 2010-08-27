use Test::More tests => 4;

use strict;
use q2;

ok(my $a = MyTime->new(700, 500),   "new()");
ok(my $b = MyTime->new(900, 550),   "new()");
is($b->minus($a),  200050,          "minus");
is($a->minus($b), -200050,          "minus");


