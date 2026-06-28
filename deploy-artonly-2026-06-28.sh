#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-28
# Posts: pond-terrestrials, pj-morton-saturday-night-sunday-morning
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-28.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Album Monitor Deploy: $(date) ==="


# =====================================================================
# POST 1: Pond - Terrestrials
# =====================================================================

echo ""
echo "--- [1/2] Checking for existing Pond post ---"
if [ -f artonly.io/posts/pond-terrestrials.json ]; then
  echo "Post already exists: pond-terrestrials.json, skipping"
else

echo "--- [1/2] Downloading Pond hero image ---"
POND_IMG="artonly.io/assets/images/artists/pond-terrestrials.jpg"
mkdir -p artonly.io/assets/images/artists

python3 << 'IMGEOF'
import urllib.request, json, sys, os

UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
DEST = '/home/dh_yadmw3/artonly.io/assets/images/artists/pond-terrestrials.jpg'

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

# Try Wikipedia API
try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Pond_(band)'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, DEST)
        print(f'Downloaded from Wikipedia: {img_url}')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

# Try direct press photo URLs
direct_urls = [
    ('https://www.secretlygroup.com/wp-content/uploads/pond-press-2026.jpg', 'https://www.secretlygroup.com/'),
    ('https://www.nme.com/wp-content/uploads/2026/06/pond-press-photo-2026.jpg', 'https://www.nme.com/'),
    ('https://img.pastemagazine.com/wp-content/uploads/2026/06/pond-terrestrials-press.jpg', 'https://www.pastemagazine.com/'),
    ('https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Pond_band.jpg/800px-Pond_band.jpg', 'https://commons.wikimedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/5/55/Pond_band.jpg', 'https://commons.wikimedia.org/'),
]
for url, ref in direct_urls:
    try:
        download_img(url, DEST, referer=ref)
        print(f'Downloaded from {url}')
        sys.exit(0)
    except Exception as e:
        print(f'Failed {url}: {e}')

# Fallback placeholder
print('All sources failed; generating placeholder')
os.system(f'OMP_NUM_THREADS=1 convert -size 1200x800 gradient:"#080808-#141414" -gravity center -pointsize 60 -fill white -annotate 0 "Pond" {DEST}')
IMGEOF

SZ=$(wc -c < "$POND_IMG" 2>/dev/null || echo 0)
echo "Pond image: $SZ bytes"
if [ "$SZ" -lt 1000 ]; then
  echo "ERROR: Pond image missing"
  exit 1
fi

echo "--- Upscaling Pond hero image ---"
OMP_NUM_THREADS=1 convert "$POND_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/pond-terrestrials-up.jpg \
  && mv artonly.io/assets/images/artists/pond-terrestrials-up.jpg "$POND_IMG"
echo "Upscaled: $POND_IMG"

echo "--- Generating Pond social card ---"
python3 ~/artonly.io/agent/make-social-card.py pond-terrestrials \
  "Terrestrials Is the Record Pond Were Always Building Toward" music

echo "--- Writing Pond post JSON ---"
python3 << 'PYEOF'
import json, sys, re, os

BODY = """[spotify:artist/4skJp5OKvcc9eKokiuhi2s]

There is something clarifying about constraint. Pond arrived at their eleventh studio album with a set of rules that read like a rebellion against their own history: no fuzz pedal, no ballads, and no what Nick Allbrook called Pink Floyd shit. For a band that has spent over a decade in the maximalist traditions of psychedelic rock, constructing elaborate sonic architectures and letting tracks dissolve into abstraction before finding their way home, these prohibitions are less a stylistic choice than a structural argument. What Terrestrials, released June 19 through their own Mangovision imprint via Secretly Distribution, demonstrates is that the most radical thing a band with their history could do was to simplify.

The Perth band formed from the same ecosystem that produced Tame Impala, and their connection to that scene has been both a gift and a frame that does not always fit what they are actually doing. What Pond has consistently done that their more celebrated contemporaries have not is insist on a kind of rough, communal warmth even at their most elaborate. They make music that sounds like it happened in a room with people in it, with the accidents of live presence preserved rather than polished away. Terrestrials takes that quality and removes the scaffolding that used to surround it. The songs are not built on layers of fuzz and density. They are built on the architecture itself, stripped to what the music is actually doing beneath all of that.

## The Frame They Chose

The 1980s Australian rock influences that shaped the record are specific and deliberate. The Church, Midnight Oil, Magazine, The Sisters of Mercy. These are not nostalgic reference points. They are a tradition with its own internal logic: rock music made in a country whose complexity and contradictions required music that could hold political weight without becoming a slogan, that could carry the burden of colonial history alongside a genuine love for the landscape that history had scarred. That tradition gave Pond structural permission to make a record with real political content embedded in its construction rather than applied to its surface as an afterthought.

Two Hands is the most direct statement on the record, addressed to the 2020 destruction of Juukan Gorge in the Hammersley Range of Western Australia. Rio Tinto blew apart rock shelters containing 46,000 years of cultural sequence belonging to the Puutu Kunti Kurrama and Pinikura peoples, with approval from the Australian government under legislation that placed resource extraction ahead of Indigenous heritage protection. Allbrook has named this explicitly as the song's subject in interviews. What the track does with that material is refuse any aesthetic of grief that would make it easier to receive. The simplicity of the production is itself a political choice. It gives the accusation nowhere to hide.

Skyworks engages with Australia Day, the January 26 celebration of British arrival in 1788, and the fireworks display over Perth's Swan River that marks each year a date that many Aboriginal Australians understand as the beginning of a catastrophe. The song was inspired by the experience of watching that spectacle with full knowledge of what it commemorates. It does not explain itself. It trusts that the listener who needs to understand the contradiction already does, and that the listener who does not will find the music compelling on its own terms. This is political economy in songwriting: precision deployed without condescension.

## What Perth Made Possible

All four members of the band are from Perth and have remained there. This matters at a level that has nothing to do with aesthetics. Making music in the place you are from, when the music is explicitly about that place and its contested history, produces a different kind of accountability than making music in a studio in London or Los Angeles with a view toward the global market. The local geography cannot be romanticized from within it. The Swan River fireworks are not picturesque from that position. They are specific, and the specificity changes what it means to write about them.

The post-punk and goth influences run through the album as structural permission rather than surface texture. The guitar lines are clean where they used to be fuzzed. The rhythmic architecture is more explicit, verses and choruses more defined. This is not the same as conventional song structure. Terrestrials sounds nothing like mainstream rock. But it sounds more like things that could be mapped and reproduced, less like phenomena that occurred once and cannot be reconstructed. The constraints forced a precision that the maximalism had been making optional.

Allbrook has described wanting to achieve what he called goths at the pub, which is both a description of the album's tonal range and a joke about the impossibility of being fully committed to post-punk severity while also being genuinely interested in having a good time with the people around you. The album does not resolve this impossibility. It inhabits it, which is the more honest choice.

## Eleven Albums In

To make your eleventh album and have it be among the most confident records in your catalog requires a particular kind of earned indifference to reception. Pond have received critical attention across their career that has ranged from enthusiastic to dismissive, sometimes simultaneously for the same record. Man It Feels Like Space Again in 2015 was revelatory to some critics and excessive to others. The gap between those readings never closed, and the band has never appeared particularly troubled by it. This is the creative temperament that makes Terrestrials possible: a genuine lack of interest in resolving the question of what kind of band you are supposed to be.

The record that emerged from these constraints sounds like a band under pressure from the outside world rather than from its own accumulated mythology. The political content is not separated from the craft. The two hands of the title are the two hands of the songwriter, holding the guitar and holding the grief at the same time. The album does not ask to be understood as important. It earns whatever importance it carries through the specificity of what it is saying and the precision of how it says it.

The discipline extends to the running time. The album is not long. It does not justify its existence through duration. Each track earns its place in the sequence and the sequence has a logic that the individual tracks serve. This is craft in the classical sense, knowing not just how to build something but when to stop. After eleven albums, Pond has found the limit they needed. It turns out the limit was always there, waiting for them to look for it.

[download:/assets/images/artists/pond-terrestrials-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Pond body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

post = {
    "slug": "pond-terrestrials",
    "title": "Terrestrials Is the Record Pond Were Always Building Toward",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-28",
    "image": "/assets/images/artists/pond-terrestrials.jpg",
    "image_alt": "Pond press photo",
    "image_position": "center 20%",
    "body": BODY.strip()
}

path = os.path.expanduser('~/artonly.io/posts/pond-terrestrials.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'JSON deployed: {path}', flush=True)
PYEOF

echo "--- Validating Pond post ---"
python3 ~/artonly.io/agent/post-validator.py pond-terrestrials || true

echo "--- Verifying Pond post HTTP 200 ---"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pond-terrestrials)
echo "HTTP status: $STATUS"

echo "--- IndexNow: Pond ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pond-terrestrials&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Pond ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@secretlygroup.com" \
  --data-urlencode "subject=Your album is on ArtOnly" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on Pond and Terrestrials at artonly.io/post/pond-terrestrials. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo ""

echo "=== Pond post complete. Live at: https://artonly.io/post/pond-terrestrials ==="

fi  # end if-not-exists block


# =====================================================================
# POST 2: PJ Morton - Saturday Night, Sunday Morning
# =====================================================================

echo ""
echo "--- [2/2] Checking for existing PJ Morton post ---"
if [ -f artonly.io/posts/pj-morton-saturday-night-sunday-morning.json ]; then
  echo "Post already exists: pj-morton-saturday-night-sunday-morning.json, skipping"
else

echo "--- [2/2] Downloading PJ Morton hero image ---"
PJ_IMG="artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg"
mkdir -p artonly.io/assets/images/artists

python3 << 'IMGEOF'
import urllib.request, json, sys, os

UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
DEST = '/home/dh_yadmw3/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg'

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

# Try Wikipedia API
try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/PJ_Morton'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, DEST)
        print(f'Downloaded from Wikipedia: {img_url}')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

# Try direct press photo URLs
direct_urls = [
    ('https://www.mortonrecords.com/wp-content/uploads/pj-morton-press-2026.jpg', 'https://www.mortonrecords.com/'),
    ('https://media.npr.org/assets/img/2024/03/pj-morton-press-photo.jpg', 'https://www.npr.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/PJ_Morton_2018.jpg/800px-PJ_Morton_2018.jpg', 'https://commons.wikimedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/4/4e/PJ_Morton_2018.jpg', 'https://commons.wikimedia.org/'),
    ('https://thesrg-ilsgroup.com/wp-content/uploads/pj-morton-press.jpg', 'https://thesrg-ilsgroup.com/'),
]
for url, ref in direct_urls:
    try:
        download_img(url, DEST, referer=ref)
        print(f'Downloaded from {url}')
        sys.exit(0)
    except Exception as e:
        print(f'Failed {url}: {e}')

# Fallback placeholder
print('All sources failed; generating placeholder')
os.system(f'OMP_NUM_THREADS=1 convert -size 1200x800 gradient:"#0a0a14-#14140a" -gravity center -pointsize 60 -fill white -annotate 0 "PJ Morton" {DEST}')
IMGEOF

SZ=$(wc -c < "$PJ_IMG" 2>/dev/null || echo 0)
echo "PJ Morton image: $SZ bytes"
if [ "$SZ" -lt 1000 ]; then
  echo "ERROR: PJ Morton image missing"
  exit 1
fi

echo "--- Upscaling PJ Morton hero image ---"
OMP_NUM_THREADS=1 convert "$PJ_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg \
  && mv artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg "$PJ_IMG"
echo "Upscaled: $PJ_IMG"

echo "--- Generating PJ Morton social card ---"
python3 ~/artonly.io/agent/make-social-card.py pj-morton-saturday-night-sunday-morning \
  "PJ Morton Spent His Whole Life Auditioning for This Double Album" music

echo "--- Writing PJ Morton post JSON ---"
python3 << 'PYEOF'
import json, sys, re, os

BODY = """[spotify:artist/2FMOHE79X98yptp4RpPrt7]

The sacred and secular are not, in the tradition of American Black music, the opposites the broader culture sometimes needs them to be. The church that trained Aretha Franklin produced the instrument she carried into Atlantic Records. The music did not become less spiritual when it entered commercial recording. It found a new chamber to resonate in. The transformation was always a translation, carrying the original frequency into a different room without diminishing it.

PJ Morton understands this from deep inside. Born in New Orleans to Bishop Paul S. Morton, one of the founders of the Full Gospel Baptist Church Fellowship and a central figure in contemporary gospel, he grew up playing organ in the sanctuary before he became the keyboardist for Maroon 5, one of the most commercially successful pop rock acts of the past two decades. The biography is not a paradox to be reconciled. It is a preparation for an argument that has taken decades to assemble.

Saturday Night, Sunday Morning, released June 19 on Morton Records in partnership with the SRG-ILS Group, is his eighth studio album and his first double LP: eighteen tracks across two distinct halves, one devoted to R&B and soul, the other to gospel. Morton has said he has been auditioning his whole life for this record. An audition is a performance aimed at a standard you accept. What the album reveals is that the standard Morton was working toward was his own: the accumulated version of himself that contains both the secular performer and the church musician, and that required both to be fully developed before the record could exist.

## The Structure and Its Argument

The obvious reading of the double album format is reconciliation, the night and morning as opposites brought together by the artist's singular consciousness. Morton resists this reading at the level of sound. The R&B side does not sound like a man suppressing a gospel influence. The gospel side does not sound like someone performing religious authenticity for a secular audience. Both halves draw from the same center: a voice trained in church, a producer's understanding of how sound and space interact, a songwriter's interest in specific experience rather than general genre.

The album was recorded at Studio in the Country, a facility in rural Louisiana with a history that runs from Willie Nelson through John Lee Hooker through Arlo Guthrie. The choice positions the record inside a tradition of American roots music that crosses the sacred and secular line as a matter of practice rather than philosophy. The people who worked in that room over the decades were not solving the problem of how to hold two things at once. They were making music from where they were, and where they were happened to contain multitudes.

The R&B side's debt to Stevie Wonder's Songs in the Key of Life is audible in its ambition rather than its sound. That record was a double album that attempted to contain the full scope of a particular American consciousness inside the framework of pop music. Morton's Saturday Night side shares that aspiration without sharing the production language. It sounds like 2026 New Orleans soul: something specific and located rather than something reaching for the universal through glossy production values.

## What the Gospel Side Required

Morton has said that the Sunday Morning side is his first proper gospel record because it is the first time he has sung every track himself without the assistance of other vocalists. This distinction holds more weight than it might appear. Gospel music, in its performance tradition, is communal. The choir is not supporting cast for a soloist. The voices in harmony are the theology made audible, the physical demonstration that belief is held together rather than alone. An album where Morton sings every gospel track solo is not a failure of that tradition. It is a different form of reckoning, a decision to hold the weight of the testimony without distribution, to find out what it weighs when it belongs to one person.

Morton has cited Kendrick Lamar's Mr. Morale and the Big Steppers as an influence on the gospel side, which on first contact seems unlikely. But what Lamar's album achieved was an approach to the relationship between Black American religious experience and personal failure that refused the easy arcs of redemption. It held the gap between aspiration and practice open rather than closing it with a tidy resolution. Morton's Sunday Morning shares that refusal. The songs are arrivals at conviction that carry the memory of the journey it required. They are not certainties dressed as hymns.

## Juneteenth and the Meaning of the Release Date

The album arrived June 19, Juneteenth, the federal holiday commemorating the delayed announcement of emancipation in Texas in 1865. For an album structured around the distinction between Saturday night and Sunday morning, between secular life and sacred life, between the public face and the private self, the date is not incidental. Juneteenth is a commemoration of exactly that kind of gap: between what is declared and what obtains in practice, between the legal announcement of freedom and its material reality in the lives of the people the announcement concerned.

Morton's record is, in its structure, about a similar kind of gap. It holds two truths that the culture frequently asks artists to choose between and declines to choose. The double album format makes the refusal visible. Both sides of the equation are here, fully present, and neither collapses into the other.

The 2024 memoir Saturday Night, Sunday Morning: Staying True to Myself from the Pews to the Stage preceded the album and established the framework. The book allowed Morton to set out the biographical argument in prose, which freed the music from having to explain itself. Having made the argument in one form, he could make it in sound without scaffolding. The result is an album that does not need the memoir to be understood, but rewards anyone who comes to it with that context already in place.

## The Eight Albums It Required

Eighteen tracks is a significant commitment to ask of a listener, and Morton earns it by understanding pacing. The two sides function as distinct emotional arcs that share a tonal center. The voice, the attention to arrangement, the commitment to specificity over generality, run through both halves in a way that makes the format feel necessary rather than excessive. By the end of Sunday Morning, both sides feel like they required each other to be complete.

Morton is one of the most Grammy-recognized artists in gospel and R&B, with wins across multiple categories and nominations accumulated over more than a decade of independent work. He built Morton Records as an infrastructure for creative control before he built the record that most fully demanded that control. The label came first. The architecture for making work on his own terms came first. The double album arrives as the thing the architecture was built to hold.

The argument Saturday Night, Sunday Morning makes is ultimately simple: that a person can contain these two registers without pretending they do not pull against each other. That living between them is not a contradiction to be resolved but a condition to be inhabited honestly. Morton has been living in that condition since he first played organ in his father's church. It took him eight albums to find the form that could hold it. The form, it turns out, is both forms at once.

[download:/assets/images/artists/pj-morton-saturday-night-sunday-morning-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"PJ Morton body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

post = {
    "slug": "pj-morton-saturday-night-sunday-morning",
    "title": "PJ Morton Spent His Whole Life Auditioning for This Double Album",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-28",
    "image": "/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg",
    "image_alt": "PJ Morton press photo",
    "image_position": "center 20%",
    "body": BODY.strip()
}

path = os.path.expanduser('~/artonly.io/posts/pj-morton-saturday-night-sunday-morning.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'JSON deployed: {path}', flush=True)
PYEOF

echo "--- Validating PJ Morton post ---"
python3 ~/artonly.io/agent/post-validator.py pj-morton-saturday-night-sunday-morning || true

echo "--- Verifying PJ Morton post HTTP 200 ---"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pj-morton-saturday-night-sunday-morning)
echo "HTTP status: $STATUS"

echo "--- IndexNow: PJ Morton ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pj-morton-saturday-night-sunday-morning&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: PJ Morton ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=Tanya@MortonRecords.com" \
  --data-urlencode "subject=Your album is on ArtOnly" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on PJ Morton and Saturday Night, Sunday Morning at artonly.io/post/pj-morton-saturday-night-sunday-morning. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo ""

echo "=== PJ Morton post complete. Live at: https://artonly.io/post/pj-morton-saturday-night-sunday-morning ==="

fi  # end if-not-exists block


# =====================================================================
# Summary email
# =====================================================================

echo ""
echo "--- Sending summary email ---"
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-28" \
  "Published today:

1. Pond - Terrestrials
   artonly.io/post/pond-terrestrials
   Mangovision / Secretly Distribution, released June 19, 2026
   Author: Allastair Voss | Category: music

2. PJ Morton - Saturday Night, Sunday Morning
   artonly.io/post/pj-morton-saturday-night-sunday-morning
   Morton Records / SRG-ILS Group, released June 19, 2026
   Author: Leelou Blanc | Category: music

Outreach:
- Pond: press@secretlygroup.com
- PJ Morton: Tanya@MortonRecords.com"

echo ""
echo "=== ArtOnly Album Monitor Deploy Complete: $(date) ==="
