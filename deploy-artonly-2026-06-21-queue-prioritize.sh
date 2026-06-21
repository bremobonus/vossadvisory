#!/bin/bash
# ArtOnly Brain Queue Prioritization
# Generated: 2026-06-21
# Purpose: Re-sort brain.json artist queue so high-audience artists come first
#          and inject trending artists that should be covered immediately.
# Run via GitHub Actions (deploy-artonly.yml) push to main

set -e
echo "=== ArtOnly Queue Prioritization: 2026-06-21 ==="
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
# Not yet written as of June 21 2026, culturally hot RIGHT NOW:
#
# - Gorillaz: "The Mountain" debuted UK Albums Chart #1 (Feb 2026),
#              first #1 since Humanz (2017), #7 US Billboard 200,
#              9th studio album draws Indian classical + electronic.
#              ~8-10M Spotify monthly listeners.
#
# - Billie Eilish: "HIT ME HARD AND SOFT" ongoing cultural moment,
#                   ~50M Spotify monthly listeners, multiple Grammys,
#                   massive Gen Z icon — not yet covered on ArtOnly.
#
# - Noah Kahan: "The Great Divide" (2026) — 31M+ Spotify monthly listeners,
#                Rolling Stone best albums 2026, Vermont folk-pop breakthrough.
#
# - Hemlocke Springs: debut album "The Apple Under the Sea" (June 2026),
#                      453k Spotify listeners, Pitchfork / RS best new music,
#                      eccentric pop critical darling of the moment.
#
# - Moses Sumney: "græ" era still culturally resonant, guest on Little Simz
#                  "Lotus" (June 2026), highly acclaimed — not yet written.
#
# - MEEK: UK breakout artist, "Fabulous" viral debut, NME 100 featured,
#          fearlessly authentic, June 2026 moment.
#
# - June McDoom: Big Thief / NME 100 2026 emerging artist, indie credentials.

trending_inject = [
    "Gorillaz",
    "Billie Eilish",
    "Noah Kahan",
    "Hemlocke Springs",
    "Moses Sumney",
    "MEEK",
    "June McDoom",
]

# Filter out any already written
trending_inject = [a for a in trending_inject if a not in artists_written]
print(f"Trending injections (not yet written): {trending_inject}")

# ── STEP 2: Tier A — 1M+ audience, from current queue ────────────────────────
# Little Simz placed first: new album "Lotus" (June 6 2026, Metacritic 86)
# is the single most time-sensitive write in the queue right now.

tier_a = [
    "Little Simz",    # ~2-3M monthly Spotify; "Lotus" album June 6 2026 Metacritic 86
    "Koffee",         # ~2-3M monthly; Grammy winner (Best Reggae Album 2020)
    "NAO",            # ~1M+ monthly; Atlantic Records, significant UK R&B following
    "SAULT",          # ~1-2M monthly; anonymous collective, massive critical status
    "JPEGMAFIA",      # 2.1M Spotify monthly listeners, 1.1M followers
    "Cleo Sol",       # ~1-2M monthly; SAULT adjacent, breakout UK soul artist
    "slowthai",       # ~800k-1M monthly; major UK rapper, Booker Prize adjacency
]

# ── STEP 3: Tier B — 100k-1M, from current queue (original order) ────────────

tier_b = [
    "Headie One",      # ~800k monthly; UK drill pioneer, major-label reach
    "Arca",            # ~500-700k monthly; XL Recordings, international acclaim
    "Shygirl",         # ~500k monthly; growing fast, Night Slug / PC Music world
    "Pa Salieu",       # ~300k monthly; Mercury Prize nominated, UK street rap
    "Greentea Peng",   # ~400k monthly; UK psych-soul, growing cult following
    "Ella Langley",    # ~500k monthly; rising country-pop crossover 2026
    "Sasha Keable",    # ~200k monthly; NME 100 2026, UK R&B
    "Moliy",           # ~300k monthly; Afropop, "Donut" viral, growing
    "Ghetts",          # ~400k monthly; UK grime elder statesman
    "Genesis Owusu",   # ~400k monthly; Australian indie-rap, Mercury Prize level
    "Sampa the Great", # ~300k monthly; Zambian-Australian rapper, critically acclaimed
    "Kelsey Lu",       # ~200k monthly; experimental R&B, Columbia Records
    "Ama Lou",         # ~150k monthly; UK indie-soul, growing
    "Knucks",          # ~300k monthly; UK rap, Album of the Year material
    "Florence Road",   # ~100k monthly; NME 100 2026 emerging artist
    "Injury Reserve",  # ~300k monthly; avant-rap, critical darlings
    "MIKE",            # ~200k monthly; NY underground rap, lo-fi critical fave
    "billy woods",     # ~200k monthly; underground NYC rap, Armand Hammer
    "Armand Hammer",   # ~150k monthly; billy woods + ELUCID, critically acclaimed
    "Vagabon",         # ~200k monthly; Cameroonian-American indie, Noname adjacent
    "Hawa",            # ~150k monthly; NYC singer, DFA Records, critical darling
    "Tkay Maidza",     # ~400k monthly; Australian alt-pop, momentum building
    "Eartheater",      # ~200k monthly; NY experimental, PAN Records
    "Bbymutha",        # ~100k monthly; Chattanooga rap, cult underground following
    "Cecily Brown",    # Visual artist: ~100k Instagram, major gallery presence
]

# ── STEP 4: Build new queue ───────────────────────────────────────────────────
# Priority: trending injections → Tier A → Tier B → remaining original order

placed = set(trending_inject + tier_a + tier_b)

# Remaining in original order (Tier C/D music + all visual artists + filmmakers)
remaining = [a for a in old_queue if a not in placed]

new_queue = trending_inject + tier_a + tier_b + remaining

print(f"\nNew queue length: {len(new_queue)}")
print(f"New artists injected (not previously in queue): {[a for a in trending_inject if a not in old_queue]}")
print(f"\nTop 20 in new queue:")
for i, artist in enumerate(new_queue[:20], 1):
    print(f"  {i:2}. {artist}")

# ── STEP 5: Write updated brain.json ─────────────────────────────────────────

brain["queue"] = new_queue
brain["last_updated"] = "2026-06-21"

with open(BRAIN, "w") as f:
    json.dump(brain, f, indent=2)

print("\n✓ brain.json updated successfully")
print(f"\nSummary:")
print(f"  Trending artists injected at front: {trending_inject}")
print(f"  Tier A artists moved up: {tier_a}")
print(f"  Total queue length: {len(new_queue)}")
print(f"  Top 10 queue order:")
for i, a in enumerate(new_queue[:10], 1):
    print(f"    {i}. {a}")

PYEOF

echo "=== Queue prioritization complete ==="
