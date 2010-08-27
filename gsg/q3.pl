use strict;

my @in = split //, $ARGV[0];
my %characters;
foreach my $letter (@in) {
   $characters{$letter}++;
}
foreach my $key (sort bycount_descending keys %characters) {
   print "$key: " . ('#' x $characters{$key}) . "\n";
}
sub bycount_descending { 
   $characters{$b} <=> $characters{$a};
}


