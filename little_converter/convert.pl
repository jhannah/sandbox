open my $in, 'inputfile.txt' or die;
my ($lines, $column_count);
while (<$in>) {
   chomp;
   my @line = split /\t/;
   $column_count = @line;
   push @$lines, [ @line ];
}
my %line;
foreach $i (0 .. $column_count - 1) { 
   $line{$lines->[0]->[$i]} = $lines->[1]->[$i];
}

foreach my $k (sort keys %line) {
   printf("%-30s %-20s\n", $k, $line{$k});
}
