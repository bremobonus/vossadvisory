#!/bin/bash
# ArtOnly Queue Prioritization Deploy
# Generated: 2026-06-29
# Run this on your local machine to push the updated queue to the server:
#   sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-29-queue-prioritize.sh

set -e
echo "=== ArtOnly Queue Prioritize: 2026-06-29 ==="

python3 << 'PYEOF'
import json

b = json.load(open("artonly.io/agent/brain.json"))

written = set(b.get("artists_written", []))

# Trending artists to inject at front (verified not in written/queue)
trending_inject = [
    "BTS",           # ARIRANG March 2026, broke Spotify records (110M first-day streams)
    "Harry Styles",  # Kiss All The Time March 2026, 65.8M monthly listeners, biggest 2026 Spotify debut
    "Noah Kahan",    # The Great Divide April 2026, #1 US+UK, claimed entire US Spotify top 6
    "Myles Smith",   # Debut album June 19 2026, 23.5M monthly listeners
    "Jill Scott",    # To Whom This May Concern Feb 2026, first album in 11 years
    "Ibeyi",         # Offering June 26 2026, just dropped on own imprint
    "Alvaro Diaz",   # Omakase, praised by Rolling Stone as masterful
]

# Only inject if not already written
trending_inject = [a for a in trending_inject if a not in written]

current_queue = b.get("queue", [])

# Tier A: 1M+ Spotify/IG followers
tier_a = {
    "The Weeknd", "Justin Bieber", "Rihanna", "Taylor Swift", "Drake",
    "Bad Bunny", "Lady Gaga", "Michael Jackson", "Kendrick Lamar", "SZA",
    "Chappell Roan", "Megan Thee Stallion", "Tyla", "Central Cee", "Dave",
}

# Tier B: 100k to 1M followers
tier_b = {
    "Skepta", "Ella Langley", "PinkPantheress", "Kehlani", "Jorja Smith",
    "FKA twigs", "Little Simz", "Ari Lennox", "Lola Young", "Leon Thomas",
    "Popcaan", "Koffee", "Cleo Sol", "Headie One", "JPEGMAFIA", "slowthai",
}

# Filter out artists already written from tier sets
tier_a = {a for a in tier_a if a not in written}
tier_b = {a for a in tier_b if a not in written}

tier_a_in_queue = [a for a in current_queue if a in tier_a]
tier_b_in_queue = [a for a in current_queue if a in tier_b]
placed = set(trending_inject) | tier_a | tier_b
remaining = [a for a in current_queue if a not in placed]

new_queue = trending_inject + tier_a_in_queue + tier_b_in_queue + remaining

b["queue"] = new_queue

open("artonly.io/agent/brain.json", "w").write(json.dumps(b, indent=2))

print(f"Queue updated. Total: {len(new_queue)} artists")
print("Top 10:")
for i, a in enumerate(new_queue[:10], 1):
    print(f"  {i}. {a}")
PYEOF

echo "=== Queue prioritization complete ==="
