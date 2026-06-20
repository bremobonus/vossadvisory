#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-20
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Triggered automatically by GitHub Actions on push to main

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-20 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It, I Knew You from Toy Story 5 debuted at No. 1 on the Billboard Hot 100 on June 20 2026, giving Swift her record 15th career chart-topper and her ninth No. 1 Hot 100 debut, breaking her tie with Ariana Grande for the most chart-topping debuts by a female artist",
        "signal": "Billboard Hot 100 No. 1 / June 20 2026 / Toy Story 5 soundtrack"
    },
    {
        "name": "Drake",
        "genre": "Music",
        "why": "ICEMAN held No. 1 on the Billboard 200 for four consecutive weeks through June 2026, debuting with 463,000 equivalent units, and Drake became the first artist ever to debut three albums in the top three spots simultaneously with ICEMAN, HABIBTI and MAID OF HONOUR",
        "signal": "Billboard 200 No. 1 for 4 weeks / Historic triple album debut"
    },
    {
        "name": "Myles Smith",
        "genre": "Music",
        "why": "Debut album My Mess, My Heart, My Life released June 19 2026 on Sony UK after two breakout EPs, backed by a major English and Irish arena tour announced for November 2026, marking a significant breakthrough for the British singer-songwriter",
        "signal": "Debut album June 19 2026 / Arena tour announced November 2026"
    },
    {
        "name": "Death Cab for Cutie",
        "genre": "Music",
        "why": "Eleventh studio album I Built You a Tower released June 5 2026 on Anti- Records, produced by John Congleton, with lead single Riptides jumping four spots to the top of the alternative chart in its first week, their strongest chart activity in years",
        "signal": "New album June 5 2026 / Riptides reaches No. 1 alternative chart"
    },
    {
        "name": "Don Toliver",
        "genre": "Music",
        "why": "Single E85 generated significant traction across Billboard hip-hop and rap charts in June 2026, with Toliver charting four songs simultaneously making him one of the most-streamed rap artists of the summer season",
        "signal": "Four songs on Billboard rap charts simultaneously / June 2026"
    },
    {
        "name": "Kim Petras",
        "genre": "Music",
        "why": "Debut indie album Detour co-created with Margo XS, Frost Children, Porches and nightfeelings was named by The Fader as one of the standout musical moments of 2026, marking a sharp departure from her earlier major-label pop sound",
        "signal": "The Fader coolest artists of 2026 / Indie debut album Detour"
    },
    {
        "name": "skaiwater",
        "genre": "Music",
        "why": "Named The Fader 2026 cover star, the London rapper breaks new ground with genre-fluid rap that moves between rage distortion and ethereal sampling, sustaining critical momentum and growing streaming numbers throughout the year",
        "signal": "The Fader 2026 cover star / Growing Spotify streaming"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Debut album Dandelion opened at No. 1 on the Billboard 200, marking the largest streaming debut week for a female country primary artist on record, executive produced alongside Miranda Lambert",
        "signal": "Billboard 200 No. 1 debut / Record female country streaming week"
    },
    {
        "name": "PinkPantheress",
        "genre": "Music",
        "why": "Stateside featuring Zara Larsson from her album Fancy That won at the 2026 American Music Awards while the track maintained strong positioning on UK and US trending charts through June 2026",
        "signal": "2026 American Music Awards winner / UK and US trending charts June 2026"
    },
    {
        "name": "Yinka Ilori",
        "genre": "Art",
        "why": "Solo debut London exhibition Joy Through Resistance at Cristea Roberts Gallery runs June 5 to July 11 2026, spanning new paintings, prints, sculpture and an immersive sound installation rooted in his British-Nigerian heritage",
        "signal": "Cristea Roberts Gallery London / June 5 to July 11 2026"
    },
    {
        "name": "Daniel Arsham",
        "genre": "Art",
        "why": "Time Fold at Perrotin London opened during London Gallery Weekend in June 2026 and runs through August 8, showcasing his signature eroded object sculptures alongside new photography and design collaborations",
        "signal": "Perrotin London / London Gallery Weekend / Through August 8 2026"
    },
    {
        "name": "Marin Majic",
        "genre": "Art",
        "why": "Solo show discodisco at Nino Mier Gallery New York ran through June 13 2026, bringing the Frankfurt-born Croatian painter significant critical attention and new international gallery presence this season",
        "signal": "Nino Mier Gallery New York / Solo show June 2026"
    },
    {
        "name": "Katy Perry",
        "genre": "Culture",
        "why": "Headlined the FIFA World Cup 2026 USA opening ceremony at Los Angeles Stadium on June 12 before a global broadcast audience of hundreds of millions, sharing the stage with LISA and Anitta in one of the summer's largest live events",
        "signal": "FIFA World Cup 2026 USA opening ceremony / June 12 Los Angeles"
    },
    {
        "name": "Anitta",
        "genre": "Culture",
        "why": "Co-headlined the FIFA World Cup 2026 USA opening ceremony in Los Angeles on June 12 alongside Katy Perry and LISA, reaching a global audience and cementing her position as the most globally followed Brazilian artist in music",
        "signal": "FIFA World Cup 2026 USA opening ceremony / June 12 Los Angeles"
    },
    {
        "name": "Quinta Brunson",
        "genre": "Culture",
        "why": "Abbott Elementary entered its fifth season in 2026 after multiple Emmy Award wins, with Brunson recognized as one of the most influential comedy writers and performers working in American television today",
        "signal": "Abbott Elementary Season 5 2026 / Multiple Emmy Awards"
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
