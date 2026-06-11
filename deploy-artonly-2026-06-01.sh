#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-01
# Posts: feeble-little-horse-bitknot, iceage-for-love-of-grace-and-the-hereafter
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-01.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-01 ==="

# ---- POST 1: feeble little horse - bitknot ----
echo "--- Deploying: feeble-little-horse-bitknot ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/feeble-little-horse-bitknot.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/feeble-little-horse-bitknot/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://www.stereogum.com/featured/feeble-little-horse-bitknot/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:feeble|little|horse)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+stereogum[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://www.saddlecreek.com/artists/feeble-little-horse/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:feeble|little|horse|press)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://saddlecreek\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.saddlecreek.com/')
        print('Downloaded from Saddle Creek')
        sys.exit(0)
except Exception as e:
    print(f'Saddle Creek failed: {e}')

try:
    html = fetch('https://www.pastemagazine.com/music/feeble-little-horse/feeble-little-horse-bitknot-album-review')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'feeble' in i.lower() or 'little' in i.lower() or 'horse' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+paste[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.pastemagazine.com/')
        print('Downloaded from Paste')
        sys.exit(0)
except Exception as e:
    print(f'Paste failed: {e}')

try:
    html = fetch('https://daily.bandcamp.com/album-of-the-day/feeble-little-horse-bitknot-review')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:feeble|little|horse)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+bandcamp[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://daily.bandcamp.com/')
        print('Downloaded from Bandcamp Daily')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp Daily failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#12100e-#2a2218\" -gravity center -pointsize 52 -fill white -annotate 0 \"feeble little horse\" {dest}')
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/feeble-little-horse-bitknot.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/feeble-little-horse-bitknot-up.jpg && \
  mv ~/artonly.io/assets/images/artists/feeble-little-horse-bitknot-up.jpg \
     ~/artonly.io/assets/images/artists/feeble-little-horse-bitknot.jpg
echo "Image upscaled: feeble-little-horse-bitknot.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py feeble-little-horse-bitknot "feeble little horse Find the Human Signal Inside the Digital Noise on bitknot" music
echo "Social card generated: feeble-little-horse-bitknot-social-9x16.jpg"
cd ~

cat > ~/artonly.io/posts/feeble-little-horse-bitknot.json << 'ENDJSON'
{
  "slug": "feeble-little-horse-bitknot",
  "title": "feeble little horse Find the Human Signal Inside the Digital Noise on bitknot",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-06-01",
  "image": "/assets/images/artists/feeble-little-horse-bitknot.jpg",
  "image_alt": "feeble little horse press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/2GJa7lPCjAB1rKXptXrfy8]\n\nThe tension that has defined feeble little horse since their 2022 debut \"Hayday\" is one that runs through the entire history of indie rock: how loud do you need to be to communicate something true? The Pittsburgh trio, built around vocalist Lydia Slocum alongside Sebastian Kinsler and Jake Kelley, established their early identity on a collision of sweet pop melodies and guitar-forward noise, the kind of blown-out shoegaze-adjacent density that made their 2023 breakthrough \"Girl with Fish\" one of the more striking records of that year. They sounded like they were yelling through foam, urgency communicated through mass and pressure. Melody was always present, but you had to work through a wall of sound to find it. The music was, in that way, perfectly of its moment: a lot going on, not much of it easy to hold.\n\n\"bitknot,\" their third full-length released May 26 on Saddle Creek, reconfigures that equation almost entirely. The guitar wall steps back. The glitchy, clipped digital textures that were always present at the edge of feeble little horse's music move to the center. Slocum's voice, previously swamped by the surrounding sound on their more aggressive material, becomes the dominant fact of the record. The noise is still present, but it is chosen noise, placed noise, noise in service of something specific rather than noise as a default condition.\n\nThis is not a simple record to categorize. If their earlier work could be described as pop-curious noise rock, bitknot is something closer to rock-curious noise pop. The distinction is not merely taxonomic. It represents a decision about where the weight goes: toward the melody, toward the voice, toward the particular anxieties that Slocum's lyrics are processing. What those anxieties involve, broadly, is being alive and visible and female and online in 2026, navigating a self that is always partially seen through someone else's feed, always measured against a filtered version that may or may not correspond to anything real.\n\n## bitknot and the Condition of the Feed\n\n[img:/assets/images/artists/feeble-little-horse-bitknot.jpg]\n\nThere is a specific cultural anxiety that has been accumulating for a decade and has not yet found its definitive artistic statement. The anxiety involves identity formation under conditions of constant visibility, the sense that the self is always being assessed and compared, always one scroll away from obsolescence. Writers, filmmakers, and musicians have circled this territory repeatedly without quite landing at its center. bitknot does not fully land there either, but it comes closer than most contemporary records, because it takes the anxiety as a given rather than a subject to be examined from a critical distance. Slocum does not explain what it is like to live inside this condition. She just lives it, in the music.\n\nThe track called \"Shopping\" is the most direct expression: a Speedy Ortiz-influenced pop construction about wanting the shoes an influencer is wearing, which sounds like a limited subject until you realize it is not about consumption but about aspiration and its discontents. About the particular way that wanting something someone else has in 2026 differs from wanting it in any prior moment of human experience. The algorithm removes the mystery of acquisition. The gap between seeing and having has narrowed to the point where wanting itself is the only state with any texture remaining.\n\nOther tracks engage less directly with platform mechanics but carry the same ambient unease. The album moves through territories of attention and its costs, the difficulty of staying still when movement feels mandatory, the way constant visibility both enables and forecloses genuine exposure. bitknot is consistent in its preoccupations without being repetitive about them. The restraint is a form of discipline, and discipline turns out to be the record's most distinguishing quality.\n\n## Slocum at the Center\n\nWhat makes bitknot work, where similar records have struggled, is the quality of Slocum's performance. She has the rare ability to sound completely present in the moment of singing without sounding exposed, to project intimacy without collapsing the distance between herself and the listener entirely. This is not a confessional record in the way that the term has been overused in contemporary indie pop. Slocum does not explain herself. She observes, and the observation carries its own authority.\n\nThe production surrounding her voice is designed to support and not overwhelm that quality. Kinsler and Kelley build textures that feel both mechanical and warm, digital in their construction but human in their effect. The glitchy elements never feel like decoration. They feel like the actual surface of the experience being described. In 2026, the digital environment is not a metaphor for alienation. It is the actual medium in which alienation, and its opposite, occur. bitknot understands this without making it a thesis.\n\nThe restraint is mutual throughout. Slocum's delivery is calibrated to the level of frankness the song requires at each moment, neither withholding more than necessary nor giving more than is warranted. This precision is what transforms bitknot from a collection of good songs into something that feels like a complete and considered statement.\n\n## A Record Still Becoming Itself\n\nbitknot is not a flawless record. The final third loses some of the album's accumulated momentum, and the title track itself, which ought to function as a kind of summary statement, is less formally resolved than the songs around it. There are moments where the glitch aesthetic tips from purposeful to fussy, where texture feels like a decision made for its own sake rather than for meaning.\n\nThese are real complaints. They do not override the album's genuine strengths, but they give it the dimension of work that is reaching for something slightly beyond its current grasp, which is often exactly where the most interesting records live. There is a faint sense in the back half that the band had more to say but ran out of the formal tools to say it with. This is the kind of problem that resolves itself between albums, and it is a far better problem to have than the opposite one.\n\nWhether bitknot belongs to the catalogue of great third albums or the catalogue of great second attempts at becoming a great record is a question the band will answer in time. What it clearly is, right now, is the most direct and most revealing document they have made. It shows, with considerable clarity, what they are about, what they are capable of, and what they are still working toward.\n\n[download:/assets/images/artists/feeble-little-horse-bitknot-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: feeble-little-horse-bitknot.json"

echo "Verifying feeble-little-horse-bitknot..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/feeble-little-horse-bitknot)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/feeble-little-horse-bitknot&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: feeble-little-horse-bitknot"


# ---- POST 2: Iceage - For Love of Grace & the Hereafter ----
echo "--- Deploying: iceage-for-love-of-grace-and-the-hereafter ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/iceage-for-love-of-grace-the-hereafter/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://mexicansummer.com/release/iceage-for-love-of-grace-the-hereafter/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:iceage|grace|hereafter)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://mexicansummer\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://mexicansummer.com/')
        print('Downloaded from Mexican Summer')
        sys.exit(0)
except Exception as e:
    print(f'Mexican Summer failed: {e}')

try:
    html = fetch('https://www.thefader.com/2026/04/07/iceage-for-love-of-grace-and-the-hereafter-release-date-details-tracklist')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:iceage)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+thefader[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thefader.com/')
        print('Downloaded from The Fader')
        sys.exit(0)
except Exception as e:
    print(f'The Fader failed: {e}')

try:
    html = fetch('http://post-trash.com/news/2026/5/26/iceage-for-love-of-grace-amp-hereafter-album-review')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:iceage)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+squarespace[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='http://post-trash.com/')
        print('Downloaded from Post-Trash')
        sys.exit(0)
except Exception as e:
    print(f'Post-Trash failed: {e}')

try:
    html = fetch('https://www.pastemagazine.com/music/iceage/iceage-for-love-of-grace-the-hereafter-album-review')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'iceage' in i.lower() or 'grace' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+paste[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.pastemagazine.com/')
        print('Downloaded from Paste')
        sys.exit(0)
except Exception as e:
    print(f'Paste failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0d0f14-#1a1e28\" -gravity center -pointsize 52 -fill white -annotate 0 \"Iceage\" {dest}')
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter-up.jpg && \
  mv ~/artonly.io/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter-up.jpg \
     ~/artonly.io/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter.jpg
echo "Image upscaled: iceage-for-love-of-grace-and-the-hereafter.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py iceage-for-love-of-grace-and-the-hereafter "Iceage Find Grace in the Unadorned on For Love of Grace and the Hereafter" music
echo "Social card generated: iceage-for-love-of-grace-and-the-hereafter-social-9x16.jpg"
cd ~

cat > ~/artonly.io/posts/iceage-for-love-of-grace-and-the-hereafter.json << 'ENDJSON'
{
  "slug": "iceage-for-love-of-grace-and-the-hereafter",
  "title": "Iceage Find Grace in the Unadorned on For Love of Grace and the Hereafter",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-06-01",
  "image": "/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter.jpg",
  "image_alt": "Iceage press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/03hlOXqRyyXO3ectp3eEbU]\n\nWhen Iceage were teenagers in Copenhagen, making the music that would become their 2011 debut \"New Brigade,\" they were operating in a condition of pure instinct. The record was eleven minutes of post-hardcore noise played by four boys who had not yet developed the self-consciousness to second-guess what they were doing. It was remarkable partly for what it was and partly for what it seemed to promise: a band that might take this raw material somewhere extraordinary, if it survived its own velocity.\n\nIn the years since, Iceage have survived and then considerably more. They have made five more records across fifteen years, each extending their reach in a different direction. Literary density on \"You're Nothing.\" Country-baroque sprawl on \"Plowing into the Field of Love.\" Orchestral ambition on \"Beyondless.\" Gospel-inflected ecstasy on \"Seek Shelter.\" Lead vocalist Elias Rønnenfelt became, in the process, one of the more compelling performers of his generation, developing a practice that accommodates both raw physical urgency and studied theatrical distance. What he did not become, until this record, is simply direct.\n\n\"For Love of Grace and the Hereafter,\" Iceage's sixth studio album released May 29 on Mexican Summer, is their most stripped-back record in over a decade. Produced in the same remote Swedish house where they recorded \"Plowing into the Field of Love,\" it carries the weight of that choice, the deliberate return to a space associated with their most critically admired work, without reproducing the sound of that work. What it produces instead is something leaner and more urgent, more focused on the direct transaction between Rønnenfelt's voice and the listener. Some distance has been closed.\n\n## The Return to Silence Studio\n\n[img:/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter.jpg]\n\nSilence Studio, a house in rural Sweden near the Norwegian border, is a significant address in Iceage's history. The sessions there in 2014 produced \"Plowing into the Field of Love,\" which marked the moment the band crystallized into something more than their punk origins, demonstrating a command of instrumentation, arrangement, and emotional register that placed them in a broader literary tradition. Returning to the same house for the sixth album is not accidental, and critics have largely treated the choice as thematic: a deliberate recurrence to conditions of creative intensity that proved generative before.\n\nWhat the return actually produced is worth examining carefully. \"Plowing\" was baroque in its approach, ornate in its commitment to string arrangements and unexpected instrumental textures. \"For Love of Grace and the Hereafter\" does the opposite: it strips those layers back to something more essential, guitars and rhythm and Rønnenfelt's voice and the specific atmosphere that a particular building in a particular landscape generates. What the two records share is not a sound but a quality of seriousness about the work, a refusal to be careless about where the music is going.\n\nThe stripped-back approach is not a simplification. It is a concentration. The twelve tracks work through constraint, each element present because it contributes something specific. The handclaps and pennywhistle that arrive mid-song on \"The Weak\" are not decorative flourishes. They are structural elements that change the temperature of the track at the moment when it needs to change. This kind of writing requires confidence and restraint in equal measure.\n\n## Rønnenfelt's New Vocabulary\n\nPrevious Iceage records placed Rønnenfelt in a specific post-punk tradition: the controlled-threat lineage that includes Nick Cave and Mark E. Smith, artists who use the voice as an instrument of cultivated menace. That mode served the band's earlier work well. It provided an aesthetic gravity that kept the music from collapsing into mere aggression or mere atmosphere.\n\nOn \"For Love of Grace and the Hereafter,\" something different is happening. The performance quality across the album's twelve tracks is more physically present, less mediated by aesthetic persona. Opener \"Ember\" establishes this immediately, Rønnenfelt delivering a deadpan rock monologue that communicates precisely through its flatness, its refusal to reach for effect. The album proceeds from that starting point into territory that requires more range, and Rønnenfelt provides it. By \"True Blue,\" the closing track, the voice is carrying weight the album has been accumulating from the first note.\n\n## What the Title Is Doing\n\n\"For Love of Grace and the Hereafter\" operates at several levels simultaneously. Grace in the secular sense: elegance, the quality of doing something well without visible effort. Grace in the theological sense: unearned goodness, the gift that cannot be compelled or forced. The Hereafter: what comes after, what survives the conditions that produced it. The album title is, in this reading, a statement of orientation: the work is made out of love for what persists beyond the present moment.\n\nFor a band that has spent fifteen years making music about violence and beauty and the relationship between them, this represents a shift in emphasis rather than a change of subject. Iceage have always been interested in what survives. They have spent most of their career approaching that interest through confrontation and wreckage. \"For Love of Grace and the Hereafter\" suggests the possibility of approaching it differently, through directness and concentration, without abandoning the seriousness that has always marked their work.\n\nThe result, across twelve tracks, is the most resolved album Iceage have made. \"Star\" and \"Lifetime\" are the most melodically open songs in their catalogue, tracks that suggest where the band might go if they continued in this direction. \"Holy Water\" introduces a trace of earlier ornamentation before \"True Blue\" closes on sustained intensity. After fifteen years of oblique approaches, Iceage have made the direct statement, and it turns out the directness was the point all along.\n\n[download:/assets/images/artists/iceage-for-love-of-grace-and-the-hereafter-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: iceage-for-love-of-grace-and-the-hereafter.json"

echo "Verifying iceage-for-love-of-grace-and-the-hereafter..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/iceage-for-love-of-grace-and-the-hereafter)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/iceage-for-love-of-grace-and-the-hereafter&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: iceage-for-love-of-grace-and-the-hereafter"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# feeble little horse / Saddle Creek
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@saddlecreek.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on feeble little horse and the new album bitknot at artonly.io/post/feeble-little-horse-bitknot. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@saddlecreek.com (feeble little horse)"

# Iceage / Mexican Summer
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@mexicansummer.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Iceage and the new album For Love of Grace and the Hereafter at artonly.io/post/iceage-for-love-of-grace-and-the-hereafter. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@mexicansummer.com (Iceage)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-01" "Published today:

1. feeble little horse - bitknot
   https://artonly.io/post/feeble-little-horse-bitknot
   Author: Leelou Blanc
   Spotify: 2GJa7lPCjAB1rKXptXrfy8
   Released: May 26, 2026 (Saddle Creek)
   3rd album, Pittsburgh trio

2. Iceage - For Love of Grace and the Hereafter
   https://artonly.io/post/iceage-for-love-of-grace-and-the-hereafter
   Author: Allastair Voss
   Spotify: 03hlOXqRyyXO3ectp3eEbU
   Released: May 29, 2026 (Mexican Summer)
   6th album, Danish quintet

Outreach:
- feeble little horse: email sent to press@saddlecreek.com
- Iceage: email sent to press@mexicansummer.com

Both releases from May 26-29, 2026, not previously covered on ArtOnly.
Note: SSH to DreamHost unavailable from cloud environment. Deploy script at deploy-artonly-2026-06-01.sh in GitHub repo."

echo "=== Deploy complete: 2026-06-01 ==="
