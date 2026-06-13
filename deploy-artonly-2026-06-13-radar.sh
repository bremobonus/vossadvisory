#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-13
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Triggered via GitHub Actions deploy-artonly.yml

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-13 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Drake",
        "genre": "Music",
        "why": "Janice STFU holds No. 2 on the Billboard Hot 100 the week of June 13, 2026, after a triple album drop placed seven of his songs simultaneously in the Spotify USA top 10, making him the frontrunner in the song of summer race",
        "signal": "Billboard Hot 100 No. 2 / Song of Summer frontrunner June 2026"
    },
    {
        "name": "Myles Smith",
        "genre": "Music",
        "why": "Debut studio album My Mess, My Heart, My Life drops June 19, 2026 on Island Records, following his global streaming breakthrough on Stargazing which drove him onto international charts in 2025",
        "signal": "Debut album release June 19, 2026"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "111XPANTIA debuted at No. 2 on the Billboard 200 in early 2026, becoming the highest-charting Spanish-language album by a duo or group ever, and the group headlined Rolling Stone's SXSW Future of Music showcase in March 2026",
        "signal": "Billboard 200 No. 2 / Rolling Stone Future of Music SXSW 2026"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "UK pop breakout who headlined night one of Rolling Stone's SXSW Future of Music showcase in March 2026, with Messy driving global streams and making her one of Britain's most-watched new voices",
        "signal": "Rolling Stone Future of Music SXSW March 2026"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Dallas rapper who headlined the closing night of Rolling Stone's SXSW Future of Music showcase in March 2026, with regional anthem Texas crossing into national streaming territory this year",
        "signal": "Rolling Stone Future of Music SXSW March 2026"
    },
    {
        "name": "Laufey",
        "genre": "Music",
        "why": "Time Magazine named her Woman of the Year for 2025, and the Icelandic-Chinese jazz-pop artist enters June 2026 with over 22 million monthly Spotify listeners and a growing crossover audience that has made her genre-defining",
        "signal": "Time Woman of the Year 2025 / 22M Spotify monthly listeners"
    },
    {
        "name": "Tyler, The Creator",
        "genre": "Music",
        "why": "Delivered a lauded Grammy performance of Don't Tap the Glass in early 2026, then Sugar on My Tongue became one of the most-used sounds on TikTok in June 2026, driving a new wave of streaming and fan engagement",
        "signal": "Grammy performance 2026 / Sugar on My Tongue viral TikTok June 2026"
    },
    {
        "name": "Bruno Mars",
        "genre": "Music",
        "why": "Most streamed artist on Spotify globally in June 2026, sustaining a multi-year run of dominance that has made him one of the most consistent chart forces in contemporary music",
        "signal": "Most streamed artist Spotify globally June 2026"
    },
    {
        "name": "Central Cee",
        "genre": "Music",
        "why": "The biggest UK rap artist right now with over 5 million Instagram followers and a global crossover that has made him a fixture on streaming charts in the US, UK, and Europe in 2026",
        "signal": "Biggest UK rap artist 2026 / 5M+ Instagram followers"
    },
    {
        "name": "Avery Singer",
        "genre": "Art",
        "why": "War overlays shown at Zurich Gallery Weekend in June 2026 brings her computer-generated compositions to a major European context, examining how digital media and technology filter consciousness and memory",
        "signal": "Zurich Gallery Weekend June 2026"
    },
    {
        "name": "Shuang Li",
        "genre": "Art",
        "why": "Solo exhibition at Kunsthalle Basel in June 2026, named to ArtReview's 14 exhibitions to see in June 2026 for her work merging performance, text, and conceptual practice across media and language",
        "signal": "Kunsthalle Basel solo show / ArtReview June 2026 pick"
    },
    {
        "name": "Julio Le Parc",
        "genre": "Art",
        "why": "Landmark retrospective Light Colour Action at Tate Modern opened June 11, 2026 presenting over 60 works spanning a 70-year career. The Argentine kinetic art pioneer passed away in May 2026 at 97, making the show a historic tribute",
        "signal": "Tate Modern retrospective June 11, 2026"
    },
    {
        "name": "Ayo Edebiri",
        "genre": "Culture",
        "why": "Won the Emmy Award for Outstanding Lead Actress in a Comedy Series for The Bear in 2025 and entered 2026 as one of the most sought-after actors in Hollywood, taking on major film projects alongside continued television acclaim",
        "signal": "Emmy Award Outstanding Lead Actress 2025 / Hollywood breakout 2026"
    },
    {
        "name": "Beyonce",
        "genre": "Culture",
        "why": "Cowboy Carter led nominations at the 67th Grammy Awards in February 2026 and her genre-crossing record continues to fuel cultural debate around American identity, country music, and Black artistry heading into summer 2026",
        "signal": "67th Grammy Awards nominations February 2026 / Cowboy Carter cultural impact"
    },
    {
        "name": "Pedro Pascal",
        "genre": "Culture",
        "why": "The Last of Us Season 2 on HBO premiered in April 2025 to record-setting streaming numbers for the network, and his cultural footprint has only grown as Season 3 enters production in 2026",
        "signal": "The Last of Us Season 2 HBO record streaming 2025"
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
