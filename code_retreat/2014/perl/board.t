use Test::More;
use Board;

ok(my $b = Board->new());

# Lone living cell dies:
ok($b->set_cell(3,3,1),           "set_cell");
ok($b->check_cell(3,3),           "check_cell");
ok($b = $b->go,                   "go");
ok(!$b->check_cell(3,3),          "check_cell");

# Dead cell can burst into life:
ok($b->set_cell(3,3,1),           "set_cell");
ok($b->set_cell(3,4,1),           "set_cell");
ok($b->set_cell(3,5,1),           "set_cell");
ok($b = $b->go,                   "go");
ok(!$b->check_cell(3,3),          "check_cell");
is($b->all_living_cells, '2,4',   "all_living_cells");

ok($b->display,                   "display");

done_testing();



