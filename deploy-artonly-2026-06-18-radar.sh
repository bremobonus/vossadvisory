#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-18
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-18-radar.sh

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-18 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It I Knew You from the Toy Story 5 soundtrack debuted at No. 1 on the Billboard Hot 100 for the week of June 20 2026, her 15th chart-topper and a new record for the most No. 1 singles in the 21st century",
        "signal": "Billboard Hot 100 No. 1, week of June 20 2026"
    },
    {
        "name": "Kelsey Lu",
        "genre": "Music",
        "why": "So Help Me God released June 12 2026 via Dirty Hit, their first album in 7 years, co-produced with Jack Antonoff and Yves Rothman, and scored 82 on the Pitchfork critic aggregate",
        "signal": "New album June 12 2026, Pitchfork score 82"
    },
    {
        "name": "Niall Horan",
        "genre": "Music",
        "why": "Dinner Party, his fourth studio album, released June 5 2026 via Capitol Records and debuted at No. 1 in six countries including the UK, Ireland, and Australia",
        "signal": "New album June 5 2026, No. 1 in 6 countries"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Headlined Rolling Stone's Future of Music Showcase at SXSW 2026 on March 12, UK pop breakout known for Messy and named to Rolling Stone's Future 25 class for 2026",
        "signal": "Rolling Stone Future of Music Showcase SXSW 2026"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "Headlined Rolling Stone's Future of Music Showcase at SXSW 2026 on March 13, arena-rocking Mexican American group from San Bernardino, California, leading Street Mob Records",
        "signal": "Rolling Stone Future of Music Showcase SXSW 2026"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Headlined Rolling Stone's Future of Music Showcase at SXSW 2026 on March 14, Texas rapper featured in Rolling Stone's Future 25 list for 2026 with breakthrough single Texas",
        "signal": "Rolling Stone Future of Music Showcase SXSW 2026, Future 25"
    },
    {
        "name": "Morgan Wallen",
        "genre": "Music",
        "why": "I Can't Love You Anymore with Ella Langley entered the Hot 100 top 10 for the week of June 20 2026, his third separate top 10 entry on the chart this year",
        "signal": "Billboard Hot 100 top 10, week of June 20 2026"
    },
    {
        "name": "SAILORR",
        "genre": "Music",
        "why": "Debut album From Florida's Finest drove a sold-out Doja Cat tour in 2025 and the artist was featured in Rolling Stone's Future of Music 2026 class with new music arriving this year",
        "signal": "Rolling Stone Future of Music 2026 class"
    },
    {
        "name": "F3miii",
        "genre": "Music",
        "why": "Appearing on the UK Official Trending Chart in June 2026 alongside Ariana Grande and PinkPantheress, with streaming numbers accelerating across platforms this month",
        "signal": "UK Official Trending Chart June 2026"
    },
    {
        "name": "Diambe",
        "genre": "Art",
        "why": "Presenting their largest solo institutional exhibition at Kunsthalle Basel in 2026, a Brazilian nonbinary artist developing a language across sculpture, painting, and film using egg tempera, beeswax, bronze, and other organic materials",
        "signal": "Kunsthalle Basel solo exhibition 2026"
    },
    {
        "name": "Birke Gorm",
        "genre": "Art",
        "why": "Selected to represent Austria at the 16th Gwangju Biennale 2026 in South Korea, running September through November, transforming the pavilion with discarded materials collected in Vienna and on site in Gwangju",
        "signal": "Austrian Pavilion, 16th Gwangju Biennale 2026"
    },
    {
        "name": "Tracey Emin",
        "genre": "Art",
        "why": "Her largest survey exhibition opened at Tate Modern in London in 2026, closely curated with the artist herself, a defining retrospective for one of Britain's most celebrated and polarizing contemporary voices",
        "signal": "Tate Modern retrospective 2026"
    },
    {
        "name": "LISA",
        "genre": "Culture",
        "why": "K-pop solo star performed at the FIFA World Cup 2026 opening ceremony at Los Angeles Stadium on June 12, sharing the stage with Katy Perry and Anitta before one of the year's largest global broadcast audiences",
        "signal": "FIFA World Cup 2026 opening ceremony June 12"
    },
    {
        "name": "Ming Wong",
        "genre": "Culture",
        "why": "A forthcoming solo exhibition at London's National Gallery marks the museum's first solo show by a Southeast Asian artist, bringing his cinema re-enactment practice to the widest institutional stage of his career",
        "signal": "National Gallery London, first solo show by a Southeast Asian artist"
    },
    {
        "name": "Saskia Colwell",
        "genre": "Culture",
        "why": "Her 2026 solo show with Victoria Miro Gallery in London is generating significant collector attention, with chalk and charcoal work that challenges the view that drawing is merely preparatory rather than finished",
        "signal": "Victoria Miro Gallery solo show 2026"
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
