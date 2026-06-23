#!/bin/bash
# ArtOnly: June McDoom - culture article - 2026-06-23
# Author pen name: Abel Blackburn | Category: culture
# Run via GitHub Actions (deploy-artonly.yml)
set -e
cd /home/dh_yadmw3

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"

echo "=== Step 1: Download images ==="
mkdir -p artonly.io/assets/images/artists

python3 << 'PYEOF'
import os, urllib.request, json

def dl(url, dest, referer=''):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
    }
    if referer:
        headers['Referer'] = referer
    for attempt in range(3):
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=30) as r:
                data = r.read()
            if len(data) > 5000:
                with open(dest, 'wb') as f:
                    f.write(data)
                print(f"  OK {dest} ({len(data)//1024}KB)", flush=True)
                return True
            else:
                print(f"  Too small ({len(data)} bytes) attempt {attempt+1}", flush=True)
        except Exception as e:
            print(f"  Attempt {attempt+1} failed: {e}", flush=True)
    print(f"  FAILED: {url}", flush=True)
    return False

base = 'artonly.io/assets/images/artists/'
imgs = {
    'june-mcdoom.jpg':         ('https://i0.wp.com/higherplainmusic.com/wp-content/uploads/2022/08/june-mcdoom.jpg', ''),
    'june-mcdoom-intro.jpg':   ('https://i1.wp.com/femmusic.s3.us-west-1.amazonaws.com/wp-content/uploads/2024/04/IMG_0073-1024x683.jpg', 'https://femmusic.com/'),
    'june-mcdoom-strings.jpg': ('https://i2.wp.com/femmusic.s3.us-west-1.amazonaws.com/wp-content/uploads/2024/04/IMG_0124-1024x683.jpg', 'https://femmusic.com/'),
    'june-mcdoom-live.jpg':    ('https://i0.wp.com/femmusic.s3.us-west-1.amazonaws.com/wp-content/uploads/2024/04/IMG_0100-1024x683.jpg', 'https://femmusic.com/'),
    'june-mcdoom-cover.jpg':   ('https://i0.wp.com/femmusic.s3.us-west-1.amazonaws.com/wp-content/uploads/2024/04/IMG_0038-683x1024.jpg', 'https://femmusic.com/'),
}

results = {}
for filename, (url, referer) in imgs.items():
    results[filename] = dl(url, base + filename, referer)

with open('/tmp/june_img_results.json', 'w') as f:
    json.dump(results, f)
print("Download results:", results, flush=True)
PYEOF

echo "=== Step 2: Publish article ==="
python3 << 'PYEOF'
import json, os, urllib.request, sys, re

results = json.load(open('/tmp/june_img_results.json'))
base = 'artonly.io/assets/images/artists/'

def has(name):
    p = base + name
    return results.get(name, False) and os.path.exists(p) and os.path.getsize(p) > 5000

def img(name):
    if has(name):
        return f'\n[img:/assets/images/artists/{name}]\n'
    return ''

body = f"""[spotify:artist/01dkMVgxs4d9pNMIOgyXVV]

There is a particular kind of patience required to pursue an art form that was not built with you in mind. June McDoom grew up in a Jamaican household in South Florida, where reggae filled every room and shaped her earliest sense of what music could be. She went on to study jazz performance in New York City. And somewhere in between, she fell in love with folk music, a tradition that has spent most of its popular history narrowly imagining who belongs inside it.

That tension is not incidental to her work. It is the engine of it. McDoom is a singer and songwriter building a catalog that brings together the reggae of her childhood, the harmonic vocabulary of jazz, and the confessional directness of 1960s and 1970s American folk. The result is a sound that cannot be fully explained by any single one of those traditions. That is precisely the point.
{img("june-mcdoom-intro.jpg")}
## The Household That Reggae Built

McDoom has spoken openly about growing up surrounded by reggae. It was not music she sought out. It was the air of the household. Artists like Alton Ellis and Dennis Brown moved through her home the way some children grow up hearing gospel or country or soul, not as a choice but as a given, something absorbed before a person is old enough to have opinions about what they like.

That inheritance matters because it created something folk music on its own rarely provides: a model of music that treats emotion as something to sustain rather than rush, that values patience and groove as artistic virtues in their own right. When McDoom later discovered the folk songwriters she would come to love, she was not trading one set of values for another. She was finding new language for feelings she already understood.

The folk artists who captured her attention were working in the most interior registers. Bobbie Gentry, Joan Baez, Jessica Pratt. Writers for whom a song was a small sealed world, complete on its own terms. McDoom recognized something in that quality. A song you could carry with you because it cost the person who made it something real, something that could not be performed or approximated.

## The Jazz Education

When she arrived in New York to study jazz performance, she was not abandoning folk. She was learning to hear it differently.

Jazz taught her about space. About what happens between notes and underneath melodies. About the way a chord can hold complexity without resolving immediately, and about the discipline required to stay inside that unresolved moment rather than rushing past it. For a songwriter already drawn to folk music for its intimacy and restraint, this was not a departure from her instincts. It was a deepening of them.

She names Dionne Warwick and Nina Simone alongside Bobbie Gentry as formative influences. These are not artists who stayed in one lane. They moved through American popular music with a fluency that crossed every genre line they encountered, and they did it without asking permission from the people who might have told them they were in the wrong room.
{img("june-mcdoom-strings.jpg")}
## Stepping Forward While Stepping Back

McDoom describes her artistic approach with a phrase that sounds simple but holds a great deal inside it: stepping forward while stepping back.

It is partly about aesthetics. Her recordings favor analog warmth, acoustic space, and a sense of time moving slowly. Her collaboration with producer Evan Wright, conducted at their shared studio in Greenpoint, Brooklyn, has consistently prioritized texture over volume and feeling over effect. The EP "With Strings," released on Temporary Residence in November 2023, takes that philosophy further than anything she had done before.

The project strips her songs back to their essentials and then rebuilds them with string arrangements by Sammy Weissberg, adding violin, viola, cello, harp, and upright bass. The effect is not grandeur. It is intimacy at scale. The strings do not overwhelm the voice. They surround it. The collaborators she brought in, including vocalist Cecile McLorin Salvant and singer Kate Davis, were chosen for the way they listen as much as the way they sing. Three part harmony, in the right hands, is a form of conversation between voices that reach agreement without any one of them giving way entirely.

The phrase also carries a cultural dimension. Stepping forward into folk, a tradition shaped largely by white American experiences of displacement and longing. Stepping back into her own history, into the Jamaican household and the reggae rhythms and the jazz education. Refusing to leave any of that at the door when she arrives at the microphone.
{img("june-mcdoom-live.jpg")}
## The Argument Her Music Makes Without Words

There is a tendency to talk about representation in music as though the solution is simply adding more names to a list. But what McDoom is doing is more fundamental than that. She is not asking folk music to make room for her. She is making room inside the music itself.

When she covers "Black Is the Color of My True Love's Hair," a traditional Appalachian song with centuries of history behind it, she is not correcting the tradition. She is inhabiting it fully, bringing everything she carries with her, and in doing so she expands what the song can mean and who it can speak to. That is not a political act in the narrow sense. It is something closer to a cultural argument made entirely through sound.

Folk music has always been concerned with inheritance. With what is passed down and what is lost and what survives against the odds. McDoom brings a different inheritance than most folk singers working today. She also brings a jazz musician's ear, a patience trained by reggae, and a songwriter's instinct for the image that stays. The combination produces music that sounds old and new at once, familiar in its quietness and genuinely strange in its construction.

She has opened for alt-J at Kings Theater in Brooklyn, toured with Nick Hakim, and performed at the Rough Trade Indieplaza Festival at Rockefeller Center. She is not unknown. She is simply unhurried. The work accumulates the way good slow work does, arriving with a weight you notice only after it has already settled.

[spotify:album/6wMWkfSxjbNK9dejWAc9n5]

## The Work That Remains

McDoom's eponymous compilation, released in April 2025 on Temporary Residence, gathers her recordings into a single document for the first time. Hearing them together makes the continuity clear. The through line is not a sound but a posture, a commitment to making music as though the audience who needs it most is worth taking real time over.

That kind of care is not decorative. It is the argument. In a moment when music is made faster, released constantly, and measured in streams, the choice to be meticulous and unhurried is itself a statement. June McDoom makes folk music in the image of her own life: Jamaican, American, trained in jazz, patient, and entirely herself.

The work that remains is simply more of the same. Which, given what she has already made, is more than enough reason to keep watching.
{img("june-mcdoom-cover.jpg")}
[download:/assets/images/artists/june-mcdoom-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|youtube|img|download):[^\]]+\]', '', body)
word_count = len(clean.split())
print(f"Word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

post = {
    "title": "June McDoom: The Folk Singer Who Never Saw Herself in the Genre She Loves",
    "date": "2026-06-23",
    "category": "culture",
    "author": "Abel Blackburn",
    "instagram": "@junemcdoom",
    "featured": False,
    "image": "/assets/images/artists/june-mcdoom.jpg",
    "image_alt": "June McDoom press photo",
    "image_position": "center 30%",
    "body": body.strip(),
    "crew": [
        {
            "name": "Evan Wright",
            "role": "Producer",
            "url": "https://open.spotify.com/artist/4xkRqU2tCsLx2RJO5RXQUX",
            "handle": "@evanwwwright"
        },
        {
            "name": "Cecile McLorin Salvant",
            "role": "Vocalist",
            "url": "https://open.spotify.com/artist/6PkSULcbxFKkxdgrmPGAvn",
            "handle": "@cecilemclorinsalvant"
        }
    ]
}

payload = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "june-mcdoom",
    "artist": "June McDoom",
    "image_url": "https://i0.wp.com/higherplainmusic.com/wp-content/uploads/2022/08/june-mcdoom.jpg",
    "post": post
}

data = json.dumps(payload).encode()
req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=data,
    headers={'Content-Type': 'application/json'}
)
with urllib.request.urlopen(req, timeout=60) as r:
    result = json.loads(r.read())
print("Publish:", json.dumps(result, indent=2), flush=True)
if not result.get('ok'):
    print(f"ERROR: publish failed", file=sys.stderr)
    sys.exit(1)
PYEOF

echo "=== Step 3: Social card ==="
python3 artonly.io/agent/make-social-card.py june-mcdoom \
    "June McDoom: The Folk Singer Who Never Saw Herself in the Genre She Loves" culture \
    || echo "Social card warning (non-fatal)"

echo "=== Step 4: Validate ==="
python3 artonly.io/agent/post-validator.py june-mcdoom

echo "=== Step 5: IndexNow ==="
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/june-mcdoom&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== Step 6: Outreach ==="
python3 << 'PYEOF'
import urllib.request, urllib.parse

body_text = """Hi Anna,

We published a new piece on ArtOnly today about June McDoom: https://artonly.io/post/june-mcdoom

What struck us most in putting it together was how clearly her approach to traditional material, like her cover of Black Is the Color of My True Love's Hair, makes the case that folk music's inheritance is larger than its recent history suggests. A downloadable social card is included in the article for the team to use if helpful. If June or anyone at Temporary Residence has questions or wants to share anything further, just reply here.

Allastair Voss
ArtOnly (artonly.io)"""

data = urllib.parse.urlencode({
    'to': 'annapaz@temporaryresidence.com',
    'subject': 'June McDoom featured on ArtOnly',
    'body': body_text,
    'reply_to': 'allastairvoss@gmail.com',
}).encode()

req = urllib.request.Request('https://artonly.io/api/send-mail.php', data=data)
with urllib.request.urlopen(req, timeout=30) as r:
    print("Mail:", r.read().decode(), flush=True)
PYEOF

echo "=== Step 7: Update brain.json ==="
python3 << 'PYEOF'
import json
b = json.load(open('artonly.io/agent/brain.json'))
written = b.get('artists_written', [])
queue = b.get('queue', [])
if 'June McDoom' not in written:
    written.append('June McDoom')
    b['artists_written'] = written
if 'June McDoom' in queue:
    queue.remove('June McDoom')
    b['queue'] = queue
json.dump(b, open('artonly.io/agent/brain.json', 'w'), indent=2)
print(f"brain.json updated. artists_written: {len(written)}", flush=True)
PYEOF

echo "=== Done: https://artonly.io/post/june-mcdoom ==="
