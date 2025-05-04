package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
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

	cutoffHoursStr := os.Getenv("MASTODON_CUTOFF_HOURS")
	cutoffHours, err := strconv.Atoi(cutoffHoursStr)
	if err != nil || cutoffHours <= 0 {
		log.Fatalf("Invalid MASTODON_CUTOFF_HOURS: %v", cutoffHoursStr)
	}
	cutoff := time.Now().Add(-time.Duration(cutoffHours) * time.Hour)

	if server == "" || token == "" {
		log.Fatal("MASTODON_SERVER and MASTODON_ACCESS_TOKEN must be set in .env")
	}

	client := mastodon.NewClient(&mastodon.Config{
		Server:      server,
		AccessToken: token,
	})

	activityCount := make(map[string]int)

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
			} else {
				acct = status.Account.Acct
			}
			activityCount[acct]++
		}

		if stop {
			break
		}

		maxID = statuses[len(statuses)-1].ID
		pageNum++
	}

	// Display sorted summary
	fmt.Println("\nSummary of Home Timeline Activity (last", cutoffHoursStr, "hours):")

	fmt.Println("\n📊 Top Activity (Toots + Boosts):")
	for _, entry := range sortByCountDescending(activityCount) {
		fmt.Printf("👤 @%s → %d\n", entry.Acct, entry.Count)
	}
}
