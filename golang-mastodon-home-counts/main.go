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

	client := mastodon.NewClient(&mastodon.Config{
		Server:      server,
		AccessToken: token,
	})

	cutoff := time.Now().Add(-24 * time.Hour)
	tootCount := make(map[string]int)
	boostCount := make(map[string]int)

	var maxID mastodon.ID
	limit := 40
	pageNum := 1

	for {
		fmt.Printf("Fetching page #%d...\n", pageNum)

		pg := &mastodon.Pagination{
			MaxID: maxID,
			Limit: int64(limit),
		}

		statuses, err := client.GetTimelineHome(context.Background(), pg)
		if err != nil {
			log.Fatalf("Error fetching timeline: %v", err)
		}

		if len(statuses) == 0 {
			break
		}

		stop := false
		for _, status := range statuses {
			if status.CreatedAt.Before(cutoff) {
				stop = true
				break
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

		if stop {
			break
		}

		maxID = statuses[len(statuses)-1].ID
		pageNum++
	}

	// Output summary
	fmt.Println("\nSummary of Home Timeline Activity (last 24 hours):")
	for acct, count := range tootCount {
		fmt.Printf("👤 @%s → 📝 %d toots\n", acct, count)
	}
	for acct, count := range boostCount {
		fmt.Printf("👤 @%s → 🔁 %d boosts\n", acct, count)
	}
}
