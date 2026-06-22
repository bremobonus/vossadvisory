#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-22
# Posts: pond-terrestrials, graham-coxon-castle-park
# Releases: Pond - Terrestrials (Jun 19, Mangovision/Secretly Distribution), Graham Coxon - Castle Park (Jun 19, Transgressive Records)
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-22 ==="

# ---- POST 1: Pond - Terrestrials ----
echo "--- Deploying: pond-terrestrials ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/pond-terrestrials.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/pond-terrestrials/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://stereogum.com/2495197/pond-announce-new-album-terrestrials-hear-two-hands/music')
    imgs = re.findall(r'(https?://media\.stereogum\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+pond[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://www.thenote.com.au/news/ponds-new-album-terrestrials-out-now')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'allbrook' in i.lower() or 'terrestrial' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+thenote[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thenote.com.au/')
        print('Downloaded from The Note')
        sys.exit(0)
except Exception as e:
    print(f'The Note failed: {e}')

try:
    html = fetch('https://au.rollingstone.com/music/music-news/pond-release-new-album-terrestrials-97251/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'allbrook' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+rollingstone[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://au.rollingstone.com/')
        print('Downloaded from Rolling Stone AU')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone AU failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#0a0d1a-#1a1f3a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Pond\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/pond-terrestrials.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/pond-terrestrials-up.jpg && \
  mv ~/artonly.io/assets/images/artists/pond-terrestrials-up.jpg \
     ~/artonly.io/assets/images/artists/pond-terrestrials.jpg
echo "Image upscaled: pond-terrestrials.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py pond-terrestrials "Pond Come Home From the Cosmos and Say What They Actually Mean" music
echo "Social card generated: pond-terrestrials-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/4skJp5OKvcc9eKokiuhi2s]

Pond have always been a band in conversation with their own excess. Coming out of Perth, Western Australia, the same scene that produced Tame Impala and a particular strain of sun damaged psychedelia, they built their early reputation on sprawling, feedback heavy, loosely organized jams that felt like they could go on forever and sometimes did. The fuzz pedal was not merely a tool. It was a philosophy. Letting things unspool past the point of resolution, treating the studio like a room where time moved differently, piling texture on texture until the song itself became secondary to the atmosphere it generated. This is the Pond that their existing audience knew, the Pond of Hobo Rocket and Man It Feels Like Space Again, a band that had figured out how to make excess feel like a form of generosity.

Terrestrials, their eleventh studio album and their first on their own Mangovision imprint via Secretly Distribution, arrives with a deliberate negation of everything that defined that sound. Before entering the studio, the band imposed three prohibitions: no fuzz pedal, no ballads, and no what they describe as Pink Floyd indulgences, meaning no extended atmospheric passages, no songs that require the listener to be patient in a particular way, no music that takes longer to pay off than it takes to earn. These prohibitions sound like a reaction to something. They are. The album is Pond deciding, at the point of their eleventh record, that compression serves them better than expansion. That the statement lands harder when it is stated once rather than circled.

What they arrive at is something that fuses the sun bleached guitar pop of 1980s Australian rock, the kind that emerged from pubs and beach suburbs and the particular quality of light on the west coast, with the eyeliner smeared post punk of British bands like Sisters of Mercy and Magazine. This is a specific and unusual combination. The Australian pub rock tradition has largely been understood as a rougher cousin to American classic rock, built on big guitars and physical presence and a certain indifference to sophistication. The British post punk that Pond are referencing here is nearly the opposite: cerebral, image conscious, interested in texture as a form of argument. Pond put these two traditions in a room together and discover that they are arguing about the same things.

## The Land Underneath the Record

Nick Allbrook has never been a subtle lyricist, but on Terrestrials the directness of the writing carries more weight than usual because the production has stripped away the psychedelic gauze that typically surrounds it. Tracks like The Fatal Shore and Personal Hell address the Australian landscape not as backdrop but as subject: the continent as something that was taken, that continues to be extracted from, that produces a specific kind of political guilt in the people who live on it while benefiting from its dispossession. Roebuck Plains places itself in the northwest of Western Australia, a region that carries enormous significance in the ongoing conversation about Indigenous land rights and the violence of extraction industries.

This is not protest music in the American tradition of folk declarations and singalong choruses. It is something more uncomfortable: music made by people who understand that they are implicated in what they are describing. The post punk formalism is appropriate here because post punk has always been the sound of people who know they cannot simply leave the system they are critiquing. You use the electric guitar. You work within the pop song. You accept the inheritance and then say what the inheritance cost.

## What the Constraints Produced

The prohibition on fuzz does not make Terrestrials a quiet record. The guitars are present and often aggressive. They have simply been given a different kind of edge. The compression of the mix pushes everything forward, and the absence of the reverb and delay that Pond employ to create psychedelic depth means the listener is in the room with the band rather than floating above it. This is a physical record in a way that previous Pond albums have sometimes deliberately avoided being.

The ten track running time, which comes in under forty minutes, is the most consequential formal decision on the album. Pond have historically been willing to test patience. Terrestrials does not test patience. It arrives, states its case, and exits before the listener has time to decide whether they agree. This works because the writing is strong enough to sustain the confidence the structure requires. Through the Heather and Two Hands are as immediate as anything Pond have recorded, built on riffs that earn their repetition rather than depending on it. Skyworks opens the album with a directness that announces the new approach before the listener has time to calibrate expectations.

Nashville (I'm Dying) closes the record with something unexpected: a song that, despite the no ballads rule, manages to be genuinely moving without betraying the album's structural commitments. It is moving because of compression rather than despite it. The restraint built across the preceding nine tracks gives the final song room to breathe that would not have existed if the album had been built the old way.

## The Independent Move and What It Means

Releasing on Mangovision, the label Pond established for this record, places them in a line of artists who have chosen the increased risk and increased control of independence at a point in their careers where the established infrastructure was no longer serving the work. Secretly Distribution handles the logistics. The creative decisions remain entirely with the band. This is not a guarantee of quality, but it is a guarantee of intention. Terrestrials sounds like a record that was made exactly as the people who made it intended. There are no compromises audible in the mix, no moments that feel like concessions to commercial legibility.

This matters for Pond specifically because their commercial legibility has always been partial at best. They are a cult act in the most precise sense: a band with a devoted audience that has never crossed into mainstream visibility, despite connections to Tame Impala and the broader global attention that followed that project. The Kevin Parker association was always more accident than design. What Pond and Tame Impala share is a geography and a generation, not a sound. Terrestrials makes this distinction clearer than any previous record. This is not psychedelic pop organized for mainstream entry. This is something more particular, made with full awareness of its own particularity.

In 2026, that particularity feels like a position rather than a limitation. The Australian political landscape, the ongoing crisis of extraction and denial, the specific textures of a culture that continues to grapple with what it took and what it owes, these are not abstract concerns. Pond have made a record that lives inside these concerns without pretending to resolve them. The post punk structure is the right vehicle for that kind of unresolved argument. Terrestrials is the sound of a band that has been building toward a specific kind of clarity for eleven albums and has finally arrived at it, on their own terms.

[download:/assets/images/artists/pond-terrestrials-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "pond-terrestrials",
    "title": "Pond Come Home From the Cosmos and Say What They Actually Mean",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-22",
    "image": "/assets/images/artists/pond-terrestrials.jpg",
    "image_alt": "Pond press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/pond-terrestrials.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: pond-terrestrials.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pond-terrestrials)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pond-terrestrials&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: pond-terrestrials"


# ---- POST 2: Graham Coxon - Castle Park ----
echo "--- Deploying: graham-coxon-castle-park ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/graham-coxon-castle-park.jpg'

try:
    html = fetch('https://www.nme.com/reviews/album/graham-coxon-castle-park-review-blur-lost-album-3951505')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+nme\.com[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+coxon[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

try:
    html = fetch('https://transgressiverecords.com/news/graham-coxon-releases-castle-park/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'coxon' in i.lower() or 'graham' in i.lower() or 'castle' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+transgressive[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://transgressiverecords.com/')
        print('Downloaded from Transgressive Records')
        sys.exit(0)
except Exception as e:
    print(f'Transgressive Records failed: {e}')

try:
    html = fetch('https://pitchfork.com/reviews/albums/graham-coxon-castle-park/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://www.grahamcoxon.co.uk/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if len(i) > 30]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.grahamcoxon.co.uk/')
        print('Downloaded from grahamcoxon.co.uk')
        sys.exit(0)
except Exception as e:
    print(f'grahamcoxon.co.uk failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#1a1a0d-#2e2e1a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Graham Coxon\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/graham-coxon-castle-park.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/graham-coxon-castle-park-up.jpg && \
  mv ~/artonly.io/assets/images/artists/graham-coxon-castle-park-up.jpg \
     ~/artonly.io/assets/images/artists/graham-coxon-castle-park.jpg
echo "Image upscaled: graham-coxon-castle-park.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py graham-coxon-castle-park "Graham Coxon Finds a Lost Record and It Was Worth the Wait" music
echo "Social card generated: graham-coxon-castle-park-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/7ueZp29tCNwjIj4yAMTEaC]

In 2011, Graham Coxon was doing what he often does: making music by himself, away from the complexities of maintaining one of the most scrutinized creative partnerships in British rock history. He had been a founding member of Blur since their formation in London in 1988, the band's guitarist and a key compositional voice, and his departure from the band in 2003 at the height of their tensions had been the kind of break that both parties spent years discussing in careful language. By 2011, Blur had reunited for festival performances and the relationship had stabilized into something workable. But Coxon was also operating in his own lane, the solo career he had been building since 2000 with records that moved through acoustic folk, krautrock influence, punk aggression, and melodic pop without settling permanently in any of them.

The sessions that year produced enough material for an album. Coxon intended it as the follow-up to his eighth solo record A+E, which would arrive in 2012. But Blur activity intervened, and then other projects, and the record stayed in the vault while the years accumulated. Fifteen years is a long time for an album to wait. Castle Park, released June 19 via Transgressive Records, is that album. It arrives after a decade and a half not as a historical document but as a genuine contemporary release, and the question that hangs over it is whether the music has survived the interval, whether what seemed worth making in 2011 still has something to say in 2026.

The answer is yes, and the reasons why tell you something interesting about what Coxon was working with. His solo catalog of eight records over nearly a quarter century forms a deliberately unsystematic body of work. It moves from the acoustic intimacy of The Sky Is Too High through the punk directness of Happiness in Magazines, through the krautrock explorations of The Spinning Top and A+E, without settling permanently in any of them. The through line is not a consistent style but a consistent restlessness, a willingness to pick up a new approach and follow it to its limit before setting it down. Castle Park represents, within this catalog, the melodic Kinks influenced side of his sensibility that has been present in his writing since the beginning but has not previously had a full album to itself.

## The Kinks in the Room

Castle Park is a power pop record, which places it in a tradition that runs from the Kinks through Big Star through Matthew Sweet through a dozen other artists who understood that the three minute guitar driven song was a container capable of considerable sophistication when handled with care. Coxon has spent his career in conversation with this tradition without always foregrounding it. The fuzz and noise of his more abrasive solo records, and of Blur's grittier work, placed those recordings in dialogue with punk and post punk. Castle Park sets that dialogue aside. The record is about melody and arrangement and the particular pleasure of a song that goes exactly where it needs to go without detours.

Billy Says and Alright, the two singles released ahead of the album, establish the terms immediately. Both are built around guitar hooks that feel effortless in the specific way that actually requires considerable effort to achieve. The Kinks comparison that reviewers have reached for is accurate: Ray Davies's capacity to write songs about ordinary English life that were also somehow about something much larger, to find the universal inside the local, is what Coxon is channeling here. This is music about a specific geography, a specific class of English experience, rendered in forms that do not require familiarity with that geography to appreciate.

Dripping Soul, which brings a flamenco influenced guitar line into the record's midsection, and the orchestral pop instrumental Melodie Pour Christine suggest an artist who was, in 2011, working through a wider range of influences than the finished A+E record would eventually convey. The vault held the more experimental material, the directions Coxon was entertaining without being certain he wanted to pursue them as the primary statement of that period. As a separate collection, these songs demonstrate a range that his more stylistically coherent records have not always shown.

## The Colchester Question

Castle Park takes its name from a park in Colchester, the Essex city where Coxon grew up. Blur's Damon Albarn was also a Colchester product, and the connection between the city and the band has always been complicated: Blur became definitively a London band in their public identity, and the specificity of their suburban and East Anglian roots was often flattened in the broader Britpop narrative. Coxon's solo work has been more willing to engage with that geography. Castle Park returns to it with an explicitness that his records have not previously attempted.

This is not nostalgia in the simple sense. The record is not asking the listener to share in the emotion of remembering a place from childhood. It is using that place as a formal anchor, a way of keeping the songs honest about where they came from and what they are made of. Produced with Ben Hillier, who has worked with Blur, Depeche Mode, and Elbow among others, the album has a warmth in its production that serves this specificity. Hillier's ear for making spaces that feel inhabited rather than designed is evident in every track.

## The Weight of the Wait

Fifteen years is long enough to change the meaning of a set of recordings without changing the recordings themselves. What Castle Park sounds like in 2026 is not necessarily what it would have sounded like in 2013. The intervening period has included Blur's reunion album The Magic Whip, Coxon's soundtrack work, and the broader shift in how Britpop and its legacy are received. The context in which Coxon now operates as a solo artist is different from the context in which these songs were made.

What survives the interval is the directness of the writing. Castle Park does not sound dated in the pejorative sense. It sounds located. Its location in time is part of its texture. There is a specific quality in power pop, when it is made well, of songs that seem to have always existed, that you feel you have heard before even on first listen. This quality requires a certain kind of technical assurance, a command of hook and structure that produces inevitability. Coxon achieves this across the majority of the record, and the tracks that demonstrate it most clearly feel like additions to a catalog that already existed.

The argument that Castle Park makes, quietly and without fanfare, is that the Kinks adjacent British guitar pop tradition contains enough depth to support sustained investigation. Graham Coxon has been investigating that tradition since before Blur made it famous, and Castle Park is the most direct documentation of that investigation he has produced. The album took fifteen years to arrive. It was worth the wait not because the wait added anything to it, but because what was inside was already good enough to justify opening the vault and letting it out.

[download:/assets/images/artists/graham-coxon-castle-park-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "graham-coxon-castle-park",
    "title": "Graham Coxon Finds a Lost Record and It Was Worth the Wait",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-22",
    "image": "/assets/images/artists/graham-coxon-castle-park.jpg",
    "image_alt": "Graham Coxon press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/graham-coxon-castle-park.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: graham-coxon-castle-park.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/graham-coxon-castle-park)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/graham-coxon-castle-park&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: graham-coxon-castle-park"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@secretlygroup.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Pond and Terrestrials at artonly.io/post/pond-terrestrials. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@secretlygroup.com (Pond)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=international@transgressive.co.uk" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Graham Coxon and Castle Park at artonly.io/post/graham-coxon-castle-park. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: international@transgressive.co.uk (Graham Coxon)"


# ---- Summary email ----
python3 << 'PYEOF'
import subprocess, os

body = """Published today:

1. Pond - Terrestrials
   https://artonly.io/post/pond-terrestrials
   Author: Allastair Voss
   Spotify: 4skJp5OKvcc9eKokiuhi2s
   Released: June 19, 2026 (Mangovision / Secretly Distribution)
   11th studio album. No fuzz pedal, no ballads, no Pink Floyd. Post punk meets 80s Australian rock.
   Themes: extractive capitalism, Indigenous incarceration, environmental destruction, hope.

2. Graham Coxon - Castle Park
   https://artonly.io/post/graham-coxon-castle-park
   Author: Leelou Blanc
   Spotify: 7ueZp29tCNwjIj4yAMTEaC
   Released: June 19, 2026 (Transgressive Records)
   9th solo album. Recorded in 2011, released 15 years later. Power pop, Kinks influenced.
   Metacritic: 81/100 universal acclaim.

Outreach:
- Pond: email sent to press@secretlygroup.com (Secretly Group press)
- Graham Coxon: email sent to international@transgressive.co.uk (Transgressive Records)"""

result = subprocess.run(
    ["python3", os.path.expanduser("~/artonly.io/api/gmail-send.py"),
     "amosleblanc@gmail.com",
     "ArtOnly Album Monitor: 2026-06-22",
     body],
    capture_output=True, text=True
)
print(result.stdout)
if result.returncode != 0:
    print("gmail-send error:", result.stderr)
PYEOF

echo "=== Deploy complete: 2026-06-22 ==="
