package Board;

use Moose;

has 'board' => (is => 'rw', isa => 'HashRef', default => sub { {} });

sub go {
  my ($self) = @_;
  my $new_board = Board->new();
  foreach my $x (keys %{$self->board}) {
    foreach my $y (keys %{$self->board->{$x}}) {
      $new_board->set_cell($x, $y, $self->will_live($x, $y));
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

sub living_neighbor_count {
  my ($self, $x, $y) = @_;

  my $rval = 0; 

  for (my $i = $x-1; $i <= $x+1; ++$i) {
      for (my $j = $y-1; $j <= $y+1; ++$j) {
          next if ($i == $x && $j == $y);
          $DB::single = 1;
          if($self->board->{$i}->{$j} && $self->board->{$i}->{$j} == 1) {
              $rval += 1;
          }
      }
  }
  print("cell at $x,$y has $rval living neighbors\n");
}

sub will_live {
  my ($self, $x, $y) = @_;
  my $lnc = $self->living_neighbor_count($x, $y);
  if ($self->check_cell($x, $y)) {
    # I'm currently alive
    if ($lnc < 2)  { return 0 }
    if ($lnc == 2) { return 1 }
    if ($lnc == 3) { return 1 }
  } else {
    # I'm currently dead
    if ($lnc == 3) { return 1 }
  }
  return 0;
}

sub all_living_cells {
    my $self = shift;
    my @cells;

    foreach my $x (keys($self->board)) {
        foreach my $y (keys($self->board->{$x})) {
            if($self->board->{$x}->{$y} == 1) {
                push (@cells, "$x,$y");
            }
        }

        return join (@cells, "|");
    }

}

1;


