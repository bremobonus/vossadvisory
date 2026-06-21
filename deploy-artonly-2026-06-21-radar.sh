#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-21
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Triggered automatically by push to main via .github/workflows/deploy-artonly.yml

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-21 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Drake",
        "genre": "Music",
        "why": "ICEMAN spent four consecutive weeks at number one on the Billboard 200 as of June 20, 2026. Drake became the first artist ever to simultaneously hold the top three positions on the chart with ICEMAN, HABIBTI, and MAID OF HONOUR, a record in the chart's 67-year history.",
        "signal": "Billboard 200 No. 1 four weeks June 2026, first to hold top three spots simultaneously"
    },
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It, I Knew You, her original song for Toy Story 5 released June 5, 2026, became the most-streamed country song in a single day by a female artist on Spotify and scored the highest first-day streams of any release in 2026 on Amazon Music.",
        "signal": "Toy Story 5 original song released June 5 2026, record streaming debut on Spotify and Amazon Music"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Won the Grammy Award for Best Pop Solo Performance for Messy at the 2026 Grammy Awards ceremony and the Brit Award for British Breakthrough Artist in February 2026, with her third album charting at number three in the UK.",
        "signal": "Grammy Best Pop Solo Performance 2026, Brit Award British Breakthrough Artist February 2026"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "Launched their first-ever US stadium tour This Is Our Dream on June 18, 2026, covering nine cities through August 7, after 111XPANTIA debuted at number two on the Billboard 200 as the highest-charting Regional Mexican album in the chart's history.",
        "signal": "First US stadium tour June 18 to August 7 2026, 111XPANTIA Billboard 200 No. 2 all-time record"
    },
    {
        "name": "Kelsey Lu",
        "genre": "Music",
        "why": "So Help Me God, released June 12, 2026 via Dirty Hit and co-produced with Jack Antonoff, features Sampha and Kamasi Washington. Pitchfork named it among the best albums of June 2026 and it drew comparisons to Solange, Weyes Blood, and Fiona Apple.",
        "signal": "So Help Me God released June 12 2026, Pitchfork Best New Music June 2026"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Named to Rolling Stone's 2026 Future 25 list in the magazine's Future of Music special issue, recognized as one of the most compelling new voices in Dallas hip-hop and one of the genre's most-watched rising figures heading into summer 2026.",
        "signal": "Rolling Stone Future 25 list 2026, Future of Music special issue"
    },
    {
        "name": "Justin Bieber",
        "genre": "Music",
        "why": "Headlined Coachella 2026 in April with a surprise guest appearance from SZA that accumulated 140 million global online views, reigniting mainstream conversation around his return to live performance and marking one of the most-watched festival sets of the year.",
        "signal": "Coachella 2026 headliner, SZA guest appearance, 140 million online views"
    },
    {
        "name": "Chappell Roan",
        "genre": "Music",
        "why": "Won Best New Artist at the 67th Grammy Awards in February 2025 following her breakout with The Rise and Fall of a Midwest Princess, and enters summer 2026 as one of pop's most-discussed headliners after a sold-out arena world tour across North America and Europe.",
        "signal": "Grammy Best New Artist 2025, sold-out arena world tour 2025 to 2026"
    },
    {
        "name": "Bad Bunny",
        "genre": "Music",
        "why": "His catalog drove chart dominance alongside J. Cole in February 2026 per NPR reporting, sustaining his position as one of the most-streamed Latin artists globally and one of the most culturally influential figures in music across multiple consecutive years.",
        "signal": "NPR: dominated charts February 2026, sustained global streaming dominance"
    },
    {
        "name": "Diambe",
        "genre": "Art",
        "why": "Their largest solo presentation to date, Bees being beans, opened at Kunsthalle Basel in early 2026 and features new film and sculptures exploring cultural memory, colonial legacies, and the fragility of the natural world through organic materials including egg tempera, plant dyes, and beeswax casts.",
        "signal": "Bees being beans at Kunsthalle Basel 2026, largest solo presentation to date"
    },
    {
        "name": "Klara Hosnedlova",
        "genre": "Art",
        "why": "Her large-scale immersive installations combining textiles, glass, metal, and sandstone drew sustained international critical attention throughout 2026, with Frieze naming her among the breakout stars of the Whitney Biennial 2026 in New York.",
        "signal": "Whitney Biennial 2026 breakout, Frieze coverage 2026"
    },
    {
        "name": "Claire Tabouret",
        "genre": "Art",
        "why": "Commissioned to create stained-glass windows for the restored Notre-Dame de Paris, with maquettes currently on view at the Grand Palais in 2026, marking the most prominent public commission of her career and a landmark moment for contemporary painting in architectural space.",
        "signal": "Notre-Dame de Paris stained-glass commission 2026, maquettes at Grand Palais"
    },
    {
        "name": "Isaac Julien",
        "genre": "Culture",
        "why": "Turner Prize winner in 2023, the British filmmaker continues presenting major retrospective installations at institutions globally in 2026, with new commissions drawing sustained coverage in Frieze and Artforum as one of the defining voices at the intersection of Black British culture, film, and contemporary art.",
        "signal": "Turner Prize 2023 winner, international retrospective and new commissions 2026"
    },
    {
        "name": "Quinta Brunson",
        "genre": "Culture",
        "why": "Creator and star of Abbott Elementary, whose fifth season concluded as ABC's most-watched comedy in the 2025 to 2026 broadcast season, making Brunson one of the most powerful figures shaping Black-led storytelling for mainstream television audiences in 2026.",
        "signal": "Abbott Elementary Season 5 completed, ABC most-watched comedy 2025 to 2026 season"
    },
    {
        "name": "Ryan Coogler",
        "genre": "Culture",
        "why": "Founder of Proximity Media, the production company built around the Black Panther franchise director has multiple projects with major studios in active development or release in 2026, cementing his position as one of Hollywood's most influential and in-demand creators.",
        "signal": "Proximity Media productions 2026, multiple major studio projects in development"
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
