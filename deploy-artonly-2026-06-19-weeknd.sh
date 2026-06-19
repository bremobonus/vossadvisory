#!/bin/bash
# ArtOnly: The Weeknd - Culture article (category 3) by Abel Blackburn
# Slug: weeknd-hurry-up-tomorrow
# Run via GitHub Actions -> DreamHost SSH

set -e

SLUG="weeknd-hurry-up-tomorrow"
BASE="/home/dh_yadmw3/artonly.io"
ASSETS="$BASE/assets/images/artists"

echo "=== ArtOnly: The Weeknd culture article ==="
date

# ── STEP 1: Download images ─────────────────────────────────────

dl() {
  local fname="$1" url="$2" alt="${3:-}"
  curl -s -L -A "Mozilla/5.0" --max-time 45 -o "$ASSETS/$fname" "$url" 2>/dev/null || true
  local sz
  sz=$(stat -c%s "$ASSETS/$fname" 2>/dev/null || echo 0)
  if [ "$sz" -lt 5000 ] && [ -n "$alt" ]; then
    echo "  retry $fname"
    curl -s -L -A "Mozilla/5.0" --max-time 45 -o "$ASSETS/$fname" "$alt" 2>/dev/null || true
    sz=$(stat -c%s "$ASSETS/$fname" 2>/dev/null || echo 0)
  fi
  if [ "$sz" -lt 5000 ] && [ -n "$alt" ]; then
    echo "  retry2 $fname (Wikimedia fallback)"
    curl -s -L -A "Mozilla/5.0" --max-time 45 -o "$ASSETS/$fname" \
      "https://upload.wikimedia.org/wikipedia/commons/a/a0/The_Weeknd_Portrait_by_Brian_Ziff.jpg" 2>/dev/null || true
    sz=$(stat -c%s "$ASSETS/$fname" 2>/dev/null || echo 0)
  fi
  echo "  $fname: ${sz} bytes"
}

# Hero image (face portrait, not album art)
dl "${SLUG}.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/a/a0/The_Weeknd_Portrait_by_Brian_Ziff.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/2/23/The_Weeknd_Jimmy_Fallon_2025_%28cropped%29.png"

# Body images (6 unique section images)
dl "${SLUG}-intro.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/02/hurry-up-tomorrow-the-weeknd.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/2/2f/The_Weeknd_Universal_Studios_Hollywood.jpg"

dl "${SLUG}-portrait.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/2/23/The_Weeknd_Jimmy_Fallon_2025_%28cropped%29.png" \
  "https://upload.wikimedia.org/wikipedia/commons/2/2f/The_Weeknd_Universal_Studios_Hollywood.jpg"

dl "${SLUG}-cover.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/2/2f/The_Weeknd_Universal_Studios_Hollywood.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/05/hurry-up-tomorrow-exclusive-still-featured-screenrant.jpg"

dl "${SLUG}-live.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/05/hurry-up-tomorrow-exclusive-still-featured-screenrant.jpg" \
  "https://deadline.com/wp-content/uploads/2025/02/hurry-up-tomorrow-pic1_rgb.jpg"

dl "${SLUG}-studio.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/05/hurry-up-tomorrow-movie-still-screenrant-exclusive.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/05/hurry-up-tomorrow-exclusive-still-featured-screenrant.jpg"

dl "${SLUG}-promo.jpg" \
  "https://deadline.com/wp-content/uploads/2025/02/hurry-up-tomorrow-pic1_rgb.jpg" \
  "https://static0.srcdn.com/wordpress/wp-content/uploads/2025/05/hurry-up-tomorrow-movie-still-screenrant-exclusive.jpg"

echo "Images done."

# ── STEP 2: Publish article ─────────────────────────────────────

python3 << 'PYEOF'
import json, subprocess, sys, os

SLUG = "weeknd-hurry-up-tomorrow"
BASE = "/home/dh_yadmw3/artonly.io"
ASSETS = BASE + "/assets/images/artists"

# Check which body images are valid
failed = []
for s in ["intro", "portrait", "cover", "live", "studio", "promo"]:
    path = f"{ASSETS}/{SLUG}-{s}.jpg"
    sz = os.path.getsize(path) if os.path.exists(path) else 0
    if sz < 5000:
        failed.append(s)
        print(f"  WARN: {SLUG}-{s}.jpg too small ({sz}B), removing from article")

body = """On August 31, 2025, Spotify confirmed that "Blinding Lights" had become the first recording in the platform's history to reach five billion streams. The milestone arrived without any coordinated press event. Abel Tesfaye, who recorded the song and built the career that carried it to that number, had already announced the retirement of The Weeknd, the stage name he had used since 2011. The record and the retirement landed in the same year. That is not coincidence. It is the shape of a project that was always moving toward a designed close. Tesfaye spent fifteen years building an identity under a stage name, scaling it to one of the most commercially dominant personas in modern music history, and then systematically retiring it. That decision, and the discipline behind it, is the most revealing thing about how he understood his own work.

## Born in Scarborough

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-intro.jpg]

Abel Makkonen Tesfaye was born February 16, 1990, in Toronto, Ontario. His parents had emigrated from Ethiopia. He grew up in Scarborough, an eastern suburb that has produced a disproportionate number of significant Canadian musicians relative to its cultural visibility. Tesfaye dropped out of high school at 17. By his own account in later interviews, he was moving between friends' apartments and recording when he uploaded his first music to YouTube in 2010 under a name with one letter removed from the weekend, for trademark purposes. He released no photographs. He gave no interviews. No booking contact existed. Music spread through blogs in the period before streaming had restructured how people discovered new artists. The absence of a public identity created a specific kind of sustained attention. Audiences knew the voice before they knew the face. The mystery held for longer than a conventional promotional launch would have allowed.

## The Character He Built

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-portrait.jpg]

The Weeknd was not a stage name in the ordinary sense. It was a character with a defined visual identity, a sustained emotional register, and a planned conclusion. The aesthetic that developed through "Beauty Behind the Madness" (2015) and "Starboy" (2016) was not incidental styling. The bleached tips, the sonic palette of well-funded isolation, and the recurring tension between excess and emptiness were architectural decisions inside a larger narrative project. The "After Hours" era (2020) made this fully explicit. The man in the red suit who appeared across a series of interconnected short films had continuity. The films had story logic and a specific direction. The final image of the character lying on a sidewalk, following a sequence referencing plastic surgery and persona collapse, was not ambiguous. It was an ending deliberately constructed to set up the next chapter.

## Blinding Lights and What It Proved

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-cover.jpg]

"Blinding Lights" was released November 29, 2019. Produced with Max Martin and Oscar Holter, it spent 57 weeks inside the Billboard Hot 100 top 10 and 86 weeks in the top 40, records at the time for any song. In January 2025, Billboard named it the number one song of the 21st century. By August 2025, it became the first recording to accumulate five billion streams on Spotify.

These numbers require some framing. "Blinding Lights" charted simultaneously across pop, R&B, and adult contemporary formats, a crossover that most artists at Tesfaye's commercial level cannot reliably produce. The song was built around 1980s synth production references but required no historical knowledge of those references to engage with emotionally. It operated as pure feeling while carrying enough formal specificity to hold critical attention. The scale of the commercial reach gave Tesfaye a platform that very few artists reach before 35, and he used it consistently to fund production decisions that most industry infrastructure would not have approved.

## The Super Bowl as Chapter Statement

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-live.jpg]

On February 7, 2021, The Weeknd performed the Super Bowl LV halftime show at Raymond James Stadium in Tampa. He funded approximately $7 million of his own money to supplement what the NFL provides to halftime performers. The show drew over 96 million television viewers. It included synchronized marching band formations, laser lit dancer sequences through stadium tunnels, and a concluding performance on a mirror covered stage.

The production was not a greatest hits concert. Tesfaye performed in character, with the bandaged face that had been central to the late period "After Hours" visual releases. The set functioned as a compressed narrative version of the album's story arc. In subsequent interviews, Tesfaye described the Super Bowl as the peak of the "After Hours" chapter. He moved directly from that project into planning what became "Dawn FM."

## Dawn FM and the Trilogy's Architecture

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-studio.jpg]

"Dawn FM," released January 7, 2022, formalized the structural logic implied by the previous two album cycles. The album was framed as a late night radio broadcast for souls in a transitional state between life and death. Jim Carrey voiced the DJ across spoken interludes. Track sequencing followed radio programming logic, with station IDs and ad breaks embedded in the running order. The production shifted toward Quincy Jones era pop references and 1980s dance music textures. The closing piece, a spoken word track called "Phantom Regret by Jim," functioned explicitly as a chapter ending.

"Hurry Up Tomorrow" was released January 31, 2025, delayed from an originally announced January 24 date following the Los Angeles wildfires. It opened with 490,500 album equivalent units in its first week in the United States and debuted at number one on the Billboard 200, Tesfaye's fifth chart position at that level. The album closed the narrative "After Hours" had opened in 2020. The character in the red suit was done.

## What the Film Said About Risk

[img:/assets/images/artists/weeknd-hurry-up-tomorrow-promo.jpg]

The "Hurry Up Tomorrow" film, directed by Trey Edward Shults, opened in theaters May 16, 2025. It starred Tesfaye alongside Jenna Ortega and Barry Keoghan. Distributed by Lionsgate, it grossed $7.8 million worldwide against a budget that made that number a significant commercial underperformance. Critical reception was largely negative. Reviews described it as navel gazing and too narrowly constructed for audiences unfamiliar with the album.

Those readings are not entirely wrong, but they miss the frame. The film was not a bid for a mainstream acting career. It was the visual closing installment of a multimedia project that had used short films, halftime show spectacle, and concept album sequencing since 2020. Tesfaye already knew from "The Idol," the HBO series he created and starred in during 2023, that extending the Weeknd character into long form serialized television did not produce critical consensus. He made the film regardless. The five billion streams "Blinding Lights" accumulated and the $7.8 million the film grossed both belong to the same project. What Abel Tesfaye does next, under his own name, remains unknown. What he completed as The Weeknd is a finished and coherent thing.

[download:/assets/images/artists/weeknd-hurry-up-tomorrow-social-9x16.jpg|Download Social Card]"""

# Strip failed image tags
for s in failed:
    tag = f"[img:/assets/images/artists/{SLUG}-{s}.jpg]"
    body = body.replace("\n" + tag + "\n", "\n")
    body = body.replace(tag, "")

payload = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": SLUG,
    "artist": "The Weeknd",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a0/The_Weeknd_Portrait_by_Brian_Ziff.jpg",
    "post": {
        "title": "Abel Tesfaye's Last Chapter: How The Weeknd Became Mythology",
        "category": "culture",
        "date": "2026-06-19",
        "author": "Abel Blackburn",
        "body": body,
        "image": f"/assets/images/artists/{SLUG}.jpg"
    }
}

tmp = "/tmp/weeknd_publish.json"
with open(tmp, "w") as f:
    json.dump(payload, f, ensure_ascii=False)

r = subprocess.run(
    ["curl", "-s", "-X", "POST", "https://artonly.io/api/publish.php",
     "-H", "Content-Type: application/json",
     "--data-binary", f"@{tmp}"],
    capture_output=True, text=True
)

print("Publish response:", r.stdout[:600])
try:
    resp = json.loads(r.stdout)
except Exception:
    print("ERROR: Could not parse response")
    sys.exit(1)

if not resp.get("ok"):
    print("PUBLISH FAILED:", resp)
    sys.exit(1)

print("PUBLISHED OK")
PYEOF

# ── STEP 3: Social card ────────────────────────────────────────
python3 "$BASE/agent/make-social-card.py" "$SLUG" "Abel Tesfaye's Last Chapter: How The Weeknd Became Mythology" 3
echo "Social card done."

# ── STEP 4: Validate ──────────────────────────────────────────
python3 "$BASE/agent/post-validator.py" "$SLUG"

# ── STEP 5: IndexNow ──────────────────────────────────────────
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/$SLUG&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"

echo ""
echo "=== The Weeknd article COMPLETE ==="
echo "URL: https://artonly.io/post/$SLUG"
