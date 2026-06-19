## Export your OPML file (your list of podcast feeds)

```
Pocket Casts mobile:
  Profile > Settings > Import & export OPML

iTunes: 
  Click on Podcasts
  File > Library > Export Playlist > Format: OPML
```

See also `../blogs` where I'm dumping OPMLs from RSS readers for blogs.

Huh. Not a single podcast we all listen to:
```
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
```

## GDPR dump from Pocket Casts

While there's
[no way in-app](https://support.pocketcasts.com/knowledge-base/view-and-manage-listening-history-features-limitations-and-faqs/)
to dump your Listening History from Pocket Casts, the very nice people at `support(at)pocketcasts(dot)com`
are happy to send you a GDPR dump of all your data (back to 2018).

Then you can use `import_to_sqlite.py` to turn that text file dump into a SQLite database.
Then you can query your SQLite database. e.g.:

```sql
✗ sqlite3 -header -column jhannah_pocketcasts.sqlite3 "
SELECT substr(modified,1,7) AS yyyymm,
       COUNT(*) AS episodes_touched,
       ROUND(SUM(CAST(played_up_to AS REAL))/60.0/60, 1) AS hours_listened
FROM episodes
WHERE playing_status IN ('2','3')          -- in-progress + completed
  AND played_up_to IS NOT NULL
GROUP BY 1
ORDER BY 1;
"
\yyyymm   episodes_touched  hours_listened
-------  ----------------  --------------
2018-06  44                31.6
2018-07  101               59.3
2018-08  79                68.5
...
```

When you also want the names of the podcasts, you can run `fetch_podcast_names.py` to grab
those names (and other metadata) from the Pocket Casts API. Then you can run queries like
"show me my top 20 podcasts of all time, by listening hours":

```sql
✗ sqlite3 -header -column jhannah_pocketcasts.sqlite3 "
WITH map AS (
  SELECT uuid AS episode, podcast FROM history
  UNION SELECT uuid, podcast FROM up_next
  UNION SELECT episode, podcast FROM bookmarks
),
agg AS (
  SELECT COALESCE(n.title, m.podcast) AS podcast,
         COUNT(*)                     AS episodes,
         ROUND(SUM(CAST(e.played_up_to AS REAL))/3600.0, 1) AS hours
  FROM episodes e
  JOIN map m ON m.episode = e.uuid
  LEFT JOIN podcast_names n ON n.uuid = m.podcast
  WHERE e.playing_status IN ('2','3')
  GROUP BY m.podcast
)
SELECT ROW_NUMBER() OVER (ORDER BY hours DESC) AS rank,
       podcast, episodes, hours
FROM agg
ORDER BY hours DESC
LIMIT 20;
"
rank  podcast                                    episodes  hours
----  -----------------------------------------  --------  -----
1     Up First from NPR                          789       229.9
2     Drunk Ex-Pastors                           135       207.6
3     1st Sky Omaha                              88        164.1
...
```
