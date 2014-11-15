package Board;

use Moose;

has 'board' => (is => 'rw', isa => 'HashRef', default => sub { {} });

sub go {
  my ($self) = @_;
  my $new_board = Board->new();
  foreach my $x (keys %{$self->board}) {
    foreach my $y (keys %{$self->board->{$x}}) {
      $new_board->set_cell($x, $y, $self->will_survive($x, $y));
    }
  }
  return $new_board;
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

sub will_survive {
  my ($self, $x, $y) = @_;

  my $neighbor_count;

  for(my $i = $x-1; $i <= $x+1; ++$i)
  {
      for(my $j = $y-1; $j <= $y+1; ++$j)
      {
          if($i == $x && $j == $y)
          {
              next;
          }

          if($self->board->{$x}->{$y} == 1)
          {
              $neighbor_count += 1;
          }
      }
  }
  print("cell at $x,$y has $neighbor_count neighbors\n");
}

1;


