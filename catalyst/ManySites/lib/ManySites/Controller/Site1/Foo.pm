package ManySites::Controller::Site1::Foo;
use Moose;
use namespace::autoclean;

BEGIN {
   extends 'ManySites::Controller::Site1::Root';
   extends 'ManySites::Controller::Foo';
 }


sub index :Local :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ManySites::Controller::Site1::Foo in Site1::Foo.');
}


sub foo1 :Local {
}


__PACKAGE__->meta->make_immutable;

1;
