use Modern::Perl;
use Test::More;

my $re = qr/
  (?<!Brad\s)  # Brad is a jerk
  \b           # Word boundary
  (O')?        # O' is optional
  Hanna[hy]    # Hannah or Hannay
  \b           # Word boundary
/ix;           # i for case insensitive, x for comments

ok('J Hannah'      =~ $re, 'J Hannah');
ok('J hannah'      =~ $re, 'J hannah');
ok('J Hannahnator' !~ $re, 'J Hannahnator');
ok("J O'Hannah"    =~ $re, "J O'Hannah");
ok("Hannay"        =~ $re, "Hannay");
ok('Brad Hannah'   !~ $re, 'Brad Hannah');

done_testing();

