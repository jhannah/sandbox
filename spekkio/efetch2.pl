#!/usr/bin/perl 
use strict;
use warnings;

use Bio::DB::EUtilities;

#First use Eutilities to retrieve the gi numbers corresponding to the accession numbers that have
#been collected above.

print "Starting to recover the sequence records based on the accession numbers.\n";

my $file3 = 'na_gi_numbers.txt';
my @genbank_na_acc = qw(NM_004974 NM_008417 NM_002233 NC_007204);

my $factory = Bio::DB::EUtilities-> new(-eutil => 'esearch',
							-email => 'pat.boutet@gmail.com',
                     -db => 'nuccore',
					#		-db => 'nucleotide',
							-term => join(',', @genbank_na_acc),
							-usehistory => 'y',
                     -cache_response => 1
);

my $count = $factory -> get_count;

my $hist = $factory-> next_History || die 'No History Data returned';
print "History Returned\n";

__END__
$factory -> set_parameters(-eutil => 'efetch',
						-rettype => 'gbwithparts',
						-retmode => 'text',
						-history => '$hist');

my $retry = 0;						
my $retmax = 500;
my $retstart = 0;

open (WRITE, ">$file3") || die "Can't open file!\n";

RETRIEVE_SEQS:
while ($retstart < $count){
	$factory -> set_parameters(-retmax => $retmax,-retstart => $retstart);
	eval{
		$factory->get_Response(-cb => sub {my($data)=@_; print WRITE $data});
	};
	if ($@){
	die "Server error: $@. Try again later" if $retry == 5;
	print STDERR "Server error redo #$retry\n";
	$retry++ && redo RETRIEVE_SEQS;
	}
	print "Retrieved $retstart";
	$retstart += $retmax;
}
close WRITE;


close WRITE;

print "Finished Eutilities nucleic acid record recovery.\n";

