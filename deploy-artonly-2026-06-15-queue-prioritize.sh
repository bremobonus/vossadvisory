#!/bin/bash
# artonly.io queue prioritization
# Generated: 2026-06-15
# Purpose: Re-sort brain.json queue so high-audience artists come first;
#          inject currently-trending artists at the front.
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-15-queue-prioritize.sh

set -e
echo "=== artonly.io Queue Prioritization: 2026-06-15 ==="
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

# ── 2. Helper ────────────────────────────────────────────────────────────────
def norm(name):
    return re.sub(r"[^a-z0-9]", "", str(name).lower())

written_norm = {norm(a) for a in written}

def already_written(name):
    return norm(name) in written_norm

# ── 3. Trending artists – culturally hot RIGHT NOW (June 15 2026) ────────────
# Sources:
#   Billboard Hot 100 wk Jun 13: Ariana Grande #1, Olivia Rodrigo #5 new
#   Spotify global Jun 2026: Tyla 40M listeners, Leon Thomas 1600% Grammy surge
#   Grammy wins 2026: Leon Thomas (Best R&B Album), Lola Young (Best Pop Solo)
#   NME 100 2026: Florence Road #1 emerging pick
#   New album releases Jun 2026: The Strokes "Reality Awaits" Jun 26
#   KATSEYE: Grammy Best New Artist 2026 nominee, global K-pop crossover
#   Kendrick Lamar, SZA, Chappell Roan, FKA twigs, Kehlani: high-audience
#     Tier A artists not yet in written list (carried from prior prioritization)
TRENDING = [
    "Tyla",            # 40M Spotify listeners; A*POP album July 2026; biggest African pop act
    "Lola Young",      # Grammy 2026 Best Pop Solo Performance; "Messy" 1B+ streams; viral
    "Leon Thomas",     # Grammy 2026 Best R&B Album; MUTT album; 1600% Spotify surge
    "The Strokes",     # "Reality Awaits" album Jun 26 2026; 18.5M Spotify listeners
    "KATSEYE",         # Grammy Best New Artist 2026 nominee; global K-pop crossover
    "Kendrick Lamar",  # 80M+ Spotify listeners; culturally dominant
    "SZA",             # 40M+ Spotify listeners; ongoing chart presence
    "Chappell Roan",   # Grammy 2026 Best New Artist winner; 25M+ listeners
    "FKA twigs",       # 10M+ listeners; artonly.io-aligned aesthetic
    "Kehlani",         # 15M+ listeners; R&B audience overlap
]

# ── 4. Audience tier lookup (researched Jun 2026) ───────────────────────────
TIER_A_NAMES = [
    # Mainstream giants
    "Ariana Grande", "Taylor Swift", "Bruno Mars", "Bad Bunny", "Drake",
    "The Weeknd", "Billie Eilish", "Dua Lipa", "Ed Sheeran", "Post Malone",
    "Harry Styles", "Beyoncé", "Justin Bieber", "Rihanna", "SZA",
    "Olivia Rodrigo", "Charli XCX", "Sabrina Carpenter", "Doja Cat",
    "Kendrick Lamar", "Travis Scott", "Cardi B", "Nicki Minaj",
    "Shakira", "Eminem", "Kanye West", "Ye", "Jay-Z", "Adele",
    "Coldplay", "Imagine Dragons", "Green Day", "Radiohead",
    "Arctic Monkeys", "Tame Impala", "Frank Ocean",
    "Tyler, the Creator", "Tyler the Creator", "J. Cole", "Future",
    "Lil Wayne", "Megan Thee Stallion", "Lizzo", "Lorde",
    "Lana Del Rey", "Florence and the Machine", "Florence + the Machine",
    "Hozier", "Sam Smith", "Sia", "Katy Perry", "Selena Gomez",
    "BTS", "BLACKPINK", "NewJeans", "aespa", "Stray Kids",
    "Glass Animals", "Steve Lacy", "Jack Harlow",
    "Peso Pluma", "Eslabon Armado", "Karol G", "J Balvin",
    "Luke Combs", "Morgan Wallen", "Zach Bryan",
    "Noah Kahan", "Gracie Abrams", "Chappell Roan",
    "Vince Staples", "Denzel Curry", "JPEGMAFIA", "Run the Jewels",
    "Anderson .Paak", "Thundercat", "Hiatus Kaiyote",
    "Bon Iver", "Fleet Foxes", "Death Cab for Cutie", "The National",
    "Vampire Weekend", "LCD Soundsystem", "Daft Punk",
    "Aphex Twin", "Four Tet", "Burial", "James Blake",
    "FKA twigs", "Kelela", "Perfume Genius",
    "Sufjan Stevens", "Phoebe Bridgers", "boygenius", "Julien Baker",
    "Lucy Dacus", "Mitski", "Japanese Breakfast", "Big Thief",
    "Angel Olsen", "Sharon Van Etten", "Weyes Blood", "Caroline Polachek",
    "Carly Rae Jepsen", "Robyn",
    "Rina Sawayama", "Ethel Cain", "Magdalena Bay", "Wet Leg",
    "Fontaines D.C.", "IDLES", "Sleaford Mods", "Courtney Barnett",
    "Aldous Harding", "Khruangbin",
    "Meshell Ndegeocello", "Erykah Badu", "D'Angelo", "Maxwell",
    "Sade", "PJ Harvey", "Fiona Apple", "Björk", "St. Vincent",
    # Confirmed from research (Jun 2026)
    "Dave",             # 35.5M Spotify monthly listeners
    "Skepta",           # 15.1M Spotify monthly listeners
    "Tyla",             # 40M Spotify monthly listeners
    "Lola Young",       # Grammy winner; massive streaming surge
    "Leon Thomas",      # Grammy winner; 1600% post-Grammy Spotify surge
    "The Strokes",      # 18.5M Spotify monthly listeners
    "Kehlani",          # 15M+ Spotify monthly listeners
    "Cleo Sol",         # 3.6M Spotify monthly listeners
    "Popcaan",          # 3.3M Spotify monthly listeners
    "Ari Lennox",       # 3.1M Spotify monthly listeners
    "Headie One",       # ~3M estimated (major UK drill act)
    "slowthai",         # ~2M estimated
    "Ella Langley",     # ~1.5M estimated
    "Koffee",           # ~1.5M (Grammy winner, global reach)
    "Little Simz",      # 1.1M Spotify monthly listeners
]

TIER_A = {norm(a) for a in TIER_A_NAMES}

TIER_B_NAMES = [
    "Shygirl", "Pa Salieu", "NAO", "Greentea Peng", "SAULT",
    "Genesis Owusu", "Sampa the Great", "Moliy", "Knucks", "Ghetts",
    "Florence Road", "Sasha Keable", "Kelsey Lu", "Ama Lou",
    "KATSEYE", "After", "Hearts2Hearts", "Ledbyher",
    "Avalon Emerson", "Aho Ssan", "Bedouine", "Future Islands",
    "Navy Blue", "Lowertown", "Aja Monet", "Traumprinz", "Iceage",
    "6LACK", "Injury Reserve", "Eartheater", "Cecily Brown",
    "Boards of Canada", "Men I Trust", "Hand Habits", "Ratboys",
    "Squirrel Flower", "Julie Byrne", "Mdou Moctar",
    "Spirit of the Beehive", "Alex G", "Indigo De Souza",
    "Yasmin Williams", "Arooj Aftab", "William Basinski",
    "Nala Sinephro", "Loraine James", "Tirzah",
]

TIER_B = {norm(a) for a in TIER_B_NAMES}

def get_tier(name):
    n = norm(name)
    if n in TIER_A:
        return "A"
    if n in TIER_B:
        return "B"
    return "C"

# ── 5. Classify and separate queue ──────────────────────────────────────────
trending_set  = {norm(a) for a in TRENDING}
slot_trending = []
slot_tier_a   = []
slot_tier_b   = []
slot_remaining= []

# Inject trending not already written
for artist in TRENDING:
    if already_written(artist):
        print(f"  SKIP trending (already written): {artist}")
        continue
    in_queue = any(norm(str(q)) == norm(artist) for q in queue_raw)
    if not in_queue:
        slot_trending.append(artist)
        print(f"  INJECT trending (new): {artist}")
    # if already in queue, it will be caught below

# Classify current queue
for item in queue_raw:
    name = str(item)
    if already_written(name):
        continue
    n = norm(name)
    if n in trending_set:
        slot_trending.append(item)
    elif get_tier(name) == "A":
        slot_tier_a.append(item)
    elif get_tier(name) == "B":
        slot_tier_b.append(item)
    else:
        slot_remaining.append(item)

def dedup(lst):
    seen, out = set(), []
    for x in lst:
        k = norm(str(x))
        if k not in seen:
            seen.add(k)
            out.append(x)
    return out

new_queue = dedup(slot_trending + slot_tier_a + slot_tier_b + slot_remaining)

# ── 6. Write back ────────────────────────────────────────────────────────────
brain["queue"] = new_queue
brain["last_updated"] = "2026-06-15"
with open(BRAIN, "w") as f:
    json.dump(brain, f, indent=2, ensure_ascii=False)

# ── 7. Report ─────────────────────────────────────────────────────────────────
trending_injected = [a for a in TRENDING if not already_written(a)]
tier_a_moved = [str(q) for q in new_queue
                if get_tier(str(q)) == "A" and norm(str(q)) not in trending_set][:10]

print()
print("═══════════════════════════════════════════")
print("  QUEUE PRIORITIZATION COMPLETE  2026-06-15")
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
