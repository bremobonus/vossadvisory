#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-14
# Posts: kelsey-lu-so-help-me-god, wiki-ancient-history
# Releases: Kelsey Lu - So Help Me God (Jun 12, Dirty Hit), Wiki - Ancient History (Jun 12, Wikset Enterprise)
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-14 ==="

# ---- POST 1: Kelsey Lu - So Help Me God ----
echo "--- Deploying: kelsey-lu-so-help-me-god ---"

python3 -c "
import urllib.request, re, sys, os

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/kelsey-lu-so-help-me-god.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/kelsey-lu-so-help-me-god/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://stereogum.com/2492624/kelsey-lu-announces-new-album-so-help-me-god-hear-running-to-pain/music')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'kelsey' in i.lower() or 'lu' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+stereogum[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://www.nme.com/reviews/album/kelsey-lu-so-help-me-god-review-3950193')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+nme\.com[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

try:
    html = fetch('https://ourculturemag.com/2026/06/12/album-review-kelsey-lu-so-help-me-god/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'kelsey' in i.lower() or 'lu' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+ourculturemag[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ourculturemag.com/')
        print('Downloaded from Our Culture')
        sys.exit(0)
except Exception as e:
    print(f'Our Culture failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#1a0d2e-#2d1a4a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Kelsey Lu\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/kelsey-lu-so-help-me-god.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/kelsey-lu-so-help-me-god-up.jpg && \
  mv ~/artonly.io/assets/images/artists/kelsey-lu-so-help-me-god-up.jpg \
     ~/artonly.io/assets/images/artists/kelsey-lu-so-help-me-god.jpg
echo "Image upscaled: kelsey-lu-so-help-me-god.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py kelsey-lu-so-help-me-god "Kelsey Lu Held Nothing Back on the Album She Spent Seven Years Becoming" music
echo "Social card generated: kelsey-lu-so-help-me-god-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/0fEfMW5bypHZ0A8eLnhwj5]

Seven years is a particular kind of interval. It is long enough that an artist's debut has acquired the residue of expectation, has been absorbed and catalogued, has been held up as evidence of what they might eventually become. Blood, Kelsey Lu's debut album released in 2019, was an extraordinary first statement: a cellist raised in a strict Jehovah's Witness household in Charlotte, North Carolina, who had left her religion at eighteen to study at the North Carolina School of the Arts and eventually arrived in New York and then Los Angeles as a collaborator of Solange, Blood Orange, and Lady Gaga, making a record that fused disco, R&B, and chamber music into something that resisted easy categorization while making its emotional intentions completely clear. Blood was the announcement. So Help Me God, released June 12 on Dirty Hit, is the proof.

Lu describes the album as an act of self-possession, language that earns its weight when you understand what preceded it. The seven years between records were not inactivity. They were years of grief, spiritual questioning, and the slow work of rebuilding after loss, which is different from the public kind of loss that registers in news cycles and is visible to audiences. Lu processed something private with a thoroughness that resulted in a record that does not declare its costs but demonstrates them. The difference matters. Declarations are easy. Demonstrations require that the artist has lived inside the material long enough to understand it from the inside.

What makes So Help Me God unusual in the contemporary landscape is not its ambition, though the ambition is considerable, but its honesty about what ambition requires. The album features Sampha, Kamasi Washington, and Kim Gordon. These three names, placed together and connected to the same record, tell you something about the range of the vision. Sampha, whose own work in the space between piano ballads and electronic production has made him one of the most emotionally precise artists working in British music. Kamasi Washington, whose saxophone playing operates in the tradition of spiritual jazz while remaining entirely of the present. Kim Gordon, whose voice and presence carries the confrontational clarity of No Wave and the institutional memory of what noise music could insist on. The fact that all three found something to contribute here is evidence of what the record contains: not genre, but feeling wide enough to accommodate all of them.

## The Cello Underneath Everything

Kelsey Lu trained as a classical cellist before she became a recording artist, and the cello informs So Help Me God in ways that are not always explicit but are always present. Classical training at the level Lu received produces a particular relationship to tension and resolution, to the way music moves through discomfort toward something that is not quite comfort but is more honest than comfort. The album's arrangements move between devotional intensity and cinematic scale, and this is a description of how a well-written piece for strings actually works: you are always aware of the architecture even when what you are experiencing feels like pure atmosphere.

The distorted guitars and choral swells that appear throughout the album are not departures from Lu's classical inheritance but applications of it. The choirs that appear in church and in the concert hall are the same institution. The distortion that runs through certain tracks carries the same function as dissonance in a late-period string quartet: it is not chaos, it is controlled instability, the sound of a structure under deliberate stress to show you what it is made of. Jazz-infused melodies and dark electronic pulses complete the picture, and none of these elements feel imported. They feel native to the emotional logic of the record.

## The Collaborators and What They Signal

Sampha's presence on the album asks something of the listener who knows his work. He is not a collaborator who dissolves into the context of other artists' records. He has too specific a sensibility for that. His contribution here speaks to what the album required: something emotionally articulate in a way that goes beyond what any single instrument or voice could achieve alone. Kamasi Washington's saxophone has always carried a quality that is not metaphor but literal aspiration, music reaching toward something it cannot quite name, which is exactly what So Help Me God is doing for its entire running length. And Kim Gordon's presence is the record's most unexpected gesture: a figure who built her career on the insight that vulnerability and confrontation are the same act, contributing to an album built on exactly that premise.

This is not a record that collected distinguished names to establish credibility. It is a record that required specific collaborators because the material it was navigating demanded people who understood the stakes.

## What Seven Years Produced

So Help Me God is, in the most direct sense, a cathartic record about surviving loss and arriving at something approaching resolution. But what it does that most records of this kind do not is earn that resolution. Most albums about grief reach their conclusions too quickly, before the listener fully believes that the processing they claim to document has actually occurred. Lu's seven-year interval is the evidence that the work was done before the album was made. The conclusions in So Help Me God do not feel performed. They feel arrived at, slowly, through genuine reckoning.

The tracklist moves from Reaper through Portrait Of A Lady On Fire, Running To Pain, Comfort, American Sonnet, and Only The Lonely to Cutting Off The Head Of A Ghost, and that final title is the clearest statement of the album's direction. You cannot move forward while still being haunted by something you have not looked at directly. The album insists on looking directly. The seven years of relative silence were the looking. So Help Me God is what she saw and what she made from it.

To say the album was worth the wait is too simple. The album is what it is not despite the silence but because of it. Some records require more time to become than a release schedule allows. This one required exactly what it took.

[download:/assets/images/artists/kelsey-lu-so-help-me-god-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "kelsey-lu-so-help-me-god",
    "title": "Kelsey Lu Held Nothing Back on the Album She Spent Seven Years Becoming",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-14",
    "image": "/assets/images/artists/kelsey-lu-so-help-me-god.jpg",
    "image_alt": "Kelsey Lu press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/kelsey-lu-so-help-me-god.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: kelsey-lu-so-help-me-god.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/kelsey-lu-so-help-me-god)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/kelsey-lu-so-help-me-god&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: kelsey-lu-so-help-me-god"


# ---- POST 2: Wiki - Ancient History ----
echo "--- Deploying: wiki-ancient-history ---"

python3 -c "
import urllib.request, re, sys, os

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/wiki-ancient-history.jpg'

try:
    html = fetch('https://stereogum.com/2501203/album-of-the-week-wiki-ancient-history/reviews/album-of-the-week')
    imgs = re.findall(r'(https?://media\.stereogum\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+wiki[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum AOTW')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://www.brooklynvegan.com/wiki-announces-new-lp-ancient-history-ft-your-old-droog-duendita-more-shares-park/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'wiki' in i.lower() or 'ancient' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+brooklynvegan[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.brooklynvegan.com/')
        print('Downloaded from Brooklyn Vegan')
        sys.exit(0)
except Exception as e:
    print(f'Brooklyn Vegan failed: {e}')

try:
    html = fetch('https://floodmagazine.com/223063/listen-wiki-park/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'wiki' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+floodmagazine[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://floodmagazine.com/')
        print('Downloaded from Flood Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Flood failed: {e}')

try:
    html = fetch('https://pitchfork.com/artists/27440-wiki/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#0a0a14-#141414\" -gravity center -pointsize 52 -fill white -annotate 0 \"Wiki\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/wiki-ancient-history.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/wiki-ancient-history-up.jpg && \
  mv ~/artonly.io/assets/images/artists/wiki-ancient-history-up.jpg \
     ~/artonly.io/assets/images/artists/wiki-ancient-history.jpg
echo "Image upscaled: wiki-ancient-history.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py wiki-ancient-history "Wiki Made His Most Focused Album in Seven Years and Called It Ancient History" music
echo "Social card generated: wiki-ancient-history-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/78X7quh8fqAGZ42OpLmUW0]

Ancient History is the kind of album that requires context to appreciate fully, though once that context is in place, the record opens in a way that purely formal criticism cannot account for. Wiki, whose real name is Jason Brickman, co-founded Ratking in New York City in the early 2010s alongside P on the Keys and Hak Miller, making music that was so specifically and insistently local, so rooted in a particular set of streets and a particular sensibility of downtown New York, that critics who encountered it often described it with a mixture of admiration and bewilderment. The bewilderment was the evidence of how original the work was. Ratking did not fit any category that existed at the time. They had to be argued into relevance. The argument was correct and they are now understood, at more than a decade's remove, as one of the defining New York rap acts of their moment.

After Ratking dissolved in 2016, Wiki pursued a solo career that produced several projects, with Oofie in 2019 standing as his most complete individual statement before this year. That album, produced entirely by Navy Blue, was a record about intimacy and loss, about the particular texture of life in New York as it was being reshaped by forces that were making the city increasingly inhospitable to the people and the culture that had made it worth inhabiting. Ancient History, released June 12 on his own Wikset Enterprise imprint, covers related ground but from a different vantage point. It has been seven years. The city has changed. The record knows this, and it does not perform nostalgia about it.

## The Parks as Method

The conceptual anchor of Ancient History is place in a very specific sense. Wiki has described the album as rooted in the New York City parks he has spent the last several years returning to most: not as symbols, not as scenery, but as part of the ordinary structure of daily life. Places to meet people. Places to write and think. Places to step briefly outside the pace of the city without actually leaving it. This distinction is subtle and becomes musically significant. Park as symbol or concept is something that has appeared in music before. Park as actual recurring location, as the place where particular conversations happened and particular feelings arrived, is more interesting and considerably harder to put into a record.

Park, the lead single, operates exactly in this territory. It is not an ode. It is a documentation. Wiki's voice carries the quality it has always had: unhurried, particular, committed to the specific over the general, capable of making a listener feel that what they are hearing happened at a specific moment in a specific place and that this particularity is not limiting but is precisely the argument. The record as a whole has this quality. The parks of Ancient History are not metaphors for anything. They are locations. The record is their record, and the people Wiki encountered in them are its population.

## The Production Coalition

What makes Ancient History something beyond a compelling personal statement is the production roster, which reads like a document of who matters in New York underground rap's present and recent past. The Alchemist, whose ear for samples and whose understanding of how jazz and soul fragments can be reconstituted into something that carries the weight of the original while being entirely new, brings to his contributions a gravity that grounds the more intimate content in tradition. Navy Blue, who produced all of Oofie and appears here on a single track, demonstrates by contrast how much Wiki's sound can shift depending on the collaborator while remaining recognizably his own.

MIKE, appearing under his dj blackpower alias, and Nick Hakim, operating as Dom Maker, bring a more experimental quality to their respective contributions. MIKE's production has always existed at the intersection of noise and intimacy, making music that feels provisional in a way that reveals rather than conceals. Hakim, whose solo work occupies a space between soul and experimental pop, brings something that resists the categories of hip-hop production and enriches the record because of that resistance. The result is an album where the sonic variety is held together not by a unified production aesthetic but by the consistency of Wiki's perspective. He is the constant. The producers are the different angles from which the constant is examined.

Features from Your Old Droog and duendita occupy their positions carefully. Your Old Droog's literary precision complements Wiki's observational approach without overwhelming it. duendita, whose own work has made her one of the more distinctive voices in New York's experimental music underground, brings a register that the record reaches for and achieves.

## The Solo Question

Something happens to an artist when they make a record entirely on their own terms, without the structure of a collective or the support of a major label apparatus. The autonomy carries a weight that institutional context tends to distribute and therefore relieve. Ancient History is released on Wikset Enterprise, Wiki's own imprint, which means no filter between what he wanted to make and what was made. The record sounds like this. It does not sound like an album negotiated into existence. It sounds like an album that could only have been made by one person who knew what they needed to say and took the time to figure out how to say it.

The seven-year gap between Oofie and Ancient History is not a concern but a feature. Wiki was not absent from music during those years. He was present in the city, in the parks, in the ongoing conversation about what New York is and what it costs and who it is still for. The album is what that sustained presence produced when it was finally compressed into a studio and a tracklist. What it describes as ancient was not ancient at all. It was happening the entire time. It is still happening. New York does not become the past. It becomes the present again, and you have to stay with it or be left by it. Wiki, on the evidence of Ancient History, stayed. The record is what that choice made.

[download:/assets/images/artists/wiki-ancient-history-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "wiki-ancient-history",
    "title": "Wiki Made His Most Focused Album in Seven Years and Called It Ancient History",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-14",
    "image": "/assets/images/artists/wiki-ancient-history.jpg",
    "image_alt": "Wiki press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/wiki-ancient-history.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: wiki-ancient-history.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/wiki-ancient-history)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/wiki-ancient-history&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: wiki-ancient-history"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@dirtyhit.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Kelsey Lu and So Help Me God at artonly.io/post/kelsey-lu-so-help-me-god. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@dirtyhit.com (Kelsey Lu)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=wiksetnyc@gmail.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Wiki and Ancient History at artonly.io/post/wiki-ancient-history. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: wiksetnyc@gmail.com (Wiki)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-14" "Published today:

1. Kelsey Lu - So Help Me God
   https://artonly.io/post/kelsey-lu-so-help-me-god
   Author: Leelou Blanc
   Spotify: 0fEfMW5bypHZ0A8eLnhwj5
   Released: June 12, 2026 (Dirty Hit)
   Second album, 7-year gap since Blood (2019). Features Sampha, Kamasi Washington, Kim Gordon.
   Themes: grief, spiritual questioning, self-possession, rebuilding after loss.

2. Wiki - Ancient History
   https://artonly.io/post/wiki-ancient-history
   Author: Allastair Voss
   Spotify: 78X7quh8fqAGZ42OpLmUW0
   Released: June 12, 2026 (Wikset Enterprise, self-released)
   First solo LP in 7 years since Oofie (2019). Produced by Alchemist, Navy Blue, MIKE (dj blackpower), Nick Hakim (Dom Maker).
   Features: Your Old Droog, duendita. NYC parks as conceptual anchor.

Outreach:
- Kelsey Lu: email sent to press@dirtyhit.com (Dirty Hit label)
- Wiki: email sent to wiksetnyc@gmail.com (best available contact, self-released)

Both releases from June 12, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-14 ==="
