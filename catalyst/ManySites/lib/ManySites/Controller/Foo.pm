package ManySites::Controller::Foo;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

sub foo1 :Local {
}

sub foo2 :Local {
}


__PACKAGE__->meta->make_immutable;

1;
