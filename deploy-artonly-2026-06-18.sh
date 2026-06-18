#!/bin/bash
# Queue prioritization update - June 18, 2026
# Injects 7 trending artists + re-sorts by audience tier
set -e

python3 << 'PYEOF'
import json

brain_path = "/home/dh_yadmw3/artonly.io/agent/brain.json"

with open(brain_path) as f:
    b = json.load(f)

new_queue = [
    "Taylor Swift",
    "Drake",
    "The Weeknd",
    "Bad Bunny",
    "Doja Cat",
    "Future",
    "Lady Gaga",
    "Kendrick Lamar",
    "SZA",
    "Chappell Roan",
    "Tyla",
    "FKA twigs",
    "Lola Young",
    "Kehlani",
    "Leon Thomas",
    "PinkPantheress",
    "Megan Thee Stallion",
    "Central Cee",
    "Jorja Smith",
    "Skepta",
    "Dave",
    "Ari Lennox",
    "Popcaan",
    "Little Simz",
    "Koffee",
    "Cleo Sol",
    "Headie One",
    "Arca",
    "Shygirl",
    "Pa Salieu",
    "slowthai",
    "JPEGMAFIA",
    "Greentea Peng",
    "Ella Langley",
    "Sasha Keable",
    "Moliy",
    "Ghetts",
    "NAO",
    "SAULT",
    "Genesis Owusu",
    "Sampa the Great",
    "Kelsey Lu",
    "Ama Lou",
    "Knucks",
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
    "Andrew Dosunmu"
]

written_set = set(b.get("artists_written", []))
filtered_queue = [a for a in new_queue if a not in written_set]

b["queue"] = filtered_queue
b["last_updated"] = "2026-06-18"

with open(brain_path, "w") as f:
    json.dump(b, f, indent=2)

print("brain.json updated. Queue length:", len(filtered_queue))
print("Top 10:", filtered_queue[:10])
PYEOF
