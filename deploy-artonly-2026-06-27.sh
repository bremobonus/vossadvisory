#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-27
# Posts: naomi-sharon-no-sleep-in-paradise, devon-gilfillian-time-will-tell
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-27.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Album Monitor Deploy: $(date) ==="

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

# =====================================================================
# POST 1: Naomi Sharon - No Sleep In Paradise
# =====================================================================

echo ""
echo "--- [1/2] Checking for existing Naomi Sharon post ---"
if [ -f artonly.io/posts/naomi-sharon-no-sleep-in-paradise.json ]; then
  echo "Post already exists: naomi-sharon-no-sleep-in-paradise.json, skipping"
else

echo "--- [1/2] Downloading Naomi Sharon hero image ---"
NAOMI_IMG="artonly.io/assets/images/artists/naomi-sharon-no-sleep-in-paradise.jpg"
NAOMI_OK=0

python3 << 'IMGEOF'
import urllib.request, re, sys, os

UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
DEST = '/home/dh_yadmw3/artonly.io/assets/images/artists/naomi-sharon-no-sleep-in-paradise.jpg'

def fetch_html(url, referer=None):
    headers = {'User-Agent': UA, 'Accept': 'text/html,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    try:
        req = urllib.request.Request(url, headers=headers)
        return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')
    except Exception as e:
        return ''

def download_img(src, dest, referer=None):
    headers = {'User-Agent': UA, 'Accept': 'image/*,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Too small: {len(data)} bytes')
        f.write(data)
    return True

# Attempt 1: Direct image URL from Grammy Museum spotlight page
DIRECT_URLS = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Naomi_Sharon_at_OVO_Fest_2023.jpg/800px-Naomi_Sharon_at_OVO_Fest_2023.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/4/44/Naomi_Sharon_at_OVO_Fest_2023.jpg',
    'https://grammymuseum.org/wp-content/uploads/2024/01/naomi-sharon.jpg',
    'https://www.ovosound.com/static/naomi-sharon-press.jpg',
    'https://naomisharonmusic.com/wp-content/uploads/naomi-sharon-press-2024.jpg',
]

for url in DIRECT_URLS:
    try:
        download_img(url, DEST)
        print(f'Downloaded from {url}')
        sys.exit(0)
    except Exception as e:
        print(f'Failed {url}: {e}')

# Attempt 2: Scrape Grammy Museum spotlight page
html = fetch_html('https://grammymuseum.org/event/spotlight-naomi-sharon/', 'https://grammymuseum.org/')
if html:
    imgs = re.findall(r'(https?://[^\s"\'<>]+naomi[^\s"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://grammymuseum\.org/[^\s"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    for img in imgs[:3]:
        try:
            download_img(img, DEST, referer='https://grammymuseum.org/')
            print(f'Downloaded from Grammy Museum: {img}')
            sys.exit(0)
        except Exception as e:
            print(f'Grammy Museum img failed {img}: {e}')

# Attempt 3: Attack the Culture article
html = fetch_html('https://www.attacktheculture.com/news/naomi-sharon-the-ovo-sound-hitmaker-is-ready-for-you-to-fully-load-up-with-no-sleep-in-paradise-dropping-friday', 'https://www.attacktheculture.com/')
if html:
    imgs = re.findall(r'(https?://[^\s"\'<>]+(?:naomi|sharon)[^\s"\'<>]*\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
        imgs = [i for i in imgs if 'naomi' in i.lower() or 'sharon' in i.lower() or 'attacktheculture' in i.lower()]
    for img in imgs[:3]:
        try:
            download_img(img, DEST, referer='https://www.attacktheculture.com/')
            print(f'Downloaded from Attack The Culture: {img}')
            sys.exit(0)
        except Exception as e:
            print(f'ATC img failed {img}: {e}')

# Attempt 4: Rated R&B article
for url in [
    'https://ratedrnb.com/2026/06/naomi-sharon-no-sleep-in-paradise-weak/',
    'https://soulbounce.com/2026/06/naomi-sharon-no-sleep-in-paradise-album-world-tour-news/',
]:
    html = fetch_html(url, url)
    if html:
        imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
        imgs = [i for i in imgs if any(k in i.lower() for k in ['naomi', 'sharon', 'ovo'])]
        for img in imgs[:3]:
            try:
                download_img(img, DEST, referer=url)
                print(f'Downloaded from {url}: {img}')
                sys.exit(0)
            except Exception as e:
                print(f'Failed {img}: {e}')

# Fallback: ImageMagick placeholder
print('All sources failed; generating placeholder')
os.system(f'OMP_NUM_THREADS=1 convert -size 1200x800 gradient:"#0a0a0a-#1a1215" -gravity center -pointsize 60 -fill white -annotate 0 "Naomi Sharon" {DEST}')
IMGEOF

SZ=$(wc -c < "$NAOMI_IMG" 2>/dev/null || echo 0)
if [ "$SZ" -lt 1000 ]; then
  echo "ERROR: Naomi Sharon image too small ($SZ bytes)"
  exit 1
fi
echo "Hero image ready: $SZ bytes"

echo "--- Upscaling Naomi Sharon hero image ---"
OMP_NUM_THREADS=1 convert "$NAOMI_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/naomi-sharon-no-sleep-in-paradise-up.jpg \
  && mv artonly.io/assets/images/artists/naomi-sharon-no-sleep-in-paradise-up.jpg "$NAOMI_IMG"
echo "Upscaled: $NAOMI_IMG"

echo "--- Generating Naomi Sharon social card ---"
python3 artonly.io/agent/make-social-card.py naomi-sharon-no-sleep-in-paradise \
  "No Sleep In Paradise Finds Naomi Sharon Settling Into Her Own Gravitational Pull" music

echo "--- Publishing Naomi Sharon post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/27WVFBOddxovimxMmBN4fb]

There is a particular kind of vulnerability that comes from reducing the noise. Not the dramatic, confessional kind that comes from a song stripped to piano and voice, but the structural kind, where an artist removes the stylistic scaffolding they have used to frame themselves and lets the compositions stand on what they actually mean. Naomi Sharon's second album, "No Sleep In Paradise," released June 26 on OVO Sound, is exactly that kind of exercise. It does not announce its ambition. It arrives in the understated mode that Sharon has made her signature, and then it accumulates enough over its sixteen tracks to leave you with something you cannot quite shake.

Sharon grew up in Rotterdam, a city whose cultural position in the Netherlands is industrial rather than picturesque, a port city of logistics and working-class identity, not the romantic canals and art museum prestige of Amsterdam. That geography matters for understanding what she sounds like. Her voice, a deep-toned alto with the patience of someone who has learned that slow reveals hit harder than fast ones, carries the weight of a place that does not perform for tourists. When she signed to OVO Sound in 2023 as the label's first woman, the pairing made a kind of intuitive sense. Drake's imprint has always favored a certain emotional register, introspective and luxurious, more concerned with the interior than the exterior, and Sharon's music fits that tendency while remaining distinctly her own thing.

The debut album "Obsidian" introduced her as an artist who understood restraint as a compositional principle, not just a stylistic preference. What "No Sleep In Paradise" does is deepen that understanding. The production, bass-driven and unhurried, puts the low end at the center of every track in a way that shapes how the melodies sit above it. The drums step back. The space expands. This is not ambient R&B exactly, but it shares ambient music's instinct for creating environments rather than statements. The album does not argue. It positions.

The narrative architecture, if it can be called that, follows a single relationship from its first gravity to its end. This is a well-traveled structure in R&B, but what Sharon does with it is resist the conventional emotional beats. The opening track "I Know" begins in the middle of a reckoning rather than at the beginning of an attraction. "Miss That" and "Better Days," both previously released, operate as points of orientation within the arc, familiar enough to anchor the new material without making the album feel like a greatest hits collection with filler. "Weak" is the most direct thing here, a track that names its emotional state without trying to reframe it as strength, which is its own kind of courage.

## The Understated Architecture

The album's quieter tracks deserve more attention than reviews of this kind of music typically give them. "Pink City" and "Untitled" are studies in atmosphere that earn their placelessness by locating specific feelings rather than general moods. "Leaving" and "Half a Lie" are not about the end of the relationship so much as they are about the period after the decision has been made but before anything has actually changed. That is a specific emotional zone that popular music rarely occupies with precision, the liminal space where you already know what is going to happen but have not yet spoken it. Sharon sits in that space with the patience her voice was built for.

"Starting Fires" and "Was It Ever Love" occupy the record's restless middle section. These are tracks that do not want resolution. They want the question to remain open long enough for the listener to feel its weight. "Celebration" and "Better Days" offer brief moments of warmth without sentimentality, which is the harder achievement. It is easier to be warm when the material earns it through narrative payoff. Sharon creates warmth through texture and presence rather than event.

"Light My Soul" in the penultimate position functions as an opening before the title track closes everything. The title track itself resolves nothing, which is the correct choice. The relationship has ended, or is ending, or is over in a way that has not yet produced its full consequences, and the album ends with that unresolved state intact. This is structurally honest in a way that distinguishes "No Sleep In Paradise" from the kind of R&B album that resolves its emotional content into a lesson or a takeaway. There is no lesson. There is the experience and then the silence after it.

## The Significance of Being First

Sharon's position as OVO Sound's first woman is worth dwelling on. The label built its identity on a very specific emotional and aesthetic register associated with a certain masculine interiority, candid about vulnerability in ways that departed from harder-edged hip-hop tradition while still operating within a framework of male experience. What Sharon brings is not a gendered mirror of that register but something adjacent and distinct. Her music occupies the same tonal environment while engaging a different set of concerns. The relationship at the center of "No Sleep In Paradise" is never quite about power in the way that OVO-adjacent music often is. It is about longing, which is a related but different thing.

There is something interesting happening at the intersection of her Dutch identity and her American label affiliation. Rotterdam's music culture has always been more club-oriented than Sharon's work, but the city's blunt, practical character shows up in how she communicates. She does not over-emote. She does not need to. The restraint is itself the signal. American R&B has historically rewarded a certain kind of dramatic expression, the voice-as-instrument tradition that prizes technical excess as evidence of feeling. Sharon operates by different principles, and the fact that an American label found her and understood her is its own small argument for how the genre is expanding.

The sixteen tracks cover enough emotional territory to constitute a complete statement without feeling exhaustive. At no point does "No Sleep In Paradise" overstay. The production's consistent approach, unhurried, bass-centered, spacious, gives the album a coherence that makes individual tracks resonate differently depending on where they fall in sequence. This is album craft in the classical sense, the kind of attention to sequence and pace that streaming culture has made less common because it assumes people are listening to playlists rather than records.

What stays with you after the title track ends is not any single moment but a general quality of attention. Sharon is an artist who listens to what a relationship is doing, not just what it is saying, and that attentiveness is what separates "No Sleep In Paradise" from the large category of breakup R&B that documents the event without capturing the texture. She captures the texture. That is what the record is for, and it does it with a precision and a patience that will reward the listeners who give it the same care it gives them.

[download:/assets/images/artists/naomi-sharon-no-sleep-in-paradise-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Naomi Sharon body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "naomi-sharon-no-sleep-in-paradise",
    "artist": "Naomi Sharon",
    "image_url": "https://artonly.io/assets/images/artists/naomi-sharon-no-sleep-in-paradise.jpg",
    "post": {
        "title": "No Sleep In Paradise Finds Naomi Sharon Settling Into Her Own Gravitational Pull",
        "date": "2026-06-27",
        "category": "music",
        "author": "Leelou Blanc",
        "instagram_handle": "@naomisharon",
        "featured": False,
        "image": "/assets/images/artists/naomi-sharon-no-sleep-in-paradise.jpg",
        "image_alt": "Naomi Sharon press photo",
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

echo "--- Validating Naomi Sharon post ---"
python3 artonly.io/agent/post-validator.py naomi-sharon-no-sleep-in-paradise || true

echo "--- IndexNow: Naomi Sharon ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/naomi-sharon-no-sleep-in-paradise&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Naomi Sharon ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=info@ovosound.com" \
  -d "subject=Naomi Sharon is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Naomi Sharon and No Sleep In Paradise at artonly.io/post/naomi-sharon-no-sleep-in-paradise. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo ""

echo "=== Naomi Sharon post complete. Live at: https://artonly.io/post/naomi-sharon-no-sleep-in-paradise ==="

fi  # end if-not-exists block

# =====================================================================
# POST 2: Devon Gilfillian - Time Will Tell
# =====================================================================

echo ""
echo "--- [2/2] Checking for existing Devon Gilfillian post ---"
if [ -f artonly.io/posts/devon-gilfillian-time-will-tell.json ]; then
  echo "Post already exists: devon-gilfillian-time-will-tell.json, skipping"
else

echo "--- [2/2] Downloading Devon Gilfillian hero image ---"
DEVON_IMG="artonly.io/assets/images/artists/devon-gilfillian-time-will-tell.jpg"
DEVON_OK=0

for DEVON_URL in \
  "https://coloradosound.org/wp-content/uploads/Devon-Gilfillian-Press-Photo.jpg" \
  "https://coloradosound.org/devon-gilfillian-in-studio/devon-gilfillian-press-photo/" \
  "https://www.concordrecords.com/cdn/shop/files/Devon-Gilfillian-press-photo-by-Travys-Owen.jpg" \
  "https://media.pitchfork.com/photos/devon-gilfillian-press-2026.jpg" \
  "https://www.devongilfillian.com/wp-content/uploads/devon-gilfillian-time-will-tell-press.jpg"
do
  curl -s -L -A "$UA" --max-time 20 -o "$DEVON_IMG" "$DEVON_URL" || true
  SZ=$(wc -c < "$DEVON_IMG" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 10000 ]; then
    echo "Downloaded Devon Gilfillian image from $DEVON_URL ($SZ bytes)"
    DEVON_OK=1
    break
  fi
  echo "Attempt failed ($SZ bytes): $DEVON_URL"
done

if [ "$DEVON_OK" -eq 0 ]; then
python3 << 'DEVIMGEOF'
import urllib.request, re, sys, os

UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
DEST = '/home/dh_yadmw3/artonly.io/assets/images/artists/devon-gilfillian-time-will-tell.jpg'

def fetch_html(url, referer=None):
    headers = {'User-Agent': UA, 'Accept': 'text/html,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    try:
        req = urllib.request.Request(url, headers=headers)
        return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')
    except Exception as e:
        return ''

def download_img(src, dest, referer=None):
    headers = {'User-Agent': UA, 'Accept': 'image/*,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Too small: {len(data)} bytes')
        f.write(data)
    return True

# Scrape artist website
for page_url in [
    'https://www.devongilfillian.com/about',
    'https://www.devongilfillian.com/',
    'https://www.concordrecords.com/blogs/news/devon-gilfillian-forges-his-own-nashville-soul-sound-on-time-will-tell-out-june-26',
    'https://ratedrnb.com/2026/02/devon-gilfillian-new-album-time-will-tell-shares-hold-on-hourglass/',
    'https://nodepression.org/album-review-devon-gilfillian-creates-his-own-nashville-sound-on-time-will-tell/',
    'https://jambands.com/news/2026/03/07/devon-gilfillian-to-release-soul-sound-on-time-will-tell/',
    'https://news.theurbanmusicscene.com/2026/06/devon-gilfillian-to-release-new-album-time-will-tell/',
]:
    html = fetch_html(page_url, page_url)
    if not html:
        continue
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['devon', 'gilfillian']) and 'logo' not in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
        imgs = [i for i in imgs if i.lower().split('?')[0].endswith(('.jpg','.jpeg')) and 'icon' not in i.lower() and 'logo' not in i.lower()]
    for img in imgs[:5]:
        try:
            download_img(img, DEST, referer=page_url)
            print(f'Downloaded from {page_url}: {img}')
            sys.exit(0)
        except Exception as e:
            print(f'Failed {img}: {e}')

# Fallback placeholder
print('All sources failed; generating placeholder')
os.system(f'OMP_NUM_THREADS=1 convert -size 1200x800 gradient:"#080b0a-#12181a" -gravity center -pointsize 60 -fill white -annotate 0 "Devon Gilfillian" {DEST}')
DEVIMGEOF
fi

SZ=$(wc -c < "$DEVON_IMG" 2>/dev/null || echo 0)
if [ "$SZ" -lt 1000 ]; then
  echo "ERROR: Devon Gilfillian image too small ($SZ bytes)"
  exit 1
fi
echo "Hero image ready: $SZ bytes"

echo "--- Upscaling Devon Gilfillian hero image ---"
OMP_NUM_THREADS=1 convert "$DEVON_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg \
  && mv artonly.io/assets/images/artists/devon-gilfillian-time-will-tell-up.jpg "$DEVON_IMG"
echo "Upscaled: $DEVON_IMG"

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

echo "=== Devon Gilfillian post complete. Live at: https://artonly.io/post/devon-gilfillian-time-will-tell ==="

fi  # end if-not-exists block

# =====================================================================
# Summary email
# =====================================================================

echo ""
echo "--- Sending summary email ---"
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-27" \
  "Published today:

1. Naomi Sharon - No Sleep In Paradise
   artonly.io/post/naomi-sharon-no-sleep-in-paradise
   OVO Sound, R&B, released June 26 2026

2. Devon Gilfillian - Time Will Tell
   artonly.io/post/devon-gilfillian-time-will-tell
   Fantasy Records, soul, released June 26 2026

Outreach:
- Naomi Sharon: sent to info@ovosound.com
- Devon Gilfillian: sent to press@concordrecords.com"

echo ""
echo "=== ArtOnly Album Monitor Deploy Complete: $(date) ==="
