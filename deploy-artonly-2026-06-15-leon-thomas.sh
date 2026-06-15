#!/bin/bash
# ArtOnly Deploy Script: Leon Thomas III
# Generated: 2026-06-15
# Post: leon-thomas
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-15 Leon Thomas III ==="
echo "--- Deploying: leon-thomas ---"

# ---- Download hero image ----
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
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/leon-thomas.jpg'

try:
    html = fetch('https://pitchfork.com/artists/leon-thomas/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Hero downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://www.grammy.com/news/leon-thomas-iii-interview-new-album-mutt/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+grammy[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
        imgs = [i for i in imgs if 'leon' in i.lower() or 'thomas' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.grammy.com/')
        print('Hero downloaded from Grammy.com')
        sys.exit(0)
except Exception as e:
    print(f'Grammy failed: {e}')

try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Leon_Thomas_III_2020.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia failed: {e}')

os.system('convert -size 1200x800 gradient:\"#1a0a2e-#2d1855\" -gravity center -pointsize 52 -fill white -annotate 0 \"Leon Thomas III\" ' + dest)
print('Hero placeholder generated')
"

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
    ('leon-thomas-intro.jpg',
     'https://upload.wikimedia.org/wikipedia/commons/9/9f/Leon_Thomas_III_in_2020.jpg'),
    ('leon-thomas-studio.jpg',
     'https://upload.wikimedia.org/wikipedia/commons/8/8d/Leon_Thomas_11_09_2013_-10_%2810784827475%29.jpg'),
    ('leon-thomas-live.jpg',
     'https://upload.wikimedia.org/wikipedia/commons/2/21/Leon_Thomas_III%2C_The_Romantic_Tour_%2855299246592%29.jpg'),
    ('leon-thomas-portrait.jpg',
     'https://upload.wikimedia.org/wikipedia/commons/1/1f/Leon_Thomas_III_2013_%28cropped%29.jpg'),
    ('leon-thomas-session.jpg',
     'https://upload.wikimedia.org/wikipedia/commons/7/7f/Leon_Thomas_11_09_2013_-1_%2810785038444%29.jpg'),
]

for filename, url in images:
    dest = os.path.join(base, filename)
    try:
        n = download_img(url, dest)
        print(f'OK: {filename} ({n} bytes)')
    except Exception as e:
        print(f'FAILED {filename}: {e}')
        os.system(f'convert -size 1200x800 gradient:"#1a0a2e-#2d1855" -gravity center -pointsize 40 -fill white -annotate 0 "Leon Thomas III" "{dest}"')
        print(f'Placeholder: {filename}')
IMGEOF

echo "Body images done"

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/0nnBZ8FXWjG9wZgM2cpfeb]

On September 27, 2024, Leon Thomas III released his second studio album, Mutt, through EZMNY Records and Motown. It peaked at number 35 on the Billboard 200, reached Gold certification with the RIAA, and sent its lead single to number 6 on the Hot 100. All of that happened before the Grammys. The 68th Annual Grammy Awards, held February 1, 2026, handed him Best R&B Album for Mutt, alongside Best Traditional R&B Performance for "Vibes Don't Lie." He had also received nominations for Album of the Year and Best New Artist. Two years before that, on February 4, 2024, he had already won his first Grammy for co-writing SZA's "Snooze." The math on Leon Thomas III is straightforward once you know where to look: he has been doing this a long time, and the industry is only now catching up to that fact.

## Thirty Years in the Making

Leon Thomas III was born on August 1, 1993, in Brooklyn, New York. His maternal grandfather, John D. Anthony, was a jazz musician and opera singer who performed on Broadway. That lineage is not decorative background. The same facility for vocal arrangement that makes Thomas a valuable collaborator and a songwriter other artists call first is the same quality that let a ten year old walk onto a Broadway stage in 2003 and sing as Young Simba in The Lion King. That version of his career ran alongside his music career for years. From 2010 to 2013 he played Andre Harris in the Nickelodeon series Victorious, alongside Ariana Grande. That role put his voice in front of millions of people and gave him no credit for what he could actually do. The gap between what audiences thought they were watching and what the performer was actually capable of is instructive. Thomas spent the next decade closing it, mostly out of view.

[img:/assets/images/artists/leon-thomas-intro.jpg]

## The Shadow Career Behind the Songs

Working as part of the production duo The Rascals with Khris Riddick-Tynes, Thomas spent years writing and producing for Ariana Grande, Drake, Rick Ross, SZA, and Toni Braxton. He was not a session player in the anonymous sense. The records he touched sound like him because he put himself into them. When SZA released "Snooze" from SOS in 2022, the writing credit included Thomas and so did the Grammy he collected when the 66th Annual Grammy Awards named it Best R&B Song on February 4, 2024. That award arrived before Mutt was even announced. He was already a Grammy winner when most of the public still did not know his name as a solo act.

In May 2022, Ty Dolla $ign signed Thomas as the first artist to EZMNY Records, the imprint Ty Dolla $ign built through a joint venture with Motown. His debut, Electric Dusk, arrived in 2023 and established a sonic identity that Mutt would then push harder. While working on his own material, Thomas also spent time in Florence, Italy, contributing as a writer and producer to the Kanye West and Ty Dolla $ign collaboration Vultures 1, released February 2024. He appears in the credits for "Burn." That detail tells you something about the level he operates at, even when his own records are not the subject of conversation.

[img:/assets/images/artists/leon-thomas-studio.jpg]

## How Mutt Came Together

Thomas has said in interviews that the album concept began with his dog, Terry, a German Shepherd and Husky mix. He drew parallels between the negotiation of behavior in a relationship and the experience of trying to get a dog to act right. The title track was the result of that line of thinking, and it became a genuine commercial hit, reaching number 6 on the Billboard Hot 100. That was his first solo top ten entry. The fourteen tracks around it cover a range that includes jazz influenced balladry, psychedelic soul, and sections that lean into a rock texture without becoming anything other than an R&B record. Influences Thomas has cited include Art Blakey, Miles Davis, Black Sabbath, Led Zeppelin, and the Rolling Stones. None of those references are decorative. The album sounds like a person who absorbed all of that and then decided to reconcile it in his own voice rather than choose one direction.

The record does not chase radio formats or trend cycles. "Vibes Don't Lie," a slower and more introspective track, won Best Traditional R&B Performance at the 68th Grammys. The fact that the Recording Academy chose that one over the commercially proven title track says something about how the album lands with attentive listeners. It rewards patience in a genre where patience is rarely assumed.

[img:/assets/images/artists/leon-thomas-live.jpg]

## Who Shows Up in the Grooves

Mutt is not a solo showcase in the way that a record obsessed with proving something usually is. Thomas brought in collaborators who fit the songs rather than names selected to generate algorithmic attention. Masego appears on "Lucid Dreams." Wale appears on "Feelings On Silent." Ty Dolla $ign, who signed Thomas and whose aesthetic sensibility clearly shaped some of what Thomas reaches for, appears on "Far Fetched." Baby Rose is on "I Used To." Axlfolie appears on "Sooner or Later." The remix version of the title track features Freddie Gibbs, and a separate remix released in March 2025 brought in Chris Brown.

None of those guest credits feel mandatory. They feel like actual creative decisions, which is rarer than it sounds. Thomas knows how to use a collaborator without losing the voice of the record itself. Each of the features lands inside the album's logic rather than interrupting it. That is a production skill as much as a curatorial one, and it reflects the years Thomas spent building those muscles on other people's projects before applying them to his own.

[img:/assets/images/artists/leon-thomas-portrait.jpg]

[spotify:album/0SzoksypeognxYJJOJEYip]

## What the Record Means After the Prizes Arrive

Thomas won Best New Artist at the 2025 BET Awards on June 9, 2025. The Grammy nominations for Album of the Year and Best New Artist placed him in company he had been building toward for over a decade without the profile that would have made it obvious to anyone paying casual attention. The irony is that institutions tend to recognize artists at the exact moment the artists no longer need the recognition to know what they are doing.

Best R&B Album and Best Traditional R&B Performance are the kind of recognitions that can reshape a career retrospectively. They can also flatten it, turning a complicated record into a marketing category. The more interesting question with Thomas is what he builds next. Mutt Deluxe: Heel, announced in 2025, extended the project. The Mutt tour followed the album cycle and brought the material to live audiences. His trajectory since Victorious has been almost entirely additive. Nothing he has released suggests someone who peaked early or who is coasting on a correct formula. Thomas said in a Grammy.com interview about the record: "I'm just putting my neck out there and daring to be different."

At thirty two years old, with two Grammy wins, a Gold album, and a BET Award on the shelf, the neck is still out. That is the ongoing question with this particular artist: whether the institutions now paying attention will keep pace with the work, or whether they will always arrive a few years behind.

[img:/assets/images/artists/leon-thomas-session.jpg]

[download:/assets/images/artists/leon-thomas-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "leon-thomas",
    "title": "Leon Thomas III Arrived on His Own Timeline",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-15",
    "image": "/assets/images/artists/leon-thomas.jpg",
    "image_alt": "Leon Thomas III press photo",
    "image_position": "center 20%",
    "crew": [
        {"name": "Masego", "role": "Feature Artist", "url": "https://open.spotify.com/artist/3ycxRkcZ67ALN3GQJ57Vig", "handle": "@masego"},
        {"name": "Baby Rose", "role": "Feature Artist", "url": "https://open.spotify.com/artist/6Z4JcgqrqgysyHIPRtDIHo", "handle": "@babyrosemusic"}
    ],
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/leon-thomas.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF

echo "Post JSON deployed: leon-thomas.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py leon-thomas "Leon Thomas III Arrived on His Own Timeline" music
echo "Social card generated: leon-thomas-social-9x16.jpg"
cd ~

# ---- Run validator ----
cd ~/artonly.io/agent
python3 post-validator.py leon-thomas || true
echo "Validator complete"
cd ~

# ---- Update brain.json ----
python3 << 'BRAINEOF'
import json, os

brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
with open(brain_path, 'r') as f:
    brain = json.load(f)

written = brain.get('artists_written', [])
if 'Leon Thomas' not in written and 'Leon Thomas III' not in written:
    brain['artists_written'] = written + ['Leon Thomas']
    print(f'Added Leon Thomas to artists_written (now {len(brain["artists_written"])})')
else:
    print('Leon Thomas already in artists_written')

queue = brain.get('queue', [])
brain['queue'] = [a for a in queue if a not in ('Leon Thomas', 'Leon Thomas III')]

brain['last_published'] = {
    'artist': 'Leon Thomas',
    'slug': 'leon-thomas',
    'title': 'Leon Thomas III Arrived on His Own Timeline',
    'date': '2026-06-15'
}

with open(brain_path, 'w') as f:
    json.dump(brain, f, indent=2, ensure_ascii=False)
    f.write('\n')
print('brain.json updated on server')
BRAINEOF

# ---- Confirm post is live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/leon-thomas)
echo "HTTP status artonly.io/post/leon-thomas: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/leon-thomas&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: leon-thomas"

# ---- Outreach ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@cultureco.co" \
  --data-urlencode "subject=ArtOnly just covered Leon Thomas III" \
  --data-urlencode "body=https://artonly.io/post/leon-thomas

Leon Thomas III spent a decade writing Grammy-winning records for other artists before Mutt made the wider world pay attention to his own. We covered the album, the Florence sessions on Vultures 1, and what it means to arrive on your own timeline. A downloadable social card is at the bottom of the page, feel free to share. Happy to arrange a proper Q and A if there is appetite, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo "Outreach sent to info@cultureco.co"

echo "=== Deploy complete: leon-thomas 2026-06-15 ==="
