use 5.18.0;

my @all_rows;
open my $in, "in.txt" or die $!;
while (<$in>) {
   chomp;
   push @all_rows, [ split / / ];
}
close $in;

foreach my $row (sort by_timestamp @all_rows) {
   say join " ", $row->[0], (scalar localtime($row->[1]));
}


sub by_timestamp {
   $a->[1] <=> $b->[1]
}


