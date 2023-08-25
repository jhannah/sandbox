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


