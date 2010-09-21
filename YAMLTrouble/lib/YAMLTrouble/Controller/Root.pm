package YAMLTrouble::Controller::Root;
use Moose;
use namespace::autoclean;
use YAML::Any;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

YAMLTrouble::Controller::Root - Root Controller for YAMLTrouble

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}


sub good : Local {
   my ($self, $c) = @_;
   $c->stash(chinese => '我很瞭解歐姆耐酒店的願景');
}

sub bad : Local {
   my ($self, $c) = @_;
   $c->stash(chinese => '我很瞭解歐姆耐酒店的願景');
   my $cfg = YAML::Any::LoadFile('yamltrouble.yml');
   $c->stash(config_string => $cfg->{name});
}


=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
