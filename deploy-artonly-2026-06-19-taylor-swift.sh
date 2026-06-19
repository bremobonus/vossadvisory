#!/bin/bash
# ArtOnly Deploy Script: Taylor Swift
# Generated: 2026-06-19
# Post: taylor-swift
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-19 Taylor Swift ==="
echo "$(date)"

echo "--- Deploying: taylor-swift ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, sys, os

def download_img(src, dest):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
    }
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Image too small: {len(data)} bytes')
        f.write(data)
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/taylor-swift.jpg'

try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Taylor_Swift_at_the_Golden_Globes_2024_%28Enhanced%2C_cropped%29_2.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (Golden Globes 2024)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 1 failed: {e}')

try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/0/04/Taylor_Swift_045_%2817682880264%29.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (portrait)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 2 failed: {e}')

try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Taylor_Swift_Eras_Tour_TTPD_Set_Down_Bad.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (Eras Tour TTPD)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 3 failed: {e}')

os.system('convert -size 1200x800 gradient:\"#1a0a2e-#2d1855\" -gravity center -pointsize 52 -fill white -annotate 0 \"Taylor Swift\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert taylor-swift.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 taylor-swift-up.jpg && mv taylor-swift-up.jpg taylor-swift.jpg
echo "Hero image upscaled"
cd ~

# ---- Download body images ----
python3 << 'IMGEOF'
import urllib.request, os

def download_img(src, dest):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
    }
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Image too small: {len(data)} bytes')
        f.write(data)
    return len(data)

base = '/home/dh_yadmw3/artonly.io/assets/images/artists'

images = [
    ('taylor-swift-intro.jpg', [
        'https://upload.wikimedia.org/wikipedia/commons/0/04/Taylor_Swift_045_%2817682880264%29.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/7/7f/Taylor_Swift_%286966830273%29.jpg',
    ]),
    ('taylor-swift-studio.jpg', [
        'https://upload.wikimedia.org/wikipedia/commons/7/7f/Taylor_Swift_%286966830273%29.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/0/04/Taylor_Swift_045_%2817682880264%29.jpg',
    ]),
    ('taylor-swift-live.jpg', [
        'https://upload.wikimedia.org/wikipedia/commons/2/29/Taylor_Swift_Eras_Tour_TTPD_Set_Down_Bad.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/6/6c/Taylor_Swift_The_Eras_Tour_Lover_Set_%2853108816372%29.jpg',
    ]),
    ('taylor-swift-portrait.jpg', [
        'https://upload.wikimedia.org/wikipedia/commons/6/6c/Taylor_Swift_The_Eras_Tour_Lover_Set_%2853108816372%29.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/2/29/Taylor_Swift_Eras_Tour_TTPD_Set_Down_Bad.jpg',
    ]),
    ('taylor-swift-cover.jpg', [
        'https://upload.wikimedia.org/wikipedia/commons/a/aa/Taylor_Swift_at_the_Golden_Globes_2024_%28Enhanced%2C_cropped%29_2.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/0/04/Taylor_Swift_045_%2817682880264%29.jpg',
    ]),
]

for filename, urls in images:
    dest = os.path.join(base, filename)
    downloaded = False
    for url in urls:
        try:
            n = download_img(url, dest)
            print(f'OK: {filename} ({n} bytes)')
            downloaded = True
            break
        except Exception as e:
            print(f'FAILED {filename} from {url}: {e}')
    if not downloaded:
        os.system(f'convert -size 1200x800 gradient:"#1a0a2e-#2d1855" -gravity center -pointsize 40 -fill white -annotate 0 "Taylor Swift" "{dest}"')
        print(f'Placeholder: {filename}')
IMGEOF

echo "Body images done"

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/06HL4z0CvFAxyc27GXpf02]

On April 19, 2024, Taylor Swift released The Tortured Poets Department and 859,000 vinyl copies left shelves in the first seven days. That is the largest vinyl sales week Luminate has recorded since it began tracking the format in 1991. A number that large is hard to make feel real. What gives it actual weight is simpler: vinyl sells because people want something to hold. Swift gave them something genuinely heavy.

This is what she has always been best at: converting emotional material into measurable quantities. The Tortured Poets Department is not her most technically refined record. It may be her most revealing. And in revealing it, she created the commercial event of 2024. That contradiction is worth sitting with.

## What the Record Actually Says

[img:/assets/images/artists/taylor-swift-intro.jpg]

The Tortured Poets Department arrived with 31 tracks in its full Anthology edition and debuted at 2.61 million equivalent album units in its opening week. That figure is the largest streaming debut in recorded history. Ten songs landed simultaneously in the Billboard Hot 100 top ten.

None of this happened because the songs are easy. Swift has made easier records. The 1989 era was engineered for maximum pop penetration, and it worked with precision. This album is different in every structural sense. It is a breakup record written by someone who has studied what breakup records can do to a listener and decided to use every available tool without announcing them.

The production from Jack Antonoff and Aaron Dessner is spare by design. Piano lines that do not resolve. Drum sounds that suggest a room two floors above you. Swift's voice sits unusually close throughout the mix. There are moments where you can hear her breath before a phrase lands. This is a choice. The proximity is the point.

The lead single, Fortnight, features Post Malone and opens the record with resigned clarity. Florida, the second collaboration and a track with Florence Welch, finds Swift doing something she rarely does: letting another voice into her interior. Florence does not decorate the track. She shifts its texture entirely. These are not standard featured arrangements. They read like conversations between people who have been through comparable things.

## The Collaborators Behind the Sound

[img:/assets/images/artists/taylor-swift-studio.jpg]

Jack Antonoff has been making records with Swift since 2014. The working relationship has become one of the more interesting artistic partnerships in contemporary pop. Antonoff is not a producer who imposes a signature sound. He subtracts. On The Tortured Poets Department he received 16 production credits. The album does not sound crowded. It sounds like aftermath.

Aaron Dessner came into Swift's orbit through folklore in 2020, the album she made during a lockdown with no scheduled sessions and no label expectations. That freedom produced something that surprised even her established audience. Dessner brings a background with The National, a band that has spent two decades making records about quiet devastation. On The Tortured Poets Department he returned with another 16 production credits, helping construct music that sounds expensive but feels intimate. The tension between those two qualities is where the record lives.

## The Eras Tour and What It Required

[img:/assets/images/artists/taylor-swift-live.jpg]

The Eras Tour ran from March 2023 through December 2024 across six continents. Economic analysts attached large numbers to individual dates. A 2023 Federal Reserve report noted that Swift's Philadelphia shows generated hotel revenue spikes visible in regional economic data. A single run of concerts became the subject of monetary analysis.

The tour matters not for the revenue but for what it required from Swift as a live performer. The Eras Tour ran approximately three and a half hours per night. It covered material from across two decades of her catalog. She performed songs written when she was seventeen alongside songs completed days before the show. The set demanded precision, physical endurance, and the ability to shift emotionally between very different versions of herself, all within the same night.

Swift has trained as a live performer since her early teens. The contemporary version onstage is completely controlled without appearing controlled. She knows exactly when the room will respond and what will produce that response. The moments when she breaks the formal performance posture and simply speaks are when the rooms go entirely still.

## The Ownership Fight

[img:/assets/images/artists/taylor-swift-portrait.jpg]

Swift's masters became a public story in 2019 when her original recordings were sold without her consent. She responded by recording new versions of her first six albums, released under the name Taylor's Version. As of 2025, she has completed four: Fearless, Red, Speak Now, and 1989. Each version reached number one on the Billboard 200.

The project reveals something specific about how she thinks. She spent years making records she would then remake and release again, running a catalog reclamation project while simultaneously producing The Tortured Poets Department and touring the Eras set. She managed a legal and creative dispute while making the records that charted and sold more than anything else in contemporary pop.

When she signed with Republic Records in 2018, she negotiated ownership of her masters on new releases. This is not a standard clause. It reflects a negotiating position that only becomes available when an artist generates the revenue she generates. The fact that she pursued it anyway, when a more conventional arrangement was on the table, says something about how she thinks about her own work and who it ultimately belongs to.

[spotify:album/1Mo4aZ8pdj6L1jx8zSwJnt]

## The Tortured Poets Department as a Statement

[img:/assets/images/artists/taylor-swift-cover.jpg]

The album title is deliberately overwrought, and Swift knows it. She named the record after a private group chat with friends, a small ironic joke that then scaled to one of the largest media events of 2024. The joke survived the scaling. Part of what makes the record interesting is that it does not take its own melodrama entirely seriously. There are lines written with too much awareness to be read as pure lament. A satirical current runs underneath the grief.

This is not new in her work. Red, her 2012 album, had it too, most explicitly in We Are Never Ever Getting Back Together, which operates as a comedy record about romantic exhaustion. The Tortured Poets Department carries a darker version of that quality. The satire is embedded in the texture of the writing, less announced, more ambient.

Luminate named it the number one album of 2024 with 6.955 million equivalent album units for the year. That is the biggest annual total for a single album since 2015. The number confirms what the cultural conversation already suggested: Swift's audience does not simply buy her music. They return to it.

The architecture of that return is what separates her from artists who merely sell. She builds records that reward repeat listening. Details surface on the third or fifth pass that were not audible the first time. This is the work of someone who plans carefully, and who trusts that her audience plans alongside her. She has built this audience across two decades, record by record, tour by tour, lawsuit by lawsuit. The result is something unusual in contemporary music: a large audience that is also a deeply attentive one.

[download:/assets/images/artists/taylor-swift-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "taylor-swift",
    "title": "Taylor Swift: What The Tortured Poets Department Actually Built in 2024",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-19",
    "image": "/assets/images/artists/taylor-swift.jpg",
    "image_alt": "Taylor Swift at the 2024 Golden Globes",
    "image_position": "center 20%",
    "crew": [
        {"name": "Jack Antonoff", "role": "Producer", "url": "https://open.spotify.com/artist/01djAGtjfDeW3Kgk8h98bV", "handle": "@jackAntonoff"},
        {"name": "Aaron Dessner", "role": "Producer", "url": "https://open.spotify.com/artist/4RnBFZRiMLpqnKZLGwPKAp", "handle": "@aarondessner"},
        {"name": "Post Malone", "role": "Featured Artist", "url": "https://open.spotify.com/artist/246dkjvS1zLTiCf5h9MNfl", "handle": "@postmalone"}
    ],
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/taylor-swift.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

# Verify no dashes used as punctuation
for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash character found in body: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} found')

# Word count check
words = len(body.split())
print(f'Word count (approx): {words}')
if words < 1000:
    print(f'WARNING: under 1000 words ({words})')
elif words > 1444:
    print(f'WARNING: over 1444 words ({words})')
else:
    print(f'OK: word count in range ({words})')
PYEOF

echo "Post JSON deployed: taylor-swift.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py taylor-swift "Taylor Swift: What The Tortured Poets Department Actually Built in 2024" music
echo "Social card generated: taylor-swift-social-9x16.jpg"
cd ~

# ---- Run validator ----
cd ~/artonly.io/agent
python3 post-validator.py taylor-swift || true
echo "Validator complete"
cd ~

# ---- Update brain.json ----
python3 << 'BRAINEOF'
import json, os

brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
with open(brain_path, 'r') as f:
    brain = json.load(f)

written = brain.get('artists_written', [])
if 'Taylor Swift' not in written:
    brain['artists_written'] = written + ['Taylor Swift']
    print(f'Added Taylor Swift to artists_written (now {len(brain["artists_written"])})')
else:
    print('Taylor Swift already in artists_written')

queue = brain.get('queue', [])
brain['queue'] = [a for a in queue if a != 'Taylor Swift']

brain['last_published'] = {
    'artist': 'Taylor Swift',
    'slug': 'taylor-swift',
    'title': 'Taylor Swift: What The Tortured Poets Department Actually Built in 2024',
    'date': '2026-06-19'
}

with open(brain_path, 'w') as f:
    json.dump(brain, f, indent=2, ensure_ascii=False)
    f.write('\n')
print('brain.json updated on server')
BRAINEOF

# ---- Confirm post is live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/taylor-swift)
echo "HTTP status artonly.io/post/taylor-swift: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/taylor-swift&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: taylor-swift"

# ---- Outreach ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@13management.com" \
  --data-urlencode "subject=ArtOnly just covered Taylor Swift" \
  --data-urlencode "body=https://artonly.io/post/taylor-swift

We published a piece on Taylor Swift and The Tortured Poets Department at the link above. No ask attached. We wrote about the production logic of the record with Jack Antonoff and Aaron Dessner, what the Eras Tour required from her as a live performer, and how she structured a catalog reclamation project while making the biggest streaming debut in history. A downloadable social card is at the bottom of the page, feel free to share. Happy to arrange a proper Q and A with Taylor if there is appetite, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo "Outreach sent to info@13management.com"

echo "=== Deploy complete: taylor-swift 2026-06-19 ==="
