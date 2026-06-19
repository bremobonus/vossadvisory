#!/bin/bash
# ArtOnly Brain Queue Prioritization
# Generated: 2026-06-19
# Purpose: Re-sort brain.json artist queue so high-audience artists come first
#          and inject 5 trending artists that should be covered immediately.
# Run via GitHub Actions (deploy-artonly.yml) push to main

set -e
echo "=== ArtOnly Queue Prioritization: 2026-06-19 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

BRAIN = "/home/dh_yadmw3/artonly.io/agent/brain.json"

with open(BRAIN) as f:
    brain = json.load(f)

old_queue = brain.get("queue", [])
artists_written = set(brain.get("artists_written", []))

print(f"Current queue length: {len(old_queue)}")
print(f"Artists already written: {len(artists_written)}")

# ── STEP 1: Trending artists to inject at front ───────────────────────────────
# Not in artists_written, culturally hot as of June 19 2026:
# - Taylor Swift: "I Knew It, I Knew You" debuted #1 Hot 100 week of June 20
# - Drake: Iceman/Habibti/Maid of Honour trilogy — biggest streaming debut 2026,
#           first artist to hold Billboard 200 #1, #2, #3 simultaneously
# - Bad Bunny: Super Bowl halftime, first Latin artist 100M monthly Spotify listeners,
#               Grammy Album of the Year for "DeBÍ TiRAR MáS FOToS"
# - Lady Gaga: MAYHEM album, broke all-time female Spotify monthly listener record
#               (124M), "Die With A Smile" approaching 2B streams
# - Michael Jackson: "Michael" biopic highest-grossing music biopic ever ($911M),
#                     catalog streams doubled, 102M monthly Spotify listeners

trending_inject = [
    "Taylor Swift",
    "Drake",
    "Bad Bunny",
    "Lady Gaga",
    "Michael Jackson",
]

# Filter out any already written
trending_inject = [a for a in trending_inject if a not in artists_written]
print(f"Trending injections (not yet written): {trending_inject}")

# ── STEP 2: Tier A — 1M+ audience, from current queue ────────────────────────
# Sorted roughly by estimated Spotify monthly listeners / Instagram reach.
# Ella Langley moved to very front of Tier A: holds Hot 100 #1 AND #2
# simultaneously (week of June 20, 2026) — unprecedented solo chart feat.

tier_a = [
    "Kendrick Lamar",    # ~60M+ monthly Spotify, Grammy AOTY for GNX
    "SZA",               # ~50M+ monthly, Grand National Tour
    "Chappell Roan",     # ~20-30M monthly, biggest 2024-25 breakout
    "Ella Langley",      # Hot 100 #1 AND #2 simultaneously June 20 2026
    "Megan Thee Stallion", # ~20M+ monthly
    "Tyla",              # ~15M monthly, Grammy winner
    "Central Cee",       # ~15M monthly, biggest UK rapper
    "PinkPantheress",    # ~10M monthly
    "Kehlani",           # ~5-6M monthly
    "Jorja Smith",       # ~5M+ monthly
    "FKA twigs",         # ~4-5M monthly
    "Little Simz",       # ~2-3M monthly, Mercury Prize, growing fast
    "Ari Lennox",        # ~3-4M monthly
    "Lola Young",        # rising UK star, 2M+ monthly
]

# ── STEP 3: Tier B — 100k-1M, from current queue ─────────────────────────────

tier_b = [
    "Dave",              # ~2M monthly UK rapper
    "Leon Thomas",       # ~500k-1M monthly
    "Skepta",            # ~2M monthly
    "Popcaan",           # ~1-2M monthly
    "Koffee",            # ~3-4M monthly
    "Cleo Sol",          # ~1M+ monthly
    "Headie One",        # ~500k-1M monthly
    "JPEGMAFIA",         # ~500k-1M monthly
    "slowthai",          # ~1-2M monthly
    "Shygirl",           # ~500k-1M, growing
    "NAO",               # ~500k-1M monthly
    "Pa Salieu",         # ~200k-500k monthly
]

# ── STEP 4: Build new queue ───────────────────────────────────────────────────
# Priority: trending injections → Tier A → Tier B → remaining original order

placed = set(trending_inject + tier_a + tier_b)

# Remaining in original order (preserves Tier C/D relative ordering)
remaining = [a for a in old_queue if a not in placed]

# Add any newly injected artists not already in old_queue
new_artists = [a for a in trending_inject if a not in old_queue]

new_queue = trending_inject + tier_a + tier_b + remaining

print(f"\nNew queue length: {len(new_queue)}")
print(f"New artists injected: {new_artists}")
print(f"\nTop 15 in new queue:")
for i, artist in enumerate(new_queue[:15], 1):
    print(f"  {i:2}. {artist}")

# ── STEP 5: Write updated brain.json ─────────────────────────────────────────

brain["queue"] = new_queue
brain["last_updated"] = "2026-06-19"

with open(BRAIN, "w") as f:
    json.dump(brain, f, indent=2)

print("\n✓ brain.json updated successfully")
print(f"  Trending artists injected at front: {trending_inject}")
print(f"  Tier A artists moved up: {tier_a}")
print(f"  Total queue length: {len(new_queue)}")

PYEOF

echo "=== Queue prioritization complete ==="
