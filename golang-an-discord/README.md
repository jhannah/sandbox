Playing around with Golang for Action Network API -> Discord API.

* read from the [Action Network REST API](https://actionnetwork.org/docs/)
* write to [Discord REST API](https://discord.com/developers/docs/reference)
   * specifically [Guild Scheduled Events](https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event)

The original version of this (first commit) written by ChatGPT 4o

> Write me a Golang program that reads from actionnetwork.org REST API and posts new "Actions" into Discord API as "Guild Scheduled Events."
> Modify the program so I can keep my secrets like discordBotToken in a separate file that I don't put in GitHub.

You'll need an `.env` file with your secrets in it that looks like this:

```
ACTIONNETWORK_API_KEY=your_real_api_key
DISCORD_BOT_TOKEN=your_real_discord_token   ("Client Secret")
DISCORD_GUILD_ID=your_real_guild_id         ("Server ID")
DISCORD_CHANNEL_ID=your_real_channel_id
```

Then run these:

```
go mod init github.com/wherever_your_code_lives
go get github.com/joho/godotenv
go run main.go
```
