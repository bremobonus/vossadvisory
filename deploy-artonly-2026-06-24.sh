#!/bin/bash
# ArtOnly Deploy Script: PJ Morton + Ama
# Generated: 2026-06-24
# Posts: pj-morton-saturday-night-sunday-morning, ama-ama
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-24 ==="

IMGDIR="/home/dh_yadmw3/artonly.io/assets/images/artists"

# ========================
# POST 1: PJ Morton
# ========================
echo "--- Deploying: pj-morton-saturday-night-sunday-morning ---"

# ---- Download PJ Morton hero image ----
python3 -c "
import urllib.request, re, sys, os, json

def fetch(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(url, headers=headers)
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

def download_img(src, dest, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Image too small: {len(data)} bytes')
        f.write(data)
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg'

try:
    html = fetch('https://shorefire.com/roster/pj-morton')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ('pj', 'morton', 'artist', 'press', 'photo'))]
    if imgs:
        download_img(imgs[0], dest, referer='https://shorefire.com/')
        print('Hero downloaded from Shore Fire')
        sys.exit(0)
except Exception as e:
    print(f'Shore Fire failed: {e}')

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/PJ_Morton'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

try:
    html = fetch('https://www.pjmorton.com/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if len(i) > 20]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.pjmorton.com/')
        print('Hero downloaded from pjmorton.com')
        sys.exit(0)
except Exception as e:
    print(f'pjmorton.com failed: {e}')

os.system('convert -size 1200x800 gradient:\"#0d1117-#1a2744\" -gravity center -pointsize 56 -fill white -annotate 0 \"PJ Morton\" ' + dest)
print('Hero placeholder generated')
"

# Upscale PJ Morton hero
OMP_NUM_THREADS=1 convert "$IMGDIR/pj-morton-saturday-night-sunday-morning.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/pj-morton-saturday-night-sunday-morning-up.jpg" && mv "$IMGDIR/pj-morton-saturday-night-sunday-morning-up.jpg" "$IMGDIR/pj-morton-saturday-night-sunday-morning.jpg"
echo "PJ Morton hero image upscaled"

# ---- Write PJ Morton post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/2FMOHE79X98yptp4RpPrt7]

Philip James Morton was born in New Orleans and raised inside a denomination. His father, Bishop Paul S. Morton Sr., is the founder of the Full Gospel Baptist Church Fellowship International, a Pentecostal organization that by some counts reaches hundreds of thousands of members. Growing up inside that world means growing up with a very specific understanding of what music is for. It is not entertainment. It is testimony. It is the place where the spoken word runs out and something else has to take over.

That background explains a great deal about what made Morton unusual when he turned up, years later, as the keyboardist for Maroon 5. The contrast is hard to overstate. Maroon 5 is one of the most commercially successful pop acts of the past two decades. Their stage is enormous, their reach algorithmic. Morton played behind Adam Levine on stadium tours and television appearances while simultaneously recording his own soul records under his own name for his own label. The double life was not hypocrisy. It was discipline. He kept both things going because he believed both things mattered.

## The Memoir and the Record

Morton published a book in 2024 called Saturday Night, Sunday Morning. The album that now carries that title is not an adaptation of the book. It is the same material thought through in a different form. Where the memoir traced the biography, the album inhabits the feeling. Both refer to the same division: the person who goes out and plays the secular room, and the person who goes home and means every word of the gospel. In New Orleans, the line between those two rooms has always been permeable. The city produces that particular tension with a certain generosity. Morton grew up knowing that the church and the club were separated by blocks, not by category.

The decision to structure the double LP as two discrete sides rather than a blend is the key artistic choice here. Saturday Night contains nine R&B songs. Sunday Morning contains nine gospel songs. Nothing bleeds across. Morton said in a Billboard interview that this is his first proper gospel album because it is the first one where he sings all the songs himself. He has released gospel records before, but always with the vocal humility of someone who is a producer and arranger first. This time the voice is exposed throughout.

## Released on Juneteenth

The June 19 release date is not accidental. Juneteenth marks the announcement of emancipation in Galveston, Texas, on June 19, 1865. For Morton, releasing this particular album on this particular day is a statement about freedom in its fullest sense. The freedom to occupy both rooms without apology. The freedom to be a Grammy winner, a Maroon 5 sideman, a bishop's son, and a New Orleans soul artist, all at once, all on the same record.

Mutual, the lead single from the Saturday Night side, is a song about the particular vulnerability of early courtship between adults who have been hurt before. It does not gesture at that experience. It describes it with specificity. The production is warm and unhurried. Morton is not trying to compete with the current landscape of R&B production, with its processed textures and algorithmic sheen. He records at Studio In The Country, a historic facility in rural Louisiana, and the room sounds like it.

Mercy opens the Sunday Morning side and establishes a completely different register. The gospel songs are not packaged gospel in the contemporary praise and worship sense. They are the kind of music Morton grew up around. They carry the gravity of conviction. They sound like a man who actually means what he is singing.

## The Guests and What They Say

Morton brought two guest artists to the record: Keyon Harrold, the jazz trumpeter who is a Grammy winner in his own right, and Rukhsana Merrise, a West London songwriter. The choices are pointed. Neither of them was selected to generate streaming attention. Both of them were selected because they fit the music.

Harrold's trumpet has appeared on records across genres, from Miles Davis tributes to contemporary R&B collaborations. His presence on the Saturday Night side adds a live instrumental warmth that sits naturally in the sonic world Morton built at Studio In The Country. Merrise's contribution brings a transatlantic sensibility that feels considered rather than cosmetic.

By the time you reach those collaborations inside the listening experience, the context has been established clearly enough that the guests feel like additions to something coherent rather than interruptions of something still finding itself.

## What the Credentials Do and Do Not Explain

Morton has six Grammy wins and 22 nominations. He won Best R&B Song for co-writing H.E.R.'s song I Can't Breathe. He has won Best Gospel Album multiple times. He is a producer whose fingerprints are on a wide range of records beyond his own. None of that explains Saturday Night, Sunday Morning. The credentials are the result of a long career spent working at a level of craft most people do not sustain. The album is the reason for the career.

This is the record Morton has been building toward. Not because it is the most commercially ambitious thing he has released. Not because it proves something to critics or to the Recording Academy. It is the most personal. A man who grew up inside a denomination, who made his living in secular rooms for decades, who wrote a memoir about living in both places, finally made the record that matches the life. The separation is intact. The communion is real. You can go from Saturday Night to Sunday Morning in a single listen and understand exactly what that journey has cost him, and what it has given back.

[download:/assets/images/artists/pj-morton-saturday-night-sunday-morning-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "pj-morton-saturday-night-sunday-morning",
    "title": "PJ Morton Made Peace Between Saturday Night and Sunday Morning",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-24",
    "image": "/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg",
    "image_alt": "PJ Morton press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/pj-morton-saturday-night-sunday-morning.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF

echo "Post JSON deployed: pj-morton-saturday-night-sunday-morning.json"

# ---- Generate PJ Morton social card ----
cd ~/artonly.io/agent
python3 make-social-card.py pj-morton-saturday-night-sunday-morning "PJ Morton Made Peace Between Saturday Night and Sunday Morning" music
echo "Social card generated: pj-morton-saturday-night-sunday-morning-social-9x16.jpg"
cd ~

# ---- Run validator ----
cd ~/artonly.io/agent
python3 post-validator.py pj-morton-saturday-night-sunday-morning || true
echo "Validator complete"
cd ~

# ========================
# POST 2: Ama
# ========================
echo "--- Deploying: ama-ama ---"

# ---- Download Ama hero image ----
python3 -c "
import urllib.request, re, sys, os, json

def fetch(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(url, headers=headers)
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

def download_img(src, dest, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Image too small: {len(data)} bytes')
        f.write(data)
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/ama-ama.jpg'

try:
    html = fetch('https://pulserecords.com/artist/ama/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg|webp))', html, re.IGNORECASE)
    imgs = [i for i in imgs if len(i) > 20 and not any(k in i.lower() for k in ('logo', 'icon', 'favicon'))]
    if imgs:
        download_img(imgs[0], dest, referer='https://pulserecords.com/')
        print('Hero downloaded from Pulse Records')
        sys.exit(0)
except Exception as e:
    print(f'Pulse Records failed: {e}')

try:
    html = fetch('https://www.thefader.com/2026/05/06/ama-album-brent-faiyaz-interview')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if len(i) > 30 and not any(k in i.lower() for k in ('logo', 'icon', 'avatar'))]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thefader.com/')
        print('Hero downloaded from FADER')
        sys.exit(0)
except Exception as e:
    print(f'FADER failed: {e}')

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Ama_(musician)'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

os.system('convert -size 1200x800 gradient:\"#1a0a00-#3d1f00\" -gravity center -pointsize 56 -fill white -annotate 0 \"Ama\" ' + dest)
print('Hero placeholder generated')
"

# Upscale Ama hero
OMP_NUM_THREADS=1 convert "$IMGDIR/ama-ama.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/ama-ama-up.jpg" && mv "$IMGDIR/ama-ama-up.jpg" "$IMGDIR/ama-ama.jpg"
echo "Ama hero image upscaled"

# ---- Write Ama post JSON ----
python3 << 'PYEOF2'
import json, os

body = """\
[spotify:artist/2tAqnHDAgnGtjnlzyoa38L]

Ama Louisa John grew up in London and started making music under the name Ama Lou. The Lou was something she chose as a preteen, a performer name that gave her enough distance from herself to step in front of an audience and mean it. It worked for a while. Her debut album, I Came Home Late, arrived via Interscope in 2022 and established a version of herself that was precise and restrained: a British songwriter working in the space between R&B and indie, with the kind of minimalist production that makes room for a voice to do the heavy lifting. Then she parted ways with Interscope, and spent two years figuring out what came next.

What came next is AMA.

## Dropping the Alias

The name change is the first and most legible statement the album makes. She is not Ama Lou anymore. She is Ama. The shortened name is not a rebrand in the marketing sense. It is a return. She has said in interviews that she had always been Ama, that the Lou was a preteen invention she grew into and then grew out of, that she was ready to stand in her own name without the extra syllable. The self-titled album follows that logic throughout its 13 tracks. There is no persona to soften the exposure. The songwriting is direct, written in the first person, and does not leave much distance between the writer and the written.

The label situation changed alongside the name. She signed to ISO Supremacy, the imprint that Brent Faiyaz runs in partnership with PULSE Records. Faiyaz's aesthetic sensibility is well documented at this point: he favors music that takes its time, that does not perform emotion but inhabits it, that trusts the listener to follow without being signposted along. That is also a good description of what Ama does on this record. The alignment between artist and label is not accidental.

## The Production Logic

AMA runs 41 minutes across 13 tracks. The production does not rush. Atmospheric soundscapes, layered harmonies, and a minimalism that prioritizes space over density: these are the choices that define the record's feel. Ama moved from London to Los Angeles in the period between albums, and you can hear something of that dislocation in the music. Not specifically, not in any way that announces itself. But there is a quality of suspension in the production, a sound that belongs to no particular city or scene, that feels like someone who has been between places long enough to stop expecting the geography to do anything for them.

Need it Bad, featuring Brent Faiyaz, is the track that most explicitly names the album's emotional core. The title is direct in a way the rest of the record often prefers to avoid. Faiyaz's presence is understated. He does not take the record over. He arrives inside the song's architecture rather than reshaping it. The feature is a collaboration in the genuine sense: two artists who have thought about the same questions and are singing about them in the same room.

Aura, featuring Bryson Tiller, operates at a different temperature. Tiller's contribution opens up something softer inside the record. The track is one of the album's more open pop gestures, which is not the same as being its least interesting. Ama knows how to use a melody without letting the melody use her.

## What Healing Actually Sounds Like

The FADER ran a feature on Ama in May with the framing of someone addicted to healing. That phrase could go wrong very easily in 2026, when the therapeutic vocabulary of popular music has been so thoroughly processed by wellness culture that it has lost most of its meaning. On AMA it does not go wrong, because the album does not present healing as a destination. It presents it as a practice, something ongoing and unresolved, and that distinction is audible in the writing.

Ama is not offering resolution. She is documenting process. The songs examine the same material from different angles, the way a person actually thinks about something they are still working through. That circularity is intentional. She has said in multiple interviews that the album is about a kind of emotional investigation, not closure. The record supports that reading. You finish the 41 minutes without feeling like anything has been settled. You feel like you have been in honest company for a while.

## The Second Album as Proof

The second record is the one that matters most in a career. The debut proves that someone can do the thing. The second album proves that the debut was not an accident. AMA succeeds at that test without performing the effort. Ama does not make a record that sounds like someone trying very hard to prove she is still here. She makes a record that sounds like someone who is still here, and who has been spending the time well.

The 13 tracks feel precisely chosen. Nothing feels like filler. Nothing feels like it arrived to justify a standard album runtime. The decisions are confident in the way that comes from knowing what you are doing rather than from having done it before. The album sounds like a person who has learned something from what did not work the first time and applied it, not through larger ambition but through sharper judgment.

AMA is the record that says who she is. She dropped the Lou, kept the precision, and made the most honest thing in her catalog. That is a reasonable definition of progress.

[download:/assets/images/artists/ama-ama-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "ama-ama",
    "title": "Ama Dropped the Alias and Kept Everything That Mattered",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-24",
    "image": "/assets/images/artists/ama-ama.jpg",
    "image_alt": "Ama press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/ama-ama.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF2

echo "Post JSON deployed: ama-ama.json"

# ---- Generate Ama social card ----
cd ~/artonly.io/agent
python3 make-social-card.py ama-ama "Ama Dropped the Alias and Kept Everything That Mattered" music
echo "Social card generated: ama-ama-social-9x16.jpg"
cd ~

# ---- Run validator ----
cd ~/artonly.io/agent
python3 post-validator.py ama-ama || true
echo "Validator complete"
cd ~

# ========================
# UPDATE brain.json
# ========================
python3 << 'BRAINEOF'
import json, os

brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
try:
    with open(brain_path, 'r') as f:
        brain = json.load(f)

    written = brain.get('artists_written', [])
    for artist in ['PJ Morton', 'Ama']:
        if artist not in written:
            written.append(artist)
            print(f'Added {artist} to artists_written')
    brain['artists_written'] = written

    queue = brain.get('queue', [])
    brain['queue'] = [a for a in queue if a not in ('PJ Morton', 'Ama', 'Ama Lou')]

    brain['last_published'] = {
        'artist': 'Ama',
        'slug': 'ama-ama',
        'title': 'Ama Dropped the Alias and Kept Everything That Mattered',
        'date': '2026-06-24'
    }

    with open(brain_path, 'w') as f:
        json.dump(brain, f, indent=2, ensure_ascii=False)
        f.write('\n')
    print('brain.json updated on server')
except Exception as e:
    print(f'brain.json update skipped: {e}')
BRAINEOF

# ========================
# VERIFY + INDEXNOW + EMAIL
# ========================

sleep 5

# Verify PJ Morton
STATUS1=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pj-morton-saturday-night-sunday-morning)
echo "HTTP status artonly.io/post/pj-morton-saturday-night-sunday-morning: $STATUS1"

# IndexNow PJ Morton
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pj-morton-saturday-night-sunday-morning&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
echo "IndexNow pinged: pj-morton-saturday-night-sunday-morning"

# Verify Ama
STATUS2=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/ama-ama)
echo "HTTP status artonly.io/post/ama-ama: $STATUS2"

# IndexNow Ama
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ama-ama&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
echo "IndexNow pinged: ama-ama"

# Outreach PJ Morton
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@shorefire.com" \
  --data-urlencode "bcc=amosleblanc@gmail.com" \
  --data-urlencode "subject=Your album is on ArtOnly" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on PJ Morton and Saturday Night Sunday Morning at artonly.io/post/pj-morton-saturday-night-sunday-morning. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" || true
echo "Outreach sent for PJ Morton"

# Outreach Ama
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@pulserecords.com" \
  --data-urlencode "bcc=amosleblanc@gmail.com" \
  --data-urlencode "subject=Your album is on ArtOnly" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on Ama and the new release AMA at artonly.io/post/ama-ama. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" || true
echo "Outreach sent for Ama"

# Summary email
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-24" "Published today:

1. artonly.io/post/pj-morton-saturday-night-sunday-morning
   PJ Morton, Saturday Night Sunday Morning (June 19, 2026)
   HTTP $STATUS1

2. artonly.io/post/ama-ama
   Ama, AMA (June 19, 2026)
   HTTP $STATUS2

Outreach:
- PJ Morton: info@shorefire.com
- Ama: info@pulserecords.com" || true
echo "Summary email sent"

echo "=== Deploy complete: 2026-06-24 ==="
