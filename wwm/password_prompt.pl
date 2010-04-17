use strict;
use Term::ReadKey;

print "Enter password:";
ReadMode('noecho'); 
my $pwd = ReadLine(0);
chomp $pwd;
ReadMode 0;
print "\nThanks. You said [$pwd]\n";


