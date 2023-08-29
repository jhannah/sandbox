#! env perl
use 5.38.0;
use experimental 'class';

class Card {
  field $face :param;
  field $suit :param;

  method show() {
    printf("That's the %s of %s\n", $face, $suit);
  }
}

my $c = Card->new(
  face => "Q",
  suit => "H",
);
$c->show;

__END__
✗ ./poker.pl
That's the Q of H

Want more?
Blog: https://chris.prather.org/perl-roguelike-part-0.html
Tutorial: https://gist.github.com/Ovid/4cc649c1eb3142b6a856d94c54b1d4ed
