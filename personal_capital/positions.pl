#! env perl

use 5.30.0;
use strict;
use warnings;
use Text::CSV_XS;

# https://investor.pershing.com/nxi/portfolio/holdings Download
my $infile = "/Users/jhannah/Dropbox/personal_capital/Positions_09_23_2021.csv";

# https://www.sustainalytics.com/
# 0-10 Negligible
# 10-20 Low
# 20-30 Medium
# 30-40 High
# 40+ Severe
my %sus = (
  AGCO => 23,    # https://www.sustainalytics.com/esg-rating/agco-corp/1008195765
  T    => 19.1,  # https://www.sustainalytics.com/esg-rating/at-t-inc/1007978477
  ABT  => 26,    # https://www.sustainalytics.com/esg-rating/abbott-laboratories/1008125729
  ALB  => 37.2,  # https://www.sustainalytics.com/esg-rating/albemarle-corp/1007896917
  GOOG => 22.9,  # https://www.sustainalytics.com/esg-rating/alphabet-inc/1007907342
  # AWK  =>      # can't find
  AMGN => 19.4,  # https://www.sustainalytics.com/esg-rating/amgen-inc/1007903062
  AAPL => 16.9,  # https://www.sustainalytics.com/esg-rating/apple-inc/1007903183
  ADP  => 13.7,  # https://www.sustainalytics.com/esg-rating/automatic-data-processing-inc/1008004515
  AGR  => 26.6,  # https://www.sustainalytics.com/esg-rating/avangrid-inc/1008169832
  BLL  => 13.8,  # https://www.sustainalytics.com/esg-rating/ball-corp/1008048598
  BAC  => 27,    # https://www.sustainalytics.com/esg-rating/bank-of-america-corp/1007897295
  DJP  => 24.3,  # https://www.sustainalytics.com/esg-rating/barclays-plc/1008202145
  CMS  => 23.9,  # https://www.sustainalytics.com/esg-rating/cms-energy-corp/1008135928
  CPB  => 22.4,  # https://www.sustainalytics.com/esg-rating/campbell-soup-co/1008136704
  CMG  => 24.2,  # https://www.sustainalytics.com/esg-rating/chipotle-mexican-grill-inc/1007904692
  CLX  => 22,    # https://www.sustainalytics.com/esg-rating/the-clorox-co/1007967696
  CL   => 20.7,  # https://www.sustainalytics.com/esg-rating/colgate-palmolive-co/1008140493
  CMCSA => 24.6, # https://www.sustainalytics.com/esg-rating/comcast-corp/1008051587
  ED   => 25.1,  # https://www.sustainalytics.com/esg-rating/consolidated-edison-inc/1008141541
  COST => 23.2,  # https://www.sustainalytics.com/esg-rating/costco-wholesale-corp/1007971063
  DISCA => 17.2, # https://www.sustainalytics.com/esg-rating/discovery-inc/1030544339
  D    => 28.2,  # https://www.sustainalytics.com/esg-rating/dominion-energy-inc/1008145351
);

my $total;
my $csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1 });
open my $fh, "<:encoding(utf8)", $infile or die $!;
while (my $row = $csv->getline ($fh)) {
  $row->[19] =~ m/COMMON STOCK/ or next;
  $row->[12] =~ s/,//g;
  printf("%-5s %10s\n", $row->[0], $row->[12]);
  $total += $row->[12];
}
close $fh;
say "Total: $total\n\n";

say "https://github.com/jhannah/sandbox/blob/main/personal_capital/positions.pl";
my $total_perc; 
$csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1 });
open $fh, "<:encoding(utf8)", $infile or die $!;
while (my $row = $csv->getline ($fh)) {
  # Security ID,USIP/ISIN/SEDOL,Account Number,Account Nickname/Title,Description,Asset Classification,Quantity,Price,Price as of date,Timezone,Change Price Amount,Change Price %,Market Value,Market Value Change,Last Activity Date,Accrued Interest,Disposition Method,Dividend Reinvestment,Market,Sub-Asset Classification
  #say $row->[18];
  $row->[19] =~ m/COMMON STOCK/ or next;
  $row->[12] =~ s/,//g;
  my $this_sus = $sus{$row->[0]} ? sprintf("%.1f", $sus{$row->[0]}) : "";
  my $this_perc = $row->[12] / $total * 100;
  printf("%-5s %-7s %-40s %0.2f%%  %-4s\n",
    $row->[0],
    $row->[18],
    $row->[4],
    $this_perc,
    $this_sus,
  );
  $total_perc += $this_perc;
}
close $fh;

say "Total perc: $total_perc";

