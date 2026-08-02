#!/usr/bin/env python3
"""Summarize a Lichess NDJSON game export: win/loss/draw per opponent, per game type.

Usage: ./analyze_games.py [games.ndjson] [my_username]
"""

import json
import sys
from collections import defaultdict

infile = sys.argv[1] if len(sys.argv) > 1 else "games.ndjson"
me = (sys.argv[2] if len(sys.argv) > 2 else "dferret").lower()


def side_label(player):
    """Human name for a player dict: a real user, a bot, or anonymous."""
    if "user" in player:
        return player["user"]["name"]
    if "aiLevel" in player:
        return f"Stockfish level {player['aiLevel']}"
    return "Anonymous"


# (opponent, game_type) -> counts
stats = defaultdict(lambda: {"win": 0, "loss": 0, "draw": 0, "ongoing": 0})
skipped = 0

with open(infile) as fh:
    for line in fh:
        line = line.strip()
        if not line:
            continue
        g = json.loads(line)

        white, black = g["players"]["white"], g["players"]["black"]
        if side_label(white).lower() == me:
            my_color, opponent = "white", side_label(black)
        elif side_label(black).lower() == me:
            my_color, opponent = "black", side_label(white)
        else:
            skipped += 1
            continue

        # `perf` distinguishes variants (atomic, crazyhouse...) as well as
        # speeds; fall back to `speed` if it is missing.
        game_type = g.get("perf") or g.get("speed") or "unknown"

        rec = stats[(opponent, game_type)]
        if g.get("status") in ("started", "created"):
            rec["ongoing"] += 1
        elif "winner" not in g:
            rec["draw"] += 1  # stalemate, agreement, insufficient material, etc.
        elif g["winner"] == my_color:
            rec["win"] += 1
        else:
            rec["loss"] += 1


def pct(rec):
    """Win % over decided games; draws count as half a win."""
    decided = rec["win"] + rec["loss"] + rec["draw"]
    if decided == 0:
        return None
    return 100.0 * (rec["win"] + 0.5 * rec["draw"]) / decided


rows = []
for (opponent, game_type), rec in stats.items():
    rows.append((opponent, game_type, rec, pct(rec)))

# Most-played opponents first, then by game type.
played = defaultdict(int)
for opponent, _, rec, _ in rows:
    played[opponent] += rec["win"] + rec["loss"] + rec["draw"] + rec["ongoing"]
rows.sort(key=lambda r: (-played[r[0]], r[0].lower(), r[1]))

hdr = f"{'Opponent':<20} {'Type':<15} {'W':>4} {'L':>4} {'D':>4} {'Score%':>8} {'Live':>5}"
print(hdr)
print("-" * len(hdr))
for opponent, game_type, rec, p in rows:
    score = f"{p:.1f}" if p is not None else "-"
    live = rec["ongoing"] or ""
    print(
        f"{opponent:<20} {game_type:<15} {rec['win']:>4} {rec['loss']:>4} "
        f"{rec['draw']:>4} {score:>8} {live:>5}"
    )

# Totals by game type.
by_type = defaultdict(lambda: {"win": 0, "loss": 0, "draw": 0, "ongoing": 0})
overall = {"win": 0, "loss": 0, "draw": 0, "ongoing": 0}
for (_, game_type), rec in stats.items():
    for k in rec:
        by_type[game_type][k] += rec[k]
        overall[k] += rec[k]

print()
print(f"{'TOTAL by type':<36} {'W':>4} {'L':>4} {'D':>4} {'Score%':>8} {'Live':>5}")
print("-" * len(hdr))
for game_type, rec in sorted(by_type.items()):
    p = pct(rec)
    score = f"{p:.1f}" if p is not None else "-"
    print(
        f"{'':<20} {game_type:<15} {rec['win']:>4} {rec['loss']:>4} "
        f"{rec['draw']:>4} {score:>8} {rec['ongoing'] or '':>5}"
    )

p = pct(overall)
print(
    f"{'':<20} {'ALL':<15} {overall['win']:>4} {overall['loss']:>4} "
    f"{overall['draw']:>4} {f'{p:.1f}' if p else '-':>8} {overall['ongoing'] or '':>5}"
)

if skipped:
    print(f"\n({skipped} games skipped: '{me}' was not a player)", file=sys.stderr)
