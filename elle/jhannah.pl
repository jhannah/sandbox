use strict;
use warnings;
use diagnostics;
 
my %weeks;
open my $fh, "<", "weekConverter.txt" or die "Can't open weeks file: $!";
while (<$fh>) {
   chomp;
   my ($date, $week) = split /\t/;
}
close $fh;
 
my $stats = {};
open my $fh, "<", "NAdate_type.txt" or die "Can't open types file: $!";
<$fh>; # discard header
while (<$fh>) {
   chomp;
   my ($type, $date) = split /\t/;
   my $week = $weeks{$date};
   my $stats->{$week}->{$type}++;
}
close $fh;
 
foreach my $week (keys %stats) {
   foreach my $type (keys %{$stats->{$week}}) {
       print "$week $type " . $stats->{$week}->{$type} . "\n";
   }
}
