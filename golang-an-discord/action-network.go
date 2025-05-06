package main

import "time"

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
	Identifiers []string  `json:"identifiers"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	StartDate   time.Time `json:"start_date"`
	EndTime     time.Time `json:"end_time"`
	Location    struct {
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
