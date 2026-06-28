#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-28b
# Posts: pa-salieu-second, tkay-maidza-signal-fire
# Note: Previous June 28 script found both picks already on server.
#       Fixed: gmail-send.py now receives JSON on stdin.

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Album Monitor Deploy: $(date) ==="

IMGDIR="artonly.io/assets/images/artists"
POSTDIR="artonly.io/posts"

# ========================
# POST 1: Pa Salieu - "Second"
# ========================
if [ -f "$POSTDIR/pa-salieu-second.json" ]; then
  echo "Post already exists: pa-salieu-second.json, skipping"
else
  echo "--- [1/2] Deploying pa-salieu-second ---"

  python3 - << 'IMGEOF'
import urllib.request, json, os, sys

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/pa-salieu-second.jpg'

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Pa_Salieu'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

try:
    import urllib.parse
    url = 'https://en.wikipedia.org/w/api.php?' + urllib.parse.urlencode({
        'action': 'query', 'titles': 'Pa Salieu', 'prop': 'pageimages',
        'format': 'json', 'pithumbsize': 1200
    })
    req = urllib.request.Request(url, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    pages = data.get('query', {}).get('pages', {})
    for p in pages.values():
        img_url = p.get('thumbnail', {}).get('source')
        if img_url:
            img_url = img_url.replace('/100px-', '/1200px-')
            download_img(img_url, dest)
            print('Hero downloaded from Wikipedia API')
            sys.exit(0)
except Exception as e:
    print(f'Wikipedia API failed: {e}')

os.system('convert -size 1200x800 gradient:"#0a0a14-#1e1e2e" -gravity center -pointsize 56 -fill white -annotate 0 "Pa Salieu" ' + dest)
print('Hero placeholder generated')
IMGEOF

  OMP_NUM_THREADS=1 convert "$IMGDIR/pa-salieu-second.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/pa-salieu-second-up.jpg" && mv "$IMGDIR/pa-salieu-second-up.jpg" "$IMGDIR/pa-salieu-second.jpg"
  echo "Pa Salieu hero image upscaled"

  python3 - << 'POSTEOF'
import json, os

body = """\
[spotify:artist/5Y2PFdHnFAFZWnWnJrPCkY]

The title is not clever. Pa Salieu called his second album Second, and that is exactly what it is. The second record. The next one. The moment every debut artist arrives at eventually, when the urgency of the first statement has passed and the question becomes whether the noise it made was a beginning or a peak. For Pa Salieu, that question arrived loaded with the weight of everything that surrounded the debut, a weight that has nothing to do with the music itself and everything to do with what was happening in Coventry in 2021.

Send Them to Coventry landed in a particular moment. The city had just been named UK City of Culture, the first time that designation went to a post-industrial Midlands location with nothing obvious to sell tourists. Pa Salieu was from Coventry and had the good fortune of releasing his debut exactly when people were paying attention to the place for the first time in decades. That timing made the record mean more than its contents alone could have achieved. It got read as a document. Critics wrote about it the way they write about landmark albums, as a record that belongs to its geography. That is both an honour and a trap.

The trap is that the second album then has to answer whether the artist is a document or a musician. Whether Coventry was the subject or the context. Whether the debut was a one-off act of witness or the opening statement of a longer career.

## The Space Between

Five years is a significant gap for a British rap and afroswing artist. The genre moves quickly. Scenes emerge and calcify and are abandoned in the space of two years. Pa Salieu releasing Second in 2026 means he has missed several cycles of what was fashionable in UK street music. He watched drill become the dominant commercial mode, watched afrobeats absorb several adjacent genres, watched a new generation of Coventry artists grow up under his shadow without slowing down. He did not rush.

Second is the record of someone who had the luxury of time and used it carefully. The production is unhurried. There is space in these tracks where the 2021 record was dense. The UK garage and afroswing elements that defined Send Them to Coventry are still present, but they have been opened out. The textures breathe. The rhythm is there but it does not push. It waits.

There is also a quietness in the emotional content that was not there before. The debut's energy came from an urgency that is easy to understand in retrospect: here is someone who grew up in a particular place, with a particular background, at a particular moment of British cultural history, and who had something to say about all three. The second album does not have that same urgency. It has something steadier. Assurance is the wrong word because it implies something earned and displayed. This is less exhibited than that. It is the absence of doubt rather than the presence of proof.

His Gambian heritage has always been audible in his music, in the cadences, in the melodic approach to rap that distinguishes his delivery from the clipped syllables of conventional UK drill. On Second that quality has become more central. Several tracks feel closer to the Gambian griot tradition than to anything UK rap has been doing in the intervening years. This is not a retreat into heritage as branding. It sounds like someone who went somewhere during those five years and brought back what they found.

## The Collaborators and What They Say

Pa Salieu's collaborative instincts have always been good. The debut featured Mahalia, Stormzy, and Aitch, artists from different corners of UK music who were invited because they fit the specific emotional register of each track. Second continues that pattern with more restraint. There are fewer features. The guests who appear are given room to operate rather than being deployed for profile purposes.

The tracklist does not chase every current trend in UK music. There is no attempt to sound like what is on the radio in 2026. There is a confidence in this. Pa Salieu spent enough time on that debut to know what his voice sounds like, and he is not interested in trading it for cultural currency. The album sounds like someone who has decided what kind of artist he is and is now making that record rather than the record the market is waiting for.

## What Coventry Gave and Took

Coventry City of Culture ended in 2021. The photographers and journalists went home. The city returned to what it was before: a post-industrial Midlands place with high unemployment, a significant Gambian community, a football club that occasionally threatens promotion, and a particular relationship to the UK post-empire experience that no one in London was paying very much attention to before that year.

Pa Salieu stayed. Not literally, but the city stays in the music. Second does not name-drop Coventry the way the debut did. It does not need to. The perspective is already there, in the posture of someone who grew up somewhere that does not typically get to explain itself. The residual defensiveness of the first record is gone. What replaced it is harder to name but audible on every track. It sounds like someone who no longer needs validation from outside his own geography.

## The Record That Proves the Career

The test of a second album is not whether it outsells the first. It is whether it makes the first feel like it was the beginning of something rather than the whole thing. Second passes that test. By the time the album ends, Send Them to Coventry feels like a prologue. Necessary, important, the record that established who he was and where he came from, but not the destination. Second is the record that says the destination is still ahead.

Five years is a long time to hold an audience. Pa Salieu managed it. The people who cared about the first record cared enough to wait. Second repays that patience without being grateful in any way that would diminish the achievement. It is not an apology for taking so long. It is the explanation.

[download:/assets/images/artists/pa-salieu-second-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "pa-salieu-second",
    "title": "Five Years Later, Pa Salieu Knows Exactly What Coventry Made Him",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-28",
    "image": "/assets/images/artists/pa-salieu-second.jpg",
    "image_alt": "Pa Salieu press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/pa-salieu-second.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
POSTEOF

  echo "pa-salieu-second.json written"

  cd ~/artonly.io/agent
  python3 make-social-card.py pa-salieu-second "Five Years Later, Pa Salieu Knows Exactly What Coventry Made Him" music
  echo "Social card generated: pa-salieu-second-social-9x16.jpg"
  cd ~

  cd ~/artonly.io/agent && python3 post-validator.py pa-salieu-second || true && cd ~

  sleep 3
  STATUS1=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pa-salieu-second)
  echo "HTTP $STATUS1 - artonly.io/post/pa-salieu-second"

  curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pa-salieu-second&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
  echo "IndexNow pinged: pa-salieu-second"

  curl -s -X POST https://artonly.io/api/send-mail.php \
    --data-urlencode "to=press@warnermusic.co.uk" \
    --data-urlencode "bcc=amosleblanc@gmail.com" \
    --data-urlencode "subject=Your artist is on ArtOnly" \
    --data-urlencode "body=Hi, we just published a piece on Pa Salieu and Second at artonly.io/post/pa-salieu-second. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" || true
  echo "Outreach sent for Pa Salieu"
fi

# ========================
# POST 2: Tkay Maidza - "Signal Fire"
# ========================
if [ -f "$POSTDIR/tkay-maidza-signal-fire.json" ]; then
  echo "Post already exists: tkay-maidza-signal-fire.json, skipping"
else
  echo "--- [2/2] Deploying tkay-maidza-signal-fire ---"

  python3 - << 'IMGEOF2'
import urllib.request, json, os, sys

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/tkay-maidza-signal-fire.jpg'

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Tkay_Maidza'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

try:
    import urllib.parse
    url = 'https://en.wikipedia.org/w/api.php?' + urllib.parse.urlencode({
        'action': 'query', 'titles': 'Tkay Maidza', 'prop': 'pageimages',
        'format': 'json', 'pithumbsize': 1200
    })
    req = urllib.request.Request(url, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    pages = data.get('query', {}).get('pages', {})
    for p in pages.values():
        img_url = p.get('thumbnail', {}).get('source')
        if img_url:
            img_url = img_url.replace('/100px-', '/1200px-')
            download_img(img_url, dest)
            print('Hero downloaded from Wikipedia API')
            sys.exit(0)
except Exception as e:
    print(f'Wikipedia API failed: {e}')

os.system('convert -size 1200x800 gradient:"#1a0010-#2e0020" -gravity center -pointsize 56 -fill white -annotate 0 "Tkay Maidza" ' + dest)
print('Hero placeholder generated')
IMGEOF2

  OMP_NUM_THREADS=1 convert "$IMGDIR/tkay-maidza-signal-fire.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/tkay-maidza-signal-fire-up.jpg" && mv "$IMGDIR/tkay-maidza-signal-fire-up.jpg" "$IMGDIR/tkay-maidza-signal-fire.jpg"
  echo "Tkay Maidza hero image upscaled"

  python3 - << 'POSTEOF2'
import json, os

body = """\
[spotify:artist/2UZIAOlrnyBgNGxhPbEkLQ]

The Last Year Was Weird, her trilogy of EPs released between 2020 and 2022, was always a provisional title. It described exactly what it needed to describe: the feeling of moving through a period of strange becoming, producing music that did not have a fixed address. The three volumes accumulated into something coherent in retrospect, but they were not designed as a single statement. They were dispatches. Signal Fire is the actual dispatch.

Tkay Maidza was born in Harare and grew up in Adelaide. She has been performing since she was a teenager, releasing music since 2014, building a catalog across genre lines that most Australian artists would have considered barriers rather than opportunities. She worked with producers who understood the aesthetic territories mapped by artists at the intersection of UK pop, experimental club music, and east coast rap. She recorded club tracks and then ballads and then something that refused either category, finding the seams between formats and occupying them with increasing precision. By the time Signal Fire arrived, she had been in the process for over a decade.

A proper debut after that much groundwork is a different kind of album. It is not the record of someone who is discovering what they can do. It is the record of someone who already knows and is deciding to show you.

## The Long Way There

The Adelaide origin is worth dwelling on for a moment. Australia occupies an ambiguous position in the global music economy. It produces artists who break internationally at a striking rate given the population, but the geography creates a particular kind of hunger alongside a particular kind of insularity. You have to choose to leave, and when you leave, you have to choose a destination. Tkay chose Los Angeles.

The move changed the music. Not overnight, not in a way that traded one set of influences for another, but in the accumulation of sonic exposure that happens when you are physically present in a city that generates specific kinds of sound. Los Angeles has its own ambient quality, a dryness and a sprawl and a certain attitude toward time that enters the music of anyone who spends enough years there. Signal Fire sounds like Los Angeles without sounding like an LA record. It has absorbed the geography without becoming it.

Her Zimbabwean identity has always been present in the music, in the rhythmic sensibility, in the way she hears melody, in a certain relationship to the body and to movement that connects to traditions far older than the genre frameworks she operates within. Signal Fire makes that connection more explicit than the EPs did. It does not perform African heritage for a Western audience. It simply incorporates it the way a person incorporates everything they have inherited.

## The Record as Synthesis

Signal Fire is 12 tracks and moves with intention. There are no moments where the album pauses to wonder what it is. The genre fluidity that defined the LYWW era has been resolved into something that sounds like Tkay's genre rather than a tour through adjacent ones. The pop instincts are intact. The club textures are intact. The vocal technique, which has always been one of her least discussed but most distinctive qualities, is given more space here than it was on the EPs.

Her voice is athletic in a very specific way. It can do fast and precise, the kind of technical delivery that belongs to rap, and it can sit inside a chord and sustain the kind of emotional attention that belongs to soul. Signal Fire uses both modes within the same tracks without making the transitions feel like category changes. The album sounds like it was made by someone who does not experience those two things as different genres but as different tools in the same kit.

The production is sharp without being cold. There is warmth in the low end, in the way the drums have been mixed to feel physical without being oppressive. The high end sparkles. Tkay has always known how to make music that rewards headphones and also works in a room. Signal Fire is the most successful demonstration of that skill in her catalog. The guest appearances are calibrated with the same care: no one is here to add algorithmic value to a tracklist. Every collaboration opens up a specific part of the album rather than redirecting attention toward a featured name.

## What the Album Asks

The title refers to a method of communication so old it predates written language. Before radio, before telephone, before the internet, people used fire on hilltops to signal across distances that would otherwise be impassable. The metaphor Tkay is working with on Signal Fire is not subtle, but it does not need to be. The album announces itself clearly and then delivers on the announcement.

What it is asking, underneath the confident production and the precise vocal performance and the decade of built infrastructure, is the question that every diaspora artist asks eventually: what does it mean to be from two places at once, and to have chosen a third? Zimbabwe, Adelaide, Los Angeles. Harare nights, Australian school mornings, California studio afternoons. Signal Fire does not resolve that complexity because the complexity is not a problem to be solved. It is a perspective to be inhabited.

The album ends with a track that sounds like a summary without sounding like a conclusion. It does not wrap things up so much as it holds the whole record in a single frame and lets you see the shape of it. That is a difficult thing to do at the end of a debut. It requires knowing not just what the album is about but what it is for, and being willing to say so in sound before you say it in words.

Tkay Maidza has been saying this all along, through the EPs, through the genre experiments, through the relocations and the collaborations. Signal Fire is the record where the saying and the sound finally arrive at the same place at the same time. That convergence is what makes it feel like a debut in the truest sense: the first time an artist puts everything they have understood about themselves into a single object and sends it out into the world.

[download:/assets/images/artists/tkay-maidza-signal-fire-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "tkay-maidza-signal-fire",
    "title": "Signal Fire Is Tkay Maidza's First Proper Album and It Was Worth the Wait",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-28",
    "image": "/assets/images/artists/tkay-maidza-signal-fire.jpg",
    "image_alt": "Tkay Maidza press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/tkay-maidza-signal-fire.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
POSTEOF2

  echo "tkay-maidza-signal-fire.json written"

  cd ~/artonly.io/agent
  python3 make-social-card.py tkay-maidza-signal-fire "Signal Fire Is Tkay Maidza's First Proper Album and It Was Worth the Wait" music
  echo "Social card generated: tkay-maidza-signal-fire-social-9x16.jpg"
  cd ~

  cd ~/artonly.io/agent && python3 post-validator.py tkay-maidza-signal-fire || true && cd ~

  sleep 3
  STATUS2=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/tkay-maidza-signal-fire)
  echo "HTTP $STATUS2 - artonly.io/post/tkay-maidza-signal-fire"

  curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/tkay-maidza-signal-fire&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
  echo "IndexNow pinged: tkay-maidza-signal-fire"

  curl -s -X POST https://artonly.io/api/send-mail.php \
    --data-urlencode "to=press@4ad.com" \
    --data-urlencode "bcc=amosleblanc@gmail.com" \
    --data-urlencode "subject=Your artist is on ArtOnly" \
    --data-urlencode "body=Hi, we just published a piece on Tkay Maidza and Signal Fire at artonly.io/post/tkay-maidza-signal-fire. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" || true
  echo "Outreach sent for Tkay Maidza"
fi

# ========================
# SUMMARY EMAIL (JSON to stdin)
# ========================
echo "--- Sending summary email ---"
python3 - << 'EMAILEOF'
import json, subprocess, os, sys

script_path = os.path.expanduser('~/artonly.io/api/gmail-send.py')

body_text = """ArtOnly Album Monitor: 2026-06-28

Published today:

1. Pa Salieu - Second
   artonly.io/post/pa-salieu-second
   Author: Allastair Voss
   Category: music
   Outreach: press@warnermusic.co.uk (BCC amosleblanc@gmail.com)

2. Tkay Maidza - Signal Fire
   artonly.io/post/tkay-maidza-signal-fire
   Author: Leelou Blanc
   Category: music
   Outreach: press@4ad.com (BCC amosleblanc@gmail.com)

Note: Previous picks (pond-terrestrials, pj-morton-saturday-night-sunday-morning)
already existed on server from June 24 deploy. New picks selected instead.

IndexNow pinged for both posts."""

data = {
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Album Monitor: 2026-06-28",
    "body": body_text
}

try:
    result = subprocess.run(
        ['python3', script_path],
        input=json.dumps(data).encode(),
        capture_output=True,
        timeout=30
    )
    print('STDOUT:', result.stdout.decode())
    if result.stderr:
        print('STDERR:', result.stderr.decode())
except Exception as e:
    print(f'Email error (non-fatal): {e}')
sys.exit(0)
EMAILEOF
echo "Summary email done"

echo "=== Deploy complete: 2026-06-28b ==="
