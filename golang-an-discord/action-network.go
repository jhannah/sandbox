package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"
)

type ActionNetworkApiResponse struct {
	Embedded struct {
		Events []Action `json:"osdi:events"`
	} `json:"_embedded"`
	Links struct {
		Next struct {
			Href string `json:"href"`
		} `json:"next"`
	} `json:"_links"`
}

// Action represents a simplified structure of an Action Network action.
type Action struct {
	ActionNetworkID string
	Identifiers     []string  `json:"identifiers"`
	Title           string    `json:"title"`
	Description     string    `json:"description"`
	StartDate       time.Time `json:"start_date"`
	EndDate         time.Time `json:"end_date"`
	Status          string    `json:"status"`
	Type            string    `json:"type"`
	FeaturedImage   string    `json:"featured_image_url"`
	TotalAccepted   int       `json:"total_accepted"`
	TotalDeclined   int       `json:"total_declined"`
	TotalTentative  int       `json:"total_tentative"`
	TotalCount      int       `json:"total_count"`
	Location        struct {
		Venue        string   `json:"venue"`
		AddressLines []string `json:"address_lines"`
		Locality     string   `json:"locality"`
		Region       string   `json:"region"`
		PostalCode   string   `json:"postal_code"`
		Country      string   `json:"country"`
		Location     struct {
			Latitude  float64 `json:"latitude"`
			Longitude float64 `json:"longitude"`
			Accuracy  string  `json:"accuracy"`
		} `json:"location"`
	} `json:"location"`
	BrowserUrl    string    `json:"browser_url"`
	Instructions  string    `json:"instructions"`
	CreatedDate   time.Time `json:"created_date"`
	ModifiedDate  time.Time `json:"modified_date"`
	OriginSystem  string    `json:"origin_system"`
	OriginDetails struct {
		Source   string `json:"source"`
		SourceID string `json:"source_id"`
	} `json:"origin_details"`
	Tags  []string `json:"tags"`
	Links struct {
		Self struct {
			Href string `json:"href"`
		} `json:"self"`
		Creator struct {
			Href string `json:"href"`
		} `json:"creator"`
		Attendances struct {
			Href string `json:"href"`
		} `json:"attendances"`
	} `json:"_links"`
}

func fetchActions(apiKey string, pageURL string) ([]Action, string, error) {
	if pageURL == "" {
		pageURL = "https://actionnetwork.org/api/v2/events"
	}
	req, err := http.NewRequest("GET", pageURL, nil)
	if err != nil {
		return nil, "", err
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("OSDI-API-Token", apiKey)

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, "", err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return nil, "", fmt.Errorf("API error %d: %s", resp.StatusCode, string(body))
	}

	var result ActionNetworkApiResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, "", err
	}

	actions := result.Embedded.Events
	next := result.Links.Next.Href

	// AN returns a slice of strings of various IDs. For our "cache" (posted_actions.json)
	// we're going to use the action_network: one.
	for i := range actions {
		if id, ok := getActionNetworkID(actions[i]); ok {
			actions[i].ActionNetworkID = id
		}
	}

	return actions, next, nil
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

func getActionNetworkID(a Action) (string, bool) {
	for _, id := range a.Identifiers {
		if strings.HasPrefix(id, "action_network:") {
			return strings.TrimPrefix(id, "action_network:"), true
		}
	}
	return "", false
}
