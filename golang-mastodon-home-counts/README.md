Playing around with Golang:

* read from a Mastodon server
* summarize how many toots and boosts each user put in your Home timeline
over the last 24 hours

The original version of this (first commit) written by ChatGPT 4o

> Write me a Golang program that reads my home timeline from Mastodon over
> the last 24 hours and summarizes for each account I follow how many toots
> and boosts that account has caused to be in my home timeline. Keep my
> secrets in an .env file.

You'll need an `.env` file with your secrets in it that looks like this:

```
MASTODON_SERVER=https://your.instance.domain
MASTODON_ACCESS_TOKEN=your_access_token
MASTODON_CUTOFF_HOURS=2
```

Then run these:

```
go mod init github.com/wherever_your_code_lives
go run main.go
```
