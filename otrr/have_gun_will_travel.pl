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
Have Gun—Will Travel 1958-12-07 (003) Ella West.flac
Have Gun—Will Travel 1958-12-14 (004) The Outlaw.flac
Have Gun—Will Travel 1958-12-21 (005) The Hanging Cross.flac
Have Gun—Will Travel 1958-12-28 (006) No Visitors.flac
Have Gun—Will Travel 1959-01-04 (007) Helen of Abajinian.flac
Have Gun—Will Travel 1959-01-11 (008) The Englishman.flac
Have Gun—Will Travel 1959-01-18 (009) Three Bells to Perdido.flac
Have Gun—Will Travel 1959-01-25 (010) The Teacher.flac
Have Gun—Will Travel 1959-02-01 (011) A Matter of Ethics.flac
Have Gun—Will Travel 1959-02-08 (012) Killer's Widow.flac
Have Gun—Will Travel 1959-02-15 (013) The Return of Doctor Thackeray.flac
Have Gun—Will Travel 1959-02-22 (014) Winchester Quarantine.flac
Have Gun—Will Travel 1959-03-01 (015) Hey Boy's Revenge.flac
Have Gun—Will Travel 1959-03-08 (016) The Monster of Moon Ridge.flac
Have Gun—Will Travel 1959-03-15 (017) Death of a Young Gunfighter.flac
Have Gun—Will Travel 1959-03-22 (018) The Five Books of Owen Deaver.flac
Have Gun—Will Travel 1959-03-29 (019) Sense of Justice.flac
Have Gun—Will Travel 1959-04-05 (020) Maggie O'Bannion.flac
Have Gun—Will Travel 1959-04-12 (021) The Colonel and the Lady.flac
Have Gun—Will Travel 1959-04-19 (022) Birds of a Feather.flac
Have Gun—Will Travel 1959-04-26 (023) The Gunsmith.flac
Have Gun—Will Travel 1959-05-03 (024) Gunshy.flac
Have Gun—Will Travel 1959-05-10 (025) The Statue of San Sebastian.flac
Have Gun—Will Travel 1959-05-17 (026) The Silver Queen.flac
Have Gun—Will Travel 1959-05-24 (027) In an Evil Time.flac
Have Gun—Will Travel 1959-05-31 (028) Blind Courage.flac
Have Gun—Will Travel 1959-06-07 (029) Roped.flac
Have Gun—Will Travel 1959-06-14 (030) Bitter Wine.flac
Have Gun—Will Travel 1959-06-21 (031) North Fork.flac
Have Gun—Will Travel 1959-06-28 (032) Homecoming.flac
Have Gun—Will Travel 1959-07-05 (033) Comanche.flac
Have Gun—Will Travel 1959-07-12 (034) Young Gun.flac
Have Gun—Will Travel 1959-07-19 (035) Deliver the Body.flac
Have Gun—Will Travel 1959-07-26 (036) The Wager.flac
Have Gun—Will Travel 1959-08-02 (037) High Wire.flac
Have Gun—Will Travel 1959-08-09 (038) Finn Alley.flac
Have Gun—Will Travel 1959-08-16 (039) The Lady.flac
Have Gun—Will Travel 1959-08-23 (040) Bonanza.flac
Have Gun—Will Travel 1959-08-30 (041) Love-Bird.flac
Have Gun—Will Travel 1959-09-06 (042) All That Glitters.flac
Have Gun—Will Travel 1959-09-13 (043) Treasure Hunt.flac
Have Gun—Will Travel 1959-09-20 (044) Stardust.flac
Have Gun—Will Travel 1959-09-27 (045) Like Father.flac
Have Gun—Will Travel 1959-10-04 (046) Contessa Marie Desmoulins.flac
Have Gun—Will Travel 1959-10-11 (047) Stopover in Tombstone.flac
Have Gun—Will Travel 1959-10-18 (048) Anything I Want.flac
Have Gun—Will Travel 1959-10-25 (049) When in Rome.flac
Have Gun—Will Travel 1959-11-01 (050) Wedding Day.flac
Have Gun—Will Travel 1959-11-08 (051) Brother Lost.flac
Have Gun—Will Travel 1959-11-15 (052) Fair Fugitive.flac
Have Gun—Will Travel 1959-11-22 (053) Landfall.flac
Have Gun—Will Travel 1959-11-29 (054) Assignment in Stone's Crossing.flac
Have Gun—Will Travel 1959-12-06 (055) Bitter Vengeance.flac
Have Gun—Will Travel 1959-12-13 (056) Out of Evil.flac
Have Gun—Will Travel 1959-12-20 (057) Ranse Carnival.flac
Have Gun—Will Travel 1959-12-27 (058) About Face.flac
Have Gun—Will Travel 1960-01-03 (059) Return Engagement.flac
Have Gun—Will Travel 1960-01-10 (060) The Lonely One.flac
Have Gun—Will Travel 1960-01-17 (061) French Leave.flac
Have Gun—Will Travel 1960-01-24 (062) Nataemon.flac
Have Gun—Will Travel 1960-01-31 (063) The Boss.flac
Have Gun—Will Travel 1960-02-07 (064) Bring Him Back Alive.flac
Have Gun—Will Travel 1960-02-14 (065) The Dollhouse in Diamond Springs.flac
Have Gun—Will Travel 1960-02-21 (066) That Was No Lady.flac
Have Gun—Will Travel 1960-02-28 (067) Bad Bert.flac
Have Gun—Will Travel 1960-03-06 (068) Somebody Out There Hates Me.flac
Have Gun—Will Travel 1960-03-13 (069) Montana Vendetta.flac
Have Gun—Will Travel 1960-03-20 (070) Caesar's Wife.flac
Have Gun—Will Travel 1960-03-27 (071) They Told Me You Were Dead.flac
Have Gun—Will Travel 1960-04-03 (072) Shanghai Is a Verb.flac
Have Gun—Will Travel 1960-04-10 (073) So True, Mr. Barnum.flac
Have Gun—Will Travel 1960-04-17 (074) Prunella's Fella.flac
Have Gun—Will Travel 1960-04-24 (075) Irish Luck.flac
Have Gun—Will Travel 1960-05-01 (076) Dressed to Kill.flac
Have Gun—Will Travel 1960-05-08 (077) Pat Murphy.flac
Have Gun—Will Travel 1960-05-15 (078) Lina Countryman.flac
Have Gun—Will Travel 1960-05-22 (079) Dusty.flac
Have Gun—Will Travel 1960-05-29 (080) Lucky Penny.flac
Have Gun—Will Travel 1960-06-05 (081) Apache Concerto.flac
Have Gun—Will Travel 1960-06-12 (082) Search for Wylie Dawson.flac
Have Gun—Will Travel 1960-06-19 (083) The Too, Too Solid Town.flac
Have Gun—Will Travel 1960-06-26 (084) Doctor from Vienna.flac
Have Gun—Will Travel 1960-07-03 (085) Dad-Blamed Luck.flac
Have Gun—Will Travel 1960-07-10 (086) Five Days to Yuma.flac
Have Gun—Will Travel 1960-07-17 (087) Little Guns.flac
Have Gun—Will Travel 1960-07-24 (088) Way for the Delta Queen.flac
Have Gun—Will Travel 1960-07-31 (089) My Son Must Die.flac
Have Gun—Will Travel 1960-08-07 (090) Viva [part 1].flac
Have Gun—Will Travel 1960-08-14 (091) Extended Viva [part 2].flac
Have Gun—Will Travel 1960-08-21 (092) The Warrant.flac
Have Gun—Will Travel 1960-08-28 (093) For the Birds.flac
Have Gun—Will Travel 1960-09-04 (094) Eat Crow.flac
Have Gun—Will Travel 1960-09-11 (095) Deadline.flac
Have Gun—Will Travel 1960-09-18 (096) Nellie Watson's Boy.flac
Have Gun—Will Travel 1960-09-25 (097) Bringing Up Ollie.flac
Have Gun—Will Travel 1960-10-02 (098) Sam Crow.flac
Have Gun—Will Travel 1960-10-09 (099) Talika.flac
Have Gun—Will Travel 1960-10-16 (100) Hell Knows No Fury.flac
Have Gun—Will Travel 1960-10-23 (101) Stardust.flac
Have Gun—Will Travel 1960-10-30 (102) Oil.flac
Have Gun—Will Travel 1960-11-06 (103) The Odds.flac
Have Gun—Will Travel 1960-11-13 (104) The Map.flac
Have Gun—Will Travel 1960-11-20 (105) Martha Nell.flac
Have Gun—Will Travel 1960-11-27 (106) From Here to Boston.flac