############## Command Line Instructions #################
my $fileName = shift;
my $outputFile = shift;

############ Open all files ##########
open (IFH,"<$fileName") or die print "Cannot open file $fileName:$!\n";
open (my $WCF, "weekConverter.txt") or die print "Can't open weeks file:$!\n";
open (OFH, ">$outputFile") or die print "Cannot open out file:$!\n";

my $line;
my $date;
my $weekNo;
my $type;
my %weeks;
my $weeks;
my $week;

##########Main Mathod##########

%weeks = createHash($WCF);

foreach my $date(keys %weeks){
   $weekNo = $weeks{$date};
   print OFH "$date\t$weekNo\n";
}

###########Subroutine create hash##########
sub createHash{
   
   ####subroutine variables####
   my $dates;
   my $weekNos;
   my %weeks;
   my @splitLine;
   
   while (my $line = <$WCF>) {
      chomp $line;
      @splitLine = split (/\t/, $line);
      $dates = $splitLine[0];
      $weekNos = $splitLine[1];
      $weeks{$dates} = $weekNos;
   }
   return %weeks
}

