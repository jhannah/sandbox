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
	EndTime     time.Time `json:"end_time"`
	Location    string    `json:"location"`
}

// DiscordEvent represents the payload to create a Discord scheduled event.
type DiscordEvent struct {
	Name               string    `json:"name"`
	Description        string    `json:"description"`
	ScheduledStartTime time.Time `json:"scheduled_start_time"`
	ScheduledEndTime   time.Time `json:"scheduled_end_time"`
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
	messages = []string{}
	for _, message := range messages {
		err := postToDiscordChannel(discordBotToken, discordChannelID, message)
		if err != nil {
			fmt.Println("Error posting to Discord:", err)
		} else {
			fmt.Println("Message posted successfully!")
		}
	}

	action := Action{
		ID:          "1",
		Title:       "super party",
		Description: "it's lit, yo",
		StartTime:   time.Now().Add(24 * time.Hour),
		EndTime:     time.Now().Add(48 * time.Hour),
		Location:    "your mom's house",
	}
	err := createDiscordEvent(action)
	if err != nil {
		fmt.Println("Error creating Discord event:", err)
	}
}

func postToDiscordChannel(discordBotToken string, discordChannelID string, message string) error {
	url := fmt.Sprintf("https://discord.com/api/v10/channels/%s/messages", discordChannelID)

	payload := map[string]string{"content": message}
	body, err := json.Marshal(payload)
	if err != nil {
		return err
	}

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bot "+discordBotToken)
	req.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode >= 300 {
		return fmt.Errorf("discord API error: %s", resp.Status)
	}

	return nil
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
		ScheduledEndTime:   action.EndTime,
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
