package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"
)

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

func createDiscordEvent(action Action) error {
	event := DiscordEvent{
		Name:               action.Title,
		Description:        action.Description,
		ScheduledStartTime: action.StartDate,
		ScheduledEndTime:   action.EndTime,
		PrivacyLevel:       2, // GUILD_ONLY
		EntityType:         3, // EXTERNAL
	}
	event.EntityMetadata.Location = action.Location.Venue

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
