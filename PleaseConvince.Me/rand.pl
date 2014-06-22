
my @list;

open my $in, "<", "controversial_topics.txt" or die;
while (<$in>) {
  chomp;
  next unless /^\*/;
  s/[\*\[\]]//g;
  s/^ +//;
  s/&nbsp;/ /g;
  push @list, $_;
}

while (1) {
  print "$list[rand @list]\n\n";
  sleep 1;
}



