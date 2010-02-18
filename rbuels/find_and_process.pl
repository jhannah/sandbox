#!/usr/bin/perl

package Manager;
use Moose;
with qw(MooseX::Workers);

sub worker_stdout {
   my ( $self, $output, $wheel ) = @_;
   print "Manager saw this: $output\n";
}
#sub worker_done    { shift; warn join ' ', @_; }
#sub worker_started { shift; warn join ' ', @_; }

no Moose;

package main;
use warnings;
use strict;
no strict 'subs';

my $manager = Manager->new();
$manager->max_workers(3);

use POE qw( Wheel::Run );

POE::Session->create(
  inline_states => {
    _start           => \&on_start,
    got_child_stdout => \&on_child_stdout,
    got_child_close  => \&on_child_close,
  }
);

POE::Kernel->run();
##$manager->run();
exit 0;


  sub on_start {
    my $child = POE::Wheel::Run->new(
      Program => [ "/usr/bin/find", "/etc/radiusclient" ],
      StdoutEvent  => "got_child_stdout",
      CloseEvent   => "got_child_close",
    );

    $_[KERNEL]->sig_child($child->PID, "got_child_signal");

    # Wheel events include the wheel's ID.
    $_[HEAP]{children_by_wid}{$child->ID} = $child;

    # Signal events include the process ID.
    $_[HEAP]{children_by_pid}{$child->PID} = $child;

    print(
      "Child pid ", $child->PID,
      " started as wheel ", $child->ID, ".\n"
    );
  }

  # Wheel event, including the wheel's ID.
  sub on_child_stdout {
    my ($stdout_line, $wheel_id) = @_[ARG0, ARG1];
    my $child = $_[HEAP]{children_by_wid}{$wheel_id};
    print "pid ", $child->PID, " STDOUT: $stdout_line\n";
    $manager->enqueue( sub { process_xml($stdout_line) } );
  }

  # Wheel event, including the wheel's ID.
  sub on_child_close {
    my $wheel_id = $_[ARG0];
    my $child = delete $_[HEAP]{children_by_wid}{$wheel_id};

    # May have been reaped by on_child_signal().
    unless (defined $child) {
      print "wid $wheel_id closed all pipes.\n";
      return;
    }

    print "pid ", $child->PID, " closed all pipes.\n";
    delete $_[HEAP]{children_by_pid}{$child->PID};
  }


sub process_xml {
   my ($file) = @_;
   print "Hello there! I will now crunch $file into gff for you!\n";
   sleep 3;   # simulate this taking a while.
}

