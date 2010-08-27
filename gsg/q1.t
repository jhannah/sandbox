use Test::More tests => 2;
use q1;

is_deeply([ q1::hibachi(3) ], [2, 2, 2],              'hibachi(3)');
is_deeply([ q1::hibachi(6) ], [2, 2, 2, 8, 32, 512],  'hibachi(6)');

