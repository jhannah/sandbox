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
	// Load secrets
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	server := os.Getenv("MASTODON_SERVER")
	token := os.Getenv("MASTODON_ACCESS_TOKEN")

	if server == "" || token == "" {
		log.Fatal("MASTODON_SERVER and MASTODON_ACCESS_TOKEN must be set in .env")
	}

	// Connect to Mastodon
	client := mastodon.NewClient(&mastodon.Config{
		Server:      server,
		AccessToken: token,
	})

	// Fetch home timeline
	timeline, err := client.GetTimelineHome(context.TODO(), nil)
	if err != nil {
		log.Fatal("Failed to fetch home timeline:", err)
	}

	// Analyze posts
	cutoff := time.Now().Add(-24 * time.Hour)
	tootCount := make(map[string]int)
	boostCount := make(map[string]int)

	for _, status := range timeline {
		if status.CreatedAt.Before(cutoff) {
			continue
		}

		var acct string
		if status.Reblog != nil {
			acct = status.Reblog.Account.Acct
			boostCount[acct]++
		} else {
			acct = status.Account.Acct
			tootCount[acct]++
		}
	}

	// Display summary
	fmt.Println("Summary of Home Timeline Activity (last 24 hours):")
	for acct := range tootCount {
		fmt.Printf("👤 @%s → 📝 %d toots\n", acct, tootCount[acct])
	}
	for acct := range boostCount {
		fmt.Printf("👤 @%s → 🔁 %d boosts\n", acct, boostCount[acct])
	}
}
