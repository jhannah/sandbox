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
my %final;
while (my $line = <$IFH>) {
   chomp $line;
   my $type;
   my %types;
   my @splitLine;
   @splitLine = split (/\t/, $line);
   $type = $splitLine[0];
   $date = $splitLine[1];
   my $week = $weeks{$date};
   $final{"$week\t$type"}++;
}

foreach my $key (sort keys %final) {
   print $OFH $key . "\t" . $final{$key} . "\n";
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


