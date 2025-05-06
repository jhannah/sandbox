package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"html"
	"io"
	"net/http"
	"regexp"
	"strings"
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
		Description:        htmlToDiscord(action.Description),
		ScheduledStartTime: action.StartDate,
		ScheduledEndTime:   action.EndDate,
		PrivacyLevel:       2, // GUILD_ONLY
		EntityType:         3, // EXTERNAL
	}
	event.EntityMetadata.Location = action.Location.Venue

	payload, err := json.Marshal(event)
	if err != nil {
		return err
	}
	prettyPrintJSON(payload)

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

	// Discord returns 200 OK
	//   not the more correct 201 Created (http.StatusCreated)
	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		fmt.Printf(
			"Discord API error:\nStatus: %d %s\nHeaders: %v\nBody: %s",
			resp.StatusCode,
			http.StatusText(resp.StatusCode),
			resp.Header,
			string(body),
		)
		return fmt.Errorf("discord API error: %d", resp.StatusCode)
	}

	return nil
}

func htmlToDiscord(input string) string {
	// Normalize line endings
	input = strings.ReplaceAll(input, "\r\n", "\n")

	// Convert common block elements to newlines
	input = strings.ReplaceAll(input, "<p>", "\n\n")
	input = strings.ReplaceAll(input, "</p>", "")
	input = strings.ReplaceAll(input, "<br>", "\n")
	input = strings.ReplaceAll(input, "<br/>", "\n")
	input = strings.ReplaceAll(input, "<ul>", "")
	input = strings.ReplaceAll(input, "</ul>", "")
	input = strings.ReplaceAll(input, "<ol>", "")
	input = strings.ReplaceAll(input, "</ol>", "")

	// List items
	input = strings.ReplaceAll(input, "<li>", "• ")
	input = strings.ReplaceAll(input, "</li>", "\n")

	// Bold and italics
	input = strings.ReplaceAll(input, "<strong>", "**")
	input = strings.ReplaceAll(input, "</strong>", "**")
	input = strings.ReplaceAll(input, "<b>", "**")
	input = strings.ReplaceAll(input, "</b>", "**")
	input = strings.ReplaceAll(input, "<em>", "*")
	input = strings.ReplaceAll(input, "</em>", "*")
	input = strings.ReplaceAll(input, "<i>", "*")
	input = strings.ReplaceAll(input, "</i>", "*")

	// Convert <a href="URL">text</a> to [text](URL)
	linkRE := regexp.MustCompile(`<a\s+href=["']([^"']+)["'][^>]*>(.*?)</a>`)
	input = linkRE.ReplaceAllString(input, "[$2]($1)")

	// Strip all remaining tags
	tagRE := regexp.MustCompile(`<[^>]+>`)
	input = tagRE.ReplaceAllString(input, "")

	// Unescape HTML entities
	input = html.UnescapeString(input)

	// Clean up extra whitespace
	input = strings.TrimSpace(input)

	return input
}
