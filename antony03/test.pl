                #By Antony Vincent#
 
#!/usr/bin/perl
 
use Bio::Perl;
use Bio::SeqIO;
use IO::String;
use Bio::SearchIO;
use Getopt::Long;
 
 
        my $filename;
        my $help;
 
 
GetOptions(
'file=s' => \$filename,
'help!' => \$help,
)
or die "Incorrect usage! Try perl extract.pl -help for an exhaustif help.\n";
###
if( $help )
{ # if start
print "\n";
print "One option is required:\n";
print " -file: Your file in multi-fasta\n";
} # if help
 
else
{ ## for the else
mkdir new_db;
my @taxa_name= "Hafniomonas laevis";
 
 
my $gb = Bio::SeqIO->new(-file   => "<$filename",
                              -format => "fasta");
 
my $fa = Bio::SeqIO->new(-file   => ">new_db/$filename",
                              -format => "fasta",
                              -flush  => 0);
 
while($seq = $gb->next_seq) {
 
    print $seq->id . "\n";
    $fa->write_seq($seq) if (grep {$_ eq $seq->id} @taxa_name);
 
}
 
 
 
 
} ##for the else


