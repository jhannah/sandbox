package main

import (
	"bytes"
	"encoding/json"
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

func main() {
	discordBotToken := os.Getenv("DISCORD_BOT_TOKEN")
	discordChannelID := os.Getenv("DISCORD_CHANNEL_ID")

	allActions := []Action{}

	for _, key := range actionNetworkAPIKeys {
		fmt.Println("Fetching from Action Network with API key:", key)

		next := ""
		for {
			actions, nextPage, err := fetchActions(key, next)
			if err != nil {
				log.Fatal(err)
			}
			allActions = append(allActions, actions...)
			if nextPage == "" {
				break
			}
			next = nextPage
		}
	}

	postedActions, err := loadPostedActions()
	if err != nil {
		fmt.Println("Error loading posted actions:", err)
		return
	}

	for _, action := range allActions {
		if _, posted := postedActions[action.ActionNetworkID]; posted {
			fmt.Printf("already in posted_actions.json: %s Skipping.\n", action.ActionNetworkID)
			continue
		}
		message := fmt.Sprintf("NEW: 📅 %s at %s (%s, %s)\n", action.Title, action.Location.Venue, action.Location.Locality, action.StartDate.Format(time.RFC1123))
		fmt.Print(message)
		postToDiscordChannel(discordBotToken, discordChannelID, message)
		err := createDiscordEvent(action)
		if err != nil {
			fmt.Println("Error creating Discord event:", err)
			continue
		}
		postedActions[action.ActionNetworkID] = true
	}

	err = savePostedActions(postedActions)
	if err != nil {
		fmt.Println("Error saving posted actions:", err)
	}

	fmt.Print("All done. Exiting.\n")
}

func prettyPrintJSON(raw []byte) {
	var pretty bytes.Buffer
	err := json.Indent(&pretty, raw, "", "  ")
	if err != nil {
		panic(err)
	}
	fmt.Println(pretty.String())
}
