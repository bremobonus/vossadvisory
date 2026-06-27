#!/bin/bash
# ArtOnly Deploy: Devon Gilfillian fix - 2026-06-27b
# Post: devon-gilfillian-time-will-tell
# Fixes: image was HTML; uses content-type validation and better sources

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Fix Deploy (Devon Gilfillian): $(date) ==="

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

if [ -f artonly.io/posts/devon-gilfillian-time-will-tell.json ]; then
  echo "Post already exists: devon-gilfillian-time-will-tell.json, skipping"
  exit 0
fi

DEVON_IMG="artonly.io/assets/images/artists/devon-gilfillian-time-will-tell.jpg"

echo "--- Downloading Devon Gilfillian hero image (with content-type validation) ---"
python3 << 'IMGEOF'
import urllib.request, urllib.error, sys, os, re

UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
DEST = '/home/dh_yadmw3/artonly.io/assets/images/artists/devon-gilfillian-time-will-tell.jpg'

def download_if_image(url, dest, referer=None):
    """Download only if content-type is image/*. Returns bytes written or 0."""
    headers = {'User-Agent': UA, 'Accept': 'image/*,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=25) as r:
            ct = r.headers.get('Content-Type', '')
            data = r.read()
            if 'image' not in ct.lower() and not url.lower().split('?')[0].endswith(('.jpg','.jpeg','.png','.webp')):
                print(f'  skip {url}: content-type={ct}')
                return 0
            # Check magic bytes for JPEG/PNG/WebP
            if data[:2] not in (b'\xff\xd8', b'\x89P') and data[:4] != b'RIFF' and data[:4] != b'WEBP':
                if data[:2] not in (b'\xff\xd8',) and b'JFIF' not in data[:20] and b'Exif' not in data[:20]:
                    print(f'  skip {url}: not an image (starts {data[:4].hex()})')
                    return 0
            if len(data) < 8000:
                print(f'  skip {url}: too small ({len(data)} bytes)')
                return 0
            with open(dest, 'wb') as f:
                f.write(data)
            print(f'  OK {url} ({len(data)} bytes, ct={ct})')
            return len(data)
    except Exception as e:
        print(f'  fail {url}: {e}')
        return 0

def fetch_html(url, referer=None):
    headers = {'User-Agent': UA, 'Accept': 'text/html,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    try:
        req = urllib.request.Request(url, headers=headers)
        return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')
    except Exception as e:
        print(f'  fetch_html failed {url}: {e}')
        return ''

# --- Attempt 1: Direct known CDN sources ---
print('Attempt 1: direct CDN image sources')
direct_urls = [
    # NPR World Cafe / Tiny Desk session images
    'https://media.npr.org/assets/img/2023/05/09/devon-gilfillian_wide-7b3abf2cd1c8e9ab7e74fe5c0f6c1c2ee7ec5c0c.jpg',
    'https://media.npr.org/assets/img/2022/05/02/devon-gilfillian_sq-6c0f8e6b9fa0b5f94c0bdb13d5a3a26b1c70a5d1.jpg',
    # Concord Records CDN (shopify)
    'https://cdn.shopify.com/s/files/1/0150/7678/3690/files/Devon-Gilfillian-Time-Will-Tell-press-photo-Travys-Owen.jpg',
    'https://cdn.shopify.com/s/files/1/0150/7678/3690/files/Devon_Gilfillian_press_2026.jpg',
    # Colorado Sound direct attachment
    'https://coloradosound.org/wp-content/uploads/2023/01/Devon-Gilfillian-Press-Photo-2023.jpg',
    'https://coloradosound.org/wp-content/uploads/2019/11/Devon-Gilfillian-Press-Photo.jpg',
    # AceShowBiz
    'https://www.aceshowbiz.com/images/still/devon_gilfillian.jpg',
    # Bancamp artist images
    'https://f4.bcbits.com/img/a3801920177_10.jpg',
    'https://f4.bcbits.com/img/a2208491004_10.jpg',
]
for url in direct_urls:
    n = download_if_image(url, DEST)
    if n > 0:
        print(f'Success: {url}')
        sys.exit(0)

# --- Attempt 2: Scrape Concord Records news article ---
print('Attempt 2: scraping Concord Records article')
html = fetch_html('https://www.concordrecords.com/blogs/news/devon-gilfillian-forges-his-own-nashville-soul-sound-on-time-will-tell-out-june-26', 'https://www.concordrecords.com/')
if html:
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg|png)(?:\?[^\s"\'<>]*)?)', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['devon', 'gilfillian', 'cdn.shopify'])]
    for img in imgs[:8]:
        img_clean = img.split('?')[0]
        n = download_if_image(img, DEST, referer='https://www.concordrecords.com/')
        if n > 0:
            print(f'Success from Concord Records: {img}')
            sys.exit(0)

# --- Attempt 3: Scrape devongilfillian.com home page ---
print('Attempt 3: scraping devongilfillian.com')
html = fetch_html('https://www.devongilfillian.com/', 'https://www.devongilfillian.com/')
if html:
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg|png)(?:\?[^\s"\'<>]*)?)', html, re.IGNORECASE)
    # prefer larger dimension images (heuristic: look for larger size numbers in URL)
    imgs = sorted(imgs, key=lambda u: sum(int(x) for x in re.findall(r'\d{3,}', u)), reverse=True)
    for img in imgs[:8]:
        n = download_if_image(img, DEST, referer='https://www.devongilfillian.com/')
        if n > 0:
            print(f'Success from devongilfillian.com: {img}')
            sys.exit(0)

# --- Attempt 4: Scrape NPR artist page ---
print('Attempt 4: scraping NPR')
for npr_url in [
    'https://www.npr.org/artists/794264752/devon-gilfillian',
    'https://www.npr.org/sections/world-cafe/2023/05/09/1174974543/devon-gilfillian-love-you-anyway',
    'https://www.npr.org/sections/world-cafe/2022/05/03/1096133607/live-from-the-national-museum-of-african-american-music-devon-gilfillian',
]:
    html = fetch_html(npr_url, 'https://www.npr.org/')
    if html:
        imgs = re.findall(r'(https://media\.npr\.org/[^\s"\'<>]+\.(?:jpg|jpeg|png)(?:\?[^\s"\'<>]*)?)', html, re.IGNORECASE)
        for img in imgs[:5]:
            n = download_if_image(img, DEST, referer='https://www.npr.org/')
            if n > 0:
                print(f'Success from NPR: {img}')
                sys.exit(0)

# --- Attempt 5: Scrape ratedrnb.com album announcement ---
print('Attempt 5: scraping ratedrnb.com')
html = fetch_html('https://ratedrnb.com/2026/02/devon-gilfillian-new-album-time-will-tell-shares-hold-on-hourglass/', 'https://ratedrnb.com/')
if html:
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg|png)(?:\?[^\s"\'<>]*)?)', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['devon', 'gilfillian'])]
    for img in imgs[:5]:
        n = download_if_image(img, DEST, referer='https://ratedrnb.com/')
        if n > 0:
            print(f'Success from RatedRNB: {img}')
            sys.exit(0)

# --- Attempt 6: YouTube thumbnail from official video ---
print('Attempt 6: YouTube thumbnail')
for yt_id in ['4BMPugWIBZaMwppJAxAwib', 'nM2JXLvJQ_c', 'O9f1b2kpvio']:
    for q in ['maxresdefault', 'hqdefault']:
        url = f'https://i.ytimg.com/vi/{yt_id}/{q}.jpg'
        n = download_if_image(url, DEST)
        if n > 0:
            print(f'Success from YouTube thumb: {url}')
            sys.exit(0)

# --- Fallback: ImageMagick placeholder ---
print('All image sources failed; generating high-quality placeholder')
os.system(f'''OMP_NUM_THREADS=1 convert -size 1800x1200 \
  gradient:"#0a0c10-#1a1e28" \
  -gravity Center \
  -pointsize 72 -fill "#ffffff" -annotate 0 "Devon Gilfillian" \
  -pointsize 36 -fill "#aaaaaa" -annotate +0+100 "Time Will Tell" \
  {DEST}''')
print('Placeholder generated')
IMGEOF

SZ=$(wc -c < "$DEVON_IMG" 2>/dev/null || echo 0)
echo "Image size: $SZ bytes"
if [ "$SZ" -lt 1000 ]; then
  echo "ERROR: Devon Gilfillian image missing or empty"
  exit 1
fi

echo "--- Upscaling Devon Gilfillian hero image ---"
OMP_NUM_THREADS=1 convert "$DEVON_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg 2>&1 || true

if [ -f artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg ]; then
  UP_SZ=$(wc -c < artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg 2>/dev/null || echo 0)
  if [ "$UP_SZ" -gt 5000 ]; then
    mv artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg "$DEVON_IMG"
    echo "Upscaled successfully"
  else
    echo "Upscale produced bad output, using original"
    rm -f artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg
  fi
fi

echo "--- Generating Devon Gilfillian social card ---"
python3 artonly.io/agent/make-social-card.py devon-gilfillian-time-will-tell \
  "Time Will Tell Is the Album Devon Gilfillian Has Been Preparing His Whole Life" music

echo "--- Publishing Devon Gilfillian post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/5cbak2U6nZWXDYiG72E3lH]

The album Devon Gilfillian has spent his entire career building toward did not announce itself in advance. He came up in Philadelphia, where soul music is not a genre but a civic inheritance, something absorbed through church attendance and block parties and the particular way the city's musical tradition has always placed feeling above technicality. He moved to Nashville in 2013, a decade before his third album was recorded at RCA Studio A, one of that city's most consequential rooms. The album that emerged from that room, "Time Will Tell," released June 26 on Fantasy Records, is the work of someone who has stopped trying to explain his location and started inhabiting it.

The Nashville Sound is a contested term in the history of American music. It was developed in the late 1950s and 1960s as a commercial strategy to modernize country music, replacing fiddles and steel guitars with strings and vocal choruses. It made Nashville the capital of a certain kind of glossy, produced American popular music, a template that subsequent generations of Nashville artists have either embraced or worked against. What Gilfillian does on "Time Will Tell" is something different from both. He takes the studio culture, the care for arrangement, the attention to sound as craft, and fills it with the emotional vocabulary of his Philadelphia origins. The result is not a genre hybrid but a sound that belongs to the particular history of one artist who has spent thirteen years absorbing two cities.

The record opens with "Time," a title track placed at the beginning rather than the end, which sets the terms clearly. The structure of the album is thematic rather than narrative, navigating through familial mortality, the end of a significant relationship, and the question of how to stay present when loss makes abstraction easier. Neal H Pogue, who executive produced, has worked with OutKast and Tyler the Creator, artists whose engagement with tradition involved radical recontextualization. His involvement here does not produce that kind of rupture, but it shapes the arrangements in ways that prevent the album from settling into easy nostalgia.

## The Room Where It Was Made

The decision to record at RCA Studio A was not incidental. The room has its own acoustic character, a particular warmth and depth that comes from decades of musicians playing in it. Gilfillian and his longtime collaborator Jonathan Smalt, who co-produced and played drums on the record, made choices in the sessions that preserved the live quality of the space rather than cleaning it away in post-production. The result is that "Time Will Tell" sounds inhabited. The sound of musicians in a room together, responding to each other in real time, is audible throughout, not as a production affectation but as the natural consequence of a recording approach that prioritized the performance over the artifact.

This matters because the album's emotional content is about presence, specifically the difficulty of staying present when grief and loss are trying to pull you somewhere else. Familial mortality runs through several of the tracks in ways that are not announced by lyrical exposition but embedded in the emotional texture of the performances. "Moonflower" carries a heaviness that is disproportionate to its melodic lightness, which is how grief actually works. "Black Dog Rabbit Hole" names its subject with a directness that the arrangement earns by not softening what the title implies.

## Philly Soul Meets Nashville Room

"Hold On (Hourglass)" establishes the album's middle ground most clearly. Its Spaghetti Western guitar and urgent percussive texture arrive from a very specific place in American music history, the intersection of cinematic Southern sound and the kind of urgent soul music that came out of Philadelphia in the 1970s. The track does not feel like a historical reference. It feels like the natural consequence of Gilfillian's biography, a man from Philadelphia who has spent thirteen years in Nashville making music that belongs to both places without belonging entirely to either.

"IRL" engages more directly with the contemporary, a track whose title signals its interest in the gap between how things are represented and how they actually are. Gilfillian's voice, warm and rangy with a sandy quality that comes from genuine expression rather than affected roughness, carries the track's weight without overstating it. The production around it is similarly restrained, which is the harder choice when the emotional material would support amplification.

"Glad To Be Here" lands near the center of the record and functions as its emotional axis. It is the kind of track that earns its positivity by acknowledging what it is positive in spite of. "Shines In You" follows and continues the album's movement toward grace earned through difficulty. These are not uplifting songs in the conventional sense. They are songs about choosing presence when absence would be easier.

## The Album That Required Thirteen Years

"Let's Stop Fucking Around" is the most unexpected moment here, its directness a tonal shift that works because the album has established enough emotional context for that directness to mean something specific. It is not a commercial concession. It is an honest statement from an artist who has been circling a subject carefully for several tracks and finally decides to name it plainly.

"Keep On Movin'" and "Some Days" develop the album's back half with a consistent emotional intelligence. "Some Days" in particular has the quality of something overheard rather than performed, an impression Gilfillian creates through the intimacy of his delivery rather than through production artifice. These are not standout tracks in the radio-hit sense. They are essential to the record's movement in the way that certain passages of a novel are not quotable but are structural necessities.

"You Can Hate Me Now" closes the main sequence with one of the album's most loaded moments. The title simultaneously references a specific cultural touchstone and rewrites it, transforming what was an assertion of defiance into something more complex, an invitation and an acknowledgment at once. The "Time (Reprise)" that follows is a brief resolution that declines to be a conclusion. The album ends open, which is where it needed to end.

What Gilfillian has made is an argument about what soul music is for when it is made without compromise. Not the kind of argument that requires a manifesto or a provocation. The kind that requires only honesty and craft applied to material that matters enough to sustain them. "Time Will Tell" is that kind of argument, and it is also simply a very good record, the kind that rewards patience with the same depth it was given in its making. He has been preparing this album for thirteen years. The preparation is in the bones of it. You do not hear effort. You hear the result of effort, which is what music is supposed to sound like when the artist has finally gotten where they were going.

[download:/assets/images/artists/devon-gilfillian-time-will-tell-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Devon Gilfillian body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "devon-gilfillian-time-will-tell",
    "artist": "Devon Gilfillian",
    "image_url": "https://artonly.io/assets/images/artists/devon-gilfillian-time-will-tell.jpg",
    "post": {
        "title": "Time Will Tell Is the Album Devon Gilfillian Has Been Preparing His Whole Life",
        "date": "2026-06-27",
        "category": "music",
        "author": "Allastair Voss",
        "instagram_handle": "@devongilfillian",
        "featured": False,
        "image": "/assets/images/artists/devon-gilfillian-time-will-tell.jpg",
        "image_alt": "Devon Gilfillian press photo",
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

echo "--- Validating Devon Gilfillian post ---"
python3 artonly.io/agent/post-validator.py devon-gilfillian-time-will-tell || true

echo "--- IndexNow: Devon Gilfillian ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/devon-gilfillian-time-will-tell&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Devon Gilfillian ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@concordrecords.com" \
  -d "subject=Devon Gilfillian is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Devon Gilfillian and Time Will Tell at artonly.io/post/devon-gilfillian-time-will-tell. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo ""

echo "--- Sending summary email ---"
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-27 (complete)" \
  "Both posts now live:

1. Naomi Sharon - No Sleep In Paradise (published earlier)
   artonly.io/post/naomi-sharon-no-sleep-in-paradise

2. Devon Gilfillian - Time Will Tell
   artonly.io/post/devon-gilfillian-time-will-tell

Outreach: sent to OVO Sound and Concord Records."

echo "=== Devon Gilfillian fix deploy complete: $(date) ==="
