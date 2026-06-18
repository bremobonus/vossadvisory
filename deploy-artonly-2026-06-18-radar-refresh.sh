#!/bin/bash
# ArtOnly Radar Cache Refresh v2
# Generated: 2026-06-18 (second pass)
# Purpose: Write 15 fresh trending artists to radar-cache.json for the /radar page
# Run via GitHub Actions (deploy-artonly.yml) workflow_dispatch on claude/manage-voss-advisory-6xIPn

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-18 v2 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Drake",
        "genre": "Music",
        "why": "ICEMAN holds No. 1 on the Billboard 200 for a fourth consecutive week as of June 20, and Drake simultaneously debuted HABIBTI and MAID OF HONOUR at Nos. 2 and 3, the first time any artist has occupied all three top spots at once",
        "signal": "Billboard 200 No. 1 four straight weeks, triple top 3 sweep, June 2026"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Holds both No. 1 and No. 2 on the Billboard Hot 100 simultaneously with Choosin Texas and Be Her as of June 20 2026, an unprecedented solo chart feat",
        "signal": "Billboard Hot 100 No. 1 and No. 2 simultaneously, June 20 2026"
    },
    {
        "name": "JENNIE",
        "genre": "Music",
        "why": "Dracula remix with Tame Impala reached No. 10 on the Billboard Hot 100 in June 2026, her first US top 10 as a solo BLACKPINK artist",
        "signal": "Billboard Hot 100 No. 10, June 2026"
    },
    {
        "name": "Tame Impala",
        "genre": "Music",
        "why": "Dracula with JENNIE debuted at No. 10 on the Billboard Hot 100 in June 2026, the psychedelic rock project's first-ever Hot 100 top 10",
        "signal": "Billboard Hot 100 No. 10, first ever top 10 hit, June 2026"
    },
    {
        "name": "Isaiah Rashad",
        "genre": "Music",
        "why": "It's Been Awful released May 1 2026 on TDE and Warner Records debuted at No. 17 on the Billboard 200, his first album in four years featuring SZA and Dominic Fike",
        "signal": "Billboard 200 No. 17 debut, new album May 2026"
    },
    {
        "name": "Tyla",
        "genre": "Music",
        "why": "Game Time is the official FIFA World Cup 2026 anthem co-written with Future, and she performed it at the opening ceremony at LA Stadium on June 12 before a global broadcast audience",
        "signal": "FIFA World Cup 2026 official anthem, opening ceremony June 12 LA"
    },
    {
        "name": "Future",
        "genre": "Music",
        "why": "Co-wrote and headlined the FIFA World Cup 2026 opening ceremony at LA Stadium on June 12 performing the official anthem Game Time with Tyla",
        "signal": "FIFA World Cup 2026 official anthem, opening ceremony June 12 LA"
    },
    {
        "name": "Rema",
        "genre": "Music",
        "why": "Goals FIFA World Cup song with LISA and Anitta charted in 15 countries and the trio performed it live at LA Stadium on June 12 at the World Cup opening ceremony",
        "signal": "FIFA World Cup 2026 opening ceremony performer, Goals global chart hit"
    },
    {
        "name": "Katy Perry",
        "genre": "Music",
        "why": "Headlined the FIFA World Cup 2026 USA opening ceremony at LA Stadium in Inglewood on June 12, the year's highest-profile live event, alongside partner Justin Trudeau in attendance",
        "signal": "FIFA World Cup 2026 USA opening ceremony headline performer, June 12"
    },
    {
        "name": "Mohammed Z. Rahman",
        "genre": "Art",
        "why": "Never the Same solo show at Tate Britain opens June 5 and runs to November 8 2026, presented inside two timber pavilions inspired by Bengali wedding canopies with new paintings exploring home and love",
        "signal": "Tate Britain solo show, June 5 to November 8 2026"
    },
    {
        "name": "Mulgil Kim",
        "genre": "Art",
        "why": "Debut solo institutional exhibition at Maddox Gallery London summer 2026, named among five contemporary artists to watch in 2026 by the gallery for depth and clear authorship",
        "signal": "Maddox Gallery debut solo show, summer 2026"
    },
    {
        "name": "Carol Bove",
        "genre": "Art",
        "why": "First museum survey and largest career presentation to date opens at the Solomon R. Guggenheim Museum in 2026, marking a defining retrospective for one of contemporary sculpture's most rigorous voices",
        "signal": "Guggenheim Museum first career survey, 2026"
    },
    {
        "name": "Anitta",
        "genre": "Culture",
        "why": "Performed Goals with LISA and Rema at the FIFA World Cup 2026 opening ceremony at LA Stadium on June 12, the song charted in 15 countries and served as one of two official World Cup anthems",
        "signal": "FIFA World Cup 2026 opening ceremony, Goals charted 15 countries"
    },
    {
        "name": "Dan + Shay",
        "genre": "Culture",
        "why": "Nashville country duo performed at the FIFA World Cup 2026 opening ceremonies in Toronto on June 13 before the Canada match, their first major stadium show of 2026 on a global stage",
        "signal": "FIFA World Cup 2026 opening ceremonies, Toronto June 13 2026"
    },
    {
        "name": "Lanza Atelier",
        "genre": "Culture",
        "why": "Mexico City architecture collective unveiled the 2026 Serpentine Pavilion in London in June 2026, their first major UK institutional commission and one of the most discussed structures of the summer",
        "signal": "2026 Serpentine Pavilion, London June 2026"
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
