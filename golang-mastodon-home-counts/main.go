package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"sort"
	"time"

	"github.com/joho/godotenv"
	"github.com/mattn/go-mastodon"
)

type countEntry struct {
	Acct  string
	Count int
}

func sortByCountDescending(m map[string]int) []countEntry {
	var sorted []countEntry
	for k, v := range m {
		sorted = append(sorted, countEntry{Acct: k, Count: v})
	}
	sort.Slice(sorted, func(i, j int) bool {
		return sorted[i].Count > sorted[j].Count
	})
	return sorted
}

func main() {
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

	// Display sorted summary
	fmt.Println("\nSummary of Home Timeline Activity (last 24 hours):")

	fmt.Println("\n📝 Top Toots:")
	for _, entry := range sortByCountDescending(tootCount) {
		fmt.Printf("👤 @%s → %d toots\n", entry.Acct, entry.Count)
	}

	fmt.Println("\n🔁 Top Boosts:")
	for _, entry := range sortByCountDescending(boostCount) {
		fmt.Printf("👤 @%s → %d boosts\n", entry.Acct, entry.Count)
	}
}
