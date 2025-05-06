package main

import (
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/joho/godotenv"
)

const postedActionsFile = "posted_actions.json"

var (
	discordBotToken      string
	discordGuildID       string
	actionNetworkAPIKeys []string
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	discordBotToken = os.Getenv("DISCORD_BOT_TOKEN")
	discordGuildID = os.Getenv("DISCORD_GUILD_ID")
	if discordBotToken == "" || discordGuildID == "" {
		log.Fatal("One or more required environment variables are missing.")
	}

	rawKeys := os.Getenv("ACTIONNETWORK_API_KEYS")
	if rawKeys == "" {
		log.Fatal("ACTIONNETWORK_API_KEYS must be set in .env")
	}
	actionNetworkAPIKeys = strings.Split(rawKeys, ",")
}

/*
func main() {
	actions, err := fetchActions()
	if err != nil {
		fmt.Println("Error fetching actions:", err)
		return
	}

	postedActions, err := loadPostedActions()
	if err != nil {
		fmt.Println("Error loading posted actions:", err)
		return
	}

	for _, action := range actions {
		if _, posted := postedActions[action.ID]; posted {
			continue
		}

		err := createDiscordEvent(action)
		if err != nil {
			fmt.Println("Error creating Discord event:", err)
			continue
		}

		postedActions[action.ID] = true
	}

	err = savePostedActions(postedActions)
	if err != nil {
		fmt.Println("Error saving posted actions:", err)
	}
}
*/

func main() {
	discordBotToken := os.Getenv("DISCORD_BOT_TOKEN")
	discordChannelID := os.Getenv("DISCORD_CHANNEL_ID")

	// You can get these strings by typing \:dfflirt: into Discord
	messages := []string{"<:dfflirt:796580268374884372>", "<:dfflirt1:796582372078125097>", "<:dfflirt2:796582435332161567>"}
	messages = []string{"Let's go fetch from AN..."}
	messages = []string{}
	for _, message := range messages {
		fmt.Println(message)
		err := postToDiscordChannel(discordBotToken, discordChannelID, message)
		if err != nil {
			fmt.Println("Error posting to Discord:", err)
		} else {
			fmt.Println("Message posted successfully!")
		}
	}

	for _, key := range actionNetworkAPIKeys {
		fmt.Println("Fetching from Action Network with API key:", key)

		next := ""
		for {
			actions, nextPage, err := fetchActions(key, next)
			if err != nil {
				log.Fatal(err)
			}
			for _, action := range actions {
				message := fmt.Sprintf("📅 %s at %s (%s, %s)\n", action.Title, action.Location.Venue, action.Location.Locality, action.StartDate.Format(time.RFC1123))
				fmt.Print(message)
				postToDiscordChannel(discordBotToken, discordChannelID, message)
			}
			if nextPage == "" {
				break
			}
			next = nextPage
		}
	}

	/*
		action := Action{
			ID:          "1",
			Title:       "super party",
			Description: "it's lit, yo",
			StartTime:   time.Now().Add(24 * time.Hour),
			EndTime:     time.Now().Add(26 * time.Hour),
			Location:    "your mom's house",
		}
		err := createDiscordEvent(action)
		if err != nil {
			fmt.Println("Error creating Discord event:", err)
		}
	*/
}
