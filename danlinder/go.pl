use 5.18.0;
use Text::CSV;

my $csv = Text::CSV->new( { binary => 1 } );
open my $fh, "<:encoding(utf8)", "in.csv" or die "in.csv: $!";

my $headers = $csv->getline($fh);   # array ref
while (my $row = $csv->getline($fh)) {
   for (my $i = 0; $i < @$headers; $i++) {
      printf ("%s=%s\n", $headers->[$i], $row->[$i]);
   }
}


