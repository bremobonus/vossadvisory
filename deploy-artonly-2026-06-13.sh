#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-13
# Posts: wiki-ancient-history, dj-seinfeld-if-this-is-it
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-13.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-13 ==="
echo "$(date)"

OMP_NUM_THREADS=1
export OMP_NUM_THREADS

IMAGES_DIR="/home/dh_yadmw3/artonly.io/assets/images/artists"
POSTS_DIR="/home/dh_yadmw3/artonly.io/posts"
AGENT_DIR="/home/dh_yadmw3/artonly.io/agent"

# ============================================================
# POST 1: Wiki - Ancient History
# ============================================================
echo ""
echo "--- Deploying: wiki-ancient-history ---"

if [ -f "$POSTS_DIR/wiki-ancient-history.json" ]; then
  echo "Post already exists: wiki-ancient-history.json, skipping"
else

python3 << 'PYEOF'
import urllib.request, re, sys, os

def fetch(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
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
            raise Exception('Image too small: {} bytes'.format(len(data)))
        f.write(data)
    print('Saved {} bytes to {}'.format(len(data), dest))

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/wiki-ancient-history.jpg'

sources = [
    ('https://www.brooklynvegan.com/wiki-announces-new-lp-ancient-history-ft-your-old-droog-duendita-more-shares-park/', 'https://www.brooklynvegan.com/'),
    ('https://stereogum.com/2499649/wiki-announces-new-album-ancient-history-hear-park/music', 'https://stereogum.com/'),
    ('https://www.shatterthestandards.com/p/album-review-ancient-history-by-wiki', 'https://www.shatterthestandards.com/'),
    ('https://www.hotnewhiphop.com/998249-ancient-history-wiki', 'https://www.hotnewhiphop.com/'),
]

for page_url, referer in sources:
    try:
        html = fetch(page_url, referer)
        imgs = re.findall(r'https?://\S+\.(?:jpg|jpeg)', html, re.IGNORECASE)
        imgs = [i for i in imgs if any(k in i.lower() for k in ['wiki', 'ancient', 'morales', 'ratking'])]
        if not imgs:
            imgs = [i.strip('"') for i in re.findall(r'https?://\S+\.(?:jpg|jpeg)', html, re.IGNORECASE) if len(i) > 50][:5]
        for img_url in imgs[:3]:
            try:
                download_img(img_url, dest, referer)
                print('Downloaded from: {}'.format(page_url))
                sys.exit(0)
            except Exception as e2:
                print('img failed {}: {}'.format(img_url[:60], e2))
    except Exception as e:
        print('Page failed {}: {}'.format(page_url[:60], e))

print('All sources failed; generating placeholder')
os.system('convert -size 1200x800 gradient:"#0a0a14-#14100a" -gravity Center -pointsize 72 -fill white -annotate 0 "Wiki" ' + dest)
PYEOF

OMP_NUM_THREADS=1 convert "$IMAGES_DIR/wiki-ancient-history.jpg" \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  "$IMAGES_DIR/wiki-ancient-history-up.jpg" && \
  mv "$IMAGES_DIR/wiki-ancient-history-up.jpg" \
     "$IMAGES_DIR/wiki-ancient-history.jpg"
echo "Image upscaled: wiki-ancient-history.jpg"

cd "$AGENT_DIR"
python3 make-social-card.py wiki-ancient-history "Wiki's Ancient History Finds the City in Every Crack It Leaves Behind" music
echo "Social card generated: wiki-ancient-history-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json

body = """[spotify:artist/78X7quh8fqAGZ42OpLmUW0]

The last time Wiki released a fully solo album, he was still in the process of calibrating what it meant to make music outside the collective structures that had defined his early career. Ratking, the Lower East Side group he formed with producer Sporting Life and rapper Hak, had dissolved by 2015. The solo work that followed was genuine and confident in the way that first statements often are, but it also carried the exploratory quality of a person still finding his footing in the absence of a collective's organizing principle. Oofie, in 2019, was his breakthrough as a solo voice, a loose and luminous record that trusted its own momentum without needing to justify itself. Ancient History, released June 12 on his own Wikset Enterprise imprint, is his first fully solo album since that record. It arrives with the specific clarity that comes from having spent several years deciding what to say and to whom.

What he wants to say is about New York, which is to say that it is about loss at the scale of a neighborhood and time at the scale of a life. The album's press materials described it as rooted in the city's parks, and this grounding is legible throughout the music. These are not picturesque backdrops or metaphors borrowed for aesthetic convenience. They are specific parks, the kind encountered by a person who moves through the city without the mediation of a car, who knows which benches hold a particular quality of afternoon light, who has watched the city systematically price out the communities that gave it its character. Ancient History is not a protest record in any direct sense. But it is an album about exactly that dynamic, approached from the inside, from the perspective of a person who remains in the city and is still trying to understand what is happening to it.

## The Producers as Argument

The assembly of producers on Ancient History is itself a statement of aesthetic intent. The Alchemist, whose sample-based productions create a quality of cool remove, appears alongside Nick Hakim, whose background in neo-soul opens warmer and more melodically generous territory. Navy Blue is here. Laron too. Mount Kimbie participates under the Dom Maker alias, and MIKE contributes under his dj blackpower alias. This is not a random accumulation of credibility. Each producer brings a specific relationship to the underground that the album is proposing itself as part of, and the combination produces a record that moves between emotional registers with unusual ease, without ever losing its sense of a consistent governing sensibility.

One track sits in the oceanic stillness that Alchemist productions tend to open, that quality of sampled material suspended in amber. The next arrives in the more intimate territory that Nick Hakim can create, where the production sounds like a room that contains actual air and silence. What prevents this variety from feeling disjointed is Wiki himself: his voice and writing maintain a consistent emotional temperature across very different sonic contexts. He has always been a writer whose intelligence is embedded in specificity rather than abstraction, in the particular rather than the general claim. The album's fourteen tracks include Bloom featuring duendita, All in the Lining featuring Your Old Droog, and Something New featuring Salimata. These collaborators are not decorative. They appear because they share a relationship to the city and to a tradition of New York art and life that the album is proposing itself as continuous with.

## The Underground It Occupies

Critics reaching for a descriptor for what the album is doing have landed on quietly psychedelic, and the phrase is accurate without fully explaining itself. The psychedelia on Ancient History is not the overt kind that announces itself through saturation and distortion. It is the psychedelia of extreme attention, the quality that emerges when a writer is precise enough about the familiar that it begins to feel strange and new. When a Wiki verse works at its best, it achieves exactly this quality. A line will describe something so specifically that you encounter it as if for the first time.

The tradition being invoked is specific. Reviews have located Ancient History within the post-Earl Sweatshirt underground rap lineage, the territory opened by Earl's own turn toward abstraction and introspection in the early 2010s and later developed by Navy Blue, MIKE, and their collaborators into a recognizable aesthetic position. What Wiki brings to this lineage is the additional weight of a persistent relationship to a specific geography. His writing sits in the tradition of Biggie and Wu-Tang simultaneously, which means the abstract and the concrete coexist in the same verse without producing friction. The melodic directness that features like duendita's appearance on Bloom introduce does not soften the intelligence of the surrounding material. It expands what that intelligence can hold.

## What the Return Reveals

The first solo album of an artist's career announces. The return to solo territory after years of collaboration reveals. It shows what the artist chooses to do with accumulated time and accumulated attention, what they deepen versus what they discard, what they have been saving for the moment when the work is entirely their own. Wiki has been making music in various configurations since his teenage years in a city that has changed dramatically around him. Ancient History is the album made by someone who has absorbed that change without being determined by it. He is still inside his subject matter, still invested in the present tense of the city rather than in mourning its past, still finding new formal strategies for describing what the place is rather than what it was.

The fourteen tracks run with economy. Nothing overstays. The album is generous without being excessive, which is itself a form of discipline and a reflection of what the music documents. New York, at least the New York that Wiki inhabits, is not excessive. It is dense and layered and economical in the way that dense things are economical, containing multitudes in a compressed space. Ancient History holds that quality in its production and pacing. It trusts its material to carry weight without extension. The record closes with the title track, which functions as both summary and continuation. It ends without concluding, which is exactly what the city does, and exactly what the best records about specific places have always done.

[download:/assets/images/artists/wiki-ancient-history-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "wiki-ancient-history",
    "title": "Wiki's Ancient History Finds the City in Every Crack It Leaves Behind",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-13",
    "image": "/assets/images/artists/wiki-ancient-history.jpg",
    "image_alt": "Wiki press photo",
    "image_position": "center 20%",
    "body": body
}

with open('/home/dh_yadmw3/artonly.io/posts/wiki-ancient-history.json', 'w') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)

print("JSON deployed: wiki-ancient-history.json")
PYEOF

echo "Verifying wiki-ancient-history..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/wiki-ancient-history)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/wiki-ancient-history&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""
echo "IndexNow pinged: wiki-ancient-history"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@wikset.nyc" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Wiki and the new album Ancient History at artonly.io/post/wiki-ancient-history. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@wikset.nyc (Wiki)"

fi  # end skip block wiki


# ============================================================
# POST 2: DJ Seinfeld - If This Is It
# ============================================================
echo ""
echo "--- Deploying: dj-seinfeld-if-this-is-it ---"

if [ -f "$POSTS_DIR/dj-seinfeld-if-this-is-it.json" ]; then
  echo "Post already exists: dj-seinfeld-if-this-is-it.json, skipping"
else

python3 << 'PYEOF'
import urllib.request, re, sys, os

def fetch(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
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
            raise Exception('Image too small: {} bytes'.format(len(data)))
        f.write(data)
    print('Saved {} bytes to {}'.format(len(data), dest))

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it.jpg'

sources = [
    ('https://www.martincid.com/music-en/dj-seinfeld-if-this-is-it-2/', 'https://www.martincid.com/'),
    ('https://wearesoundspace.com/dj-seinfeld-if-this-is-it-ninja-tune', 'https://wearesoundspace.com/'),
    ('https://www.buzzmag.co.uk/dj-seinfeld-if-this-is-it-album-review/', 'https://www.buzzmag.co.uk/'),
    ('https://djseinfeld.com/', 'https://djseinfeld.com/'),
]

for page_url, referer in sources:
    try:
        html = fetch(page_url, referer)
        imgs = re.findall(r'https?://\S+\.(?:jpg|jpeg)', html, re.IGNORECASE)
        imgs = [i for i in imgs if any(k in i.lower() for k in ['seinfeld', 'ninja', 'jakobsson', 'armand'])]
        if not imgs:
            imgs = [i.strip('"') for i in re.findall(r'https?://\S+\.(?:jpg|jpeg)', html, re.IGNORECASE) if len(i) > 50][:5]
        for img_url in imgs[:3]:
            try:
                download_img(img_url, dest, referer)
                print('Downloaded from: {}'.format(page_url))
                sys.exit(0)
            except Exception as e2:
                print('img failed {}: {}'.format(img_url[:60], e2))
    except Exception as e:
        print('Page failed {}: {}'.format(page_url[:60], e))

print('All sources failed; generating placeholder')
os.system('convert -size 1200x800 gradient:"#0a0a18-#100a18" -gravity Center -pointsize 52 -fill white -annotate 0 "DJ Seinfeld" ' + dest)
PYEOF

OMP_NUM_THREADS=1 convert "$IMAGES_DIR/dj-seinfeld-if-this-is-it.jpg" \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  "$IMAGES_DIR/dj-seinfeld-if-this-is-it-up.jpg" && \
  mv "$IMAGES_DIR/dj-seinfeld-if-this-is-it-up.jpg" \
     "$IMAGES_DIR/dj-seinfeld-if-this-is-it.jpg"
echo "Image upscaled: dj-seinfeld-if-this-is-it.jpg"

cd "$AGENT_DIR"
python3 make-social-card.py dj-seinfeld-if-this-is-it "DJ Seinfeld Finds Harmony in His Own Restlessness on If This Is It" music
echo "Social card generated: dj-seinfeld-if-this-is-it-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json

body = """[spotify:artist/37YzpfBeFju8QRZ3g0Ha1Q]

There is a quality of sound that only becomes audible when a room has thinned, when the social pressure of a gathering drops away and what remains is the music itself, organized for its own purposes rather than to manage an occasion. DJ Seinfeld, the Swedish producer Armand Jakobsson, has been making music aimed at exactly that quality since 2016, when he released his first recordings under a name borrowed from the American sitcom he watched obsessively in Barcelona. The lo-fi house he made in those early years, bedroom productions characterized by deliberate grain and an unperformed melancholy, found an audience almost immediately. It also found him a category. Lo-fi house was a genre in the moment of his arrival, and he became one of its representative figures not by seeking the position but by arriving there as a consequence of being honest about what he heard.

If This Is It, released June 5 on Ninja Tune, is his third album and the record that most completely leaves the original category behind. This is not surprising in retrospect. 2022's Mirrors signaled the pivot, moving from the warm-noise aesthetic of his early singles toward something more fully realized and more willing to seek the resolutions that lo-fi house by design withheld. 2024's Hopecore went further, introducing melodic ambition that his earlier work would have deflected as too direct. If This Is It arrives as the record those two albums were building toward: music made by someone who has stopped explaining himself in relation to where he started, and started making exactly the music he hears.

## The Sound of Not Explaining Yourself

The 12-track album moves through house, UK garage, and the emotional register of early 2000s trance in ways that are purposeful rather than nostalgic. The 2000s trance reference deserves particular attention because trance is a genre that has rarely recovered its critical reputation from the commercial excess of its mainstream moment. What Jakobsson hears in that tradition is not the bombast but the yearning beneath it, the specific quality of a sound designed to create collective suspension, to lift individual experience into something shared and sustained. His version does not reach for the anthemic. It reaches for what the anthemic was trying to produce before scale inflated it into spectacle. The emotional architecture is recognizable without being derivative.

The collaborators across the twelve tracks, SG Lewis, Confidence Man, TS Graye, Dan Whitlam, ARY, Moyka, and just lil, are diverse in their backgrounds and consistent in their function on the record. They bring voices into an album that might otherwise be entirely textural, and these voices do not dominate. They become part of the sonic argument, which is that feeling and intelligence are not opposites. Jakobsson has described the album as being about reflecting on the past without dwelling in it and finding harmony in restlessness. This description is more precise than artist statements typically manage to be. Restlessness as a condition is usually framed as a problem requiring resolution. If This Is It refuses that framing. The restlessness in the music, the way tracks shift register, the way melodic material arrives and then opens into something more atmospheric, is presented as a natural state rather than a transitional one. Harmony within that state is not stillness. It is a different kind of balance, one that does not require stopping.

## Ninja Tune and What It Means to Be Taken Seriously

The label context matters more than label contexts usually matter. Ninja Tune, founded in 1990 by Coldcut as a specifically independent alternative to the major label infrastructure of the moment, has spent over three decades building a catalog that spans electronic music in most of its meaningful forms. Amon Tobin, Four Tet, Actress, Bonobo, Floating Points, and many others whose work has required and rewarded the kind of attention that electronic music receives only when it is given space to be heard as music rather than functional sound design. Being signed to Ninja Tune in 2022 placed Jakobsson within that conversation, and the placement has proved illuminating in both directions. The label's catalog tells a story about what electronic music has been capable of, and If This Is It contributes to that story with something that feels genuinely new within Jakobsson's own development.

If This Is It benefits from this context because Ninja Tune's catalog trains a particular mode of listening. The label's audience knows how to approach electronic music with genuine compositional ambition, music that does not organize itself around a single climax or a recognizable structural formula. The tracks here reward patience in the specific way that serious electronic albums do: by distributing their emotional content across durations that feel intuitive rather than predetermined. The album does not rush its argument. It assumes a listener willing to follow. In a landscape where most electronic releases aim for the forty-five second hook that survives an algorithm, that assumption is itself a form of respect.

## What Arrival Sounds Like

The album's title contains the philosophical move the record is making. If this is it, then what follows is not resignation but clarity: the specific relief that comes from stopping the comparison between what is and what might have been. Jakobsson, nine years into a career that began in a genre he has since outgrown, is making music for whoever is willing to follow him into the territory he actually inhabits, which is somewhere between the bedroom and the rave, between melancholy and something closer to joy, between the local and the universal. The category of lo-fi house, which was never exactly what he was doing and was always a partial description at best, has been replaced by something harder to name and considerably more interesting.

If This Is It is the most accomplished electronic album he has made. Not the most surprising, and not the most challenging in the sense of presenting the largest number of unfamiliar ideas. But the one in which every production decision feels like it was made by someone who knew what he was trying to achieve and trusted himself to pursue it. The genre affiliations that defined his entry into public consciousness are present in the music as materials rather than as identity. He is using them rather than being used by them. That is the transition that marks a producer's maturity, and If This Is It is the record that marks it definitively. It sounds like arrival because that is what it is, and the sound of someone reaching a place they intended to reach is one of the more satisfying things music can offer.

[download:/assets/images/artists/dj-seinfeld-if-this-is-it-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "dj-seinfeld-if-this-is-it",
    "title": "DJ Seinfeld Finds Harmony in His Own Restlessness on If This Is It",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-13",
    "image": "/assets/images/artists/dj-seinfeld-if-this-is-it.jpg",
    "image_alt": "DJ Seinfeld press photo",
    "image_position": "center 20%",
    "body": body
}

with open('/home/dh_yadmw3/artonly.io/posts/dj-seinfeld-if-this-is-it.json', 'w') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)

print("JSON deployed: dj-seinfeld-if-this-is-it.json")
PYEOF

echo "Verifying dj-seinfeld-if-this-is-it..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/dj-seinfeld-if-this-is-it)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/dj-seinfeld-if-this-is-it&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""
echo "IndexNow pinged: dj-seinfeld-if-this-is-it"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@ninjatune.net" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on DJ Seinfeld and the new album If This Is It at artonly.io/post/dj-seinfeld-if-this-is-it. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@ninjatune.net (DJ Seinfeld)"

fi  # end skip block dj seinfeld


# ============================================================
# Summary email
# ============================================================
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-13" "Published today:

1. Wiki - Ancient History
   https://artonly.io/post/wiki-ancient-history
   Author: Allastair Voss
   Spotify: 78X7quh8fqAGZ42OpLmUW0
   Released: June 12, 2026 (Wikset Enterprise)
   14 tracks, first fully solo album since Oofie (2019)
   Producers: Alchemist, Nick Hakim, Navy Blue, Dom Maker, dj blackpower

2. DJ Seinfeld - If This Is It
   https://artonly.io/post/dj-seinfeld-if-this-is-it
   Author: Leelou Blanc
   Spotify: 37YzpfBeFju8QRZ3g0Ha1Q
   Released: June 5, 2026 (Ninja Tune)
   12 tracks, third album
   Features: SG Lewis, Confidence Man, TS Graye, ARY, Moyka

Outreach:
- Wiki: email sent to press@wikset.nyc
- DJ Seinfeld: email sent to press@ninjatune.net"

echo ""
echo "=== Deploy complete: 2026-06-13 ==="
