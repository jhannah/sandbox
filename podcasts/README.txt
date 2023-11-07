
Pocket Casts mobile:
  Profile > Settings > Import & export OPML

iTunes: 
  Click on Podcasts
  File > Library > Export Playlist > Format: OPML


See also ../blogs where I'm dumping OPMLs from RSS readers for blogs.


Huh. Not a single podcast we all listen to:
$ perl -nE '/text="(.*?)"/ && say $1' *.opml | sort | uniq -c | sort -rn | head
   3 Reply All
   3 Jay Flaunts His Ignorance. The podcast.
   3 Dan Carlin's Hardcore History
   3 Cortex
   2 This American Life
   2 The Web Platform Podcast
   2 The Way I Heard It with Mike Rowe
   2 The Flop House
   2 The Changelog
   2 The Adventure Zone


