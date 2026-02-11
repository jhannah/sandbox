https://www.bbc.com/news/articles/c36162xn4x5o
^ copy / paste

# Strip commas and % signs, which confused SQLite3:
perl -pe 's/[,%]//g' < 2024_nebraska_election.csv > 2024_filtered.csv

sqlite3 2024.sqlite3
CREATE TABLE IF NOT EXISTS "votes"(
  "County" TEXT, "Candidate" TEXT, "Party" TEXT,
  "Votes" INT, "Vote_share" REAL, "Expected" REAL);
.mode tabs
.import --skip 1 2024_filtered.csv votes
SELECT party, sum(votes) FROM votes GROUP BY 1 ORDER BY votes DESC;
SELECT party, sum(votes) FROM votes
  WHERE county NOT IN ("Douglas", "Lancaster", "Sarpy")
  GROUP BY 1 ORDER BY votes DESC;

SELECT county, votes FROM votes WHERE party = 'Democrat' ORDER BY votes DESC;
Douglas	148733
Lancaster	81012
Sarpy	43825


