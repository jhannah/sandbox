#!/usr/bin/env python3
"""Import a PocketCasts GDPR text dump into a SQLite database.

The dump is a series of sections, each shaped like:

    Section Name
    --------
    col1,col2,col3      <- CSV header
    val,val,val         <- CSV data rows
    <blank line>

Each section becomes a table (all columns TEXT). Fields are parsed with the
csv module so quoted commas (URLs, titles) are handled correctly.
"""
import csv
import re
import sqlite3
import sys
from pathlib import Path

SRC = Path(sys.argv[1] if len(sys.argv) > 1 else "jhannah_pocketcasts_GDPR_dump_20260619.txt")
DB = Path(sys.argv[2] if len(sys.argv) > 2 else "jhannah_pocketcasts.sqlite3")

DASHES = re.compile(r"^-{3,}$")


def slug(name: str) -> str:
    """Turn a section title into a safe table name."""
    return re.sub(r"\W+", "_", name.strip().lower()).strip("_")


def column(name: str) -> str:
    """Turn a CSV header cell into a safe column name."""
    s = re.sub(r"\W+", "_", name.strip().lower()).strip("_")
    return s or "col"


def split_sections(lines):
    """Yield (title, [body lines]) tuples.

    A section starts when a line is immediately followed by a dashes line.
    """
    sections = []
    i = 0
    n = len(lines)
    while i < n:
        if i + 1 < n and DASHES.match(lines[i + 1]):
            title = lines[i].strip()
            i += 2  # skip title + dashes
            body = []
            while i < n:
                # next section header? (line followed by dashes)
                if i + 1 < n and DASHES.match(lines[i + 1]) and lines[i].strip():
                    break
                body.append(lines[i])
                i += 1
            sections.append((title, body))
        else:
            i += 1
    return sections


def main():
    raw = SRC.read_text(encoding="utf-8", errors="replace").splitlines()
    sections = split_sections(raw)

    if DB.exists():
        DB.unlink()
    con = sqlite3.connect(DB)
    cur = con.cursor()

    for title, body in sections:
        # Drop blank trailing lines; the first non-blank line is the CSV header.
        rows = list(csv.reader(line for line in body if line.strip() != ""))
        if not rows:
            print(f"  (skip empty section: {title!r})")
            continue
        header = rows[0]
        data = rows[1:]
        table = slug(title)
        cols = [column(c) for c in header]
        # de-dup column names
        seen = {}
        uniq = []
        for c in cols:
            if c in seen:
                seen[c] += 1
                c = f"{c}_{seen[c]}"
            else:
                seen[c] = 0
            uniq.append(c)
        cols = uniq

        col_defs = ", ".join(f'"{c}" TEXT' for c in cols)
        cur.execute(f'CREATE TABLE "{table}" ({col_defs})')
        placeholders = ", ".join("?" * len(cols))
        # pad/truncate rows to header width
        norm = []
        for r in data:
            if len(r) < len(cols):
                r = r + [None] * (len(cols) - len(r))
            elif len(r) > len(cols):
                r = r[: len(cols)]
            norm.append(r)
        cur.executemany(
            f'INSERT INTO "{table}" VALUES ({placeholders})', norm
        )
        print(f"  {table}: {len(norm)} rows, {len(cols)} cols")

    con.commit()
    con.close()
    print(f"Wrote {DB}")


if __name__ == "__main__":
    main()
