#! /usr/bin/env perl 

use strict;
use warnings;

my $file1 = shift;
my $col =   shift;
my $file2 = shift;

$col--;  # make first column "1" not "0"

unless (
   $file1 && -r $file1
   && $col
   && $file2 && -r $file2
) { 
   print <<EOT;

$0 FILE_TO_FILTER COLUMN_NUMBER FILTER_LIST_FILE

e.g.: 

$0 OV_vs_FT_450K.txt 15 Wa_Genes.txt

EOT
   exit;
}

my %genes;
open my $in, '<', $file2;
while (<$in>) { 
   chomp;
   s/[^ -_]//g;
   $genes{$_} = 1;
}

open $in, '<', $file1;
print <$in>;   # header line
while (<$in>) { 
   my @l = split /\t/;
   # print "[[$l[$col]]]\n";
   print if ($genes{ $l[$col] }); 
}




 
