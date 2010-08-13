package Foo::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Foo::Controller::Root - Root Controller for Foo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub default : Private {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

sub foo : Local {
   my ($self, $c) = @_;
   $DB::single = 1;
   my @methods = $self->get_action_methods();
   my %all;
   foreach my $m (@methods) {
      if ($m->{associated_metaclass} && $m->{associated_metaclass}->{methods}) {
         foreach my $m (keys %{$m->{associated_metaclass}->{methods}}) {
            $all{$m} = 1 unless ($m =~ /^_/);
         }
      }
   }
   foreach my $m (keys %all) {
      $c->log->debug($m);
   }
   1;
}
sub bar : Local { }
sub baz : Local { }


=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
