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
        "why": "\"I Knew It, I Knew You\" from the Toy Story 5 soundtrack debuted at No. 1 on the Billboard Hot 100 dated June 20, 2026, her 15th Hot 100 chart-topper and the biggest country single of 2026 on Apple Music, written and produced with Jack Antonoff.",
        "signal": "Billboard Hot 100 No. 1 / Global 200 No. 1 / Toy Story 5 June 2026"
    },
    {
        "name": "Shakira",
        "genre": "Music",
        "why": "Performed \"Dai Dai,\" the official 2026 FIFA World Cup anthem, at the June 11 opening ceremony in Mexico alongside Burna Boy. Co-written with Jon Bellion and Ed Sheeran in five languages, the song reached the top 10 on the UK Official Trending Chart.",
        "signal": "FIFA World Cup 2026 official anthem / Opening ceremony June 11"
    },
    {
        "name": "Burna Boy",
        "genre": "Music",
        "why": "Co-created and performed \"Dai Dai,\" the official 2026 FIFA World Cup anthem, at the June 11 opening ceremony in Mexico. Billboard ranked the song the third-best World Cup anthem of 2026.",
        "signal": "FIFA World Cup 2026 official anthem / Opening ceremony June 11"
    },
    {
        "name": "Kelsey Lu",
        "genre": "Music",
        "why": "\"So Help Me God\" released June 12 via Dirty Hit, earning a Pitchfork score of 82. Their first album in seven years, co-produced with Jack Antonoff, featuring Sampha, Kamasi Washington, and Kim Gordon.",
        "signal": "New album June 12 2026 / Pitchfork score 82"
    },
    {
        "name": "Bad Bunny",
        "genre": "Music",
        "why": "\"DtMF\" topped the Billboard Hot 100 and Global 200 in February 2026 after his Super Bowl LX halftime show performance. He became the first artist to hold the entire top 25 simultaneously on the Hot Latin Songs chart.",
        "signal": "Billboard Hot 100 No. 1 / Super Bowl LX / First artist with entire Hot Latin Songs top 25"
    },
    {
        "name": "Don Toliver",
        "genre": "Music",
        "why": "\"Octane\" debuted at No. 1 on the Billboard 200 in February 2026 with 162,000 equivalent album units, his first chart-topping album. All 18 of its tracks simultaneously charted on the Hot 100.",
        "signal": "Billboard 200 No. 1 debut / All 18 tracks on Hot 100"
    },
    {
        "name": "JayDon",
        "genre": "Music",
        "why": "\"Lullaby\" entered the Top 10 on Billboard Hot R&B/Hip-Hop Airplay in 2026, his first charting single from the EP \"Me My Songs and I,\" executive produced by Usher and L.A. Reid.",
        "signal": "Billboard Hot R&B/Hip-Hop Airplay Top 10 / 2026 debut"
    },
    {
        "name": "LE SSERAFIM",
        "genre": "Music",
        "why": "Appeared on the UK Official Trending Chart for the week of June 16, 2026 alongside Shakira and Olivia Rodrigo, extending the K-pop group's sustained crossover presence on mainstream global charts.",
        "signal": "UK Official Trending Chart June 16, 2026"
    },
    {
        "name": "Janine Berdin",
        "genre": "Music",
        "why": "Filipino singer's live performance of \"What If I Miss You For The Rest Of My Life\" went viral in 2026 with 11 million Instagram views, drawing personal praise from Demi Lovato and Jessie Reyez.",
        "signal": "11M Instagram views / Praised by Demi Lovato and Jessie Reyez"
    },
    {
        "name": "KAWS",
        "genre": "Art",
        "why": "\"Art and Comix\" exhibition opened at Vienna's ALBERTINA MODERN on April 3, 2026 and runs through September 27, presenting major KAWS sculptures alongside works by Jean-Michel Basquiat and Keith Haring.",
        "signal": "ALBERTINA MODERN Vienna / April to September 2026"
    },
    {
        "name": "Marin Majic",
        "genre": "Art",
        "why": "\"discodisco\" solo exhibition at Nino Mier Gallery in New York ran May 15 to June 13, 2026, featuring atmospheric paintings layered with marble dust and wax. Featured on Artsy's June 2026 artists-on-radar list.",
        "signal": "Nino Mier Gallery NYC / Artsy June 2026 radar"
    },
    {
        "name": "Elif Saydam",
        "genre": "Art",
        "why": "\"Glory\" exhibition at Galerie Rudiger Schottle in Munich is running through June 2026, presenting paintings and collages on nontraditional materials including antique bathroom stall doors and kitchen sponges. Featured on Artsy's June 2026 radar.",
        "signal": "Galerie Rudiger Schottle Munich / Artsy June 2026 radar"
    },
    {
        "name": "J Balvin",
        "genre": "Culture",
        "why": "Performed at the FIFA World Cup 2026 opening ceremony in Mexico on June 11 alongside Shakira and Burna Boy, reaching one of the largest simultaneous global broadcast audiences of the year.",
        "signal": "FIFA World Cup 2026 opening ceremony June 11"
    },
    {
        "name": "LISA",
        "genre": "Culture",
        "why": "Performed at the 2026 FIFA World Cup opening ceremony alongside Katy Perry and Anitta in June 2026, one of the most-watched live events of the summer, building on her momentum as a global solo artist post-BLACKPINK.",
        "signal": "FIFA World Cup 2026 opening ceremony / June 2026"
    },
    {
        "name": "Jane Yang D'Haene",
        "genre": "Culture",
        "why": "Announced as a Loewe Foundation Craft Prize finalist in February 2026, with ceramic works acquired by Harvard Art Museums and the Brooklyn Museum. Her fusion of tradition and invention has positioned her at the intersection of craft and contemporary fashion culture.",
        "signal": "Loewe Foundation Craft Prize finalist 2026 / Harvard Art Museums and Brooklyn Museum acquisitions"
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
