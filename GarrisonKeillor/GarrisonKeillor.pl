#! env perl

use 5.40.0;
use Template;
use POSIX qw(strftime);
use Time::Local qw(timegm);

# Placeholder base date: noon UTC on 1989-01-01. Noon (not midnight) so that
# converting to a US timezone can't roll the displayed date back a day.
my $base_epoch = timegm(0, 0, 12, 1, 0, 1989 - 1900);

my $tt = Template->new({
  # INCLUDE_PATH => 'templates',
  INTERPOLATE  => 1,
}) || die "$Template::ERROR\n";

my @episodes;
while (<DATA>) {
  chomp;
  next unless /\w/;
  # GarrisonKeillor-MoreNewsFromLakeWobegon/01-Pontoon Boat-Garrison Keillor.mp3
  my ($folder, $filename) = split m{/}, $_, 2;
  my ($ep_number, $title) = split /[- ]/, $filename, 2;
  $title =~ s/\-Garrison Keillor\.mp3$//;
  # We don't actually know the real date per track. Stagger one day per episode
  # from the base so players that sort by pubDate keep them in episode order.
  my $epoch = $base_epoch + ($ep_number - 1) * 86400;
  my $pub_date = strftime('%a, %d %b %Y %H:%M:%S +0000', gmtime($epoch));
  push @episodes, {
    filename  => $filename,
    title     => $title,
    pub_date  => $pub_date,
    ep_number => $ep_number,
    folder    => $folder,
    duration  => "0:20:00",   # On average, 20 minutes. We don't actually know from here how long each actually is
  };
}
my $vars = {
  title      => 'Garrison Keillor Archive - More News from Lake Wobegon',
  owner_name => 'Garrison Keillor',
  # Drew didn't unload any square image I can use. Podcast players needs square images.
  # So use this square image from another Internet Archive uploader:
  image      => 'https://archive.org/download/garrison-keillor/Garrison%20Keillor.png',
  link       => 'https://archive.org/details/GarrisonKeillor-MoreNewsFromLakeWobegon',
  summary    => 'Thanks to my fiance\'s spectacular (and nearly all out of print) Garrison Keillor audio collection, we thus begin a series of Garrison Keillor Archives from 1989. Contains many excellent and classic recitations by Mr. Keillor. Internet Archive\'d by Drew Evan Dobbs.',
  per_ep_root_url => 'https://archive.org/download',
  episodes   => [ @episodes ],
};

$tt->process('feed.rss.tt', $vars, 'GarrisonKeillor.rss')
  || die $tt->error(), "\n";

__DATA__
GarrisonKeillor-MoreNewsFromLakeWobegon/01-Pontoon Boat-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/02-Author-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/03-The Freedon Of The Press-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/04-Vicks-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/05-Truckstop-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/06-Smokes-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/07-The Perils Of Spring-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/08-Let Us Pray-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/09-Alaska-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/10-Uncle Al's Gift-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/11-Skinny Dip-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/12-Homecoming-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/13 Rotten Apples-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/14 O Death-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/15 The Wise Men-Garrison Keillor.mp3
GarrisonKeillor-MoreNewsFromLakeWobegon/16 A Trip to Grand Rapids-Garrison Keillor.mp3

GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/17 Me and Choir-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/18 A Day in the Life of Clarence Bunsen-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/19 A Letter from Jim-Fiction-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/20 The Living Flag-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/21 The Tollefson Boy Goes to College-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/22 Tomato Butt-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/23 Chamber of Commerce-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/24 Dog Days of August-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/25 Mrs Bergey and the Schubert Carillon Piano-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/26 Giant Decoys-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/27 Daryl Tolleruds Long Day-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/28 Hog Slaughter-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/29 Thanksgiving-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/30 The Royal Family-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/31 Guys on Ice-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/32 James Lundeens Christmas-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/33 The Christmas Story Re-Told-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/34 New Years Eve from New York-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/35 Storm Home-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/36 Meeting Donny Hart at the Bus Stop-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/37 A Day at the Circus with Mazumbo-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/38 The Tolleruds Korean Baby-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/39 Sylvester Kruegers Desk-Garrison Keillor.mp3
GarrisonKeillorArchiveVol02-SeasonsFourCassetteSet/40 Babe Ruth Visits Lake Woebegon-Garrison Keillor.mp3

GarrisonKeillorArchiveVol.03-GospelBirdsPt2/41 Mammoth Concert Tickets-Garrison Keillor.mp3
GarrisonKeillorArchiveVol.03-GospelBirdsPt2/42 Bruno, the Fishing Dog-Garrison Keillor.mp3
GarrisonKeillorArchiveVol.03-GospelBirdsPt2/43 Gospel Birds-Garrison Keillor.mp3

GarrisonKeillorArchive04-20thAnniversary-4-CDset/44 O Captain, My Captain-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/45 Casey at the Bat-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/46 Rhubarb-01--Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/47 Revival Tent-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/48 The Perfect Day-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/49 Carl's Dog Story-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/50 The Lake Superior Canyon Project-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/51 The Elegance of Winter-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/52 Answering Machine-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/53 A Kohler Thanksgiving-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/54 The Living Flag-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/55 Buddy Holly and the Pharaohs of Rhythm-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/56 Cherry Picker-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/57 Graduation Day-Garrison Keillor.mp3
GarrisonKeillorArchive04-20thAnniversary-4-CDset/58 Raccoons-Garrison Keillor.mp3

GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/59 Mr. Bergy's Christmas-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/60 Powdermilk Biscuits-Shy People-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/61 Fearmonger's Shoppe-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/62 Rex the Hokstaeder's Dog-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/63 Uncle Ed Tollefson-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/64 Hotel Minnesota-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/65 Ajua!-Garrison Keillor.mp3
GarrisonKeillorArchiveVol05-aPrairieHomeChristmas-TheFamilyRadio-GospelBirdsPt1/66 Pastor Ingquist's Trip to Orlando-Garrison Keillor.mp3

GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/67 Berthas Kitty Boutique-Cat Box Video-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/68 Greenwich Village Days-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/69 Cafe Boeuf Secrets of the Kitchen-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/70 Mels Big Boy Buffet-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/71 The Ketchup Advisory Board-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/72 Rhubarb-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/73 Sweet Corn-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/74 The Suns Gonna Shine Someday-Garrison Keillor.mp3
GarrisonKeillorArchiveVol06-ComedyTheater-RhubarbCassettes/75 Yellow Ribbon-Garrison Keillor.mp3
