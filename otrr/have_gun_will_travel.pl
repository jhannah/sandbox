#! env perl

use 5.40.0;
use Template;

my $tt = Template->new({
  # INCLUDE_PATH => 'templates',
  INTERPOLATE  => 1,
}) || die "$Template::ERROR\n";

my @episodes;
while (<DATA>) {
  chomp;
  my $ep = {};
  if (/Introduction/) {
    push @episodes, {
      filename  => $_,
      title     => "OTRR Introduction",
      # pub_date  => "19 May 2024 00:20:34 GMT",
      pub_date  => "2024-05-19",
      ep_number => 0,
    };
  } else {
    my $filename = $_;
    # Have Gun—Will Travel 1958-11-23 (001) Strange Vendetta.flac
    my ($pub_date, $ep_number, $title) = ($filename =~ /Have Gun—Will Travel ([\d\-]+) \((\d+)\) ([\w\s]+)/);
    $ep_number =~ s/^0+//;
    push @episodes, {
      filename  => $filename,
      title     => $title,
      pub_date  => $pub_date,
      ep_number => $ep_number,
    };
  }
}
my $vars = {
  title      => 'Have Gun Will Travel',
  owner_name => 'Old-Time Radio Researchers',
  image      => 'https://archive.org/download/OTRR_Maintained_Have_Gun_Will_Travel/OTRR_Maintained_Have_Gun_Will_Travel.jpg',
  link       => 'https://www.otrr.org/',
  summary    => 'Radio program that aired 1958-1960. Long description here: https://archive.org/details/OTRR_Maintained_Have_Gun_Will_Travel',
  per_ep_root_url => 'https://archive.org/download/OTRR_Have_Gun_Singles',
  episodes   => [ @episodes ],
};

$tt->process('feed.rss.tt', $vars, 'have_gun_will_travel.rss')
  || die $tt->error(), "\n";

__DATA__
00 OTRR Introduction.mp3
Have Gun—Will Travel 1958-11-23 (001) Strange Vendetta.flac
Have Gun—Will Travel 1958-11-30 (002) Road to Wickenburg.flac