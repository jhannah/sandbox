use strict;
use warnings;
use 5.10.0;
use DBI;

my $dbh = DBI->connect(...);
my $sth1 = $dbh->prepare("select * from [urls]");
my $sth2 = $dbh->prepare("select * from [orgs] where url = ?");
my $sth3 = $dbh->prepare("update [urls] set org_id = ?");
$sth1->execute;
while (my $row1 = $sth1->fetchrow_hashref) {
   if ($row1->{url}}) {
      say "url is " . $row1->{url};
      $sth2->execute($row1->{url});
      while (my $row2 = $sth2->fetchrow_hashref) {
         say "   found a match on orgs row " . $row2->{id};
         $sth3->execute($row2->{id});
         # ... 
      }
   }
}

$dbh->disconnect;;

