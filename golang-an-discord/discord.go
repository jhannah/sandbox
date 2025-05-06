package main

import "time"

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
