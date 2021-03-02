use 5.26.0;
use Text::CSV;

# https://loseit.com/#Insights:Weight%5EWeight Export
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
open my $fh, "<:encoding(utf8)", "FoodCalories2021-03-02 (7366).csv" or die $!;
<$fh>;  # ignore header
my %cals;
while (my $row = $csv->getline($fh)) {
  $cals{fix_date($row->[0])} = $row->[1];
}

open $fh, "<:encoding(utf8)", "Weights2021-03-02 (7366).csv" or die $!;
<$fh>;  # ignore header
my %weights;
while (my $row = $csv->getline($fh)) {
  $weights{fix_date($row->[0])} = $row->[1];
}

foreach my $d (reverse sort keys %cals) {
  say "$d,$cals{$d},$weights{$d}";
}

sub fix_date {
  my ($m, $d, $y) = split m#/#, shift;
  return "$y-$m-$d";
}


