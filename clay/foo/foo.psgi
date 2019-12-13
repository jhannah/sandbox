use strict;
use warnings;

use Foo;

my $app = Foo->apply_default_middlewares(Foo->psgi_app);
$app;

