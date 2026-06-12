#!/bin/bash
# artonly.io radar cache refresh
# Generated: 2026-06-12
# Purpose: Find 15 trending artists and write them to artonly.io/data/radar-cache.json
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-12-radar.sh

set -e
echo "=== artonly.io Radar Cache Refresh: 2026-06-12 ==="
echo "$(date)"

python3 << 'PYEOF'
import json, os, re

BRAIN = os.path.expanduser("~/artonly.io/agent/brain.json")
RADAR = os.path.expanduser("~/artonly.io/data/radar-cache.json")

# Load brain to get artists already written
with open(BRAIN) as f:
    brain = json.load(f)

written = [str(a) for a in brain.get("artists_written", [])]
print(f"Artists already written: {len(written)}")

def norm(name):
    return re.sub(r'[^a-z0-9]', '', str(name).lower())

written_norm = {norm(w) for w in written}

def already_written(name):
    return norm(name) in written_norm

# Candidate pool: trending artists, June 2026
# Sources: Billboard Hot 100 wk Jun 13, Spotify global charts, BRIT Awards 2026,
#          Grammy 2026, Coachella 2026, Whitney Biennial 2026, Tate Modern 2026.
# Rule: no em-dashes in any text. Use commas or periods only.

POOL_MUSIC = [
    {
        "name": "Ariana Grande",
        "genre": "Music",
        "why": "Lead single Hate That I Made You Love Me debuted at No. 1 on Billboard Hot 100 on June 13, her 10th chart-topper, from forthcoming album Petal due July 31 on Republic Records",
        "signal": "Billboard Hot 100 No. 1"
    },
    {
        "name": "Olivia Rodrigo",
        "genre": "Music",
        "why": "Third album You Seem Pretty Sad for a Girl So in Love dropped June 12, named the most anticipated pop release of summer 2026 by Music Times, produced entirely by Dan Nigro",
        "signal": "New album release"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Choosin Texas spent 10 non-consecutive weeks at No. 1 on the Hot 100 and swept the 2026 ACM Awards with seven wins, the most ever by one artist in a single year",
        "signal": "Billboard Hot 100 record and ACM Awards sweep"
    },
    {
        "name": "Bruno Mars",
        "genre": "Music",
        "why": "Album The Romantic debuted at No. 1 in 20 countries and I Just Might spent 21 weeks atop Hot R&B Songs, making him the top global Spotify artist with 136.9 million monthly listeners",
        "signal": "Spotify Global No. 1"
    },
    {
        "name": "Drake",
        "genre": "Music",
        "why": "Janice STFU from triple album release Iceman leads Billboard Songs of Summer 2026 and broke Michael Jacksons record for most No. 1 hits by a male solo artist on the Hot 100",
        "signal": "Billboard Hot 100 record"
    },
    {
        "name": "Evanescence",
        "genre": "Music",
        "why": "Sanctuary released June 5 on BMG is their first studio album in 8 years, with a world tour starting June 11 marking one of rock's most anticipated returns of 2026",
        "signal": "New album release June 2026"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "First-ever US stadium tour This Is Our Dream starts June 18 at Petco Park in San Diego, after topping Hot Latin Songs with 111XPANTIA and headlining Suenos 2026 in Chicago",
        "signal": "Stadium tour announcement and Billboard No. 1"
    },
    {
        "name": "Karol G",
        "genre": "Music",
        "why": "Headlined Coachella 2026 as the first Latina to do so and sold 2 million tickets in four days for her Viajando Por El Mundo global tour, with Tropicoqueta her fourth consecutive No. 1 on Top Latin Albums",
        "signal": "Coachella headliner and tour record"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Won her first Grammy for Best Pop Performance for Messy in early 2026, swept the BRIT Awards Breakthrough Artist category, and released comeback single From Down Here on May 22",
        "signal": "Grammy and BRIT Awards win 2026"
    },
    {
        "name": "Sabrina Carpenter",
        "genre": "Music",
        "why": "Headlined Coachella 2026 to a sold-out crowd and released Madonna collaboration Bring Your Love in April, with Manchild from Man's Best Friend still in the Hot 100 top 10",
        "signal": "Coachella headliner and new collaboration"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "All the Way featuring Bailey Zimmerman became the first song in chart history to simultaneously top both Billboard Hot Country Songs and Hot Rap Songs, crossing genre lines in real time",
        "signal": "Billboard dual chart record"
    },
    {
        "name": "Yes",
        "genre": "Music",
        "why": "24th studio album Aurora arrives June 2026 featuring Steve Howe, Geoff Downes, and Billy Sherwood in a reunion celebrated as the band's most complete lineup since the 1990s",
        "signal": "New album June 2026"
    },
]

POOL_ART = [
    {
        "name": "Raven Halfmoon",
        "genre": "Art",
        "why": "Nine-foot ceramic sculpture Too Ancient to Care stands in the Whitney Biennial 2026 plaza, claiming space for Caddo Nation women, named one of 8 standout artists by Artsy",
        "signal": "Whitney Biennial 2026"
    },
    {
        "name": "Tracey Emin",
        "genre": "Art",
        "why": "A Second Life retrospective at Tate Modern spanning 40 years and more than 100 works runs February 27 to August 31 2026, the largest Emin survey ever mounted",
        "signal": "Tate Modern retrospective 2026"
    },
    {
        "name": "Emilie Louise Gossiaux",
        "genre": "Art",
        "why": "Kong Play installation of 100 hand-built ceramics honoring late guide dog London is among the first works visitors encounter at Whitney Biennial 2026, drawing widespread critical attention",
        "signal": "Whitney Biennial 2026"
    },
    {
        "name": "Ming Wong",
        "genre": "Art",
        "why": "National Gallery London 2025 Artist in Residence film Dance of the Sun on the Water reimagines Derek Jarman and represents the museum's first major commission by a Southeast Asian artist",
        "signal": "National Gallery London commission 2025 to 2026"
    },
]

POOL_CULTURE = [
    {
        "name": "Taylor Swift",
        "genre": "Culture",
        "why": "Honored at the Songwriters Hall of Fame in New York on June 11 alongside Alanis Morissette and Gene Simmons, with a viral custom New York Knicks T-shirt moment with Alana Haim",
        "signal": "Songwriters Hall of Fame induction June 2026"
    },
    {
        "name": "Michaela Coel",
        "genre": "Culture",
        "why": "Stars opposite Anne Hathaway in A24 film Mother Mary directed by David Lowery, with the film generating major awards season speculation heading into summer 2026",
        "signal": "A24 film summer 2026"
    },
    {
        "name": "Greta Gerwig",
        "genre": "Culture",
        "why": "Named president of the jury for the 2026 Cannes Film Festival, cementing her position as the defining filmmaker of her generation two years after Barbie rewrote box office history",
        "signal": "Cannes Film Festival jury president 2026"
    },
    {
        "name": "Emily Blunt",
        "genre": "Culture",
        "why": "Stars in Steven Spielberg's Disclosure Day alongside Josh O'Connor, a film described as one of the most anticipated releases of summer 2026 by Entertainment Weekly",
        "signal": "Spielberg film summer 2026"
    },
]

# Build final list: 9 music, 3 art, 3 culture
music_candidates = [a for a in POOL_MUSIC if not already_written(a["name"])]
art_candidates   = [a for a in POOL_ART   if not already_written(a["name"])]
culture_candidates = [a for a in POOL_CULTURE if not already_written(a["name"])]

print(f"Music candidates: {len(music_candidates)}, Art: {len(art_candidates)}, Culture: {len(culture_candidates)}")

music_picks   = music_candidates[:9]
art_picks     = art_candidates[:3]
culture_picks = culture_candidates[:3]

radar = music_picks + art_picks + culture_picks
total = len(radar)
print(f"Final radar list: {total} artists ({len(music_picks)} music, {len(art_picks)} art, {len(culture_picks)} culture)")

if total < 15:
    # Pad from remaining pools if under 15
    remaining = music_candidates[9:] + art_candidates[3:] + culture_candidates[3:]
    remaining_filtered = [a for a in remaining if not any(norm(a["name"]) == norm(r["name"]) for r in radar)]
    radar += remaining_filtered[:15 - total]
    print(f"Padded to {len(radar)} artists")

# Write radar cache
os.makedirs(os.path.dirname(RADAR), exist_ok=True)
with open(RADAR, "w") as f:
    json.dump(radar, f, indent=2, ensure_ascii=False)
    f.write("\n")

print(f"\nWrote {len(radar)} artists to {RADAR}")
for i, r in enumerate(radar, 1):
    print(f"  {i:2d}. [{r['genre']}] {r['name']}")

# Verify
with open(RADAR) as f:
    verify = json.load(f)
print(f"\nVerified: {len(verify)} artists in radar-cache.json")
PYEOF

echo "=== Radar Cache Refresh Done ==="
