package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"
)

const postedActionsFile = "posted_actions.json"

var (
	discordBotToken     string
	discordGuildID      string
	actionNetworkAPIKey string
)

// Action represents a simplified structure of an Action Network action.
type Action struct {
	ID          string    `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	StartTime   time.Time `json:"start_time"`
	Location    string    `json:"location"`
}

// DiscordEvent represents the payload to create a Discord scheduled event.
type DiscordEvent struct {
	Name               string    `json:"name"`
	Description        string    `json:"description"`
	ScheduledStartTime time.Time `json:"scheduled_start_time"`
	PrivacyLevel       int       `json:"privacy_level"`
	EntityType         int       `json:"entity_type"`
	EntityMetadata     struct {
		Location string `json:"location"`
	} `json:"entity_metadata"`
}

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	discordBotToken = os.Getenv("DISCORD_BOT_TOKEN")
	discordGuildID = os.Getenv("DISCORD_GUILD_ID")
	actionNetworkAPIKey = os.Getenv("ACTIONNETWORK_API_KEY")

	if discordBotToken == "" || discordGuildID == "" || actionNetworkAPIKey == "" {
		log.Fatal("One or more required environment variables are missing.")
	}
}

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

// Stub — replace with real Action Network API call
func fetchActions() ([]Action, error) {
	return []Action{
		{
			ID:          "example-action-001",
			Title:       "Community Meetup",
			Description: "Let's talk about change!",
			StartTime:   time.Now().Add(36 * time.Hour),
			Location:    "Public Library, Omaha",
		},
	}, nil
}

func createDiscordEvent(action Action) error {
	event := DiscordEvent{
		Name:               action.Title,
		Description:        action.Description,
		ScheduledStartTime: action.StartTime,
		PrivacyLevel:       2, // GUILD_ONLY
		EntityType:         3, // EXTERNAL
	}
	event.EntityMetadata.Location = action.Location

	payload, err := json.Marshal(event)
	if err != nil {
		return err
	}

	url := fmt.Sprintf("https://discord.com/api/v10/guilds/%s/scheduled-events", discordGuildID)
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(payload))
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bot "+discordBotToken)
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusCreated {
		body, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("discord API error: %s", string(body))
	}

	return nil
}

func loadPostedActions() (map[string]bool, error) {
	data, err := os.ReadFile(postedActionsFile)
	if err != nil {
		if os.IsNotExist(err) {
			return make(map[string]bool), nil
		}
		return nil, err
	}

	var posted map[string]bool
	err = json.Unmarshal(data, &posted)
	return posted, err
}

func savePostedActions(posted map[string]bool) error {
	data, err := json.MarshalIndent(posted, "", "  ")
	if err != nil {
		return err
	}
	return os.WriteFile(postedActionsFile, data, 0644)
}
