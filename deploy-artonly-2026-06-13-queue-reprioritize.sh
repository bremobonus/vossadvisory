#!/bin/bash
# ArtOnly Queue Reprioritization Script
# Generated: 2026-06-13
# Task: Re-sort artist queue by audience tier + inject trending artists at front
# Run this on the DreamHost server via SSH

set -e
echo "=== ArtOnly Queue Reprioritization: 2026-06-13 ==="

python3 << 'PYEOF'
import json
from datetime import date

path = '/home/dh_yadmw3/artonly.io/agent/brain.json'
with open(path) as f:
    b = json.load(f)

# New queue order:
# 1. Trending artists (not yet written, culturally hot June 13 2026)
# 2. Tier A artists (1M+ audience)
# 3. Tier B artists (100k-1M)
# 4. Remaining in original order

new_queue = [
    # --- TRENDING (injected/promoted to front, June 13 2026) ---
    # Olivia Rodrigo: album "you seem pretty sad for a girl so in love" broke Spotify records June 12 2026
    "Olivia Rodrigo",
    # Tyler, The Creator: "Don't Tap the Glass" Grammy perf, "Sugar on My Tongue" viral TikTok June 2026
    "Tyler, The Creator",
    # Sabrina Carpenter: 5th biggest artist on Spotify, 2026 Coachella anthems
    "Sabrina Carpenter",
    # Bruno Mars: most streamed artist on Spotify June 2026
    "Bruno Mars",
    # PinkPantheress: strong ongoing streaming presence
    "PinkPantheress",
    # Megan Thee Stallion: 30M+ followers, top-tier US rap
    "Megan Thee Stallion",
    # Central Cee: biggest UK rap artist right now, 5M+ Instagram
    "Central Cee",

    # --- TIER A (1M+ audience, sorted from original queue) ---
    "Jorja Smith",        # ~4M Instagram
    "Skepta",             # ~3M Instagram
    "Dave",               # ~2M Instagram
    "Ari Lennox",         # ~2M Instagram/Spotify
    "Popcaan",            # ~2M Instagram
    "Koffee",             # ~1M+ Instagram
    "Cleo Sol",           # ~1M+ Spotify monthly
    "Little Simz",        # ~1M+ Instagram (Mercury Prize)
    "Headie One",         # ~1M+ Spotify monthly

    # --- TIER B (100k-1M audience, sorted from original queue) ---
    "Ella Langley",       # ~500K Spotify monthly
    "Sasha Keable",       # ~200K Instagram
    "Moliy",              # ~200K Spotify
    "Arca",               # ~500K Instagram
    "Shygirl",            # ~400K Instagram
    "Pa Salieu",          # ~500K Spotify
    "Ghetts",             # ~400K Spotify
    "slowthai",           # ~600K Instagram
    "NAO",                # ~500K Instagram
    "JPEGMAFIA",          # ~500K Spotify monthly
    "Kelsey Lu",          # ~200K Instagram
    "Ama Lou",            # ~200K Spotify
    "Greentea Peng",      # ~600K Instagram
    "Knucks",             # ~300K Spotify
    "SAULT",              # ~200K Spotify
    "Genesis Owusu",      # ~500K Spotify
    "Sampa the Great",    # ~300K Spotify

    # --- REMAINING (original order, Tier C/D and visual art/film section) ---
    "Florence Road",
    "clipping.",
    "Eartheater",
    "Injury Reserve",
    "MIKE",
    "billy woods",
    "Armand Hammer",
    "Vagabon",
    "Hawa",
    "Tkay Maidza",
    "Bbymutha",
    "Cecily Brown",
    "Nick Leon",
    "Vegyn",
    "Lee Gamble",
    "Amnesia Scanner",
    "Smerz",
    "Kelman Duran",
    "Elysia Crampton",
    "SPAZA",
    "Abena Koomson-Davis",
    "Msaki",
    "Blinky Bill",
    "Sen Morimoto",
    "Standing on the Corner",
    "Kerry James Marshall",
    "Njideka Akunyili Crosby",
    "Henry Taylor",
    "Titus Kaphar",
    "Wangechi Mutu",
    "Mickalene Thomas",
    "Theaster Gates",
    "Mark Bradford",
    "Dana Schutz",
    "Laura Owens",
    "Marlene Dumas",
    "Jenny Saville",
    "Rose Wylie",
    "Lubaina Himid",
    "Isaac Julien",
    "Wolfgang Tillmans",
    "Collier Schorr",
    "Taryn Simon",
    "Deana Lawson",
    "LaToya Ruby Frazier",
    "Donald Glover",
    "Lena Dunham",
    "Issa Rae",
    "Phoebe Waller-Bridge",
    "Bo Burnham",
    "Ramy Youssef",
    "Quinta Brunson",
    "Jerrod Carmichael",
    "Sam Levinson",
    "Janicza Bravo",
    "Dee Rees",
    "Ryan Coogler",
    "Chloe Zhao",
    "Barry Jenkins",
    "Jordan Peele",
    "Boots Riley",
    "Kogonada",
    "Andrew Dosunmu",
]

b['queue'] = new_queue
b['last_updated'] = str(date.today())

with open(path, 'w') as f:
    json.dump(b, f, indent=2, ensure_ascii=False)

print(f'Queue updated. Total length: {len(b["queue"])}')
print('Top 10 now in queue:')
for i, a in enumerate(b['queue'][:10], 1):
    print(f'  {i}. {a}')
PYEOF

echo "=== Done ==="
