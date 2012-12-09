use strict;
use warnings;
use Test::More;
use Cell;

ok(my $c = Cell->new,      'new');
is($c->state, 'DEAD',      'DEAD by default');
is($c->neighbor_count, 8,  'neighbor_count');

done_testing();

