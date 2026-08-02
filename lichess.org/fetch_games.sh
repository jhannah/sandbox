#!/usr/bin/env bash
# Download a Lichess user's full game history as NDJSON.
#
# Usage: ./fetch_games.sh [username] [outfile]
#
# Notes on the Lichess API:
#   - Endpoint: GET https://lichess.org/api/games/user/{username}
#   - Send `Accept: application/x-ndjson` to get one JSON object per line.
#     Without it you get PGN (and an HTML 404 page if anything is off).
#   - Anonymous requests are allowed but throttled to 20 games/sec, and
#     Lichess permits only ONE in-flight request per IP: concurrent calls
#     get `429 {"error":"Please only run 1 request(s) at a time"}`.
#   - Setting LICHESS_TOKEN (a personal API token from
#     https://lichess.org/account/oauth/token) raises the limit to 60
#     games/sec for your own games and makes throttling far less likely.
#   - `max` is omitted so that all games are downloaded.

set -euo pipefail

USER_NAME="${1:-dferret}"
OUT="${2:-games.ndjson}"
# `ongoing=true` is needed or in-progress games are silently omitted.
URL="https://lichess.org/api/games/user/${USER_NAME}?pgnInJson=false&clocks=false&evals=false&opening=false&ongoing=true"

# Token from $LICHESS_TOKEN, or from a .lichess_token file next to this script.
TOKEN="${LICHESS_TOKEN:-}"
TOKEN_FILE="$(dirname "$0")/.lichess_token"
if [[ -z "$TOKEN" && -r "$TOKEN_FILE" ]]; then
  TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"
fi

AUTH=()
if [[ -n "$TOKEN" ]]; then
  AUTH=(-H "Authorization: Bearer ${TOKEN}")
else
  echo "warning: no token; anonymous bulk export is currently rejected by Lichess" >&2
fi

for attempt in 1 2 3 4 5 6 7 8; do
  code=$(curl -sS --compressed \
    -H "Accept: application/x-ndjson" \
    ${AUTH[@]+"${AUTH[@]}"} \
    -w '%{http_code}' -o "${OUT}.tmp" \
    "$URL")

  if [[ "$code" == "200" ]]; then
    mv "${OUT}.tmp" "$OUT"
    echo "OK: $(wc -l < "$OUT") games written to $OUT"
    exit 0
  fi

  echo "attempt ${attempt}: HTTP ${code} $(head -c 120 "${OUT}.tmp")" >&2
  sleep $((attempt * 15))
done

echo "Failed to download games after 8 attempts" >&2
exit 1
