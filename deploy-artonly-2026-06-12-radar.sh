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
BRAIN = "/home/dh_yadmw3/artonly.io/agent/brain.json"

artists = [
    {
        "name": "Ariana Grande",
        "genre": "Music",
        "why": "Lead single 'Hate That I Made You Love Me' debuted at No. 1 on the Billboard Hot 100 dated June 13, her 10th career chart-topper, ahead of new album 'petal' dropping July 31",
        "signal": "Billboard Hot 100 No. 1"
    },
    {
        "name": "Olivia Rodrigo",
        "genre": "Music",
        "why": "Third studio album 'you seem pretty sad for a girl so in love' released June 12, 2026, with 'Drop Dead' already charting globally and over 60 million monthly Spotify listeners",
        "signal": "New album release"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "'Choosin Texas' spent 10 non-consecutive weeks atop the Billboard Hot 100 and became the first song by a female artist to simultaneously lead the Hot 100, Hot Country Songs, and Country Airplay charts; she won 7 ACM Awards in a single year",
        "signal": "Billboard Hot 100 No. 1 / ACM Awards sweep"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "Launched first U.S. stadium tour 'This Is Our Dream' on June 18 in San Diego spanning nine stadiums nationwide; headlined Rolling Stone's SXSW Future of Music showcase in March 2026",
        "signal": "U.S. stadium tour launch"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Returned from a voluntary hiatus with new single 'From Down Here' on May 22, 2026, co-produced with James Blake; won the 2026 Grammy Award for Best Pop Solo Performance for 'Messy'",
        "signal": "New single / Grammy win"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Headlined Rolling Stone's Future of Music SXSW showcase on March 14, 2026; 'All the Way' featuring Bailey Zimmerman was the first song to simultaneously top both Billboard Hot Country Songs and Hot Rap Songs",
        "signal": "Rolling Stone Future of Music / Billboard chart history"
    },
    {
        "name": "Tyla",
        "genre": "Music",
        "why": "'Chanel' reached No. 1 on Billboard Rhythmic Airplay in March 2026 and second studio album 'A*Pop' arrives July 24, 2026; she won her second Grammy for Best African Music Performance in February",
        "signal": "Upcoming album / Billboard No. 1"
    },
    {
        "name": "Charli XCX",
        "genre": "Music",
        "why": "Summer 2026 single 'Rock Music' and its TikTok glitch-edit format became an inescapable viral trend, sustaining over 30 million monthly Spotify listeners heading into festival season",
        "signal": "TikTok viral trend"
    },
    {
        "name": "Bloc Party",
        "genre": "Music",
        "why": "London post-punk band listed among Pitchfork's most anticipated 2026 releases with new material expected, their first project since 2022's 'Alpha Games'",
        "signal": "Pitchfork 2026 anticipated release"
    },
    {
        "name": "Tracey Emin",
        "genre": "Art",
        "why": "Largest-ever career retrospective 'A Second Life' at Tate Modern runs through August 31, 2026, spanning 40 years across painting, video, installation, and sculpture including 'My Bed'",
        "signal": "Tate Modern retrospective"
    },
    {
        "name": "Hiba Schahbaz",
        "genre": "Art",
        "why": "First major retrospective 'The Garden' at MOCA North Miami brought together 80 works across 15 years of the Pakistani American painter's Indo-Persian miniature influenced paintings",
        "signal": "MOCA North Miami retrospective"
    },
    {
        "name": "Claire Tabouret",
        "genre": "Art",
        "why": "French artist commissioned by France's Ministry of Culture to design six contemporary stained-glass windows for the restored Notre-Dame de Paris, with preparatory maquettes exhibited at the Grand Palais this spring",
        "signal": "Notre-Dame de Paris commission"
    },
    {
        "name": "Precious Okoyomon",
        "genre": "Culture",
        "why": "Multihyphenate artist, poet, and comedian selected for the 82nd Whitney Biennial at the Whitney Museum of American Art in New York, on view through August 23, 2026",
        "signal": "Whitney Biennial 2026"
    },
    {
        "name": "Raven Halfmoon",
        "genre": "Culture",
        "why": "Colossal figurative sculptor working with Indigenous iconography, named one of eight standout artists at the 82nd Whitney Biennial at the Whitney Museum of American Art, on view through August 23, 2026",
        "signal": "Whitney Biennial 2026"
    },
    {
        "name": "Julio Torres",
        "genre": "Culture",
        "why": "Comedy auteur and former Saturday Night Live writer featured as a multidisciplinary artist in the 82nd Whitney Biennial at the Whitney Museum of American Art, on view through August 23, 2026",
        "signal": "Whitney Biennial 2026"
    }
]

with open(RADAR, "w") as f:
    json.dump(artists, f, indent=2, ensure_ascii=False)

data = json.load(open(RADAR))
print(f"Wrote {len(data)} artists to radar-cache.json")
for a in data:
    print(f"  [{a['genre']:8s}]  {a['name']}")

print()
print("Verifying: no em-dashes in text...")
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
