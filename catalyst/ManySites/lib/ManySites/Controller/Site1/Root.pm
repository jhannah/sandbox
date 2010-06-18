package ManySites::Controller::Site1::Root;
use Moose;
use namespace::autoclean;

BEGIN {extends 'ManySites::Controller::Root'; }
##    ManySites::View::TT->config(WRAPPER => 'site1/wrapper.tt' );

sub auto :Private {
   my ($self, $c) = @_;
   $c->log->debug( "hi, auto() Site1::Root::auto() here");

   # ManySites::View::TT->config(WRAPPER => 'site1/wrapper.tt' );
   # $c->view("TT")->config(WRAPPER => 'site1/wrapper.tt' );
   # __PACKAGE__->config->{'View::TT'}->{WRAPPER} = 'site1/wrapper.tt';

   $c->stash->{wrapper} = 'site1/wrapper.tt';

   $c->log->debug("jay1: " . ManySites::View::TT->config->{WRAPPER});
}

__PACKAGE__->meta->make_immutable;

1;
