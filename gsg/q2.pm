# Unless startup time is a big concern, we would typically use Moose to get
# lots of free functionality without all the typing (accessors, 
# manipulators, defaults, data type constraints/coercions, etc.)
# But in this case let's assume Moose isn't an option and use raw Perl 5.

package MyTime;
use strict;
sub new {
   my ($package, $sec, $msec) = @_; 
   my $self = {
      sec  => $sec,
      msec => $msec,
   };
   return bless $self;
}
sub sec  { $_[0]->{sec} }
sub msec { $_[0]->{msec} }
sub minus {
   my ($self, $other) = @_;
   return 
      (($self->{sec} -  $other->sec) * 1000) + 
      ( $self->{msec} - $other->msec);
}

1;

