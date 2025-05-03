Playing around with Golang for Action Network API -> Discord API.

The original version of this (first commit) written by ChatGPT 4o

> Write me a Golang program that reads from actionnetwork.org REST API and posts new "Actions" into Discord API as "Guild Scheduled Events."
> Modify the program so I can keep my secrets like discordBotToken in a separate file that I don't put in GitHub.

```
go mod init github.com/jhannah/sandbox/golang-an-discord
go get github.com/joho/godotenv
go run main.go
```
