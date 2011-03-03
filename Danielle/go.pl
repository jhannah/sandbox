#!/usr/bin/perl -w
# AlnMatrix
#    VERSION: Version 1 Jan 25, 2011
#    PURPOSE: Read in aln file and create a Phylogenetic tree using the
#			  Neighbor-joining algorithm
#
#    INPUT FILES:
#             1. Clustal .aln file
#             2.
#    OUTPUT FILES: Output to screen
#             Gives each 2D matrix of mismatches in the alignment,
#			  then calculates net divergence and average divergence

############## LIBRARIES AND PRAGMAS ################
use strict;
use warnings;

#use Data::Dumper;

####################FILES#####################

my $input = "rai1alnfile.aln";

#################### CONSTANTS ######################

my %alignhash;
my $seq_identifier;
my $seq = "";
my $seq_names;
my $name;
my $subjects;
my $mismatch;
my $next_line;
my %diffhash2;
my %avg_div;
my $sum;

###################MAIN###################

%alignhash = Get_alignment($input);
foreach my $key ( sort keys(%alignhash) ) {

    print "$key\t$alignhash{$key}\n";

}
Make_Matrix();
Net_Divergence();

#################Sub Get_alignment#########

sub Get_alignment {

    my ($input) = @_;
    my $flag = 0;
    my $key;
    my $line;

    open ALN_FILE, "<$input" or die "Can't open $input: $!\n";

    #$line = <ALN_FILE>;        # Read first line (must be CLUSTAL)

    #print $line;

    while ( $line = <ALN_FILE> )
    {

        if ( $line =~ /^CLUSTAL/ )
        {
            next;
        }

        elsif ( $line =~ /^(\S+)\s+([ATGCatgc-]+)/ )
        {
            $name = $1;
            $seq  = $2;
            print $name, "\t";
            print $seq,  "\n";

            if ( !exists $alignhash{$name} & $flag )
            {
                $alignhash{$name} = $seq;
            }

            else
            {
                $flag = 1;
                $alignhash{$name} .= $seq;
            }
        }
    }    #end while loop

    close ALN_FILE;
    return (%alignhash);

}    #end sub Get_alignment

##############sub Make_Matrix#################

sub Make_Matrix {

    my $diff = 0;
    my $lengthij;
    

    foreach my $i ( keys %alignhash )

    {

        print $i, "\n";

        foreach my $j ( keys %alignhash )
        {

            print $i. $j, "\n";

            my $valj = $alignhash{$j};
            my $vali = $alignhash{$i};

            print "$i\t$vali\n";
            print "$j\t$valj\n";

            $lengthij = length($vali); #can be moved to outside loop

            $diff = 0;

            for ( my $x = 0 ; $x < $lengthij ; $x++ )
            {

                if ( substr( $valj, $x, 1 ) ne substr( $vali, $x, 1 ) )
                {
                    $diff++;
                }

            }

			#$diffhash{$i.$j} = $diff;
			#$diffhash{$j.$i} = $diff;	#Don't do it this way- not the easy way, you'll regret it later!!
            $diffhash2{$i}{$j} = $diff; #Do it this way- don't listen to Dr. Fawcett-
            $diffhash2{$j}{$i} = $diff; #this is the easy way!!!

            print "mismatch table: \n";
            foreach my $key1 ( sort keys %diffhash2 )
            {
                my $val1 = $diffhash2{$key1};

                foreach my $key2 ( sort keys %{$val1} )

                {

                    print $key1.$key2, "\n", $val1->{$key2}, "\n";
                }
            }

        }
    }    #end Make_Matrix

#####################sub Net_divergece##############

    sub Net_Divergence {

        my @val;
        my $lengthhash;
        my $j;
        my $sum;
        my $val;
        my $total_sum;
        my %netdiv;

        #my ($input) = @_; #diffhash
        my $num_keys = keys %diffhash2;    #number of values

        foreach my $i ( keys %diffhash2 )

        {

            #$val = $diffhash2{$i};

            #warn Dumper %{$diffhash2{$i}};
            $sum = Sum( values %{ $diffhash2{$i} } );

            print "Key: $i", "\n";
            print "Net Divergence: ";
            print "$sum\n";
			
			
			$netdiv{$i} = $sum;
			sub Avg_Divergence (@sum) ; 
        }

    }

}    #end sub Net_Divergence

##################sub Sum######################

sub Sum {

    my $sum;
    foreach my $num (@_)
    {

        $sum += $num;
    }

    return $sum;

}    #end sub Sum

#####################sub Avg_Divergence#########################
###### We want the end product of this subroutine to give ###### 
###### us the best (lowest number) i, j, and Mij...The	  ######
###### comparisons between the same sequences where the	  ###### 
###### differences are zero should be skipped.			  ######
################################################################


sub Avg_Divergence {
my $avg_div;

    foreach my $i ( keys %alignhash )

    {

        print $i, "\n";

        foreach my $j ( keys %alignhash )
        {


            print $i "" $j, "\n";
            
            $avg_div = ($diffhash2($i)($j) - ($sum + $netdiv{$j})) / (scalar(keys %alignhash) - 2);
            
            print "Average Divergence: $avg_dev, \n";

         }
      }   
}      
