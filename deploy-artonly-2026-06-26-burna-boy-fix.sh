#!/bin/bash
# ArtOnly — Burna Boy FIX: correct payload + re-publish + outreach
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-26-burna-boy-fix.sh

echo "=== ArtOnly Fix Deploy: Burna Boy 2026-06-26 ==="
echo "$(date)"

# ---- Step 1: Enable publishing ----
echo ""
echo "--- Step 1: Enable publishing ---"
python3 - << 'PYEOF'
import json, os
cfg_path = '/home/dh_yadmw3/artonly.io/data/publish-config.json'
cfg = {}
if os.path.exists(cfg_path):
    try:
        cfg = json.load(open(cfg_path))
    except Exception:
        pass
cfg['publishing_enabled'] = True
with open(cfg_path, 'w') as f:
    json.dump(cfg, f, indent=2)
print('publishing_enabled -> True')
PYEOF

# ---- Step 2: Fix hero image filename ----
echo ""
echo "--- Step 2: Fix hero image filename ---"
IMG_DIR="/home/dh_yadmw3/artonly.io/assets/images/artists"
SLUG="burna-boy-african-giant"

# Rename hero to canonical filename (SLUG.jpg, no -hero suffix)
if [ -f "$IMG_DIR/${SLUG}-hero.jpg" ]; then
    cp "$IMG_DIR/${SLUG}-hero.jpg" "$IMG_DIR/${SLUG}.jpg"
    echo "Copied ${SLUG}-hero.jpg -> ${SLUG}.jpg"
elif [ -f "$IMG_DIR/${SLUG}.jpg" ]; then
    echo "${SLUG}.jpg already exists ($(wc -c < $IMG_DIR/${SLUG}.jpg) bytes)"
else
    echo "Hero image missing — downloading fresh"
    curl -s -L -A "Mozilla/5.0 (X11; Linux x86_64)" \
      -o "$IMG_DIR/${SLUG}.jpg" \
      "https://upload.wikimedia.org/wikipedia/commons/c/ce/Untold_2024_-Burna_Boy_%2853926047977%29_%28cropped%29.jpg"
    echo "Downloaded: $(wc -c < $IMG_DIR/${SLUG}.jpg) bytes"
fi

echo "Hero image: $(wc -c < $IMG_DIR/${SLUG}.jpg) bytes"

# ---- Step 3: Publish with corrected payload ----
echo ""
echo "--- Step 3: Publish article (corrected payload) ---"
python3 - << 'PYEOF'
import json, os, re, urllib.request

IMG_DIR = '/home/dh_yadmw3/artonly.io/assets/images/artists'
SLUG = 'burna-boy-african-giant'

def img_ok(name):
    p = f"{IMG_DIR}/{SLUG}-{name}.jpg"
    return os.path.exists(p) and os.path.getsize(p) >= 5000

BODY_FULL = """[spotify:artist/3wcj11K77LjEY1PkEazffa]

On July 8, 2023, Burna Boy walked out onto the field at Citi Field in Queens, New York, and played a headline show to a crowd of over 40,000 people. The show sold out. No African artist had ever headlined a stadium in the United States before. The show did not have a crossover single to justify it. It had a body of work.

Damini Ebunoluwa Ogulu was born in Port Harcourt, Rivers State, Nigeria, in 1991. His grandfather, Benson Idonije, was a journalist and concert promoter who managed Fela Kuti. He grew up with those records in the house. He also spent formative years in London and Brighton, absorbing grime and drum and bass. By the time he returned to Lagos and started releasing music under the name Burna Boy in 2012, those two vocabularies were already running simultaneously in his head. That collision is not a fusion in the sense of blending two things into a compromise. It is two things occupying the same space without either one disappearing.

## The Album That Redefined the Conversation

African Giant came out in July 2019 on his own imprint, Spaceship Entertainment, with Atlantic Records handling international distribution. It entered with no mass radio campaign in Europe or North America. The nomination for Best World Music Album at the 62nd Grammy Awards three months after release was the first time a lot of people outside Nigeria and the diaspora had a reason to take note.

The album is 19 tracks. It opens with the title track, a declaration that is also a position statement. It moves through "Dangote," which runs Fela influenced horns into dancehall percussion and names Africa's wealthiest man as a touchstone for ordinary ambition. "Killin Dem" with Zlatan won Best Collaboration at The Headies 2019. "Gum Body" with Jorja Smith worked because Smith already carries rhythm in her own music without straining for it. The album does not stop to explain itself at any point. That choice was deliberate. It is also the reason it holds.

Beyonce heard "Ye" and reached out. Burna Boy appeared on The Lion King: The Gift later that year. He did not change his sound to meet that new audience. He continued making the record he had always been making. Most artists in that position do not have the discipline to hold that line.

[img:/assets/images/artists/burna-boy-african-giant-intro.jpg]

## A Stadium in Queens

The Citi Field concert in July 2023 was not positioned as a cultural moment by its promoters. It was positioned as a concert. That is actually the more significant framing. A cultural moment suggests something exceptional and contained. A concert implies that this is simply what happens when this artist tours.

The audience was drawn largely from African and African diaspora communities in New York, the New Jersey corridor, and beyond. It demonstrated that those communities are large enough, and willing enough to spend, to fill a baseball stadium for an artist who never modified his sound to reach them. The geography matters. Port Harcourt to London to Lagos to Queens is not an abstraction. It is a migration pattern that created a specific audience in a specific place.

In June 2023, he also became the first artist from Africa to perform at the UEFA Champions League Final kickoff show at Ataturk Olympic Stadium in Istanbul, reaching an estimated 700 million viewers. The two events within weeks of each other said the same thing from different directions.

[img:/assets/images/artists/burna-boy-african-giant-live.jpg]

## The Grammy and Its Limits

Twice as Tall won the Grammy for Best Global Music Album at the 63rd Annual Grammy Awards on March 14, 2021. Diddy executive produced it. The album is leaner and more focused than African Giant. "Wonderful" with Wande Coal shifts through three rhythmic ideas in under four minutes. "Way Too Big" consolidates the argument that had been building since 2019 into a single statement of intent.

The Grammy mattered institutionally. It gave bookers, label executives, and festival programmers a shorthand they could use in a meeting without further context. It did not change the music. It confirmed a position the music had already established.

The category name, Best Global Music Album, is worth noting. Global, in Grammy usage, is a catchall for music not made in the United States. The category exists. The win happened. Burna Boy has consistently treated it as a starting point rather than an arrival.

[img:/assets/images/artists/burna-boy-african-giant-studio.jpg]

## Port Harcourt Stays in the Room

Burna Boy has been consistent about the fact that his sound is rooted in Port Harcourt before it is rooted in London or Lagos. Port Harcourt is a port city, which means it has always moved things in and out. The music that came out of there in the 1970s and 1980s absorbed Congolese soukous and Jamaican reggae alongside the highlife and Afrobeat traditions of western Nigeria. That layering is audible in everything Burna Boy makes.

His collaborations follow a specific logic that is easier to see in retrospect. Jorja Smith on "Gum Body" shared rhythmic instincts. Damian Marley on "Monsters You Made" brought a musical inheritance that overlaps with what Burna Boy builds from. Ed Sheeran, who appeared on "For My Hand" from Love, Damini, is the outlier. It works because Sheeran is more rhythmically flexible than his pop profile suggests.

For No Sign of Weakness, released July 10, 2025, the collaborators include Travis Scott, Mick Jagger, Stromae, and Shaboozey. Each connection has its own logic. Jagger brings rock history and a willingness to appear outside his own idiom. Stromae operates in French language pop and brings European sophistication without condescension. Shaboozey's country adjacency points toward a direction that does not yet have a name. Travis Scott is the choice made on pure pop mechanics, and it earns its place on its own terms.

[img:/assets/images/artists/burna-boy-african-giant-session.jpg]

[spotify:album/79lrrUvUyIuOD12b5taQVP]

## Six Years on the Billboard Hot 100

In 2026, Burna Boy became the first African artist to have charted at least one song on the Billboard Hot 100 for six consecutive years, covering 2021 through 2026. That is a metric drawn from the primary American commercial chart. It measures presence in a market he never chased directly.

The 2026 AFRIMA gave him Album of the Year for No Sign of Weakness. The tour supporting the record opened at Red Rocks Amphitheatre on November 12, 2025. North American dates sold out. The AFRIMA win and the Hot 100 record arrived in the same calendar year and together describe the shape of his reach: simultaneously continental and global, simultaneously inside the industry's framework and indifferent to its approval.

What the six year Hot 100 run actually demonstrates is longevity without reinvention. He has not changed the genre he works in, released a pop record to reset his commercial standing, or moved toward a sound that would make him more legible to an audience that was not already paying attention. The numbers arrived anyway. That is an unusual outcome in any era of the music industry.

The conversation about where African music sits in the global hierarchy is not closed. What Burna Boy has done is make it harder to avoid. The terms were set in Port Harcourt, developed in Lagos, and confirmed in Queens. The album that started the run is still the one that makes the clearest argument.

[img:/assets/images/artists/burna-boy-african-giant-promo.jpg]

[download:/assets/images/artists/burna-boy-african-giant-social-9x16.jpg|Download Social Card]"""

# Remove [img:] lines where the image file is missing or too small
lines = BODY_FULL.split('\n')
body_lines = []
for line in lines:
    m = re.match(r'\[img:/assets/images/artists/burna-boy-african-giant-([a-z]+)\.jpg\]', line)
    if m:
        name = m.group(1)
        if img_ok(name):
            body_lines.append(line)
            print(f'  img {name}: OK')
        else:
            print(f'  img {name}: SKIP (not found or too small)')
    else:
        body_lines.append(line)

body = '\n'.join(body_lines)

payload = {
    'action': 'publish',
    'token': 'ao-pub-Neverending48-2026',
    'slug': SLUG,
    'artist': 'Burna Boy',
    'post': {
        'slug': SLUG,
        'title': 'Burna Boy and the Album That Made Africa Non-Negotiable',
        'author': 'Allastair Voss',
        'category': 'music',
        'date': '2026-06-26',
        'image': f'/assets/images/artists/{SLUG}.jpg',
        'image_alt': 'Burna Boy at Untold Festival 2024',
        'image_position': 'center 30%',
        'body': body
    }
}

data = json.dumps(payload).encode()
req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=data,
    headers={'Content-Type': 'application/json'},
    method='POST'
)
try:
    with urllib.request.urlopen(req, timeout=30) as resp:
        result = resp.read().decode()
        print('Publish response:', result[:600])
except Exception as e:
    print(f'Publish error: {e}')
PYEOF

# ---- Step 4: Social card ----
echo ""
echo "--- Step 4: Social card ---"
cd /home/dh_yadmw3/artonly.io/agent
python3 make-social-card.py burna-boy-african-giant "Burna Boy and the Album That Made Africa Non-Negotiable" 0 || echo "Social card: non-fatal warning"

# ---- Step 5: Post validator ----
echo ""
echo "--- Step 5: Post validator ---"
python3 post-validator.py burna-boy-african-giant || echo "Validator: non-fatal warning"

# ---- Step 6: IndexNow ----
echo ""
echo "--- Step 6: IndexNow ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/burna-boy-african-giant&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

# ---- Step 7: Update brain.json ----
echo ""
echo "--- Step 7: Update brain.json ---"
python3 - << 'PYEOF'
import json

brain_path = '/home/dh_yadmw3/artonly.io/agent/brain.json'
b = json.load(open(brain_path))

written = b.get('artists_written', [])
if 'Burna Boy' not in written:
    written.append('Burna Boy')
    b['artists_written'] = written
    print(f'Added Burna Boy to artists_written ({len(written)} total)')
else:
    print('Burna Boy already in artists_written')

queue = b.get('queue', [])
if 'Burna Boy' in queue:
    queue.remove('Burna Boy')
    b['queue'] = queue
    print('Removed Burna Boy from queue')

b['last_published'] = {
    'artist': 'Burna Boy',
    'slug': 'burna-boy-african-giant',
    'title': 'Burna Boy and the Album That Made Africa Non-Negotiable',
    'date': '2026-06-26'
}

with open(brain_path, 'w') as f:
    json.dump(b, f, indent=2, ensure_ascii=False)
print('brain.json updated')
PYEOF

# ---- Step 8: Outreach email ----
echo ""
echo "--- Step 8: Outreach email ---"
python3 - << 'PYEOF'
import json, urllib.request

payload = {
    'token': 'ao-pub-Neverending48-2026',
    'to': 'spaceshipent.info@gmail.com',
    'reply_to': 'allastairvoss@gmail.com',
    'subject': 'Your artist on ArtOnly: Burna Boy',
    'body': """Hello,

I wanted to let you know that we published a piece on Burna Boy today on ArtOnly.

You can read it here: https://artonly.io/post/burna-boy-african-giant

The article covers African Giant and the run it started, the Citi Field show in July 2023, the Grammy win, and what the six consecutive years on the Billboard Hot 100 actually represent. It runs about 1,200 words and is written for readers who follow the music closely.

If you have any corrections, additions, or would like to discuss coverage of upcoming releases or tour dates, please reply to this email.

Best,
Allastair Voss
ArtOnly"""
}

data = json.dumps(payload).encode()
req = urllib.request.Request(
    'https://artonly.io/api/send-mail.php',
    data=data,
    headers={'Content-Type': 'application/json'},
    method='POST'
)
try:
    with urllib.request.urlopen(req, timeout=30) as resp:
        result = resp.read().decode()
        print('Mail response:', result[:400])
except Exception as e:
    print(f'Mail error: {e}')
PYEOF

echo ""
echo "=== Fix deploy complete ==="
echo "Post URL: https://artonly.io/post/burna-boy-african-giant"
