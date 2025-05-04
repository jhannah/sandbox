package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/joho/godotenv"
	"github.com/mattn/go-mastodon"
)

func main() {
	// Load environment variables
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	server := os.Getenv("MASTODON_SERVER")
	token := os.Getenv("MASTODON_ACCESS_TOKEN")

	if server == "" || token == "" {
		log.Fatal("MASTODON_SERVER and MASTODON_ACCESS_TOKEN must be set in .env")
	}

	// Initialize Mastodon client
	client := mastodon.NewClient(&mastodon.Config{
		Server:      server,
		AccessToken: token,
	})

	// Set the cutoff time to 24 hours ago
	cutoff := time.Now().Add(-24 * time.Hour)

	// Maps to count toots and boosts per account
	tootCount := make(map[string]int)
	boostCount := make(map[string]int)

	// Pagination parameters
	var maxID mastodon.ID
	limit := 40 // Maximum allowed by Mastodon API

	for {
		// Set up pagination
		pg := &mastodon.Pagination{
			MaxID: maxID,
			Limit: int64(limit),
		}

		// Fetch a page of the home timeline
		statuses, err := client.GetTimelineHome(context.Background(), pg)
		if err != nil {
			log.Fatalf("Error fetching timeline: %v", err)
		}

		// Break if no more statuses are returned
		if len(statuses) == 0 {
			break
		}

		// Process each status
		for _, status := range statuses {
			// Check if the status is older than the cutoff
			if status.CreatedAt.Before(cutoff) {
				// Since statuses are returned in descending order, we can stop processing
				break
			}

			// Determine the account responsible for the status
			var acct string
			if status.Reblog != nil {
				acct = status.Reblog.Account.Acct
				boostCount[acct]++
			} else {
				acct = status.Account.Acct
				tootCount[acct]++
			}
		}

		// Update maxID for the next page
		maxID = statuses[len(statuses)-1].ID
	}

	// Display the summary
	fmt.Println("Summary of Home Timeline Activity (last 24 hours):")
	for acct, count := range tootCount {
		fmt.Printf("👤 @%s → 📝 %d toots\n", acct, count)
	}
	for acct, count := range boostCount {
		fmt.Printf("👤 @%s → 🔁 %d boosts\n", acct, count)
	}
}
