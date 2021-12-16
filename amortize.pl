#! env perl

# Sample output:
#   https://gist.github.com/jhannah/4c74c240ba987edea6e5f0f72a342ab3

use Modern::Perl;
use Getopt::Long;
use Number::Format qw(format_number);

# This Python tool almost does what I want:
# pip3 install amortization     (https://github.com/roniemartinez/amortization)
# amortize --principal 176000 --period 180 --interest-rate 0.0213 --schedule

# But in my case I also want to make principle-only payments without the monthly
# payment changing.

my ($principle, $periods, $interest_rate, @principle_payments);
GetOptions(
  "principle=f"         => \$principle,
  "periods=i"           => \$periods,
  "interest_rate=f"     => \$interest_rate,
  "principle_payment=s" => \@principle_payments,
) or die "Error in command line arguments";

unless ($principle && $periods && $interest_rate) {
  print <<EOT;
Usage:
  amortize.pl --principle=176000 --periods=180 --interest_rate=2.13 \\
    --principle_payment=12:2000 \\
    --principle_payment=24:2000

Take out a \$176,000 loan over 15 years at 2.13% APR.
But make a \$2,000 principle-only payment after payment #12.
And another after payment #24.
Those extra payments shorten the number of payments we have to make,
and make the last payment smaller.
EOT
  exit;
}
my %principle_payments;
foreach my $pp (@principle_payments) {
  my ($period, $amount) = split /:/, $pp;
  $principle_payments{$period} = $amount;
}

print <<EOT;
  #   Payment     Int     Princ     Balance
---  --------  ------  --------  ----------
EOT

my $each_payment = each_payment();
my $this_period = 1;
my $total_interest_paid;
# heh. Floating point math is sloppy, so we do a sloppy check:
while (sprintf("%.2f", $principle) > 0) {
  my $this_interest = $principle * $interest_rate / 100 / 12;
  $total_interest_paid += $this_interest;
  if ($each_payment > $principle) {
    # Whoops! We would have overpaid the loan on the last payment.
    # Adjust the payment amount for this (the last) month
    $each_payment = $principle + $this_interest;
  }
  my $this_principle = $each_payment - $this_interest;
  $principle -= $this_principle;
  say sprintf("%3s  %8s  %6s  %8s  %10s",
    $this_period,
    format_number($each_payment,   2, 2), 
    format_number($this_interest,  2, 2), 
    format_number($this_principle, 2, 2), 
    format_number($principle,      2, 2),
  );
  if ($principle_payments{$this_period}) {
    my $a = $principle_payments{$this_period};
    $principle -= $a;
    say sprintf("Principle-only payment made:\n%22s %8s  %10s",
      '',
      format_number($a, 2, 2),
      format_number($principle, 2, 2),
    );
  }
  $this_period++;
}
say "Total interest paid: " . format_number($total_interest_paid, 2, 2);

sub each_payment {
  # https://www.kasasa.com/blog/how-to-calculate-loan-payments-in-3-easy-steps
  # A = Payment amount per period
  # P = Initial principal or loan amount (in this example, $10,000)
  # r = Interest rate per period (in our example, that's 7.5% divided by 12 months)
  # n = Total number of payments or periods
  # A = P (r (1+r)^n) / ( (1+r)^n -1 )
  my $r = $interest_rate / 100 / 12;
  my $a = $principle * $r * (1 + $r) ** $periods / ((1 + $r) ** $periods - 1);
  return $a;
}

