#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-19
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-19-radar.sh

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-19 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It I Knew You, her single from the Toy Story 5 soundtrack, topped the Billboard Hot 100 for the week of June 17 2026, her 15th career chart-topper and the most No. 1 singles by any artist in the 21st century",
        "signal": "Billboard Hot 100 No. 1, week of June 17 2026, Toy Story 5 soundtrack"
    },
    {
        "name": "FKA twigs",
        "genre": "Music",
        "why": "Eusexua Afterglow, released June 19 2026, is the direct follow-up to Eusexua, which won Best Dance/Electronic Album at the 2026 Grammy Awards in February, her first-ever Grammy win",
        "signal": "New album June 19 2026, follow-up to 2026 Grammy Best Dance/Electronic Album winner"
    },
    {
        "name": "Kehlani",
        "genre": "Music",
        "why": "Her self-titled fifth studio album dropped June 19 2026, her first new album in four years, released in two marble vinyl variants",
        "signal": "New album June 19 2026, first in four years"
    },
    {
        "name": "Lucy Dacus",
        "genre": "Music",
        "why": "Forever Is a Feeling, her new album, released June 19 2026 and is among the most anticipated indie rock arrivals of the summer, with wide coverage from Billboard to Stereofox",
        "signal": "New album June 19 2026"
    },
    {
        "name": "Chris Brown",
        "genre": "Music",
        "why": "Brown The Chocolate Edition dropped June 19 2026, led by Man on a Mission featuring Wizkid, with Brown entering the week as the highest-Spotify-followed artist among all June 19 releases at 60.2 million monthly listeners",
        "signal": "New album June 19 2026, 60.2M Spotify monthly listeners"
    },
    {
        "name": "Kelsey Lu",
        "genre": "Music",
        "why": "So Help Me God, released June 12 2026 via Dirty Hit, is their second album after seven years, co-produced by Jack Antonoff and Yves Rothman with Sampha and Kamasi Washington as featured guests, and earned a 77 from Pitchfork",
        "signal": "Pitchfork 77, new album June 12 2026 on Dirty Hit"
    },
    {
        "name": "Key Glock",
        "genre": "Music",
        "why": "Project X, his new album, released June 19 2026 with 10.2 million Spotify monthly listeners, placing him among the most-followed hip-hop artists dropping music this week",
        "signal": "New album June 19 2026, 10.2M Spotify monthly listeners"
    },
    {
        "name": "The Kid LAROI",
        "genre": "Music",
        "why": "New music released June 19 2026, with the Australian artist at 40.6 million Spotify monthly listeners and continuing his run as one of the platform's most-followed acts under 25",
        "signal": "New music June 19 2026, 40.6M Spotify monthly listeners"
    },
    {
        "name": "Kim Petras",
        "genre": "Music",
        "why": "Detour, her indie debut released in 2026 after years in the major label system, blends electroclash and rock with emotional rawness, earning her a spot on Fader's 32 Coolest Artists of 2026 list",
        "signal": "New album Detour 2026, Fader 32 Coolest Artists of 2026"
    },
    {
        "name": "Elif Saydam",
        "genre": "Art",
        "why": "Glory, her solo exhibition at Galerie Rudiger Schottle in Munich, opened in 2026 and runs through July 31, presenting miniature works alongside new larger paintings in oil, collage, and silver leaf, and she is among Artsy's five June 2026 radar picks",
        "signal": "Solo show Galerie Rudiger Schottle Munich through July 31 2026, Artsy June 2026 radar"
    },
    {
        "name": "Avery Singer",
        "genre": "Art",
        "why": "War_overlays, her current exhibition in Zurich, integrates AI directly into her painting practice and is one of the 14 exhibitions ArtReview named as unmissable in June 2026",
        "signal": "ArtReview June 2026 must-see exhibition, Zurich"
    },
    {
        "name": "Maya Seas",
        "genre": "Art",
        "why": "Featured as one of five artists on Artsy's June 2026 radar, the emerging painter is drawing new collector and institutional attention this summer",
        "signal": "Artsy June 2026 radar pick"
    },
    {
        "name": "KAWS",
        "genre": "Culture",
        "why": "His COMPANION figures span painting, sculpture, and large-scale public installation, with multiple museum exhibitions confirmed for 2026 and a broadened global collector base cited in both Artsy and Frieze 2026 collector surveys",
        "signal": "Multiple 2026 museum exhibitions, cited in Artsy and Frieze 2026 collector reports"
    },
    {
        "name": "Zhou Song",
        "genre": "Culture",
        "why": "Named on Frieze's Ten Artists to Watch in 2026 list for oil paintings that examine the tension between human consciousness and algorithmic thinking in a post-biological age",
        "signal": "Frieze Ten Artists to Watch in 2026"
    },
    {
        "name": "Devon Again",
        "genre": "Culture",
        "why": "The Colorado pop artist earned a spot on Fader's 32 Coolest Artists of 2026 list and is opening for Olivia Rodrigo on her summer 2026 tour, creating cinematic songs filled with epic feeling",
        "signal": "Fader 32 Coolest Artists of 2026, opening for Olivia Rodrigo summer tour"
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
