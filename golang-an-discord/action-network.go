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
	EndTime         time.Time `json:"end_time"`
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
	BrowserUrl   string `json:"browser_url"`
	Instructions string `json:"instructions"`
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

	for i := range actions {
		if id, ok := getActionNetworkID(actions[i]); ok {
			fmt.Printf("setting ActionNetworkID: %s\n", id)
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
