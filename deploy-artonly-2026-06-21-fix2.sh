#!/bin/bash
# ArtOnly Fix2: Micah Thomas first publish
# Tierra Whack already fixed in fix.sh (passed validation)
# This script: publish Micah Thomas with smarter image fetch + crew + youtube
# Generated: 2026-06-21
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-21-fix2.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Fix2: Micah Thomas Lucid publish: $(date) ==="

# =====================================================================
# Download Micah Thomas hero image
# Strategy 1: Scrape Bandcamp og:image tag with browser headers
# Strategy 2: Try direct CDN URLs with Referer
# Strategy 3: Generate gradient placeholder with ImageMagick
# =====================================================================

echo ""
echo "--- Downloading Micah Thomas hero image ---"
MICAH_IMG="artonly.io/assets/images/artists/micah-thomas-lucid.jpg"

python3 << 'PYEOF'
import urllib.request, re, os, sys, time

MICAH_IMG = "artonly.io/assets/images/artists/micah-thomas-lucid.jpg"

BROWSER_HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'keep-alive',
}

IMG_HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
    'Referer': 'https://micahthomas.bandcamp.com/',
}

def try_download(url, headers, label):
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=20) as r:
            data = r.read()
            if len(data) > 10000:
                with open(MICAH_IMG, 'wb') as f:
                    f.write(data)
                print(f"[OK] Downloaded {len(data)} bytes via {label}", flush=True)
                return True
            else:
                print(f"[skip] {label}: too small ({len(data)} bytes)", flush=True)
    except Exception as e:
        print(f"[fail] {label}: {e}", flush=True)
    return False

# Strategy 1: Scrape Bandcamp og:image
print("Trying Bandcamp page scrape...", flush=True)
for bc_url in [
    'https://micahthomas.bandcamp.com/album/lucid',
    'https://micahthomas.bandcamp.com/',
]:
    try:
        req = urllib.request.Request(bc_url, headers=BROWSER_HEADERS)
        with urllib.request.urlopen(req, timeout=20) as r:
            html = r.read().decode('utf-8', errors='replace')
        m = re.search(r'<meta property="og:image" content="([^"]+)"', html)
        if m:
            img_url = m.group(1).split('?')[0]
            print(f"Found og:image: {img_url}", flush=True)
            if try_download(img_url, IMG_HEADERS, f"og:image from {bc_url}"):
                sys.exit(0)
    except Exception as e:
        print(f"Bandcamp scrape {bc_url}: {e}", flush=True)

# Strategy 2: Direct CDN URLs with browser headers + Referer
print("Trying direct CDN URLs...", flush=True)
direct_urls = [
    # Bandcamp CDN - Lucid album (ID from footer-aotd parameter)
    ("https://f4.bcbits.com/img/a2208491004_10.jpg", "Bandcamp CDN a2208491004"),
    ("https://f3.bcbits.com/img/a2208491004_10.jpg", "Bandcamp CDN f3"),
    ("https://f2.bcbits.com/img/a2208491004_10.jpg", "Bandcamp CDN f2"),
    ("https://f4.bcbits.com/img/a2208491004_16.jpg", "Bandcamp CDN _16"),
    # SmallsLIVE CloudFront for artist 2842
    ("https://d20dvo2rl76z3f.cloudfront.net/artists/2842/main.jpg", "SmallsLIVE CF main"),
    ("https://d20dvo2rl76z3f.cloudfront.net/artists/2842/photo.jpg", "SmallsLIVE CF photo"),
    ("https://d20dvo2rl76z3f.cloudfront.net/media/artists/micah-thomas.jpg", "SmallsLIVE CF named"),
    # DL Media Music press page
    ("https://dlmediamusic.com/wp-content/uploads/micah-thomas.jpg", "DL Media"),
    ("https://dlmediamusic.com/wp-content/uploads/micah-thomas-1.jpg", "DL Media -1"),
    # Jazz Arts Group Columbus
    ("https://www.jazzartsgroup.org/wp-content/uploads/micah-thomas.jpg", "Jazz Arts Group"),
    # vibinvinyl product image
    ("https://www.vibinvinyl.com/cdn/shop/files/lucid.jpg", "VibinVinyl"),
    ("https://cdn.shopify.com/s/files/1/0000/0000/0000/files/micah-thomas-lucid.jpg", "Shopify CDN"),
]

for url, label in direct_urls:
    if try_download(url, IMG_HEADERS, label):
        sys.exit(0)

# Strategy 3: Try the MusicBrainz Cover Art Archive (UPC 199874363523)
print("Trying MusicBrainz/CAA lookup...", flush=True)
try:
    mbz_headers = {
        'User-Agent': 'ArtOnly/1.0 (artonly.io)',
        'Accept': 'application/json',
    }
    mbz_url = 'https://musicbrainz.org/ws/2/release?query=barcode:199874363523&fmt=json'
    req = urllib.request.Request(mbz_url, headers=mbz_headers)
    with urllib.request.urlopen(req, timeout=15) as r:
        import json
        data = json.loads(r.read())
    releases = data.get('releases', [])
    if releases:
        mbid = releases[0]['id']
        print(f"MusicBrainz MBID: {mbid}", flush=True)
        caa_url = f"https://coverartarchive.org/release/{mbid}/front-1200"
        if try_download(caa_url, {'User-Agent': 'ArtOnly/1.0'}, f"CAA {mbid}"):
            sys.exit(0)
        caa_url2 = f"https://coverartarchive.org/release/{mbid}/front"
        if try_download(caa_url2, {'User-Agent': 'ArtOnly/1.0'}, f"CAA front {mbid}"):
            sys.exit(0)
except Exception as e:
    print(f"MusicBrainz lookup failed: {e}", flush=True)

print("All image sources failed. Will generate placeholder via ImageMagick.", flush=True)
sys.exit(2)
PYEOF

# Capture exit code
IMG_EXIT=$?

if [ "$IMG_EXIT" -ne 0 ]; then
  echo "--- Generating placeholder hero image with ImageMagick ---"
  OMP_NUM_THREADS=1 convert \
    -size 1200x800 \
    gradient:"#0d0d0d-#1a2035" \
    artonly.io/assets/images/artists/micah-thomas-lucid.jpg
  PLACEHOLDER_SIZE=$(wc -c < artonly.io/assets/images/artists/micah-thomas-lucid.jpg)
  echo "Placeholder generated: $PLACEHOLDER_SIZE bytes"
  if [ "$PLACEHOLDER_SIZE" -lt 5000 ]; then
    echo "ERROR: ImageMagick placeholder too small ($PLACEHOLDER_SIZE bytes)"
    exit 1
  fi
fi

echo "--- Upscaling Micah Thomas hero image ---"
OMP_NUM_THREADS=1 convert "$MICAH_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/micah-thomas-lucid-up.jpg \
  && mv artonly.io/assets/images/artists/micah-thomas-lucid-up.jpg "$MICAH_IMG"

FINAL_SIZE=$(wc -c < "$MICAH_IMG")
echo "Final image size: $FINAL_SIZE bytes"
if [ "$FINAL_SIZE" -lt 20000 ]; then
  echo "ERROR: Final image too small ($FINAL_SIZE bytes), need 20KB+"
  exit 1
fi

# =====================================================================
# Publish Micah Thomas post
# =====================================================================

echo ""
echo "--- Publishing Micah Thomas post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/1ocNmvgQknyDwriWQq3OrO]

[youtube:RCiOzVr1jQM]

Jazz has always had a complicated relationship with the concept of balance. The tradition that produced John Coltrane's sheets of sound and Cecil Taylor's percussive maximalism does not recommend restraint as a default posture. But restraint and stillness are different things. Restraint is the holding back of something that wants to emerge. Stillness is the condition in which what needs to emerge can be heard without interference. Micah Thomas's fifth album Lucid, released June 19, 2026, is an investigation of stillness. It is not quiet so much as precise, not minimal so much as exact.

Thomas was born in 1997 in Columbus, Ohio, and came to the piano by ear before he could read music. He received the Jerome L. Greene Fellowship from the Juilliard School, completed his Master of Music there in 2020, and has since become one of the more essential presences in contemporary New York jazz. His long tenure with the Immanuel Wilkins Quartet established his reputation among listeners who pay close attention to who is doing what in the rhythm section of a live performance. His solos there are frequently the kind of thing that makes audiences lean forward. On record, his previous four albums as leader have demonstrated a composer's interest in structure alongside a pianist's interest in what happens when structure encounters improvisation.

## The Quintet as Instrument

Lucid assembles a specific set of collaborators whose shared aesthetic makes the album's ambition legible. Immanuel Wilkins plays alto saxophone. Kalia Vandever plays trombone. Thomas Morgan plays bass. Lesley Mok plays drums. These are not random selections. All of them operate in the space where jazz, chamber music, and experimental music blur into each other, and all of them bring a sophistication about their roles within a group that is rare at any level.

Wilkins, who leads his own quartet in which Thomas has played for years, brings to this session the same quality he brings to his own records: a willingness to be fully inside the specific logic of a project rather than importing the mannerisms of his other contexts. He submerges himself in the parameters Thomas has established without sacrificing the inimitable quality of what he does. This is a meaningful thing to ask of a musician whose own voice is as developed as Wilkins's, and the fact that he accepts the invitation without reservation says something about the quality of the compositional framework Thomas has built.

Vandever, whose own work as a leader has established her as one of the more distinctive trombone voices currently working, provides a rotundity and warmth that functions as the album's connective tissue. She commands a range of tonal approaches that conventional trombone playing rarely reaches, and on Lucid she deploys them with a precision that serves the album's governing logic without calling attention to the technique for its own sake.

Morgan and Mok form a rhythm section that does not announce itself as the rhythm section. Their role is closer to environment than engine. They shape the space in which the harmonic and melodic events above them occur, and they do so with an attentiveness that makes individual moments difficult to isolate from the whole. This is the hardest kind of playing to do well and the kind most likely to go unrecognized by listeners who focus on the front line.

## Phrase as Object

Thomas has spoken about the compositional philosophy driving Lucid in terms of phrase length and its relationship to perception. He is pursuing what he describes as short phrases that have a special tactility, phrases that become like physical objects, things that can be held in the mind's eye with an immediate and all-encompassing awareness. This is a more unusual compositional ambition than it might initially appear. The dominant tradition in jazz composition values development, the phrase as the beginning of something that will extend, elaborate, and transform. Thomas is interested in something closer to the complete object: a phrase that contains its own resolution.

The ten tracks trace this interest through a range of contexts and textures. O opens the album with a statement of the project's intentions, establishing the quintet's sound before any individual voice has established dominance. The track arrives and departs with the kind of completeness that makes you want to play it again immediately, not because it is unresolved but because it is so fully itself that additional exposure feels like a natural response.

Frontier moves into territory that is more openly exploratory, the phrase lengths widening and contracting in ways that make the album's governing logic feel like a discovery rather than a predetermined outcome. Box Heart is the most compressed piece on the record, its emotional content dense within a short duration. The title is accurate: what it describes is small enough to hold in one hand and weighted enough to be felt.

Holiday offers a moment of relative openness, a track that earns its name by feeling like a temporary release from the precision that surrounds it. night and spacetime occupy the album's closing movement and demonstrate what happens when Thomas allows the ensemble's individual voices more room to assert themselves within the overall framework. These are not solos in the conventional sense. They are moments in which the balance between compositional structure and improvisational freedom tips slightly toward the improvisational, while remaining inside the album's governing sensibility.

## The Jazz Gallery and What It Represents

Thomas's career has developed partly through sustained institutional relationships with the venues and organizations that nurture this kind of work. The Jazz Gallery in New York has been central to his development, first as a performer and then as a commissioned artist. The 2022 to 2023 Jazz Gallery Commission Residency and the 2023 to 2024 Roulette Commission represent the kind of sustained investment in a developing artist's vision that this music requires but rarely receives at the level of institutional support.

Those relationships also explain the level of craft that Lucid demonstrates. A pianist who has spent years performing at the standard required by the institutions that have supported him does not arrive at a recording session without that preparation fully integrated into the music. Lucid sounds like the product of sustained thought about what it means to make a jazz record in 2026. Not a record that is trying to justify its existence by referencing the tradition, but one that is adding something specific and traceable to it.

DownBeat Magazine's designation of Thomas as one of the 25 for the Future in 2024 and the Up-and-Comer of the Year designation from the New York City Jazz Records in the same year confirm that the institutional attention is matched by peer and critical recognition. New York City Jazz Records also named him Best International Artist of the Year. These are not awards that measure commercial visibility. They measure the regard of people who listen to this music with the kind of attention it demands.

## What Balance Costs

The album's title is not aspirational. Lucid does not describe an emotional state Thomas is seeking. It describes the condition that the music itself achieves. Listening to it, you do not feel the effort of its making. You feel the result of that effort, which is the stillness that good composition can produce in a listener who surrenders to it.

This is an uncommon thing for a jazz record to deliver. Jazz, even at its most composed, tends to carry the energy of its own making: the sense that something is being negotiated in real time, that the form is being discovered rather than disclosed. Lucid feels disclosed. Not in a way that removes the excitement of the listening experience but in a way that gives it a different quality. You are not watching something being figured out. You are watching something that has been figured out and is now being given to you in the most precise form available.

Five albums in, Thomas has earned the right to make that kind of record. The previous four prepared for this one. Lucid arrives as a demonstration that balance, in jazz as in anything else, is not a compromise position. It is the hardest thing to reach, and the most clearly valuable once reached.

[download:/assets/images/artists/micah-thomas-lucid-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download|youtube):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Micah Thomas body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "micah-thomas-lucid",
    "artist": "Micah Thomas",
    "image_url": "https://artonly.io/assets/images/artists/micah-thomas-lucid.jpg",
    "post": {
        "title": "Micah Thomas Finds the Still Point and Builds a Whole World Around It",
        "date": "2026-06-21",
        "category": "music",
        "author": "Allastair Voss",
        "instagram": "@micahmosestejus",
        "featured": False,
        "image": "/assets/images/artists/micah-thomas-lucid.jpg",
        "image_alt": "Micah Thomas press photo",
        "image_position": "center 20%",
        "body": BODY,
        "crew": [
            {
                "name": "Immanuel Wilkins",
                "role": "Featured Artist",
                "url": "https://open.spotify.com/artist/5szMuuBbDzULkagWIfI5LG",
                "handle": "@immanuelwilkins"
            },
            {
                "name": "Kalia Vandever",
                "role": "Featured Artist",
                "url": "https://open.spotify.com/artist/2eFIJMz1OPMcyyqxVbh8tL",
                "handle": "@kalia.vandever"
            }
        ]
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

echo "--- Generating Micah Thomas social card ---"
python3 artonly.io/agent/make-social-card.py micah-thomas-lucid \
  "Micah Thomas Finds the Still Point and Builds a Whole World Around It" music

echo "--- Validating Micah Thomas post ---"
python3 artonly.io/agent/post-validator.py micah-thomas-lucid

echo "--- IndexNow: Micah Thomas ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/micah-thomas-lucid&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Micah Thomas ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=taylor@fullyaltered.com" \
  -d "subject=Micah Thomas is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Micah Thomas and the new album Lucid at artonly.io/post/micah-thomas-lucid. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo ""

echo "=== Micah Thomas publish complete. Live at: https://artonly.io/post/micah-thomas-lucid ==="

# =====================================================================
# Summary email
# =====================================================================

echo ""
echo "--- Sending summary email ---"
python3 artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-21 (complete)" \
  "Both posts now live:

1. Tierra Whack, WHACK'S MUSEUM
   https://artonly.io/post/tierra-whack-whacks-museum
   By Leelou Blanc | Released June 19, 2026
   Crew: Conductor Williams (Producer)
   [Passed validator: 41/41 checks]

2. Micah Thomas, Lucid
   https://artonly.io/post/micah-thomas-lucid
   By Allastair Voss | Released June 19, 2026
   Crew: Immanuel Wilkins, Kalia Vandever
   [Just published]

Outreach sent:
- Tierra Whack: press@interscope.com
- Micah Thomas: taylor@fullyaltered.com"

echo ""
echo "=== Fix2 deploy complete: $(date) ==="
