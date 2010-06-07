#!/usr/bin/perl -w

use Modern::Perl;
use Bio::SeqIO;

my $in = Bio::SeqIO->new(-file=>$ARGV[0], -format=>'swiss');
my $seq_obj = $in->next_seq;
print $seq_obj->seq;
exit;

open (my $EPIC,"<", $ARGV[0]);

my ($ID, $AC, $SEQ);

while (<$EPIC>) {
    if (m/^ID\s{3}(\S*)\s/gi) {$ID=$1;}
    if (m/^AC\s{3}(\S*)\;/gi) {
        $AC=$1;
print ">$ID $AC\n";
    }
    if (m/^\s{5}(.+)/gi) {
        $SEQ .= $1;
        $SEQ =~ s/\s//g;
    }
}
print "$SEQ\n";
my @res=split("",$SEQ);
my $helcount=0;
my $lala=length($SEQ);
my @observed;
for (my $obcount=0;$obcount<=$lala-1;$obcount++)
{$observed[$obcount]='nonhydro';}
#print "@observed";
open (EPIC,"$ARGV[0]");
while (<EPIC>)
{if ($_=~m/^FT\s{3}TRANSMEM\s*(\d*)\s*(\d*)/gi)
{print "\n";
$helcount++;
print "TM$helcount $1 $2 ";
for (my $trans=$1;$trans<=$2;$trans++)
{print $res[$trans];
$observed[$trans]='hydro';}}}
#print "@observed";
print "\n";


my %KD = ('A'=>'1.8',
'R'=>'-4.5',
'N'=>'-3.5',
'D'=>'-3.5',
'C'=>'2.5',
'Q'=>'-3.5',
'E'=>'-3.5',
'G'=>'-0.4',
'H'=>'-3.2',
'I'=>'4.5',
'L'=>'3.8',
'K'=>'-3.9',
'M'=>'1.9',
'F'=>'2.8',
'P'=>'-1.6',
'S'=>'-0.8',
'T'=>'-0.7',
'W'=>'-0.9',
'Y'=>'-1.3',
'V'=>'4.2');

my @predicted=("nonhydro","nonhydro","nonhydro","nonhydro","nonhydro","nonhydro","nonhydro","nonhydro","nonhydro");
my $arith=0;
for (my $i=10;$i<=$lala-9;$i++) {
    for (my $add=-10;$add<=9;$add++) {
        my $mediator=$res[$i+$add];
        die "$mediator does not exist in \%KD" if !exists $KD{$mediator};
$arith=$arith+$KD{$mediator};
    }
    my $hydrocount=$arith/20;
    print "$hydrocount\n";
    if ($hydrocount>=0) {push (@predicted,'hydro');}
    if ($hydrocount<0) {push (@predicted,'nonhydro');}
    $arith=0;
}

my ($tp, $tn, $fp, $fn);
for (my $compcount=0;$compcount<=$#observed;$compcount++) {
    if ($predicted[$compcount] eq $observed[$compcount]) {
        if ($observed[$compcount] eq "hydro") {$tp++;}
if ($observed[$compcount] eq "nonhydro") {$tn++;}
    } else {
        if ($observed[$compcount] eq "hydro") {$fn++;}
        if ($observed[$compcount] eq "nonhydro") {$fp++;}
    }
}
my $Q=($tp+$tn)/($tp+$tn+$fp+$fn);
print "Q=$Q\n";


