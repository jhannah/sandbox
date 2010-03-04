############## Command Line Instructions #################
my $fileName = shift;
my $outputFile = shift;

############ Open all files ##########
open (my $IFH,"<$fileName") or die print "Cannot open file $fileName:$!\n";
open (my $WCF, "weekConverter.txt") or die print "Can't open weeks file:$!\n";
open (my $OFH, ">$outputFile") or die print "Cannot open out file:$!\n";

my $line;
my $date;
my $weekNo;
my $type;
my %weeks;
my $weeks;
my $week;

##########Main Mathod##########

%weeks = createHash($WCF);
%types = createHash2($IFH);
foreach my $date(keys %weeks){
   $weekNo = $weeks{$date};
   $type   = $types{$date};
   print $OFH "$weekNo\t$type\n";
}

###########Subroutine create hash##########
sub createHash{
   
   ####subroutine variables####
   my $date;
   my $weekNos;
   my %weeks;
   my @splitLine;
   
   while (my $line = <$WCF>) {
      chomp $line;
      @splitLine = split (/\t/, $line);
      $date = $splitLine[0];
      $weekNos = $splitLine[1];
      $weeks{$date} = $weekNos;
   }
   return %weeks
}

###########Subroutine create hash##########
sub createHash2{
   
   ####subroutine variables####
   my $date;
   my $type;
   my %types;
   my @splitLine;
   
   while (my $line = <$IFH>) {
      chomp $line;
      @splitLine = split (/\t/, $line);
      $type = $splitLine[0];
      $date = $splitLine[1];
      $types{$date} = $type;
   }
   return %types;
}

