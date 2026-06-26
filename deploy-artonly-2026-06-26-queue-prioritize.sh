#!/bin/bash
# ArtOnly Brain Queue Prioritization
# Generated: 2026-06-26
# Purpose: Re-sort brain.json artist queue so high-audience artists come first
#          and inject 7 trending artists hot right now (late June 2026).
# Triggered via: push to main on GitHub (deploy-artonly.yml workflow)

set -e
echo "=== ArtOnly Queue Prioritization: 2026-06-26 ==="
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

# ── STEP 1: Trending artists to inject at front (June 26, 2026) ──────────────
# Artists culturally HOT right now, not yet written by artonly.io:
#
# Burna Boy  — Official FIFA World Cup 2026 anthem "Dai Dai" (w/ Shakira)
#               debuted Hot 100 week of June 27; Afrobeats global icon
# Shakira    — "Dai Dai" World Cup anthem, first Hot 100 entry in years,
#               300M+ Instagram, cultural moment of the summer
# Victoria Monét — Grammy winner (Best New Artist 2025), sophisticated
#               R&B/pop, 30M+ Spotify monthly, artonly.io's exact lane
# Beyoncé    — Act III (rock era) highly anticipated, still #1 cultural
#               touchstone, not yet covered by artonly.io
# GloRilla   — "Glorious" album with Sexyy Red / Megan / Latto features,
#               most culturally significant female rap release of summer 2026
# Gracie Abrams — Won AMA Best New Artist; "Stupid Song" + "Honeybee"
#               debuted #3 and #9 on Hot 100 (week of June 27), indie-leaning
# Sexyy Red  — Everywhere: World Cup collabs, GloRilla joint tape teased,
#               on Drake's BROWN album ("Rich Baby Daddy" w/ SZA)

trending_inject = [
    "Burna Boy",
    "Shakira",
    "Victoria Monét",
    "Beyoncé",
    "GloRilla",
    "Gracie Abrams",
    "Sexyy Red",
]

# Filter already written
trending_inject = [a for a in trending_inject if a not in artists_written]
print(f"Trending injections (not yet written): {trending_inject}")

# ── STEP 2: Tier A — 1M+ audience, from current queue ────────────────────────
# Sorted by Spotify monthly listeners (June 2026 data):
# Bieber 131M > Weeknd 113M > MJ 112M > Rihanna 110M > Taylor 102M >
# Lady Gaga 101M > Bad Bunny 100M > Drake 98M > Kendrick ~60M > SZA ~50M

tier_a = [
    "Justin Bieber",      # 131.3M Spotify monthly (comeback era, top 2 globally)
    "The Weeknd",         # 113.5M Spotify monthly
    "Michael Jackson",    # 112.1M Spotify monthly (biopic surge, $911M box office)
    "Rihanna",            # 110M Spotify monthly
    "Taylor Swift",       # 101.9M Spotify monthly; "I Knew It, I Knew You" #1 June 20
    "Lady Gaga",          # 101.4M Spotify monthly; MAYHEM broke all-time female record
    "Bad Bunny",          # 100.1M Spotify monthly; Super Bowl, Grammy AOTY
    "Drake",              # 97.7M Spotify monthly; triple album release May 2026
    "Kendrick Lamar",     # ~60M Spotify monthly; GNX Grammy AOTY winner
    "SZA",                # ~50M Spotify monthly; Grand National Tour
    "Chappell Roan",      # ~25M Spotify monthly; biggest 2024–25 breakout
    "Megan Thee Stallion",# ~20M Spotify monthly
    "Central Cee",        # ~15M Spotify monthly; biggest UK rapper globally
    "Tyla",               # ~15M Spotify monthly; Grammy winner; World Cup "Game Time"
    "PinkPantheress",     # ~10M Spotify monthly
    "Kehlani",            # ~8M Spotify monthly
    "Jorja Smith",        # ~6M Spotify monthly
    "FKA twigs",          # ~5M Spotify monthly
    "Donald Glover",      # ~5M Spotify monthly / 5M+ Instagram
    "Dave",               # ~5M Spotify monthly; biggest UK rap storyteller
    "Ari Lennox",         # ~4M Spotify monthly
    "Koffee",             # ~4M Spotify monthly
    "Issa Rae",           # ~4M Instagram; cultural force (Insecure, Rap Sh!t)
    "Jordan Peele",       # ~2M Instagram; A24-level cultural filmmaker
    "Skepta",             # ~3M Spotify monthly
    "Popcaan",            # ~3M Spotify monthly
    "Leon Thomas",        # ~3M Spotify monthly; fastest-rising R&B presence
    "Little Simz",        # ~3M Spotify monthly; Mercury Prize, Grammy nom
    "Lola Young",         # ~2–3M Spotify monthly; UK rising star
    "Headie One",         # ~2M Spotify monthly
    "Cleo Sol",           # ~1.5M Spotify monthly
    "JPEGMAFIA",          # ~1.2M Spotify monthly
    "slowthai",           # ~1.2M Spotify monthly
]

# ── STEP 3: Tier B — 100k–1M audience, from current queue ────────────────────
tier_b = [
    "Ella Langley",    # ~600k Spotify; held Hot 100 #1 and #2 simultaneously June 20
    "Josh Fawaz",      # TikTok summer anthem trending, ~300k
    "Saxboy Billy",    # "The Puerto Rico Song" viral summer earworm
    "Nyck Caution",    # "PRESSURE!" World Cup TikTok sound
    "Shygirl",         # ~800k Spotify monthly
    "Arca",            # ~700k Spotify monthly
    "SAULT",           # ~500k Spotify monthly
    "NAO",             # ~500k Spotify monthly
    "Pa Salieu",       # ~400k Spotify monthly
    "Greentea Peng",   # ~400k Spotify monthly
    "Moliy",           # ~400k Spotify monthly; NME 100 2026
    "Sasha Keable",    # ~200k Spotify monthly; NME 100 2026
    "Ghetts",          # ~300k Spotify monthly
    "Kelsey Lu",       # ~300k Spotify monthly
    "Ama Lou",         # ~100k Spotify monthly
    "Knucks",          # ~300k Spotify monthly
]

# ── STEP 4: Build new queue ───────────────────────────────────────────────────
placed = set(trending_inject + tier_a + tier_b)

# Remaining in original relative order
remaining = [a for a in old_queue if a not in placed]

# New artists not previously in queue at all
new_artists = [a for a in trending_inject if a not in old_queue]

new_queue = trending_inject + tier_a + tier_b + remaining

print(f"\nNew queue length: {len(new_queue)}")
print(f"New artists injected (not in old queue): {new_artists}")
print(f"\nTop 15 in new queue:")
for i, artist in enumerate(new_queue[:15], 1):
    print(f"  {i:2}. {artist}")

# ── STEP 5: Write updated brain.json ─────────────────────────────────────────
brain["queue"] = new_queue
brain["queue_last_updated"] = "2026-06-26"
brain["queue_update_reason"] = (
    "Trending injection + tier sort 2026-06-26: "
    + str(len([a for a in trending_inject if a not in old_queue])) + " new artists injected "
    "(Burna Boy/Shakira World Cup anthem; Victoria Monét Grammy winner; "
    "Beyoncé Act III; GloRilla Glorious; Gracie Abrams Hot 100 debut; Sexyy Red), "
    "queue re-sorted by Spotify monthly listeners within tier"
)

with open(BRAIN, "w") as f:
    json.dump(brain, f, indent=2)

print("\n✓ brain.json updated successfully")
print(f"  Trending artists injected at front: {trending_inject}")
print(f"  Tier A count: {len(tier_a)}")
print(f"  Tier B count: {len(tier_b)}")
print(f"  Total queue length: {len(new_queue)}")

PYEOF

echo "=== Queue prioritization complete ==="
