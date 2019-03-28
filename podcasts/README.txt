
Pocket Casts mobile:
  Profile > Settings > Import & export OPML

iTunes: 
  Click on Podcasts
  File > Library > Export Playlist > Format: OPML



Huh. Not a single podcast we all listen to:
$ perl -nE '/text="(.*?)"/ && say $1' *.opml | sort | uniq -c | sort -rn | head
   3 Waking Up with Sam Harris
   3 The Changelog
   3 Jay Flaunts His Ignorance. The podcast.
   3 JS Party
   2 This American Life
   2 The Web Platform Podcast
   2 The Flop House
   2 The Adventure Zone
   2 TalkScript
   2 Stop Podcasting Yourself
