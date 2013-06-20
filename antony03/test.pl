                #By Antony Vincent#
 
#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
 
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
) or die "Incorrect usage! Try perl extract.pl -help for an exhaustif help.\n";

if( $help ) { 
    print "\n";
    print "One option is required:\n";
    print " -file: Your file in multi-fasta\n";
    exit;
}

mkdir 'new_db';
my @find_these= ("A-12345", "B-12345");
 
my $gb = Bio::SeqIO->new(-file   => "<$filename",
                              -format => "fasta");
 
my $fa = Bio::SeqIO->new(-file   => ">new_db/$filename",
                              -format => "fasta",
                              -flush  => 0);

SEQ:
while (my $seq = $gb->next_seq) {
    my $id_and_desc = $seq->id . " " . $seq->desc;
    foreach my $str (@find_these) {
        if ($id_and_desc =~ /\Q$str\E/) {
            $fa->write_seq($seq);
            next SEQ;
        }
    }
}
 
 
 
