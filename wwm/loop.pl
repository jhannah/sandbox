foreach my $n (qw(e_1 e_2 foo e_7)) {
   next unless ($n =~ /^e_(\d+)$/);
   print "$n: $1 \n";
}

