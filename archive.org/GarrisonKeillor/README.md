
[Drew Evan Dobbs](https://archive.org/details/GarrisonKeillor-MoreNewsFromLakeWobegon)
has compiled 75 episodes of Garrison Keillor: A Prairie Home Companion: News from Lake Wobegon (and more)
onto the [Internet Archive](https://archive.org/).

I love my podcast player, so I want to listen to those shows as podcasts.

This software generates an RSS feed you can stick in your podcast player app.
The feed contains these collections from the Internet Archive:

* Garrison Keillor Archive Vol. 01 - More News from Lake Wobegon
* Garrison Keillor Archive Vol. 02 - Seasons Four-Cassette Set
* Garrison Keillor Archive Vol. 03 - Gospel Birds Pt. 2
* Garrison Keillor Archive Vol. 04 - 20th Anniversary 4-CD Set
* Garrison Keillor Archive Vol. 05 - A Prairie Home Christmas-The Family Radio-Gospel Birds Pt. 1
* Garrison Keillor Archive Vol. 06 - Comedy Theater & Rhubarb cassette sets

[RSS URL](https://raw.githubusercontent.com/jhannah/sandbox/refs/heads/main/archive.org/GarrisonKeillor/GarrisonKeillor.rss)
for your podcast player.

### Generating the feed

The feed is built in two steps. The episode list, file sizes, and runtimes all
come straight from the source [Internet Archive](https://archive.org/) items, so
there is no hand-maintained track list.

1. **Fetch the metadata** (only needed when the set of source items changes).
   This hits the archive.org metadata API once per item and caches every
   `.mp3`'s byte size and runtime to `metadata.json`, keyed by folder. The list
   of source items lives at the top of `fetch_metadata.pl`:

   ```
   perl fetch_metadata.pl
   ```

   Requires HTTPS support for `HTTP::Tiny` (`cpanm IO::Socket::SSL Net::SSLeay`).

2. **Generate the RSS** from the cached metadata (no network access):

   ```
   perl GarrisonKeillor.pl
   ```

   This reads `metadata.json`, turns every `.mp3` into an episode (the episode
   number is the filename's numeric prefix, the title is the rest), sorts by
   episode number, and writes `GarrisonKeillor.rss`.

### Debugging Notes

[RSS validation](https://beamly.com/tools/podcast-feed-validator/)
