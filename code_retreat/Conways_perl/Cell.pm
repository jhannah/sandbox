package Cell;
use Moose;
use Moose::Util::TypeConstraints;

has 'state' => (
   is      => 'rw', 
   isa     => enum([ qw( ALIVE DEAD ) ]),
   default => 'DEAD',
);
has 'location' => ( 
   is      => 'rw', 
   isa     => 'Location',
   default => sub{ Location->new },
);

has 'neighbor_list' => (
   traits  => ['Array'], 
   is      => 'rw', 
   isa     => 'ArrayRef[Cell]',
   default => sub { [] },
   handles => {
      push_neighbor => 'push',
   },
);

sub neighbor_count {
   my @neighbors = ();
   return scalar(@neighbors);
}

1;


