use strict;
use diagnostics;
use warnings;
use IPC::System::Simple qw(run system capture EXIT_ANY);
use WWW::Search;
 
$SIG{ALRM} = sub { die "timeout" };
 
my $random_word = random_dictionary_word();
my $oSearch = new WWW::Search('MSN');
my $sQuery = WWW::Search::escape_query("Shopping $random_word");
$oSearch->native_query($sQuery);
 
while (my $oResult = $oSearch->next_result()) {
   my $border = $oResult->url;
   print $oResult->url, "\n";
   system( [0..255], "php.exe scan.php $border");
}
 
 
sub random_dictionary_word {
   srand;
   open my $in, "<", "mydictionary.txt" or die "Can't open mydictionary.txt";
   my $it;
   while (<$in>) {
      rand($.) < 1 && ($it = $_);
   }
   return $it;
}
 
