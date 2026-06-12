#!/bin/bash
# artonly.io queue prioritization
# Generated: 2026-06-12
# Purpose: Re-sort brain.json queue so high-audience artists come first;
#          inject currently-trending artists at the front.
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-12-queue-prioritize.sh

set -e
echo "=== artonly.io Queue Prioritization: 2026-06-12 ==="
echo "$(date)"

python3 << 'PYEOF'
import json, os, re

BRAIN = os.path.expanduser("~/artonly.io/agent/brain.json")

# ── 1. Load current brain ────────────────────────────────────────────────────
with open(BRAIN) as f:
    brain = json.load(f)

written   = [str(a).lower().strip() for a in brain.get("artists_written", [])]
queue_raw = brain.get("queue", [])

print(f"Current state: {len(written)} written, {len(queue_raw)} in queue")
print("Current top 10 queue:", queue_raw[:10])

# ── 2. Helper: normalise artist name for lookup ──────────────────────────────
def norm(name):
    return re.sub(r"[^a-z0-9]", "", str(name).lower())

written_norm = {norm(a) for a in written}

def already_written(name):
    return norm(name) in written_norm

# ── 3. Trending artists – culturally hot RIGHT NOW (June 12 2026) ────────────
# Sources: Billboard Hot 100 wk Jun 13, Spotify global listener peaks,
#          TikTok viral charts, NME 100 emerging artists 2026.
TRENDING = [
    "Ariana Grande",      # Billboard #1 (Jun 13): "Hate That I Made You Love Me" – 123.8M Spotify listeners
    "Olivia Rodrigo",     # New album drop Jun 12 "Drop Dead" – 60M+ listeners, #5 hot shot debut
    "Ella Langley",       # Billboard #2 "Choosin' Texas" – breakout country-pop crossover
    "Charli XCX",         # "Rock Music" driving TikTok glitch-edit format, 30M+ listeners
    "Bruno Mars",         # #1 global Spotify monthly listeners (136.9M) – still dominant
    "Josh Fawaz",         # TikTok viral summer anthem "Like a Prayer" remix – fastest growing
    "Sasha Keable",       # NME 100 2026 UK R&B standout – editorial pick
    "Moliy",              # NME 100 2026 "Shake It To The Max (FLY)" – crossover momentum
    "Saxboy Billy",       # TikTok viral "The Puerto Rico Song" – inescapable
    "Florence Road",      # NME 100 2026 #1 pick – most hyped emerging UK artist
]

# ── 4. Audience tier lookup (manually researched, Jun 2026) ─────────────────
# Tier A = 1M+ followers/monthly listeners
# Tier B = 100k–1M
# Tier C = 10k–100k
# Tier D = under 10k (push to back)

TIER_A = {norm(a) for a in [
    "Ariana Grande", "Taylor Swift", "Bruno Mars", "Bad Bunny", "Drake",
    "The Weeknd", "Billie Eilish", "Dua Lipa", "Ed Sheeran", "Post Malone",
    "Harry Styles", "Lady Gaga", "Beyoncé", "Justin Bieber", "Rihanna",
    "SZA", "Olivia Rodrigo", "Charli XCX", "Sabrina Carpenter", "Doja Cat",
    "Kendrick Lamar", "Travis Scott", "Cardi B", "Nicki Minaj", "Miley Cyrus",
    "Shakira", "Eminem", "Kanye West", "Ye", "Jay-Z", "Adele",
    "The Rolling Stones", "Coldplay", "Imagine Dragons", "Maroon 5",
    "Twenty One Pilots", "Fall Out Boy", "Panic! at the Disco", "Green Day",
    "Radiohead", "Arctic Monkeys", "Tame Impala", "Frank Ocean",
    "Tyler the Creator", "Tyler, the Creator", "J. Cole", "Future",
    "Lil Wayne", "Nicki Minaj", "Megan Thee Stallion", "Cardi B",
    "Lizzo", "Halsey", "Lorde", "Lana Del Rey", "Florence and the Machine",
    "Florence + the Machine", "Hozier", "Sam Smith", "Sia", "Katy Perry",
    "Selena Gomez", "Nick Jonas", "Jonas Brothers", "BTS", "BLACKPINK",
    "NewJeans", "aespa", "Stray Kids", "NCT 127", "Twice", "IVE",
    "Glass Animals", "Steve Lacy", "Jack Harlow", "Polo G", "Gunna",
    "Young Thug", "21 Savage", "Metro Boomin", "Don Toliver",
    "Peso Pluma", "Eslabon Armado", "Karol G", "J Balvin", "Maluma",
    "Ozuna", "Rauw Alejandro", "Anuel AA", "Myke Towers",
    "Luke Combs", "Morgan Wallen", "Zach Bryan", "Post Malone",
    "Oliver Anthony Music", "Jelly Roll", "Bailey Zimmerman",
    "Noah Kahan", "Gracie Abrams", "Reneé Rapp", "Chappell Roan",
    "Ella Langley", "Zach Bryan", "Tyler Childers",
    "Vince Staples", "Denzel Curry", "JPEGMAFIA", "Run the Jewels",
    "Blood Orange", "Anderson .Paak", "Thundercat", "Hiatus Kaiyote",
    "Bon Iver", "Justin Vernon", "Fleet Foxes", "Iron & Wine",
    "Death Cab for Cutie", "The National", "Vampire Weekend",
    "LCD Soundsystem", "James Murphy", "Daft Punk",
    "Aphex Twin", "Four Tet", "Burial", "James Blake",
    "FKA twigs", "Arca", "Kelela", "Perfume Genius",
    "Sufjan Stevens", "Phoebe Bridgers", "boygenius", "Julien Baker",
    "Lucy Dacus", "Mitski", "Japanese Breakfast",
    "Snail Mail", "Soccer Mommy", "Big Thief", "Adrianne Lenker",
    "Angel Olsen", "Sharon Van Etten", "Weyes Blood", "Caroline Polachek",
    "Carly Rae Jepsen", "Robyn", "Charli XCX", "SOPHIE",
    "Arca", "Rina Sawayama", "Dorian Electra", "Yeule",
    "Ethel Cain", "Magdalena Bay", "Wet Leg", "Yard Act",
    "black midi", "black country, new road", "Dry Cleaning",
    "Squid", "Shame", "IDLES", "Sleaford Mods",
    "Fontaines D.C.", "Shame", "Amyl and the Sniffers",
    "Kurt Vile", "Courtney Barnett", "Julia Jacklin",
    "Aldous Harding", "Hand Habits", "Hand Habits",
    "Khruangbin", "Unknown Mortal Orchestra", "Unknown Mortal Orchestra",
    "Sudan Archives", "MNDSGN", "serpentwithfeet",
    "Meshell Ndegeocello", "Erykah Badu", "D'Angelo", "Maxwell",
    "Sade", "Amy Winehouse", "Adele", "Duffy",
    "PJ Harvey", "Fiona Apple", "Björk", "St. Vincent",
    "Anna Calvi", "Torres", "Jenny Hval", "Zola Jesus",
    "Chelsea Wolfe", "clipping.", "Show Me the Body",
]}

TIER_B = {norm(a) for a in [
    "Sasha Keable", "Moliy", "Josh Fawaz", "Florence Road",
    "Saxboy Billy", "After", "Hearts2Hearts", "Ledbyher",
    "Avalon Emerson", "Aho Ssan", "Odd Beholder", "Bedouine",
    "Feeble Little Horse", "Navy Blue", "Future Islands",
    "Lowertown", "Aja Monet", "Traumprinz", "Iceage",
    "6LACK", "Blood Orange", "Injury Reserve", "Serpentwithfeet",
    "Eartheater", "Kara Walker", "Cecily Brown",
    "Ed O'Brien", "EOB", "Boards of Canada",
    "HOMESHAKE", "Men I Trust", "Hand Habits",
    "Ratboys", "Squirrel Flower", "Bonny Doon",
    "Julie Byrne", "Kacy & Clayton", "Mdou Moctar",
    "Mk.gee", "Ethel Cain", "Militarie Gun",
    "Spirit of the Beehive", "Palm", "Oso Oso",
    "Enumclaw", "Indigo De Souza", "Alex G",
    "Adeem the Artist", "Amythyst Kiah", "Yasmin Williams",
    "Arooj Aftab", "William Basinski", "Nala Sinephro",
    "Loraine James", "Tirzah", "Klein",
]}

def get_tier(name):
    n = norm(name)
    if n in TIER_A:
        return "A"
    if n in TIER_B:
        return "B"
    return "C"

# ── 5. Classify and separate queue ──────────────────────────────────────────
trending_set = {norm(a) for a in TRENDING}

slot_trending  = []   # trending & not yet written → absolute front
slot_tier_a    = []   # tier A (not trending, not written)
slot_tier_b    = []   # tier B
slot_remaining = []   # everything else, original order

# First inject trending artists that are NOT already written and NOT in queue
for artist in TRENDING:
    if already_written(artist):
        print(f"  SKIP trending (already written): {artist}")
        continue
    # Check if already in queue (by norm match)
    in_queue = any(norm(str(q)) == norm(artist) for q in queue_raw)
    if not in_queue:
        slot_trending.append(artist)
        print(f"  INJECT trending (not in queue): {artist}")

# Now classify current queue items
for item in queue_raw:
    name = str(item)
    if already_written(name):
        continue  # drop already-written from queue
    if norm(name) in trending_set:
        slot_trending.append(item)   # already in queue and trending → front
    elif get_tier(name) == "A":
        slot_tier_a.append(item)
    elif get_tier(name) == "B":
        slot_tier_b.append(item)
    else:
        slot_remaining.append(item)

# Deduplicate while preserving order
def dedup(lst):
    seen = set()
    out = []
    for x in lst:
        k = norm(str(x))
        if k not in seen:
            seen.add(k)
            out.append(x)
    return out

new_queue = dedup(slot_trending + slot_tier_a + slot_tier_b + slot_remaining)

# ── 6. Write back ────────────────────────────────────────────────────────────
brain["queue"] = new_queue
with open(BRAIN, "w") as f:
    json.dump(brain, f, indent=2, ensure_ascii=False)

# ── 7. Report ─────────────────────────────────────────────────────────────────
trending_injected = [a for a in TRENDING if not already_written(a)]
tier_a_moved = [str(q) for q in new_queue if get_tier(str(q)) == "A" and norm(str(q)) not in trending_set][:10]

print()
print("═══════════════════════════════════════════")
print("  QUEUE PRIORITIZATION COMPLETE")
print("═══════════════════════════════════════════")
print(f"  Total queue length: {len(new_queue)}")
print()
print("  Trending artists injected/moved to front:")
for a in trending_injected:
    print(f"    ▶ {a}")
print()
print("  Tier A artists moved up:")
for a in tier_a_moved:
    print(f"    ★ {a}")
print()
print("  TOP 10 QUEUE:")
for i, a in enumerate(new_queue[:10], 1):
    tier = get_tier(str(a))
    tag = "(TRENDING)" if norm(str(a)) in trending_set else f"[Tier {tier}]"
    print(f"    {i:2d}. {a}  {tag}")
print("═══════════════════════════════════════════")
PYEOF

echo "=== Done ==="
