use 5.40.0;
# perldoc -f wantarray

my @people = hello();
say join " & ", @people;
my $people = hello();
say "How the heck are you $people?";
hello();

sub hello {
  if (wantarray()) {
    # list context
    return qw( jay ed );
  } elsif (defined wantarray()) {
    # scalar context
    return "jay and ed";
  } else {
    # void context
    say "Hello Jay and Ed!";
  }
}



