use Modern::Perl;

foreach my $n ('J Hannah', 'Brad Hannah', 'Zig Hannah', 'Bob Marley') {
   say "$n: ", $n =~ /(?<!brad )hannah/i ? "yes" : "no";
}

