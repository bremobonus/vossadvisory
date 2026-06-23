#!/bin/bash
# ArtOnly: Original Koffee - FIX: hardcode img before first heading
# Run via GitHub Actions (deploy-artonly.yml)
set -e
cd /home/dh_yadmw3

echo "=== Fix: Republish Original Koffee with hardcoded intro image ==="

python3 << 'PYEOF'
import json, os, urllib.request, sys, re

# koffee.jpg (1341KB) and koffee-intro.jpg (835KB) are already on server from prior run
# koffee-live.jpg, koffee-studio.jpg, koffee-cover.jpg failed - they are omitted

base = 'artonly.io/assets/images/artists/'

def has(name):
    p = base + name
    return os.path.exists(p) and os.path.getsize(p) > 5000

def img(name):
    if has(name):
        return f'\n[img:/assets/images/artists/{name}]\n'
    return ''

# Verify intro image is present; if not, use hero as fallback
if has('koffee-intro.jpg'):
    intro_img = '\n[img:/assets/images/artists/koffee-intro.jpg]\n'
else:
    intro_img = '\n[img:/assets/images/artists/koffee.jpg]\n'

print(f"intro_img status: koffee-intro.jpg exists={has('koffee-intro.jpg')}", flush=True)
print(f"koffee.jpg exists={has('koffee.jpg')}", flush=True)

body = (
    '[spotify:artist/1gWjcmBsveEYMxOZ0VRi32]\n\n'
    '[youtube:EvOABOa3IrU]\n\n'
    'Most artists spend years trying to reach a Grammy. Mikayla Victoria Simpson, who performs as Original Koffee, arrived there at 19. Her debut EP, Rapture, won the Grammy Award for Best Reggae Album at the 62nd Annual Grammy Awards in 2020, making her the youngest artist ever to win in that category. The question that followed, for anyone paying attention, was not how she had gotten there. It was where she would go next.\n\n'
    'Gifted, released on March 25, 2022, is the answer. The debut full-length album by the artist then known simply as Koffee is not a Grammy acceptance speech extended to ten tracks. It is the work of a 22-year-old from Spanish Town, Jamaica, who had spent the previous five years building something precise and then had to build it again at a larger scale, without losing what made the first version work.\n'
    + intro_img +
    '\n## Spanish Town and the Guitar She Taught Herself\n\n'
    'Koffee grew up in a Seventh Day Adventist household in Spanish Town, just outside Kingston. Her mother worked for the Ministry of Health. The church was the first place she learned to control her voice and understand what harmony required of a singer. She taught herself guitar at 12, beginning with chords she found by watching videos and working through the instrument\'s logic on her own, without formal lessons, building a relationship to the instrument that was entirely personal before it was ever professional.\n\n'
    'The Jamaican reggae artists she grew up listening to shaped her sense of what a song needed to do. Protoje and Chronixx were the ones she has cited most directly, artists of the same generation who brought a contemporary sensibility to a tradition with deep roots and clear expectations about what counted as authentic. What she absorbed from them was not just technique or genre. It was the idea that you could make music that carried social and spiritual weight and still sound like it belonged in the present.\n\n'
    'In 2017, at 17, she posted a tribute to Usain Bolt on Instagram. The video went viral after Bolt himself reposted it. What followed was not exactly a plan but a demonstration that the voice she had been building since the church choir had reach beyond what she had tested. The single "Burning" appeared that same year and found an audience before anyone at a label had made any decisions about her.\n\n'
    '## Toast and the Moment That Almost Became the Whole Story\n\n'
    'The 2019 EP Rapture contained "Toast," the track that introduced Koffee to the widest audience she had yet reached. The song was a celebration of gratitude and presence, built on a groove that made it useful at parties and in headphones and on radio simultaneously. It certified platinum in the UK. It charted internationally. By any reasonable measure, it was a breakout.\n\n'
    'The risk of a breakout single is that it can become the thing people expect you to repeat. "Toast" was a perfect single. It was also a narrow band of what the EP itself contained, and the EP was a narrow band of what she could do. The Grammy for Rapture acknowledged something real about the music. It also created a frame around her career that Koffee would need to step outside of to make the album she actually wanted to make.\n\n'
    '## Gifted and the Question of Ownership\n\n'
    'Gifted is a record about taking stock. The title is not modest. It is a statement about the nature of what she has, about talent as something that arrives with obligations attached and requires active care. The album contains no guest features, a choice that, given the collaborations she had already landed by 2022 (including a track with Gunna and the Cyanide remix with Daniel Caesar), signals that this particular record was hers to carry alone.\n\n'
    'She produced half of the album herself. The remaining tracks were made with producers JAE5 and Frank Dukes and Jamaican producer iotosh. The presence of JAE5, who has built records for artists across genres and continents, on a roots reggae album was not a commercial concession. It was a choice to bring in a collaborator whose sensibility extended what the music could hold without replacing its center.\n\n'
    'The tracks range from "X10," which opened the album with a statement of confidence, through "Where I\'m From," which rooted the whole record back in Spanish Town, to "West Indies," which became its own kind of anthem with 19 million views and a clear statement of identity. Ten tracks on the standard edition. A sound that absorbed Afrobeat and neo soul and dancehall without losing the reggae at its foundation.\n\n'
    '[spotify:album/4Ch605EjDQIZowlcaArlLP]\n\n'
    '## What the Award Could Not Give Her\n\n'
    'A Grammy can confirm that the music you have already made was worth making. It cannot tell you what to make next, cannot give you the confidence that comes from working through a full album rather than the compact emergency of an EP, and cannot protect you from the question of whether the follow-up will carry equal weight.\n\n'
    'Gifted answered that question. It peaked at number nine in the UK and charted across Europe. It surpassed one hundred million streams on Spotify. It received a Grammy nomination for Best Reggae Album in 2023, which would have been remarkable for any artist and which, for someone who had already won that award, meant something different: that the first win was not a fluke and that the debut album had been evaluated on its own terms.\n\n'
    'The Grammy at 19 confirmed that she could make a brilliant EP. Gifted confirmed that she could make a record.\n\n'
    '## Original Koffee and What She Is Building\n\n'
    'In April 2025, she returned with a single released under the name Original Koffee, the first music under the new moniker. The rebranding is not a reinvention. It is a clarification. The word original was always the accurate one. The music she has made since 2017 has drawn from a tradition she did not borrow for effect but grew up inside of, and the name now reflects something that was always true.\n\n'
    'The trajectory from a church choir in Spanish Town to a self-taught guitarist at 12 to a viral Instagram moment at 17 to a Grammy at 19 to a debut album at 22 and now a rebrand at 25 is not a story of someone chasing a career. It is a story of someone building one with patience and intention, adjusting the frame when the frame stops fitting, and making music that continues to earn the weight it claims.\n\n'
    '[download:/assets/images/artists/original-koffee-social-9x16.jpg|Download Social Card]'
)

clean = re.sub(r'\[(?:spotify|youtube|img|download):[^\]]+\]', '', body)
word_count = len(clean.split())
print(f"Word count: {word_count}", flush=True)

# Verify [img:] appears before first ##
img_pos = body.find('[img:')
heading_pos = body.find('## ')
print(f"First [img:] at position {img_pos}, first ## at {heading_pos}", flush=True)
if img_pos == -1 or img_pos > heading_pos:
    print("ERROR: [img:] not before first ##", file=sys.stderr)
    sys.exit(1)

if word_count < 888:
    print(f"ERROR: only {word_count} words", file=sys.stderr)
    sys.exit(1)

post = {
    "title": "Original Koffee: How Jamaica's Youngest Grammy Winner Built the Album That Followed",
    "date": "2026-06-23",
    "category": "music",
    "author": "Leelou Blanc",
    "instagram": "@originalkoffee",
    "featured": False,
    "image": "/assets/images/artists/koffee.jpg",
    "image_alt": "Original Koffee press photo by Mykal Cushnie",
    "image_position": "center 20%",
    "body": body,
    "crew": [
        {
            "name": "JAE5",
            "role": "Producer",
            "url": "https://open.spotify.com/artist/2oJBtt1QwEKW86uqs0DQag",
            "handle": "@jae5"
        },
        {
            "name": "Gunna",
            "role": "Featured Artist",
            "url": "https://open.spotify.com/artist/4r63FhuTkUYltbVAg5TQnk",
            "handle": "@gunna"
        }
    ]
}

payload = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "original-koffee",
    "artist": "Original Koffee",
    "image_url": "https://artonly.io/assets/images/artists/koffee.jpg",
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
    print("ERROR: publish failed", file=sys.stderr)
    sys.exit(1)
PYEOF

echo "=== Social card ==="
python3 artonly.io/agent/make-social-card.py original-koffee \
    "Original Koffee: How Jamaica's Youngest Grammy Winner Built the Album That Followed" music \
    || echo "Social card warning (non-fatal)"

echo "=== Validate ==="
python3 artonly.io/agent/post-validator.py original-koffee

echo "=== IndexNow ==="
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/original-koffee&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== Outreach ==="
python3 << 'PYEOF'
import urllib.request, urllib.parse

body_text = """Hi,

We published a new piece on ArtOnly today about Original Koffee: https://artonly.io/post/original-koffee

The article centers on Gifted as the album that answered the real question her Grammy raised, specifically how she chose to produce half of it herself and release it without features as a deliberate act of ownership. A downloadable social card is in the article if the team wants to use it. If anyone has questions or would like to add anything, just reply here.

Leelou Blanc
ArtOnly (artonly.io)"""

data = urllib.parse.urlencode({
    'to': 'press@columbia.co.uk',
    'subject': 'Original Koffee featured on ArtOnly',
    'body': body_text,
    'reply_to': 'allastairvoss@gmail.com',
}).encode()

req = urllib.request.Request('https://artonly.io/api/send-mail.php', data=data)
with urllib.request.urlopen(req, timeout=30) as r:
    print("Mail:", r.read().decode(), flush=True)
PYEOF

echo "=== Update brain.json ==="
python3 << 'PYEOF'
import json
b = json.load(open('artonly.io/agent/brain.json'))
written = b.get('artists_written', [])
queue = b.get('queue', [])
for name in ['Koffee', 'Original Koffee']:
    if name not in written:
        written.append(name)
    if name in queue:
        queue.remove(name)
b['artists_written'] = written
b['queue'] = queue
json.dump(b, open('artonly.io/agent/brain.json', 'w'), indent=2)
print(f"brain.json updated. artists_written: {len(written)}", flush=True)
PYEOF

echo "=== Done: https://artonly.io/post/original-koffee ==="
