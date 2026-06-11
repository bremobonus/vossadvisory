#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-11
# Posts: bedouine-neon-summer-skin, navy-blue-sir-render
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-11.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-11 ==="


# ---- POST 1: Bedouine - Neon Summer Skin ----
echo "--- Deploying: bedouine-neon-summer-skin ---"

if [ -f ~/artonly.io/posts/bedouine-neon-summer-skin.json ]; then
  echo "Post already exists: bedouine-neon-summer-skin.json, skipping"
else

# Download press photo
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/bedouine-neon-summer-skin.jpg'

# Try Aquarium Drunkard review
try:
    html = fetch('https://aquariumdrunkard.com/2026/06/04/bedouine-neon-summer-skin/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bedouine' in i.lower() or 'aquarium' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://aquariumdrunkard\.com/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://aquariumdrunkard.com/')
        print('Downloaded from Aquarium Drunkard')
        sys.exit(0)
except Exception as e:
    print(f'Aquarium Drunkard failed: {e}')

# Try Paste Magazine interview
try:
    html = fetch('https://www.pastemagazine.com/music/bedouine/bedouine-neon-summer-skin-interview-2026')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bedouine' in i.lower() or 'paste' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.pastemagazine.com/')
        print('Downloaded from Paste Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Paste Magazine failed: {e}')

# Try Far Out Magazine review
try:
    html = fetch('https://faroutmagazine.co.uk/bedouine-neon-summer-skin-album-review/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bedouine' in i.lower() or 'farout' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://faroutmagazine\.co\.uk/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://faroutmagazine.co.uk/')
        print('Downloaded from Far Out Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Far Out Magazine failed: {e}')

# Try KLOF Mag
try:
    html = fetch('https://klofmag.com/2026/06/bedouine-neon-summer-skin/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bedouine' in i.lower() or 'klof' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://klofmag.com/')
        print('Downloaded from KLOF Mag')
        sys.exit(0)
except Exception as e:
    print(f'KLOF Mag failed: {e}')

# Try Spacebomb artist page
try:
    html = fetch('https://spacebombgroup.com/artists/bedouine')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bedouine' in i.lower() or 'spacebomb' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://spacebombgroup.com/')
        print('Downloaded from Spacebomb')
        sys.exit(0)
except Exception as e:
    print(f'Spacebomb failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0f0a-#0a1a14\" -gravity center -pointsize 52 -fill white -annotate 0 \"Bedouine\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/bedouine-neon-summer-skin.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/bedouine-neon-summer-skin-up.jpg && \
  mv ~/artonly.io/assets/images/artists/bedouine-neon-summer-skin-up.jpg \
     ~/artonly.io/assets/images/artists/bedouine-neon-summer-skin.jpg
echo "Image upscaled: bedouine-neon-summer-skin.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py bedouine-neon-summer-skin "On Neon Summer Skin, Bedouine Holds the Places Time Has Already Taken" music
echo "Social card generated: bedouine-neon-summer-skin-social-9x16.jpg"
cd ~

# Deploy JSON post
cat > ~/artonly.io/posts/bedouine-neon-summer-skin.json << 'ENDJSON'
{
  "slug": "bedouine-neon-summer-skin",
  "title": "On Neon Summer Skin, Bedouine Holds the Places Time Has Already Taken",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-06-11",
  "image": "/assets/images/artists/bedouine-neon-summer-skin.jpg",
  "image_alt": "Bedouine press photo",
  "image_position": "center 20%",
  "description": "The difficulty of writing about displacement is that the experience resists clean narrative. Displacement is not a story with a beginning and a resolved end.",
  "body": "[spotify:artist/6IiZemRMna678qNhiRkYI5]\n\nThe difficulty of writing about displacement is that the experience resists clean narrative. Displacement is not a story with a beginning and a resolved end. It is an ongoing condition, a particular quality of attention calibrated over years of knowing that the ground you stand on now is not the only ground you have ever stood on. Azniv Korkejian, who records as Bedouine, was born in Syria, raised between Saudi Arabia and Texas, and has spent the adult chapters of her life in Los Angeles. Her music has always understood this condition not as something to overcome but as something to draw from: a store of sensory detail, language heard and half-remembered, light in particular rooms at particular hours.\n\n\"Neon Summer Skin,\" her fourth album and first for Thirty Tigers, extends this understanding into the most personal terrain she has yet explored. The eleven tracks span forty-one minutes and move with the quality of a long afternoon in a place you know you are about to leave. There is no urgency here, but there is a weight that comes from understanding what it means for time to pass and from choosing to be present for it rather than look somewhere else.\n\nThe album's backstory is essential and gives the music its particular gravity. Korkejian traveled to Saudi Arabia to visit her parents when they told her the visit might be her last, as they planned to relocate to Armenia. That trip becomes the emotional center of this record, not as a theme to be stated but as a ground condition, a before and after that inflects every arrangement, every vocal choice, every melodic turn. You do not need to know the backstory to feel it. The music carries it in ways that are more reliable than explanation.\n\n## The Sound of Coming From Somewhere\n\nWhat distinguishes \"Neon Summer Skin\" from Bedouine's earlier work is a deepening of the sonic palette without any loss of intimacy. The folk guitar and spare arrangements that defined her 2017 debut are still present, but they exist here alongside bossa nova variations, space-age keyboards, orchestral gestures, and production choices that feel informed by psychedelia without committing to the genre's more disorienting extremes. Producer Jonathan Rado, who has worked with Foxygen and Weyes Blood, understands how to make a record that sounds personal without sounding small. The musicians include Korkejian's partner Guy Syffert and the D'Addario brothers from The Lemon Twigs, whose own music demonstrates a similar commitment to finding warmth within formal ambition.\n\nThe title track is the album's most explicit statement of its concerns. It laments the passage of time and the ways certain things exist now only in memory: a specific quality of light, a texture of summer skin, a version of the self that cannot be recovered. The title phrase is strange and specific in the way that the best folk-adjacent titles are, arriving with the force of an image from a dream you can still see hours after waking.\n\n\"Canopies\" is the album's most formally unusual track, built around a recorded conversation between Korkejian and her mother about her mother's time in an orphanage. The decision to embed this document into the album transforms it from a collection of personal songs into something that carries the weight of generations. The orphanage her mother describes is gone now. The conversation captures something that would otherwise exist only in the dissolving memory of one person. By placing it inside the music, Korkejian makes it permanent in the way that only recorded sound can be permanent.\n\nThe track \"Deghma Cheega\" deploys language from outside English, a linguistic choice that is less about accessibility than about precision. The sounds of a language tied to a specific geography and family history carry things that translation cannot carry. This is consistent with the album's broader project: not making the foreign familiar, but making the familiar foreign enough to see clearly.\n\n## The Politics of Staying Particular\n\nThere is a political dimension to \"Neon Summer Skin\" that operates quietly, without announcement. Korkejian's biographical details, Syrian birth, Saudi childhood, American adulthood, Armenian heritage, describe a life shaped by forces that have nothing to do with personal choice. The displacement that runs through this record is not the displacement of wanderlust or artistic restlessness. It is the displacement of people whose options have been constrained by history, by geography, by the decisions of states about whose movement is permitted and whose is not.\n\nThe music does not make this argument directly. It makes it by being so precisely located in personal experience that the listener understands, without being told, that this precision is itself a kind of act. A refusal to become abstract, to be subsumed into category or statistic. Songs that name specific instruments from a specific childhood, that embed an actual conversation about an actual orphanage, that use the title phrase to name a specific physical memory, are doing something that political writing rarely manages: making the general legible through the particular without losing either in the process.\n\n## An Artist Who Trusts the Work\n\nBedouine has now made four records, and the trajectory is clear. Each album has deepened the project without narrowing it. \"Neon Summer Skin\" is the most fully realized of the four, not because it is the most ambitious in scope, but because it is the most coherent in its ambitions. Every element, the sound, the structure, the thematic material, the decision to use a recorded family conversation as a piece of music, works together toward a single effect: the experience of being in close proximity to something that is passing, and choosing to pay attention to it fully rather than look away.\n\nThe record closes with \"White Patent Leather,\" a song that does what the best closing tracks do. It holds the emotional charge of everything that has preceded it without explaining it. It trusts the listener to have been paying attention, to have accumulated the record's texture over its forty-one minutes, and to understand what the final notes mean without having them spelled out. That kind of trust between an artist and an audience is not earned quickly. It is built across a body of work. \"Neon Summer Skin\" shows that Bedouine has built it, and that she knows how to use it.\n\n[download:/assets/images/artists/bedouine-neon-summer-skin-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: bedouine-neon-summer-skin.json"

# Verify live
echo "Verifying bedouine-neon-summer-skin..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/bedouine-neon-summer-skin)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/bedouine-neon-summer-skin&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: bedouine-neon-summer-skin"

fi  # end skip block


# ---- POST 2: Navy Blue - Sir Render ----
echo "--- Deploying: navy-blue-sir-render ---"

if [ -f ~/artonly.io/posts/navy-blue-sir-render.json ]; then
  echo "Post already exists: navy-blue-sir-render.json, skipping"
else

# Download press photo
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/navy-blue-sir-render.jpg'

# Try Underground Hip Hop Blog review
try:
    html = fetch('https://undergroundhiphopblog.com/albums/sir-render-finds-navy-blue-grappling-with-his-previous-self-album-review/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'navy' in i.lower() or 'sir-render' in i.lower() or 'underground' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://undergroundhiphopblog\.com/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://undergroundhiphopblog.com/')
        print('Downloaded from Underground Hip Hop Blog')
        sys.exit(0)
except Exception as e:
    print(f'Underground Hip Hop Blog failed: {e}')

# Try Pitchfork review
try:
    html = fetch('https://pitchfork.com/reviews/albums/navy-blue-sir-render/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try Shatter the Standards
try:
    html = fetch('https://www.shatterthestandards.com/p/album-review-sir-render-by-navy-blue')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'navy' in i.lower() or 'sir' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.shatterthestandards.com/')
        print('Downloaded from Shatter the Standards')
        sys.exit(0)
except Exception as e:
    print(f'Shatter the Standards failed: {e}')

# Try Hip Hop Golden Age
try:
    html = fetch('https://hiphopgoldenage.com/navy-blue-sir-render-review/')
    imgs = re.findall(r'(https?://[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'navy' in i.lower() or 'sir' in i.lower() or 'hiphop' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://hiphopgoldenage\.com/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://hiphopgoldenage.com/')
        print('Downloaded from Hip Hop Golden Age')
        sys.exit(0)
except Exception as e:
    print(f'Hip Hop Golden Age failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a14-#14141e\" -gravity center -pointsize 52 -fill white -annotate 0 \"Navy Blue\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/navy-blue-sir-render.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/navy-blue-sir-render-up.jpg && \
  mv ~/artonly.io/assets/images/artists/navy-blue-sir-render-up.jpg \
     ~/artonly.io/assets/images/artists/navy-blue-sir-render.jpg
echo "Image upscaled: navy-blue-sir-render.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py navy-blue-sir-render "Sir Render Is Navy Blue at His Most Exposed and His Most Complete" music
echo "Social card generated: navy-blue-sir-render-social-9x16.jpg"
cd ~

# Deploy JSON post
cat > ~/artonly.io/posts/navy-blue-sir-render.json << 'ENDJSON'
{
  "slug": "navy-blue-sir-render",
  "title": "Sir Render Is Navy Blue at His Most Exposed and His Most Complete",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-06-11",
  "image": "/assets/images/artists/navy-blue-sir-render.jpg",
  "image_alt": "Navy Blue press photo",
  "image_position": "center 20%",
  "description": "The title is a pun and also a program. To surrender is to give something up. To render is to deliver, to make available, to produce something for presentation.",
  "body": "[spotify:artist/5qRbfEf4Ooo19aRXKQzvUV]\n\nThe title is a pun and also a program. To surrender is to give something up. To render is to deliver, to make available, to produce something for presentation. \"Sir Render,\" the play on words that Sage Elsesser deploys as the title of his third studio album, splits the phrase simultaneously in both directions, suggesting an act that is both a release and a creation, both an ending and a beginning. This doubling is not accidental. The album is exactly this: a surrender that produces something, a laying down of weight that makes a different kind of clarity visible.\n\n\"Sir Render\" is the final record in a trilogy that began with \"Song of Sage: Post Panic!\" in 2021 and continued through \"The Sword and the Soaring\" in 2022. It functions as a prequel to both, turning back toward the darkness and the unresolved weight that preceded those records' moments of spiritual forward motion. The trilogy, understood in sequence, moves through time and outward in emotional range. This final chapter goes back to the root, to the capsizing, to the moment before the turn that the earlier albums documented.\n\nElsesser grew up in New York and came up through the underground network that connected him with artists like MIKE, Mach-Hommy, and Earl Sweatshirt. He began as a skateboarder, model, and collaborative presence before his own recordings established him as one of the more singular voices operating in the space where jazz-informed underground hip-hop meets lyric poetry and spiritual inquiry. His work has never been loud about its concerns. It proceeds by accumulation rather than announcement, and the best tracks in his catalog tend to arrive at their fullest meaning only after multiple listens, when the density of the language has settled and the emotional geography of the record becomes navigable.\n\n## The Sound of Stripping Back\n\nWhere \"The Sword and the Soaring\" felt expansive, bright, and musically lush, \"Sir Render\" is cold, stark, and deliberately unpolished. The production is minimal, often drumless, built around abstract textures and spare melodic fragments that support rather than frame the vocals. This is a choice about what kind of honesty the material requires. The songs on this record are not looking for shelter in production. They are looking for exposure.\n\nThe fifteen tracks run just under forty-five minutes and move with the logic of a session that has decided to go somewhere difficult and stay there until the work is finished. The opening track \"Commencement\" establishes the terms without ceremony: a drumless intro in which Elsesser addresses the experience of capsizing and the decision to turn his life over to God. This is not the language of religious performance or the language of conversion narrative. It is the language of a person who has found, through the specific pressure of his own experience, that the self requires something to surrender to in order to remain intact.\n\n## The Collaborators as Witnesses\n\nThe features on \"Sir Render\" are not decorative. Armand Hammer and Earl Sweatshirt appear as voices from within the same tradition of thoughtful, serious hip-hop that Elsesser inhabits and has helped define. Their presence is a form of verification, a way of locating this record within a community of artists who share its commitments and can therefore speak to its terms.\n\nThe most significant appearance is the posthumous feature from Ka, the Brownsville rapper and poet who died in September 2024 and left behind one of the most rigorous and quietly devastating bodies of work in the history of American hip-hop. His presence on \"Circa\" carries an emotional weight that cannot be separated from the knowledge of his absence. The track addresses the experience of being healed by people we can no longer hear from directly, of being shaped by presences that have become memory. To listen to it is to hold two things simultaneously: the music as it is, precise and calm and fully itself, and the fact of the person who made it, who is no longer here. This is what posthumous recordings do at their best. They do not resolve into grief. They ask grief to coexist with the work, which is a harder and more generous demand.\n\n## Surrender as Practice\n\nThe underlying argument of \"Sir Render\" is that surrender is not weakness. It is a specific kind of strength: the strength to stop performing certainty, to stop carrying what cannot be carried alone, to acknowledge that the conditions of a life shaped by urban hardship and accumulating loss are not conditions that can be resolved by individual will alone.\n\nThis is not a new argument in hip-hop. The genre has been wrestling with spirituality, surrender, and the specific weight of Black urban experience in America since its inception. What distinguishes Elsesser's handling of these themes is precision. He does not reach for abstraction when the particular will do. He does not use the language of spiritual aspiration to avoid the language of specific pain. The record is full of images that locate their meaning in exact detail rather than in gesture.\n\nThere is also something in the collaborative scale of this record worth noting. Elsesser has worked in community throughout his career, and \"Sir Render\" reflects that orientation. The features, the production contributors, the context of Freedom Sounds, his own imprint, all suggest an artist who understands that the work of consciousness, the specific work this album is doing, is not a solitary project. It requires witnesses. It requires community. The surrender the album describes is personal, but the context in which it takes place is shared.\n\nBy the record's final moments, the surrender the title promises has been completed. What has been rendered, what the album has produced and delivered, is the record itself: fifteen tracks that tell the truth about what it costs to still be here, and why being here still matters.\n\n[download:/assets/images/artists/navy-blue-sir-render-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: navy-blue-sir-render.json"

# Verify live
echo "Verifying navy-blue-sir-render..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/navy-blue-sir-render)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/navy-blue-sir-render&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: navy-blue-sir-render"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Bedouine / Thirty Tigers
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@thirtytigers.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Bedouine and the new album Neon Summer Skin at artonly.io/post/bedouine-neon-summer-skin. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@thirtytigers.com (Bedouine)"

# Navy Blue / Freedom Sounds
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=navybluethetruest@gmail.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Navy Blue and the new album Sir Render at artonly.io/post/navy-blue-sir-render. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: navybluethetruest@gmail.com (Navy Blue)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-11" "Published today:

1. Bedouine - Neon Summer Skin
   https://artonly.io/post/bedouine-neon-summer-skin
   Author: Leelou Blanc
   Spotify: 6IiZemRMna678qNhiRkYI5
   Released: June 5, 2026 (Thirty Tigers)
   11 tracks, 41 minutes, fourth album
   Themes: displacement, family history, Armenian-Syrian heritage, memory

2. Navy Blue - Sir Render
   https://artonly.io/post/navy-blue-sir-render
   Author: Allastair Voss
   Spotify: 5qRbfEf4Ooo19aRXKQzvUV
   Released: June 5, 2026 (Freedom Sounds)
   15 tracks, 45 minutes, trilogy closer
   Features: Armand Hammer, Earl Sweatshirt, Ka (posthumous)

Outreach:
- Bedouine: email sent to press@thirtytigers.com
- Navy Blue: email sent to navybluethetruest@gmail.com

Both releases from June 5, 2026, confirmed not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-11 ==="
