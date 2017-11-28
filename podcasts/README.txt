
Pocket Casts:
  Left side bar > Settings > Import & export > Export subscriptions

iTunes: 
  Click on Podcasts
  File > Library > Export Playlist > Format: OPML



Huh. Not a single podcast we all 3 listen to:
$ perl -nE '/text="(.*?)"/ && say $1' *.opml | sort | uniq -c | sort -rn | head
   2 Waking Up with Sam Harris
   2 My Brother, My Brother And Me
   2 Jay Flaunts His Ignorance. The podcast.
   2 Harmontown
   2 EconTalk
   2 Dan Carlin's Hardcore History
   1 iPhreaks Show
   1 feeds
   1 You Made It Weird with Pete Holmes
   1 You Are Not So Smart
