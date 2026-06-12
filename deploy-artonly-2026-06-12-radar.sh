#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-12
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-12-radar.sh

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-12 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Sabrina Carpenter",
        "genre": "Music",
        "why": "Manchild reached No. 1 on the UK Singles Chart ending Alex Warren's 12-week run at the top, and Man's Best Friend debuted in the Billboard 200 top five this spring",
        "signal": "UK Singles Chart No. 1"
    },
    {
        "name": "Don Toliver",
        "genre": "Music",
        "why": "Octane debuted at No. 1 on the Billboard 200 in February 2026 with all 18 tracks landing simultaneously on the Hot 100; Tiramisu became his first solo Hot 100 No. 1",
        "signal": "Billboard 200 No. 1 / Hot 100 No. 1"
    },
    {
        "name": "Bad Bunny",
        "genre": "Music",
        "why": "DtMF became his first solo No. 1 on the Billboard Hot 100 and he placed four songs simultaneously in the top 10 following his 2026 Super Bowl halftime performance",
        "signal": "Billboard Hot 100 No. 1"
    },
    {
        "name": "Chappell Roan",
        "genre": "Music",
        "why": "Pink Pony Club finally reached the Billboard Hot 100 top 10 in 2026, and she was chosen alongside Sabrina Carpenter and Doechii to host the 2026 Grammy nominations livestream",
        "signal": "Billboard Hot 100 Top 10 / Grammy nominations host"
    },
    {
        "name": "Doechii",
        "genre": "Music",
        "why": "Won Best Rap Album at the 67th Annual Grammy Awards for Alligator Bites Never Heal, the mixtape that debuted at No. 10 on the Billboard 200, making her the third woman ever to win that category",
        "signal": "Grammy Award Best Rap Album 2026"
    },
    {
        "name": "PinkPantheress",
        "genre": "Music",
        "why": "Girl Like Me rose to No. 11 on the UK Official Trending Chart in early June 2026 following the release of its music video, driving a new surge in streams across the UK and Europe",
        "signal": "UK Trending Chart No. 11 June 2026"
    },
    {
        "name": "Katseye",
        "genre": "Music",
        "why": "Pinky Up posted significant movement on the UK Official Trending Chart in the first week of June 2026, signaling the HYBE-launched global girl group's growing crossover momentum",
        "signal": "UK Trending Chart movement June 2026"
    },
    {
        "name": "F3miii",
        "genre": "Music",
        "why": "Broke into the UK Official Trending Chart Top 10 in early June 2026 with a surge in online traction and streams, one of the fastest-rising new acts on the UK chart this month",
        "signal": "UK Trending Chart Top 10 June 2026"
    },
    {
        "name": "Tyla",
        "genre": "Music",
        "why": "Chanel reached No. 1 on Billboard Rhythmic Airplay in March 2026; second studio album A*Pop arrives July 24, 2026 on Epic Records; she won her second Grammy for Best African Music Performance in February",
        "signal": "Upcoming album / Billboard No. 1 / Grammy win"
    },
    {
        "name": "Maya Seas",
        "genre": "Art",
        "why": "Named to Artsy's 5 Artists on Our Radar in June 2026 for her richly layered figurative paintings combining oil stick, acrylic, charcoal, and 24-karat gold inspired by Indian miniature traditions",
        "signal": "Artsy Artists on Our Radar June 2026"
    },
    {
        "name": "Thomas Houseago",
        "genre": "Art",
        "why": "Solo exhibition Death's Sacred Mirror at Lévy Gorvy Dayan in London presents new sculptures alongside Egyptian, Greek, and Aztec artifacts in a cabinet-of-curiosities format; Crystal No. 1 (2026) anchors the show",
        "signal": "Lévy Gorvy Dayan London solo show June 2026"
    },
    {
        "name": "Su Yu-Xin",
        "genre": "Art",
        "why": "Named to Artsy's 5 Artists on Our Radar in June 2026 and profiled by Art Basel for her process of collecting organic materials, including oyster shells, lapis lazuli, and green soil, to make her own pigments",
        "signal": "Artsy Artists on Our Radar / Art Basel feature June 2026"
    },
    {
        "name": "Questlove",
        "genre": "Culture",
        "why": "Opened Tribeca Film Festival 2026 on June 3 with a new documentary on Earth, Wind and Fire, adding to his credits as musician, DJ, author, and Oscar-winning director",
        "signal": "Tribeca Film Festival 2026 opening night"
    },
    {
        "name": "Alicia Keys",
        "genre": "Culture",
        "why": "Documentary on her life and career anchors Tribeca Film Festival 2026 as the closing-night selection on June 14, 2026, placing her at the center of the summer's most prominent film event",
        "signal": "Tribeca Film Festival 2026 closing night"
    },
    {
        "name": "threeASFOUR",
        "genre": "Culture",
        "why": "Fashion design collective's documentary threeASFOUR: Full Circle directed by Sean Ono Lennon had its world premiere at Tribeca Film Festival on June 3, 2026, spotlighting 25 years of boundary-crossing design",
        "signal": "Tribeca Film Festival 2026 world premiere"
    }
]

with open(RADAR, "w") as f:
    json.dump(artists, f, indent=2, ensure_ascii=False)

data = json.load(open(RADAR))
print(f"Wrote {len(data)} artists to radar-cache.json")
for a in data:
    print(f"  [{a['genre']:8s}]  {a['name']}")

print()
print("Verifying: no em-dashes or en-dashes in text...")
issues = []
for a in data:
    for field in ("why", "signal", "name"):
        if "—" in a.get(field, "") or "–" in a.get(field, ""):
            issues.append(f"  DASH FOUND in {a['name']} ({field})")
if issues:
    for i in issues:
        print(i)
else:
    print("  OK: no em-dashes or en-dashes found")

PYEOF

echo "=== Radar cache update complete ==="
