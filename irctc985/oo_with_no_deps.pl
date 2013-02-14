package Animal;
use strict; 
use warnings;
sub new { return bless {}; }
sub speak {
   my ($self) = @_;
   return $self->sound;
}

package Mouse;
use strict; 
use warnings;
our @ISA = qw/Animal/;
sub new { return bless {}; }
sub sound {
   my ($self) = @_;
   return "Mouse goes: pi pi\n";
}

package main;
use strict; 
use warnings;
my $m = Mouse->new();
print $m->speak;



