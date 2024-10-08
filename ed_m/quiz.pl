use 5.40.0;
my $correct = question();
while (<STDIN>) {
  chomp;
  if ($_ != $correct) {
    say "Nope, try again.";
  } else {
    say "Correct!";
    $correct = question();
  }
}

sub question {
  my $x = int(rand(10));
  my $y = int(rand(10));
  say "What's $x + $y?";
  return $x + $y;
}

