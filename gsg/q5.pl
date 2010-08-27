# perl -p -i.bak -e 's/mispell/misspell/' data.txt


# Note that the above changes the first occurrence *on each line* of the file.  
# If you want to leave all other occurrences misspelled (or if perl -i is 
# considered cheating), here's a long version:

use strict;
use autodie;
open my $in,  '<', 'q5.data.txt';
open my $out, '>', 'temp.txt';   # Should probably use File::Temp here
my $continue = 1;
while (<$in>) {
   if ($continue && s/mispell/misspell/) {
      $continue = 0;
   }
   print $out $_;
}
close $out;
close $in;
rename('temp.txt', 'q5.result.txt');


