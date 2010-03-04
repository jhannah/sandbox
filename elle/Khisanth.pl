use strict;
use warnings;

# Usage: perl count_infections.pl input1 input2 input3 ...

# create date to week conversion table
my %date_to_week;
open my $week_converter, "<", "weekConverter.txt"
	or die "Couldn't open 'weekConverter.txt': $!";

while( my $line = <$week_converter> ) {
	chomp $line;
	my ($date, $week) = split /\t/, $line;
	$date_to_week{ $date } = $week;
}


# process all the files specified on the command line
for my $file ( @ARGV ) {
	open my $date_type, "<", $file or die "Couldn't open '$file': $!";

	my %counts;
	while( my $line = <$date_type> ) {
		chomp $line;
		my ($date, $type) = split /\t/, $line;

		if( exists( $date_to_week{ $date } ) ) {
			# zero pad for sorting
			my $week = sprintf "%02d", $date_to_week{ $date };
			$counts{ "$week\t$type" }++;
		} else {
			# what to do if no conversion is available is not specified
		}
	}

	print "Week\tType\tCounts\n";
	for my $week_type ( sort keys %counts ) {
		print "$week_type\t$counts{$week_type}\n";
	}
}


