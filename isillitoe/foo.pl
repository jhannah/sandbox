package Manager;
use Moose;
with qw(MooseX::Workers);

sub worker_stdout {
  my ( $self, $output, $job ) = @_;
  printf(
      "%s(%s,%s) said '%s'\n",
      $job->name, $job->ID, $job->PID, $output
  );
}

sub run { 
  foreach (qw( foo bar baz )) {
      my $job = MooseX::Workers::Job->new(
         name    => $_,
         command => sub { print "Started\n"; sleep(10); print "Finished\n"; die "horribly" },
         timeout => 30,
      );
      $_[0]->enqueue( $job );
  }
  POE::Kernel->run();
}

no Moose;

Manager->new()->run();   


