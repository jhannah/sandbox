#! env perl

use Template;

my $tt = Template->new({
  # INCLUDE_PATH => 'templates',
  INTERPOLATE  => 1,
}) || die "$Template::ERROR\n";

my $vars = {
  name     => 'Count Edward van Halen',
  debt     => '3 riffs and a solo',
  deadline => 'the next chorus',
};

$tt->process('feed.rss.tt', $vars, 'have_gun_will_travel.rss')
  || die $tt->error(), "\n";

