use Test::More;

ok("foo"    =~ /(?<!bar)foo/);
ok("barfoo" !~ /(?<!bar)foo/);
ok("bizfoo" =~ /
  (?<!bar)
  foo
/x);
ok("barfoo" !~ /
  (?<!bar)
  foo
/x);
ok("bar foo" =~ /
  (?<=bar\s)
  \b
  foo
/x);

done_testing();

