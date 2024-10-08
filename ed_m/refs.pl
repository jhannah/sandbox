use 5.40.0;
my $foo = {
  a => [ "woop", "woo" ],
  b => [ "yup", "yuppers", "y3" ]
};
say $foo->{b}->[2];
say $$foo{b}->[2];
say $foo->{b}[2];
say $$foo{b}[2];

my @array = (1,2,3);     my $arrayref = [1,2,3];
my %hash = (1 => "one"); my $hashref = { 1 => "one" };
my $scalar = 7;          my $scalarref = \7;

say $array[1], $arrayref->[1];
say $hash{1},  $hashref->{1};
say $scalar,   $$scalarref;

sub foo { say "hi ", shift }
my $fooref = \&foo;
foo("ed");
$fooref->("ed");
