use strict;
use warnings;
use DBI;

my $dbh = DBI->connect(...);
my $sth1 = $dbh->prepare("select * from [urls]");
my $sth2 = $dbh->prepare("select * from [orgs] where url like ?");
$sth1->execute;
while (my $row1 = $sth1->fetchrow_hashref) {
   if ($row1->{url}}) {
      $sth2->execute($row1->{url});
      while (my $row2 = $sth2->fetchrow_hashref) {
         # ... 
      }
   }
}

$sth2->finish;
$sth1->finish;
$dbh->disconnect;;

