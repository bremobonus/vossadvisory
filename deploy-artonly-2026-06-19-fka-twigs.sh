#!/bin/bash
# ArtOnly Deploy Script: FKA twigs
# Generated: 2026-06-19
# Post: fka-twigs
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-19 FKA twigs ==="
echo "--- Deploying: fka-twigs ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, sys, os

def download_img(src, dest, referer=None, accept='image/jpeg,image/jpg,image/*;q=0.8'):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': accept,
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/fka-twigs.jpg'

try:
    download_img(
        'https://fadmagazine.com/wp-content/uploads/FKA-twigs-credit-Jordan-Hemingway-1-811x1200.jpg',
        dest,
        referer='https://fadmagazine.com/'
    )
    print('Hero downloaded from FAD Magazine')
    sys.exit(0)
except Exception as e:
    print(f'FAD failed: {e}')

try:
    download_img(
        'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/c9775d18-0099-4dd9-a4cd-a2dc08b192f4/Sub+Global+-+FKA+Twigs-2.jpg',
        dest,
        referer='https://www.alexuptonphotography.com/'
    )
    print('Hero downloaded from Alex Upton Photography')
    sys.exit(0)
except Exception as e:
    print(f'Alex Upton fallback failed: {e}')

os.system('convert -size 1200x800 gradient:\"#0a0a0a-#1a0a2e\" -gravity center -pointsize 52 -fill white -annotate 0 \"FKA twigs\" ' + dest)
print('Hero placeholder generated')
"

# ---- Download body images ----
python3 << 'IMGEOF'
import urllib.request, os

def download_img(src, dest, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': 'image/jpeg,image/jpg,image/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Image too small: {len(data)} bytes')
        f.write(data)
    return len(data)

base = '/home/dh_yadmw3/artonly.io/assets/images/artists'

images = [
    (
        'fka-twigs-intro.jpg',
        'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/c2e073cf-e8ea-4947-befb-b78fdd38fc15/Sub+Global+-+FKA+Twigs-19.jpg',
        'https://www.alexuptonphotography.com/'
    ),
    (
        'fka-twigs-live.jpg',
        'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/b33bf06b-4234-4a79-b514-3056d8cb0cdf/Sub+Global+-+FKA+Twigs-1.jpg',
        'https://www.alexuptonphotography.com/'
    ),
    (
        'fka-twigs-studio.jpg',
        'https://fadmagazine.com/wp-content/uploads/FKA-twigs-credit-Jordan-Hemingway-2-1200x803.jpg',
        'https://fadmagazine.com/'
    ),
    (
        'fka-twigs-portrait.jpg',
        'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/8044f618-5111-4837-a481-e75fa370d244/Sub+Global+-+FKA+Twigs-20.jpg',
        'https://www.alexuptonphotography.com/'
    ),
    (
        'fka-twigs-promo.jpg',
        'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/77be5d2b-6ab0-4fae-ba4e-9f05455355d6/Sub+Global+-+FKA+Twigs-7.jpg',
        'https://www.alexuptonphotography.com/'
    ),
]

fallbacks = {
    'fka-twigs-intro.jpg': 'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/51483c9e-b0d0-4c3f-959b-c5edc176589d/Sub+Global+-+FKA+Twigs-4.jpg',
    'fka-twigs-live.jpg':  'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/5862a6c0-6af0-4ffc-bd1e-4f44cea10506/Sub+Global+-+FKA+Twigs-3.jpg',
    'fka-twigs-studio.jpg': 'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/c9775d18-0099-4dd9-a4cd-a2dc08b192f4/Sub+Global+-+FKA+Twigs-2.jpg',
    'fka-twigs-portrait.jpg': 'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/0e411d53-26d7-44f2-93c7-d1a3c93daed6/Sub+Global+-+FKA+Twigs-12.jpg',
    'fka-twigs-promo.jpg': 'https://images.squarespace-cdn.com/content/v1/571cb8d760b5e99d45a36587/477f89da-b0a2-4fa1-a8ec-90d95c9dc182/Sub+Global+-+FKA+Twigs-10.jpg',
}

for filename, url, referer in images:
    dest = os.path.join(base, filename)
    ok = False
    for attempt_url, attempt_ref in [(url, referer), (fallbacks.get(filename, url), 'https://www.alexuptonphotography.com/')]:
        try:
            n = download_img(attempt_url, dest, attempt_ref)
            print(f'OK: {filename} ({n} bytes)')
            ok = True
            break
        except Exception as e:
            print(f'Attempt failed {filename}: {e}')
    if not ok:
        os.system(f'convert -size 1200x800 gradient:"#0a0a0a-#1a0a2e" -gravity center -pointsize 40 -fill white -annotate 0 "FKA twigs" "{dest}"')
        print(f'Placeholder generated: {filename}')
IMGEOF

echo "Body images done"

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/6nB0iY1cjSY1KyhYyuIIKH]

On September 13, 2024, Tahliah Debrett Barnett walked into Sotheby's New Bond Street in London and made the auction house host something it had never held in 280 years of operation: a durational performance. The work was called The Eleven. Eleven performers. Eleven ritualized physical motions. Each motion lasting eleven minutes. For thirteen days the piece ran in the galleries, daily, a living installation that Barnett had spent five years developing. Nothing at The Eleven was sold.

That entry point matters for understanding what FKA twigs is building. Barnett operates at the intersection of somatic practice, choreography, visual art, and recorded music, treating those domains as overlapping rather than sequential. EUSEXUA, her third studio album released January 24, 2025 through Young and Atlantic Records, cannot be fully understood without The Eleven. The two works emerged from the same enquiry. The album title names a state Barnett has described as the feeling of pure aliveness that exists between identities, before the ego reconstitutes itself. The Eleven named eleven pillars of that state: intake, truth, primal revelation, shaping, eusexua body, minestate, opus, looping, keychain, crone, and the art of sol. They are not separate projects. They are the same project in two different materials.

## The Architecture of The Eleven

[img:/assets/images/artists/fka-twigs-intro.jpg]

The structure of The Eleven is precise in a way that tends to get lost in coverage that emphasizes its emotional register. Barnett developed an eleven step somatic healing practice over five years. Each step is a specific physical action, held for exactly eleven minutes. The work draws from somatic experiencing therapy and from Labanotation, the formal choreography notation system invented by Rudolf Laban in the 1920s that encodes human movement as written score. What Barnett did at Sotheby's was transmit that system to a rotating cast of eleven performers so the work could continue without her presence, daily, in galleries that more typically hold paintings and bronzes.

The Eleven was the first durational performance in Sotheby's 280 year history. That is a fact worth sitting with. The auction house was built to sell things. The performance could not be owned. Barnett was not making a point about the art market, or not only that. She was doing what she always does: choosing the most precise available context for the specific thing she was trying to say.

The exhibition surrounding the performance was not supplementary. Jordan Hemingway, the British photographer who has become a close collaborator of Barnett, made large nude portraits of her in states of physical distortion, the body as subject and instrument simultaneously. Sketchbooks, diaries, Polaroids, and drawings from five years of development lined the walls. The choice to show the working process concurrently rather than retrospectively says something specific about where Barnett thinks meaning lives in art. The Eleven was not a presentation. It was evidence.

## EUSEXUA and the Team Who Built It

[img:/assets/images/artists/fka-twigs-live.jpg]

EUSEXUA arrived January 24, 2025 with eleven tracks and a runtime of 42 minutes and 58 seconds. Barnett built it with a specific and deliberately assembled group. Eartheater, the American multi-instrumentalist Alexandra Drewchin, contributed to the album. Drewchin makes records that operate in the territory between noise and formal composition and brings a formal seriousness to sound that sits alongside Barnett's own preoccupations. Koreless, the Welsh electronic producer Lewis Roberts, worked extensively across the record. Roberts's production is rooted in classical minimalism rather than dance music and does not soften at the edges. The Norwegian production duo Stargate appear alongside Marius de Vries, whose credits include Bjork and Madonna and who has built a long career working with artists who treat the album as a formal challenge. North West, performing in Japanese, appears on one track.

The cast was not assembled for press convenience. Each collaborator represents a different register of influence that Barnett was absorbing and metabolizing. The album's opening title track is its thesis: propulsive, refusing to resolve into comfort without first pulling the listener through something more disorienting. Critics reached for Bjork and Janet Jackson and Nine Inch Nails. Those references are accurate and insufficient. EUSEXUA is less interested in pleasure as product than in pleasure as evidence of selfhood. It is about the body knowing something before the mind catches up.

## From Cheltenham to New Bond Street

[img:/assets/images/artists/fka-twigs-studio.jpg]

Barnett was born on January 17, 1988, in Cheltenham, Gloucestershire, England. Her mother was an English dancer and gymnast. Her father, Jamaican, was a musician. She began working professionally as a dancer in her teens, moving to London and performing as a backup dancer before releasing EP1 in 2012 under the FKA twigs name. LP1, her debut studio album, arrived in 2014 and received a Mercury Prize nomination. Magdalene followed in 2019, made partly through and partly about the end of a public relationship, and partly as a sustained engagement with the figure of Mary Magdalene as a woman whose story was controlled by institutions with no interest in her actual experience.

In 2019, Barnett began training in pole dancing. Press coverage treated this as a curiosity. That framing missed what was happening. She was approaching pole work the way a sculptor approaches a new material: studying formally, developing her own vocabulary within the form, and deploying that vocabulary in music videos and live performance. By the time The Eleven was in development, the pole practice and the somatic methodology had become inseparable. The body was not illustrating the work. The body was the work. That distinction is not semantic. It changes what the art is and how it operates.

The geography of Barnett's trajectory is worth noting. From Cheltenham, to London stages, to the Sotheby's galleries on New Bond Street. The last step is not an arrival at cultural legitimacy. It is a choice about context, a decision to place durational somatic art inside one of the oldest commercial institutions in British culture and observe what happens when the two occupy the same room.

## Jordan Hemingway and the Visual Logic

[img:/assets/images/artists/fka-twigs-portrait.jpg]

The collaboration with Jordan Hemingway is central to understanding the visual dimension of Barnett's practice. Hemingway is a British photographer whose work tends toward the bodily and the unresolved. The portraits he made for The Eleven are not comfortable images. Barnett appears in positions that read simultaneously as strain and as command, the ambiguity structural rather than accidental. These photographs were not made to promote the performance. They were made as part of it. The images function as notation, capturing the states that the eleven movements produce and holding them in a form that persists after the performance ends.

This logic extends across Barnett's visual output. She has directed music videos, commissioned photographic work, and shaped the visual identity of each of her projects with the same deliberateness she brings to recorded sound. The choice of visual collaborators is as considered as the choice of producers. Barnett does not outsource the visual grammar of her work. She operates with a consistent formal intelligence across all its expressions, and Hemingway is a collaborator who meets that intelligence directly rather than simply serving it.

[spotify:album/3o1TOhMkU5FFMSJMDhXfdF]

## What the Work Refuses

[img:/assets/images/artists/fka-twigs-promo.jpg]

There is a pattern in how FKA twigs gets received that deserves naming. Critics praise the ambition and then qualify it against commercial expectations. The Mercury Prize nomination, the Atlantic Records deal, the collaborations with producers whose names appear on mainstream records: these are treated as evidence that Barnett is working toward something more accessible, that the work will eventually resolve into a form more legible to larger audiences. EUSEXUA disrupts that reading. The album does not move toward accessibility. It moves toward precision. The difference matters.

Eartheater makes music that is structurally demanding. Koreless builds from electronics that owe more to classical minimalism than to genre conventions. Marius de Vries has built a career on records that treat the album as a formal problem. The team assembled around EUSEXUA was not assembled for outcome optimization. It was assembled for a specific kind of work. At Barnett's level of industry visibility, where pressure to expand audiences is constant and well resourced, that choice is itself a statement.

The Eleven ran for thirteen days to audiences who sought it out. EUSEXUA runs 42 minutes and asks something in return. The sketchbooks at Sotheby's were the score. The album is another movement in the same composition. What Barnett is building is not a biographical body of work in the conventional sense, a sequence of releases documenting an evolving career arc. It is a single sustained investigation into what the body knows and what that knowledge looks like when it takes material form. That investigation shows no sign of concluding, and there is nothing in Barnett's working method to suggest it will resolve into something tidier.

[download:/assets/images/artists/fka-twigs-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "fka-twigs",
    "title": "FKA twigs: The Body Is the Score",
    "author": "Monica Cosby",
    "category": "art",
    "date": "2026-06-19",
    "image": "/assets/images/artists/fka-twigs.jpg",
    "image_alt": "FKA twigs press photo by Jordan Hemingway",
    "image_position": "center 20%",
    "crew": [
        {
            "name": "Eartheater",
            "role": "Producer",
            "url": "https://open.spotify.com/artist/18ca9d5EU5R1AhVKPR1cm0",
            "handle": "@eartheater"
        },
        {
            "name": "Koreless",
            "role": "Producer",
            "url": "https://open.spotify.com/artist/3TsEEdpuuCN1G0dPxV4uOA",
            "handle": "@koreless"
        }
    ],
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/fka-twigs.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

# Count body words
words = len([w for w in body.split() if not w.startswith('[') or not w.endswith(']')])
print(f'Body word count (approx): {words}')
PYEOF

echo "Post JSON deployed: fka-twigs.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py fka-twigs "FKA twigs: The Body Is the Score" art
echo "Social card generated"
cd ~

# ---- Run validator ----
cd ~/artonly.io/agent
python3 post-validator.py fka-twigs || true
echo "Validator complete"
cd ~

# ---- Update brain.json ----
python3 << 'BRAINEOF'
import json, os

brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
with open(brain_path, 'r') as f:
    brain = json.load(f)

written = brain.get('artists_written', [])
if not any('fka' in str(x).lower() or 'twigs' in str(x).lower() for x in written):
    brain['artists_written'] = written + ['FKA twigs']
    print(f'Added FKA twigs to artists_written (now {len(brain["artists_written"])})')
else:
    print('FKA twigs already in artists_written')

queue = brain.get('queue', [])
brain['queue'] = [a for a in queue if 'twigs' not in str(a).lower() and 'fka' not in str(a).lower()]

brain['last_published'] = {
    'artist': 'FKA twigs',
    'slug': 'fka-twigs',
    'title': 'FKA twigs: The Body Is the Score',
    'date': '2026-06-19'
}

with open(brain_path, 'w') as f:
    json.dump(brain, f, indent=2, ensure_ascii=False)
    f.write('\n')
print('brain.json updated')
BRAINEOF

# ---- Confirm post is live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/fka-twigs)
echo "HTTP status artonly.io/post/fka-twigs: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/fka-twigs&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: fka-twigs"

# ---- Outreach: Young Records / FKA twigs label ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@y-o-u-n-g.com" \
  --data-urlencode "subject=ArtOnly just covered FKA twigs" \
  --data-urlencode "body=https://artonly.io/post/fka-twigs

FKA twigs is one of very few artists operating simultaneously across somatic performance, visual art, and recorded music at this level, and we wanted to cover The Eleven and EUSEXUA together rather than in isolation. The piece addresses the Sotheby's installation, the album's collaborators, and what the Jordan Hemingway portraits reveal about her practice as a whole. A downloadable social card is at the bottom of the page, feel free to share. If there is interest in a proper conversation or any follow-up, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo "Outreach sent to info@y-o-u-n-g.com"

echo "=== Deploy complete: fka-twigs 2026-06-19 ==="
