# Lichess game history — win/loss by opponent and game type

Pulls the full game history for a Lichess account and reports win / loss / draw
percentages broken down by opponent and by game type (bullet, blitz, rapid,
classical, correspondence, and variants such as racingKings).

Account analyzed: <https://lichess.org/@/dferret>

## Procedure

### 1. Get an API token

The bulk export endpoint currently returns `404 {"error":"Not found"}` for
anonymous requests (see [Notes](#notes-on-the-lichess-api) below), so a token is
required:

1. Go to <https://lichess.org/account/oauth/token/create>
2. No scopes need to be checked — public game data requires none.
3. Copy the token and either export it, or drop it in a file next to the
   script (both are gitignored):

```sh
export LICHESS_TOKEN=lip_xxxxxxxxxxxx
# or:
echo 'lip_xxxxxxxxxxxx' > lichess.org/.lichess_token
```

### 2. Download the games

```sh
./fetch_games.sh dferret games.ndjson
```

This calls `GET https://lichess.org/api/games/user/{username}` with
`Accept: application/x-ndjson`, so each line of `games.ndjson` is one game
object. `max` is omitted, so every game is downloaded. The script retries with
increasing backoff, because Lichess allows only one in-flight request per IP.

### 3. Summarize

```sh
./analyze_games.py games.ndjson dferret
```

Prints one row per (opponent, game type) plus totals:

```
Opponent             Type               W    L    D   Score%  Live
-------------------------------------------------------------------
```

- **W / L / D** — wins, losses, draws.
- **Score%** — standard chess scoring over *decided* games: a draw counts as
  half a win, i.e. `(W + 0.5*D) / (W + L + D)`. Games still in progress are
  excluded from the percentage.
- **Live** — games currently in progress against that opponent.

Opponents are ordered by number of games played.

Games against the engine show up as `Stockfish level N`, and unregistered
opponents as `Anonymous`.

## Notes on the Lichess API

Verified against the live API on 2026-08-02:

- `GET /api/user/{username}` — works anonymously. Returns aggregate counts
  (`count.win` / `.loss` / `.draw`) and per-speed ratings, but **not** a
  per-opponent breakdown, which is why the full export is needed.
- `GET /api/user/{username}/current-game` — works anonymously (HTTP 200).
- `GET /api/games/user/{username}` — the bulk export. Documented as allowing
  anonymous access at 20 games/sec, but it returned **HTTP 404** for every
  request tried, including for other accounts (`thibault`) and with no query
  parameters at all. Other endpoints on the same host worked from the same
  machine, and the result was identical with the network sandbox disabled, so
  this is Lichess refusing the request rather than a local network problem.
  Use a token.
- With a token the export works and is fast (338 games in a couple of seconds).
- `ongoing=true` is required, or in-progress games are silently left out of the
  export. Without it the download returned 326 games; with it, 338 — the
  difference being the 12 games in progress.
- Concurrent requests are rejected with
  `429 {"error":"Please only run 1 request(s) at a time"}`. Make requests
  strictly sequentially.
- Omitting the `Accept: application/x-ndjson` header returns PGN, and an HTML
  error page rather than JSON when something is wrong — which makes failures
  much harder to read.

## Files

- [fetch_games.sh](fetch_games.sh) — downloads the NDJSON export, with retry/backoff.
- [analyze_games.py](analyze_games.py) — computes the per-opponent, per-type table.
- `games.ndjson` — the downloaded export (not committed).
