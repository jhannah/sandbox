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
MASTODON_ACCESS_TOKEN=your_access_token
MASTODON_SERVER=https://your.instance.domain
```

Then run these:

```
go mod tidy
go run main.go
```
