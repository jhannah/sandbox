
The [Old-Time Radio Researches](https://www.otrr.org/)
have compiled thousands of episodes of old radio shows and uploaded them to the
[Internet Archive](https://archive.org/).

I love my podcast player, so I want to listen to those shows as podcasts.

This software generates RSS feeds you can stick in your podcast player app.

**Have Gun Will Travel:** 116 tracks (106 broadcasts 1958-1960, plus the
Paladin audition tapes, an introduction, a synopsis, and cast biographies):
* [Read all about the program and volunteers](https://archive.org/details/OTRR_Maintained_Have_Gun_Will_Travel)
  who saved the original audio.
* [RSS](https://raw.githubusercontent.com/jhannah/sandbox/refs/heads/main/otrr/have_gun_will_travel.rss)
  URL for your podcast player.

### Generating the feed

The feed is built in two steps. The episode list, file sizes, and runtimes all
come straight from the source [Internet Archive](https://archive.org/) item, so
there is no hand-maintained track list.

1. **Fetch the metadata** (only needed when the source item changes). This hits
   the archive.org metadata API once and caches every `.mp3`'s byte size and
   runtime to `metadata.json`:

   ```
   perl fetch_metadata.pl
   ```

   Requires HTTPS support for `HTTP::Tiny` (`cpanm IO::Socket::SSL Net::SSLeay`).

2. **Generate the RSS** from the cached metadata (no network access):

   ```
   perl have_gun_will_travel.pl
   ```

   This reads `metadata.json`, turns every `.mp3` in the item into an episode
   (parsing the broadcast date, episode number, and title from each filename),
   and writes `have_gun_will_travel.rss`.

### Debugging Notes

[RSS validation](https://podba.se/validate/?url=https://raw.githubusercontent.com/jhannah/sandbox/refs/heads/main/otrr/have_gun_will_travel.rss)
