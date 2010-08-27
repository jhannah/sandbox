use strict;

my %last_name = (
   Mary      => "Li",
   James     => "O'Day",
   Thomas    => "Miller",
   William   => "Garcia", 
   Elizabeth => "Davis",
);
foreach my $first_name (sort by_LengthLast_AlphaFirst keys %last_name) {
   print "$first_name $last_name{$first_name}\n";
} 
sub by_LengthLast_AlphaFirst {
   length($last_name{$a}) <=> length($last_name{$b}) 
      ||
   $a cmp $b
}



