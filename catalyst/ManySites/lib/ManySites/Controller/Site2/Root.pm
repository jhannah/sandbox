package ManySites::Controller::Site2::Root;
use Moose;
use namespace::autoclean;

BEGIN {extends 'ManySites::Controller::Root'; }

sub auto {
   # ManySites::View::TT->config->{WRAPPER} = 'site2/wrapper.tt';
}

__PACKAGE__->meta->make_immutable;

1;
