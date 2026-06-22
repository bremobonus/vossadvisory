#!/bin/bash
# ArtOnly Deploy: hemlocke springs
# Generated: 2026-06-22
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-22.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Deploy: hemlocke springs: $(date) ==="

UA="Mozilla/5.0 (compatible; ArtOnly/1.0)"

# =====================================================================
# Step 4b: Download hero image
# =====================================================================
echo "--- Downloading hero image ---"
HERO_OK=0
for HERO_URL in \
  "https://www.nme.com/wp-content/uploads/2026/02/hemlocke-springs-press-image-696x442.jpg" \
  "https://sacksco.com/photo/hi/hemlocke_springs3.jpg" \
  "https://img.pastemagazine.com/wp-content/uploads/2026/02/12095846/93F2F64E-E041-4654-AF24-3E2D1DEA7B1A.jpeg"; do
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs.jpg" \
    "$HERO_URL" || true
  SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs.jpg" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 5000 ]; then
    echo "Hero: $SZ bytes from $HERO_URL"
    HERO_OK=1
    break
  fi
  echo "Hero attempt failed ($SZ bytes): $HERO_URL"
done
if [ "$HERO_OK" -eq 0 ]; then echo "ERROR: All hero image sources failed"; exit 1; fi

# =====================================================================
# Step 4b: Download body images
# =====================================================================

echo "--- Downloading body image: intro ---"
INTRO_OK=0
for URL in \
  "https://img.pastemagazine.com/wp-content/uploads/2026/02/12095846/93F2F64E-E041-4654-AF24-3E2D1DEA7B1A.jpeg" \
  "https://sacksco.com/photo/hi/hemlocke_springs.jpg" \
  "https://ourculturemag.com/wp-content/uploads/K1600_hemlocke_press-photo_albumannounce-e1761164721264.webp"; do
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs-intro.jpg" \
    "$URL" || true
  SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-intro.jpg" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 5000 ]; then echo "intro: $SZ bytes"; INTRO_OK=1; break; fi
  echo "intro attempt failed ($SZ bytes): $URL"
done
if [ "$INTRO_OK" -eq 0 ]; then echo "WARNING: intro image failed all attempts, will remove from body"; fi

echo "--- Downloading body image: studio ---"
STUDIO_OK=0
for URL in \
  "https://img.pastemagazine.com/wp-content/uploads/2026/02/12100039/8DF52DAF-9F20-4A05-9381-D54734D343DE.jpeg" \
  "https://sacksco.com/photo/hi/hemlocke_springs2.jpg"; do
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs-studio.jpg" \
    "$URL" || true
  SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-studio.jpg" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 5000 ]; then echo "studio: $SZ bytes"; STUDIO_OK=1; break; fi
  echo "studio attempt failed ($SZ bytes): $URL"
done
if [ "$STUDIO_OK" -eq 0 ]; then echo "WARNING: studio image failed all attempts, will remove from body"; fi

echo "--- Downloading body image: live ---"
LIVE_OK=0
for URL in \
  "https://sacksco.com/photo/hi/hemlocke_springs3.jpg" \
  "https://sacksco.com/photo/hi/hemlocke_springs2.jpg"; do
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs-live.jpg" \
    "$URL" || true
  SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-live.jpg" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 5000 ]; then echo "live: $SZ bytes"; LIVE_OK=1; break; fi
  echo "live attempt failed ($SZ bytes): $URL"
done
if [ "$LIVE_OK" -eq 0 ]; then
  # Try webp conversion as last resort
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs-live.webp" \
    "https://ourculturemag.com/wp-content/uploads/K1600_hemlocke_press-photo_albumannounce-e1761164721264.webp" || true
  SZ_WEBP=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-live.webp" 2>/dev/null || echo 0)
  if [ "$SZ_WEBP" -gt 5000 ]; then
    convert artonly.io/assets/images/artists/hemlocke-springs-live.webp \
      artonly.io/assets/images/artists/hemlocke-springs-live.jpg 2>/dev/null || true
    rm -f artonly.io/assets/images/artists/hemlocke-springs-live.webp
    SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-live.jpg" 2>/dev/null || echo 0)
    if [ "$SZ" -gt 5000 ]; then echo "live (converted): $SZ bytes"; LIVE_OK=1; fi
  fi
fi
if [ "$LIVE_OK" -eq 0 ]; then echo "WARNING: live image failed all attempts, will remove from body"; fi

echo "--- Downloading body image: cover ---"
COVER_OK=0
for URL in \
  "https://www.nme.com/wp-content/uploads/2026/02/hemlocke-springs-tatuts-album-cover.jpg" \
  "https://sacksco.com/photo/hi/hemlocke_springs_cover.jpg"; do
  curl -s -L -A "$UA" --max-time 25 \
    -o "artonly.io/assets/images/artists/hemlocke-springs-cover.jpg" \
    "$URL" || true
  SZ=$(wc -c < "artonly.io/assets/images/artists/hemlocke-springs-cover.jpg" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 5000 ]; then echo "cover: $SZ bytes"; COVER_OK=1; break; fi
  echo "cover attempt failed ($SZ bytes): $URL"
done
if [ "$COVER_OK" -eq 0 ]; then echo "WARNING: cover image failed all attempts, will remove from body"; fi

# =====================================================================
# Step 5: Publish
# =====================================================================
echo "--- Publishing hemlocke springs ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re, os

IMG_DIR = "/home/dh_yadmw3/artonly.io/assets/images/artists"

def img_ok(name):
    p = os.path.join(IMG_DIR, name)
    return os.path.exists(p) and os.path.getsize(p) > 5000

BODY_RAW = """[spotify:artist/52PdgUJOjvS6Mpmjy1SAlx]

On October 30, 2022, Isimeme Naomi Udu posted a video to TikTok dressed as Dionne from Clueless, teasing the bridge of a song called Girlfriend. By the following afternoon the clip had crossed one million views. By mid December that year the track had surpassed ten million streams on Spotify. She had recently completed a semester of postgraduate study at Dartmouth College in quantitative biomedical sciences. She had never released a full project before. The numbers arrived before anyone knew her name.

That sequence belongs to a now familiar genre. An algorithm accelerates an unknown person into a phenomenon, attention peaks in a concentrated window, the algorithm moves on. What makes hemlocke springs different is not that this happened. It is what she built in the space the moment opened.

## The Thirty One Days That Changed Everything

Girlfriend worked for reasons that have nothing to do with timing. The track is built on a synth architecture pulling from 1980s new wave without performing nostalgia for it. The hook lands in a register that is playful and confessional at once. The lyrics document the experience of watching a friend fall for someone destructive while feeling entirely powerless to stop it. A queer Black woman writing with that degree of precision about female friendship and its interior life was not a common presence in commercial pop at the end of 2022. Listeners understood what they were hearing immediately.

Udu had produced the track herself. She grew up in Raleigh, North Carolina, the daughter of two Nigerian immigrants, and came to music through private practice rather than any institutional pathway. No label development deal preceded the upload. No talent competition gave her a platform. No industry mentorship shaped what she made. She built what she needed and posted it without ceremony. Girlfriend was only her second publicly released song.

The cultural specificity of the moment was legible to anyone paying attention. Black women have populated the most generative corners of independent pop for years, consistently doing the foundational work that tends to get credited to other people downstream. Hemlocke Springs arrived as someone unwilling to let that pattern claim her. She produced. She wrote. She controlled her visual presentation from the first Clueless video forward. The virality was real. The infrastructure behind it was entirely hers.

[img:/assets/images/artists/hemlocke-springs-intro.jpg]

## Self Production as Self Determination

There is a version of this story where an artist who goes viral in October 2022 signs a major label deal in November and releases a diluted single the following spring. Hemlocke Springs did not take that route. She spent nearly three years in deliberate development before releasing her debut album. She signed with Dreamshop Management in August 2024 and then moved to AWAL for distribution ahead of the 2026 release. Neither relationship represents the kind of label control that extracts creative authority from an artist and replaces it with market optimization.

During that period she worked almost entirely on her own terms. Her collaboration with producer BURNS, the British producer behind sessions for Lady Gaga, Britney Spears, and Charli xcx, came about as a meeting between two people who understood a specific sonic space and wanted to push further into it. Every track on the debut album was written jointly by Udu and Matthew James Burns, with one exception: the prelude, which Udu wrote alone. Production credit belongs to both of them throughout the rest of the record.

This is what artistic autonomy looks like in practice in 2026. It is not total isolation. It is knowing exactly when to bring another voice in, how much creative authority to retain, and what kind of project you are ultimately trying to build. Udu demonstrated that instinct from the moment she uploaded those first SoundCloud demos and quietly removed them the following morning. She was not ready to commit to something unresolved. That discipline did not change once the stream counts started climbing.

[img:/assets/images/artists/hemlocke-springs-studio.jpg]

## Beyond the Viral Moment

The question that follows any artist through their first years of visibility is whether the moment that introduced them to the public accurately represents what they are actually trying to do. For some artists, yes. For hemlocke springs, the answer is more complicated. Girlfriend is a good song. It is not a complete portrait of the artist who made it.

Her releases in the period leading up to the album, including The Beginning of the End in September 2025, pushed toward darker and more complex emotional territory. The synth architecture remained but the confessional register deepened. She began constructing something that looked less like a sequence of singles shaped for platform performance and more like a coherent artistic vision with a destination. By the time the debut album was announced, it was clear she had been building toward a specific place the entire time.

The live circuit confirmed the same thing. She toured with Conan Gray in 2025, played Governors Ball in June 2026, and performed at Bonnaroo in June 2026. These are not the bookings of an artist managing a single moment. They are the bookings of someone building a career that will outlast the platform that first carried her. Her audiences expanded well beyond the TikTok user base that found her first. That expansion was earned through material that holds up to repeated listening, which is the only test that matters once the algorithm stops amplifying you.

[img:/assets/images/artists/hemlocke-springs-live.jpg]

[spotify:album/3td33YbrUND8jvdarSmgmR]

## The Tree, the Sea, the Declaration

Released on February 13, 2026, via AWAL, the apple tree under the sea is a concept album built around discovering self and confronting the past. That description undersells it. The record functions as a fever dream, moving through grief, repression, memory, and transformation with rigor that avoids indulgence at every turn. Metacritic logged a score of 81 out of 100 from nine critics, reflecting genuine consensus rather than hype spillover from social media presence.

The album runs for just over thirty three minutes across ten tracks. That runtime is a deliberate choice. Udu does not pad. She does not explain herself at length. She trusts the listener to follow her through the transitions between tracks, and the transitions carry their own emotional weight. The record closes in a genuinely different place than it opens, which sounds like the minimum requirement for a concept album but is actually rare. Most records that set up a journey fail to complete it convincingly.

The title rewards attention. An apple tree under the sea is a thing that should not exist. It is a living organism placed in an environment designed to prevent it from surviving. The image does not appear to be explained in the press materials around the record. It does not need to be. The album earns its title by the time you reach the final track.

There is a larger cultural argument embedded in hemlocke springs as a presence in pop in 2026. Queer Black women who produce their own music, control their own visual identity, and build careers outside of major label machinery are still remarkable enough to be noted. They should not be. The industry infrastructure has historically been more efficient at extracting value from this kind of talent than at sustaining it. Udu built her infrastructure before she needed it, which meant no one else could capture it when the moment arrived.

The fall 2026 tour is the next chapter. She has spent nearly four years converting a TikTok moment into an actual career, and the material she has produced during that period justifies every hour of it. The apple tree under the sea is still growing. The fact that it should not exist is exactly the point.

[img:/assets/images/artists/hemlocke-springs-cover.jpg]

[download:/assets/images/artists/hemlocke-springs-social-9x16.jpg|Download Social Card]"""

# Remove [img:] lines for images that are missing or too small
def filter_body(body):
    lines = body.split('\n')
    result = []
    for line in lines:
        m = re.match(r'\[img:/assets/images/artists/([^\]]+)\]', line.strip())
        if m:
            fname = m.group(1)
            if img_ok(fname):
                result.append(line)
            else:
                print(f"WARNING: removing [img:] for missing/small file: {fname}", flush=True)
        else:
            result.append(line)
    return '\n'.join(result)

BODY = filter_body(BODY_RAW)

# Count body words (excluding embed tags)
clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Body word count: {word_count}", flush=True)
if word_count < 1000:
    print(f"ERROR: body only {word_count} words, need 1000+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "hemlocke-springs",
    "artist": "hemlocke springs",
    "image_url": "https://artonly.io/assets/images/artists/hemlocke-springs.jpg",
    "post": {
        "title": "hemlocke springs: Four Years of Building What the Moment Could Not Give Her",
        "date": "2026-06-22",
        "category": "culture",
        "pen": "Abel Blackburn",
        "instagram_handle": "@hemlockesprings",
        "featured": False,
        "image": "/assets/images/artists/hemlocke-springs.jpg",
        "image_alt": "hemlocke springs press photo",
        "image_position": "center 20%",
        "body": BODY
    }
}

data = json.dumps(POST).encode('utf-8')
req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=data,
    headers={'Content-Type': 'application/json'}
)
try:
    with urllib.request.urlopen(req, timeout=60) as r:
        resp = r.read().decode('utf-8')
        print(f"Publish response: {resp}", flush=True)
        parsed = json.loads(resp)
        if not parsed.get('ok'):
            print(f"ERROR: publish failed: {resp}", file=sys.stderr)
            sys.exit(1)
except Exception as e:
    print(f"ERROR publishing: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF

# =====================================================================
# Step 6: Social card
# =====================================================================
echo "--- Generating social card ---"
python3 artonly.io/agent/make-social-card.py hemlocke-springs \
  "hemlocke springs: Four Years of Building What the Moment Could Not Give Her" 3

# =====================================================================
# Step 7: Validate
# =====================================================================
echo "--- Validating post ---"
python3 artonly.io/agent/post-validator.py hemlocke-springs

# =====================================================================
# Step 8: IndexNow
# =====================================================================
echo "--- Submitting to IndexNow ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/hemlocke-springs&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

# =====================================================================
# Step 9: Outreach
# =====================================================================
echo "--- Sending outreach email ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=cami.opere@awal.com" \
  --data-urlencode "subject=ArtOnly just covered hemlocke springs" \
  --data-urlencode "body=https://artonly.io/post/hemlocke-springs

ArtOnly published a piece on hemlocke springs today. The debut album does something rare: it actually completes the concept it sets up, moving through grief and transformation in a way that lands at a genuinely different place than it started. A social card is available at the bottom of the page, feel free to share. If hemlocke springs or anyone on the team wants to reply, just hit reply. Allastair Voss, ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo ""

echo "=== hemlocke springs deploy complete: $(date) ==="
echo "Live at: https://artonly.io/post/hemlocke-springs"
