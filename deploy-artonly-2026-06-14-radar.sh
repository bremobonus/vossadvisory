#!/bin/bash
# ArtOnly Radar Cache Refresh
# Generated: 2026-06-14
# Purpose: Write 15 trending artists to radar-cache.json for the /radar page
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-14-radar.sh

set -e
echo "=== ArtOnly Radar Cache Refresh: 2026-06-14 ==="
echo "$(date)"

python3 << 'PYEOF'
import json

RADAR = "/home/dh_yadmw3/artonly.io/data/radar-cache.json"

artists = [
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Debut album Dandelion debuted at No. 1 on the Billboard 200 in April 2026 with 169,000 units, and she became the first female artist ever to chart three songs simultaneously in the top 10 of Billboard's Country Airplay chart, now heading into a sold-out arena tour",
        "signal": "Billboard 200 No. 1 / Country Airplay history / 2026 arena tour"
    },
    {
        "name": "Justin Bieber",
        "genre": "Music",
        "why": "Headlined Coachella 2026 in April for his first full public concert since his Justice Tour ended in 2022, delivering a 34-song set with surprise appearances from Billie Eilish and SZA that accumulated 140 million online views",
        "signal": "Coachella 2026 headliner / 140M online views"
    },
    {
        "name": "Karol G",
        "genre": "Music",
        "why": "Co-headlined Coachella 2026 alongside Sabrina Carpenter and Justin Bieber, cementing her standing as the biggest Latin female presence at a major US music festival and sustaining a global streaming run into mid-2026",
        "signal": "Coachella 2026 co-headliner"
    },
    {
        "name": "Taylor Swift",
        "genre": "Music",
        "why": "I Knew It I Knew You debuted at No. 1 on the UK Singles Chart in 2026, making her the first international artist to earn multiple chart-toppers in the UK this year, while TS13 is confirmed in active development",
        "signal": "UK Singles Chart No. 1 2026 / TS13 in development"
    },
    {
        "name": "aespa",
        "genre": "Music",
        "why": "LEMONADE entered the UK Official Trending Chart in early June 2026 and landed on Spotify's Songs of Summer 2026 predictions, marking the K-pop group's most direct crossover push into Western pop markets to date",
        "signal": "UK Official Trending Chart June 2026 / Spotify Songs of Summer 2026"
    },
    {
        "name": "Zara Larsson",
        "genre": "Music",
        "why": "Her summer 2026 collaboration appeared on Spotify's official Songs of Summer 2026 playlist alongside Ariana Grande and Olivia Rodrigo, giving her renewed global visibility heading into her strongest streaming season in years",
        "signal": "Spotify Songs of Summer 2026 playlist"
    },
    {
        "name": "The Weeknd",
        "genre": "Music",
        "why": "Ranked fifth most streamed artist globally in 2026 per Luminate data with 5.4 billion streams, sustaining chart presence across North America, Europe and Latin America while anticipation builds around a forthcoming project",
        "signal": "5.4B global streams 2026 / Luminate top 5"
    },
    {
        "name": "Bad Bunny",
        "genre": "Music",
        "why": "DeBÍ TiRAR MáS FOToS won Album of the Year at the 2026 Grammy Awards, the first Spanish-language album to receive the honour, and he leads all artists globally with 11.5 billion streams in 2026 per Luminate data",
        "signal": "2026 Grammy Album of the Year / 11.5B global streams"
    },
    {
        "name": "Billie Eilish",
        "genre": "Music",
        "why": "Made a surprise appearance at Justin Bieber's headlining Coachella 2026 set that accumulated 140 million online views in April, and ranks among the top 10 most streamed artists globally in 2026 with 3.5 billion streams per Luminate data",
        "signal": "Coachella 2026 surprise appearance / 3.5B global streams 2026"
    },
    {
        "name": "Michaela Yearwood-Dan",
        "genre": "Art",
        "why": "First institutional museum exhibition in the UK opened at The Whitworth in Manchester in April 2026 and runs through October, presenting 14 new paintings and 6 ceramic vessels in a multidimensional installation exploring Blackness, femininity and community",
        "signal": "The Whitworth solo exhibition April to October 2026"
    },
    {
        "name": "Anne Imhof",
        "genre": "Art",
        "why": "Solo exhibition at Sprüth Magers London opened June 5, 2026 and runs through August 1, placing the German performance artist and painter at the centre of London Gallery Weekend and the summer exhibition season",
        "signal": "Sprüth Magers London solo show June 5 to August 1 2026"
    },
    {
        "name": "Huang Yuxing",
        "genre": "Art",
        "why": "Named by Artsy collectors as an artist to watch in 2026 for large-scale figurative canvases that are drawing attention from international galleries across Asia and Europe, with his critical profile rising steadily this season",
        "signal": "Artsy 12 Collectors to Watch 2026"
    },
    {
        "name": "Timothée Chalamet",
        "genre": "Culture",
        "why": "A screenshot from his 2026 Critics Choice Award speech became a widely shared meme template across TikTok and X, making him one of the most referenced cultural figures in the first half of 2026",
        "signal": "Critics Choice speech viral meme 2026 / TikTok and X"
    },
    {
        "name": "Kai Cenat",
        "genre": "Culture",
        "why": "One of the biggest live streaming presences globally with over 60 million YouTube subscribers, his potential cameo in Scary Movie 6 became a trending topic in June 2026 following a viral teaser that fuelled widespread fan speculation",
        "signal": "Scary Movie 6 cameo speculation viral June 2026 / 60M YouTube subscribers"
    },
    {
        "name": "IShowSpeed",
        "genre": "Culture",
        "why": "Hit 50 million YouTube subscribers in 2026 and his marathon collaborative streams with Kai Cenat rank among the most-watched streaming events of the year, cementing his standing as a genuinely global internet phenomenon",
        "signal": "50 million YouTube subscribers 2026 / most-watched streaming events"
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
