
Pocket Casts mobile:
  Profile > Settings > Import & export OPML

iTunes: 
  Click on Podcasts
  File > Library > Export Playlist > Format: OPML



Huh. Not a single podcast we all listen to:
$ perl -nE '/text="(.*?)"/ && say $1' *.opml | sort | uniq -c | sort -rn | head
   3 The Changelog
   3 Reply All
   3 Jay Flaunts His Ignorance. The podcast.
   3 JS Party
   3 Dan Carlin's Hardcore History
   2 Waking Up with Sam Harris
   2 This American Life
   2 The Web Platform Podcast
   2 The Way I Heard It with Mike Rowe
   2 The Flop House

