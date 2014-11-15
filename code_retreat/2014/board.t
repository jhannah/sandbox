use Test::More;
use Board;

ok(my $b = Board->new());
#ok($b->set_cell(5,5),     "set_cell");
#ok($b->set_cell(4,5),     "set_cell");
#ok($b->set_cell(5,6),     "set_cell");
#ok($b->set_cell(5,3),     "set_cell");
ok($b->set_cell(3,3,1),   "set_cell");
ok($b->check_cell(3,3),   "check_cell");
ok($b = $b->go,           "go");
ok(!$b->check_cell(3,3),  "check_cell");

ok($b = $b->go,           "go");
ok($b->display,           "display");

done_testing();



