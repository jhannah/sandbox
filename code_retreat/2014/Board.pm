package Board;

use Moose;

has 'board' => (is => 'rw', isa => 'HashRef', default => sub { {} });

sub go {
  1;
}

sub display {
  1;
}

sub set_cell {
  my ($self, $x, $y, $value) = @_;
  $self->board->{$x}->{$y} = $value;
  return 1;
}

sub check_cell {
  my ($self, $x, $y) = @_;
  $self->board->{$x}->{$y};
}


1;


