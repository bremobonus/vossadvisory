#!/bin/bash
# ArtOnly Queue Prioritization Deploy
# Generated: 2026-06-20
# Purpose: Inject trending artists + re-sort queue by audience tier
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-20-requeue.sh

set -e
echo "=== ArtOnly Queue Prioritization: 2026-06-20 ==="

python3 << 'PYEOF'
import json

BRAIN_PATH = "/home/dh_yadmw3/artonly.io/agent/brain.json"

with open(BRAIN_PATH) as f:
    brain = json.load(f)

artists_written = set(brain.get("artists_written", []))

# Trending NOW (June 20 2026) - injected at front, not yet written
# Josh Fawaz: "Like a Prayer" remix = #1 TikTok Summer Anthem 2026
# Saxboy Billy: "The Puerto Rico Song" viral summer earworm
# Nyck Caution: "PRESSURE!" soundtracking 120k World Cup TikToks
# The Weeknd: 113.5M Spotify monthly listeners
# Justin Bieber: 131.3M Spotify monthly listeners (comeback cycle)
# Rihanna: 110M Spotify monthly listeners
trending_inject = [
    "Josh Fawaz",
    "Saxboy Billy",
    "Nyck Caution",
    "The Weeknd",
    "Justin Bieber",
    "Rihanna",
]

# Tier A (1M+ audience) from original queue
tier_a = [
    "Taylor Swift",
    "Drake",
    "Bad Bunny",
    "Lady Gaga",
    "Michael Jackson",
    "Kendrick Lamar",
    "SZA",
    "Chappell Roan",
    "Megan Thee Stallion",
    "Tyla",
    "Central Cee",
    "Dave",
    "Skepta",
]

# Tier B (100k-1M audience) from original queue top 40
tier_b = [
    "Ella Langley",
    "PinkPantheress",
    "Kehlani",
    "Jorja Smith",
    "FKA twigs",
    "Little Simz",
    "Ari Lennox",
    "Lola Young",
    "Leon Thomas",
    "Popcaan",
    "Koffee",
    "Cleo Sol",
    "Headie One",
    "JPEGMAFIA",
    "slowthai",
    "Shygirl",
    "Arca",
    "SAULT",
]

# Tier C (10k-100k audience) from original queue top 40
tier_c = [
    "NAO",
    "Pa Salieu",
    "Greentea Peng",
    "Sasha Keable",
    "Moliy",
    "Ghetts",
    "Kelsey Lu",
    "Ama Lou",
    "Knucks",
]

# Remaining queue (original positions 41+)
remaining = [
    "Genesis Owusu", "Sampa the Great", "Florence Road", "clipping.",
    "Eartheater", "Injury Reserve", "MIKE", "billy woods", "Armand Hammer",
    "Vagabon", "Hawa", "Tkay Maidza", "Bbymutha", "Cecily Brown", "Nick Leon",
    "Vegyn", "Lee Gamble", "Amnesia Scanner", "Smerz", "Kelman Duran",
    "Elysia Crampton", "SPAZA", "Abena Koomson-Davis", "Msaki", "Blinky Bill",
    "Sen Morimoto", "Standing on the Corner", "Kerry James Marshall",
    "Njideka Akunyili Crosby", "Henry Taylor", "Titus Kaphar", "Wangechi Mutu",
    "Mickalene Thomas", "Theaster Gates", "Mark Bradford", "Dana Schutz",
    "Laura Owens", "Marlene Dumas", "Jenny Saville", "Rose Wylie",
    "Lubaina Himid", "Isaac Julien", "Wolfgang Tillmans", "Collier Schorr",
    "Taryn Simon", "Deana Lawson", "LaToya Ruby Frazier", "Donald Glover",
    "Lena Dunham", "Issa Rae", "Phoebe Waller-Bridge", "Bo Burnham",
    "Ramy Youssef", "Quinta Brunson", "Jerrod Carmichael", "Sam Levinson",
    "Janicza Bravo", "Dee Rees", "Ryan Coogler", "Chloe Zhao", "Barry Jenkins",
    "Jordan Peele", "Boots Riley", "Kogonada", "Andrew Dosunmu",
]

# Filter out any already-written artists from injections
clean_trending = [a for a in trending_inject if a not in artists_written]

new_queue = clean_trending + tier_a + tier_b + tier_c + remaining

old_len = len(brain.get("queue", []))
brain["queue"] = new_queue
brain["queue_last_updated"] = "2026-06-20"
brain["queue_update_reason"] = (
    "Trending injection + tier sort 2026-06-20: "
    + str(len(clean_trending)) + " trending artists injected at front, "
    "queue re-sorted A/B/C by audience tier"
)

with open(BRAIN_PATH, "w") as f:
    json.dump(brain, f, indent=2)

print(f"Queue updated: {old_len} -> {len(new_queue)} artists")
print(f"Trending injected: {clean_trending}")
print(f"Top 10: {new_queue[:10]}")
PYEOF

echo "=== Queue prioritization complete ==="
