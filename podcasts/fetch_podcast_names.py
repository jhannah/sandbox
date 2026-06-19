#!/usr/bin/env python3
"""Resolve PocketCasts podcast uuids to titles via the public API and cache
them in a `podcast_names` table.

Safe to re-run: only uuids not already cached (with a non-null title) are
fetched, so an interrupted run resumes where it left off.
"""
import gzip
import json
import sqlite3
import sys
import time
import urllib.request
from pathlib import Path

DB = Path(sys.argv[1] if len(sys.argv) > 1 else "jhannah_pocketcasts.sqlite3")
URL = "https://cache.pocketcasts.com/mobile/podcast/full/{}"

con = sqlite3.connect(DB)
cur = con.cursor()
cur.execute(
    """CREATE TABLE IF NOT EXISTS podcast_names (
         uuid TEXT PRIMARY KEY,
         title TEXT,
         author TEXT,
         fetched_at TEXT,
         error TEXT
       )"""
)
con.commit()

# Every uuid we care about: subscribed podcasts + anything referenced elsewhere.
cur.execute(
    """
    WITH all_uuids AS (
        SELECT uuid FROM podcasts
        UNION SELECT podcast FROM history
        UNION SELECT podcast FROM up_next
        UNION SELECT podcast FROM bookmarks
    )
    SELECT uuid FROM all_uuids
    WHERE uuid IS NOT NULL AND uuid <> ''
      AND uuid NOT IN (SELECT uuid FROM podcast_names WHERE title IS NOT NULL)
    """
)
todo = [r[0] for r in cur.fetchall()]
print(f"{len(todo)} uuids to fetch")


def fetch(uuid):
    req = urllib.request.Request(
        URL.format(uuid),
        headers={"User-Agent": "Mozilla/5.0", "Accept-Encoding": "gzip"},
    )
    with urllib.request.urlopen(req, timeout=20) as resp:
        raw = resp.read()
        if resp.headers.get("Content-Encoding") == "gzip":
            raw = gzip.decompress(raw)
    d = json.loads(raw)["podcast"]
    return d.get("title"), d.get("author")


for i, uuid in enumerate(todo, 1):
    title = author = err = None
    try:
        title, author = fetch(uuid)
    except Exception as e:  # noqa: BLE001 - record any failure, keep going
        err = f"{type(e).__name__}: {e}"
    cur.execute(
        """INSERT INTO podcast_names (uuid, title, author, fetched_at, error)
           VALUES (?, ?, ?, datetime('now'), ?)
           ON CONFLICT(uuid) DO UPDATE SET
             title=excluded.title, author=excluded.author,
             fetched_at=excluded.fetched_at, error=excluded.error""",
        (uuid, title, author, err),
    )
    if i % 25 == 0:
        con.commit()
        print(f"  {i}/{len(todo)}  last: {title or err}")
    time.sleep(0.1)  # be polite

con.commit()
ok = cur.execute("SELECT COUNT(*) FROM podcast_names WHERE title IS NOT NULL").fetchone()[0]
bad = cur.execute("SELECT COUNT(*) FROM podcast_names WHERE title IS NULL").fetchone()[0]
print(f"Done. {ok} resolved, {bad} failed/empty.")
con.close()
