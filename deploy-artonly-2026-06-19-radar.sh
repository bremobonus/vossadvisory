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
        "name": "Chris Brown",
        "genre": "Music",
        "why": "Brown The Chocolate Edition drops June 19 2026, one of the biggest release-day events of the summer. Chris Brown carries 60.2 million Spotify monthly listeners into the project.",
        "signal": "New album June 19 2026, 60.2M Spotify monthly listeners"
    },
    {
        "name": "Key Glock",
        "genre": "Music",
        "why": "Project X drops June 19 2026, the Memphis Paper Route Empire rapper's first solo studio album in three years, arriving with 10.2 million Spotify monthly listeners and high anticipation from his fanbase.",
        "signal": "New album June 19 2026, Paper Route Empire"
    },
    {
        "name": "YG",
        "genre": "Music",
        "why": "The Gentlemen's Club drops June 19 2026, a long-awaited comeback from the Compton rapper with 10.9 million Spotify monthly listeners. His first studio album since I Got Issues in 2022.",
        "signal": "New album June 19 2026, first release since 2022"
    },
    {
        "name": "The Kid LAROI",
        "genre": "Music",
        "why": "Girls featuring Kehlani drops June 19 2026, the Australian-American pop rap artist's most high-profile single of the year. The track comes with a music video and marks his return to the mainstream spotlight.",
        "signal": "New single June 19 2026, featuring Kehlani"
    },
    {
        "name": "Ne-Yo",
        "genre": "Music",
        "why": "Thinking What I'm Thinking drops June 19 2026, the Grammy-winning R and B songwriter's first major solo single of the year and a reminder of why his pen remains one of the sharpest in the genre.",
        "signal": "New single June 19 2026"
    },
    {
        "name": "Kelsey Lu",
        "genre": "Music",
        "why": "So Help Me God released June 12 2026 on Dirty Hit, co-produced with Jack Antonoff and Yves Rothman, earning a Pitchfork score of 82. Their first album in seven years.",
        "signal": "New album June 12 2026, Pitchfork score 82, Dirty Hit"
    },
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It I Knew You from the Toy Story 5 soundtrack debuted at No. 1 on the Billboard Hot 100 this week, her 15th career chart-topper and a new record for the most No. 1 singles in the 21st century.",
        "signal": "Billboard Hot 100 No. 1, Toy Story 5 soundtrack, June 2026"
    },
    {
        "name": "RIIZE",
        "genre": "Music",
        "why": "II, The 2nd Mini Album, drops June 19 2026, SM Entertainment's rising K-pop group returning with their most anticipated project since their 2023 debut and pushing into new sonic territory.",
        "signal": "New mini album June 19 2026, SM Entertainment"
    },
    {
        "name": "Chloe",
        "genre": "Music",
        "why": "Resurrection with producer Timbaland drops June 19 2026, Beyonce's protege's long-awaited debut full-length and her boldest step yet toward defining her sound outside of the duo format.",
        "signal": "New album June 19 2026, produced by Timbaland"
    },
    {
        "name": "Avery Singer",
        "genre": "Art",
        "why": "War overlays opened June 12 at Hauser and Wirth in Zurich and runs through September 5 2026. One of the New York painter's most significant European institutional showings to date.",
        "signal": "Hauser and Wirth Zurich, June 12 to September 5 2026"
    },
    {
        "name": "Wolfgang Tillmans",
        "genre": "Art",
        "why": "Delivered a landmark public lecture on rethinking museum object labels at Beaux-Arts de Paris on June 16 2026, sparking debate across the international photography and contemporary art communities.",
        "signal": "Beaux-Arts de Paris public lecture, June 16 2026"
    },
    {
        "name": "Hiba Schahbaz",
        "genre": "Art",
        "why": "Included in a major group exhibition at FLAG Art Foundation New York in 2026, the Pakistani American miniature painter is one of the most closely watched artists in the current South Asian representation moment in Western institutions.",
        "signal": "FLAG Art Foundation New York group show 2026"
    },
    {
        "name": "PinkPantheress",
        "genre": "Culture",
        "why": "Trending on the UK Official Charts in June 2026 alongside Ariana Grande and F3miii as she prepares new material. The London electronic pop artist continues to build one of the most distinctive catalogs in contemporary British pop.",
        "signal": "UK Official Charts trending June 2026"
    },
    {
        "name": "Harry Styles",
        "genre": "Culture",
        "why": "Aperture reached No. 1 on the Billboard Hot 100 for the week of February 7 2026, and his summer tour dates extending into 2026 keep him among the most prominent pop culture figures of the year.",
        "signal": "Billboard Hot 100 No. 1, February 7 2026"
    },
    {
        "name": "Wizkid",
        "genre": "Culture",
        "why": "Featured on Chris Brown's lead single Man on a Mission releasing June 19 2026, the Lagos-born Afrobeats global crossover star maintains one of the most devoted worldwide fanbases in contemporary African pop.",
        "signal": "Featured on Chris Brown Man on a Mission, June 19 2026"
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
