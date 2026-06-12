#!/bin/bash
# artonly.io Radar Cache Refresh
# Generated: 2026-06-12
# Purpose: Write 15 trending artists to radar-cache.json for artonly.io/radar

set -e
echo "=== artonly.io Radar Cache Refresh: 2026-06-12 ==="
echo "$(date)"

python3 << 'PYEOF'
import json, os, re

BRAIN      = os.path.expanduser("~/artonly.io/agent/brain.json")
RADAR_OUT  = os.path.expanduser("~/artonly.io/data/radar-cache.json")

# ── 1. Load artists_written from brain ──────────────────────────────────────
with open(BRAIN) as f:
    brain = json.load(f)

artists_written_raw = [str(a) for a in brain.get("artists_written", [])]
written_norm = {re.sub(r"[^a-z0-9]", "", a.lower()) for a in artists_written_raw}
print(f"Artists already written: {len(written_norm)}")

def already_written(name):
    return re.sub(r"[^a-z0-9]", "", name.lower()) in written_norm

# ── 2. Candidates (20 total so we always fill 15) ───────────────────────────
# Sources: Billboard Hot 100 wk Jun 13 2026, Pitchfork, Artsy June 2026,
#          ArtReview June 2026, Rolling Stone Future of Music SXSW 2026,
#          2026 AMA nominations, Grammy 2026 winners.
CANDIDATES = [
    # Music (target 9)
    {
        "name": "Ariana Grande",
        "genre": "Music",
        "why": "Lead single Hate That I Made You Love Me debuted at No. 1 on the Billboard Hot 100 dated June 13, 2026, her 10th chart-topper ahead of album Petal.",
        "signal": "Billboard Hot 100 No. 1"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Sophomore album Dandelion debuted at No. 1 on the Billboard 200 in April 2026 with 169,000 equivalent album units, the biggest week for a country album by a woman in two years.",
        "signal": "Billboard 200 No. 1"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Won Grammy Award for Best Pop Solo Performance for Messy in February 2026, won BRIT Breakthrough Artist, and launched a UK arena tour in June 2026.",
        "signal": "Grammy Award winner"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "Headlined night two of Rolling Stone Future of Music showcase at SXSW 2026, representing the leading edge of arena-scale regional Mexican music crossover.",
        "signal": "Rolling Stone Future of Music SXSW 2026"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Headlined the final night of Rolling Stone Future of Music showcase at SXSW 2026, riding the momentum of his breakout single Texas.",
        "signal": "Rolling Stone Future of Music SXSW 2026"
    },
    {
        "name": "Sienna Spiro",
        "genre": "Music",
        "why": "Die On This Hill generated over 16 billion TikTok video views, charted No. 19 on the Billboard Hot 100, and her contribution Material Lover for The Devil Wears Prada 2 reached No. 4 on UK trending charts in May 2026.",
        "signal": "TikTok viral, Billboard Hot 100"
    },
    {
        "name": "Olivia Dean",
        "genre": "Music",
        "why": "Debut album The Art of Loving reached the top 10 on the Billboard 200 with hit Man I Need, earning seven nominations at the 2026 American Music Awards including Breakthrough Album.",
        "signal": "2026 AMA nominee, Billboard top 10"
    },
    {
        "name": "Sombr",
        "genre": "Music",
        "why": "Debut album I Barely Know Her nominated for Breakthrough Album of the Year at the 2026 American Music Awards, with seven total AMA nominations rivaling Taylor Swift.",
        "signal": "2026 AMA Breakthrough Album nominee"
    },
    {
        "name": "Megan Moroney",
        "genre": "Music",
        "why": "Album Cloud 9 reached No. 1 on the Billboard Country Albums chart and earned three nominations at the 2026 American Music Awards, cementing her as a country breakthrough act.",
        "signal": "Billboard Country No. 1"
    },
    # Art (target 3)
    {
        "name": "Rachel Maclean",
        "genre": "Art",
        "why": "Solo exhibition The Enchantment of Reason opened June 5, 2026 at Josh Lilley, London, featuring a new film drawing parallels between the AI boom and Victorian fairy mania.",
        "signal": "Gallery show, London 2026"
    },
    {
        "name": "Thomas Houseago",
        "genre": "Art",
        "why": "Exhibition Death's Sacred Mirror opened June 4, 2026 at Lévy Gorvy Dayan, London, pairing new sculptures with historical artifacts in a survey of sculpture across civilisations.",
        "signal": "Gallery show, London 2026"
    },
    {
        "name": "Maya Seas",
        "genre": "Art",
        "why": "Named among Artsy editors 5 Artists on Our Radar in June 2026 for her oil stick and 24-karat gold works inspired by Indian miniatures, gaining rapid gallery attention.",
        "signal": "Artsy editorial pick, June 2026"
    },
    # Culture (target 3)
    {
        "name": "Jeremy Allen White",
        "genre": "Culture",
        "why": "Named face of Louis Vuitton Spring-Summer 2026 campaign while The Bear continues to draw critical acclaim, placing him at the intersection of fashion and prestige TV.",
        "signal": "Louis Vuitton campaign, The Bear"
    },
    {
        "name": "Taylor Swift",
        "genre": "Culture",
        "why": "Inducted into the Songwriters Hall of Fame on June 11, 2026, and leads the 2026 American Music Awards with eight nominations, extending her record cultural dominance.",
        "signal": "Songwriters Hall of Fame inductee"
    },
    {
        "name": "Addison Rae",
        "genre": "Culture",
        "why": "Debut album Addison debuted at No. 4 on the Billboard 200 and earned a Grammy nomination for Best New Artist in 2026, completing her TikTok-to-pop-star arc.",
        "signal": "Grammy nomination, Billboard top 5"
    },
    # Backup candidates in case any above are already written
    {
        "name": "Sabrina Carpenter",
        "genre": "Music",
        "why": "Album Man's Best Friend debuted at No. 1 in 18 countries in August 2025 and continued charting globally through 2026, earning her the title of Pop Artist of the Year at the 2026 iHeartRadio Music Awards.",
        "signal": "iHeartRadio Music Awards winner"
    },
    {
        "name": "Chappell Roan",
        "genre": "Music",
        "why": "Continued dominance in 2026 with sold-out arena dates and chart presence stemming from Good Luck, Babe, cementing her as one of the defining voices of the era.",
        "signal": "Arena tour 2026"
    },
    {
        "name": "Adrianne Lenker",
        "genre": "Music",
        "why": "Released a critically acclaimed solo album in early 2026, building on Big Thief momentum with intimate songwriting that landed on year-end lists early.",
        "signal": "Pitchfork critical acclaim"
    },
    {
        "name": "Zach Bryan",
        "genre": "Music",
        "why": "Continued to dominate country and Americana crossover charts in 2026, breaking stadium records and holding multiple spots on the Hot Country Songs chart simultaneously.",
        "signal": "Billboard Hot Country Songs"
    },
    {
        "name": "Peso Pluma",
        "genre": "Music",
        "why": "Maintained global streaming dominance in 2026 with regional Mexican corridos tumbados reaching new international audiences and chart positions across Latin formats.",
        "signal": "Spotify global chart"
    },
]

# ── 3. Filter out already-written artists ────────────────────────────────────
candidates_filtered = [c for c in CANDIDATES if not already_written(c["name"])]
print(f"Candidates after filter: {len(candidates_filtered)}")

# Pick 15, aiming for 9 Music, 3 Art, 3 Culture
music   = [c for c in candidates_filtered if c["genre"] == "Music"]
art     = [c for c in candidates_filtered if c["genre"] == "Art"]
culture = [c for c in candidates_filtered if c["genre"] == "Culture"]

selected = music[:9] + art[:3] + culture[:3]

# If we don't have 15, top up from remaining music
if len(selected) < 15:
    used = {re.sub(r"[^a-z0-9]", "", s["name"].lower()) for s in selected}
    extras = [c for c in candidates_filtered if re.sub(r"[^a-z0-9]", "", c["name"].lower()) not in used]
    selected += extras[:15 - len(selected)]

print(f"Final radar list: {len(selected)} artists")
for a in selected:
    print(f"  [{a['genre']:7s}] {a['name']}")

# ── 4. Write radar-cache.json ─────────────────────────────────────────────────
os.makedirs(os.path.dirname(RADAR_OUT), exist_ok=True)
with open(RADAR_OUT, "w") as f:
    json.dump(selected, f, indent=2, ensure_ascii=False)

print(f"\nWrote {len(selected)} artists to {RADAR_OUT}")

# ── 5. Verify ────────────────────────────────────────────────────────────────
verify = json.load(open(RADAR_OUT))
print(f"Verify: {len(verify)} artists in radar cache")
print("Done.")
PYEOF

echo "=== Radar Cache Refresh Complete ==="
