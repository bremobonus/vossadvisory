#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-31
# Posts: anderson-paak-kpops, ear-rumspringa
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-31.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-31 ==="

# ---- POST 1: Anderson .Paak - K-POPS! ----
echo "--- Deploying: anderson-paak-kpops ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/anderson-paak-kpops.jpg'

try:
    html = fetch('https://www.rollingstone.com/music/music-features/inside-anderson-paak-k-pop-album-1235563473/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:anderson|paak)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://media\.rollingstone\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.rollingstone.com/')
        print('Downloaded from Rolling Stone')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone failed: {e}')

try:
    html = fetch('https://collider.com/k-pops-bts-images-anderson-paak-soul-rasheed/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:anderson|paak|kpops)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+collider[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://collider.com/')
        print('Downloaded from Collider')
        sys.exit(0)
except Exception as e:
    print(f'Collider failed: {e}')

try:
    html = fetch('https://pitchfork.com/reviews/albums/anderson-paak-k-pops/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0505-#1a0808\" -gravity center -pointsize 52 -fill white -annotate 0 \"Anderson .Paak\" {dest}')
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/anderson-paak-kpops.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/anderson-paak-kpops-up.jpg && \
  mv ~/artonly.io/assets/images/artists/anderson-paak-kpops-up.jpg \
     ~/artonly.io/assets/images/artists/anderson-paak-kpops.jpg
echo "Image upscaled: anderson-paak-kpops.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py anderson-paak-kpops "Anderson .Paak Steps Behind the Camera and Takes His Sound With Him" music
echo "Social card generated: anderson-paak-kpops-social-9x16.jpg"
cd ~

cat > ~/artonly.io/posts/anderson-paak-kpops.json << 'ENDJSON'
{
  "slug": "anderson-paak-kpops",
  "title": "Anderson .Paak Steps Behind the Camera and Takes His Sound With Him",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-31",
  "image": "/assets/images/artists/anderson-paak-kpops.jpg",
  "image_alt": "Anderson .Paak press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/3jK9MiCrA42lLAdMGUZpwa]\n\nThere is a photograph of Anderson .Paak, born Brandon Paak Anderson in Oxnard, California, that circulated widely in the days before K-POPS! landed on Netflix. He is standing on a Seoul street in a director's chair, headphones around his neck, a script in his hand, looking sideways at something the camera cannot see. The image does not announce itself as significant. It is a promotional photograph, efficiently composed and lit for press use. But the detail that stops you is the expression on his face, which is not the face of someone performing authority. It is the face of someone genuinely absorbed in the problem in front of him. Brandon Paak Anderson is a musician who made himself into a filmmaker, and the photograph catches him in the moment when the two identities have stopped competing.\n\nK-POPS!, the soundtrack to his Netflix directorial debut, arrived May 29, one day before the film itself became available to stream. The album collects seventeen tracks built around the narrative of the film and extending outward from it, into musical territory that .Paak and his longtime collaborator producer Dem Jointz had clearly been waiting for the right occasion to explore. The occasion is a K-pop competition drama set in Seoul, in which .Paak plays a struggling musician navigating a comeback alongside an unexpected relationship with his son. His actual son, Soul Rasheed, makes his recording debut on the album. That detail, a father and son creating together for the first time in a public space, gives the project an emotional weight that no marketing strategy could manufacture.\n\n## The Collaboration Architecture\n\nThe guest list for K-POPS! reads like an index of the current Korean pop industry's most significant exports, and also like a document of how thoroughly the global music market has reorganized itself around Seoul's production infrastructure. G-Dragon appears. So do DEAN, aespa, NMIXX, Chung Ha, Crush, Jay Park, Soyeon of (G)I-DLE, Hongjoong of ATEEZ, Joshua of Seventeen, JO1, LNGSHOT, and Kevin Woo. These are not cameo appearances. They are collaborations, in the truest sense, between an artist who built his career in the tradition of Black American funk and soul and a set of practitioners working within the industrial specificity of the Korean pop apparatus.\n\nWhat makes K-POPS! more than a cultural exchange exercise is the seriousness with which .Paak and Dem Jointz have constructed the sonic framework. The production does not ask its Korean guests to rap or sing over beats that predate their involvement. It attempts something harder, a hybrid infrastructure that takes the textural precision of K-pop production and the rhythmic language of West Coast R&B and finds where they actually share grammar, rather than where they can be forced into proximity. There are moments on the album where this attempt does not fully resolve. There are more moments where it succeeds, and the success has a specific quality: music that sounds like it emerged from a situation nobody had fully planned, which is the best kind.\n\n## What the Film Makes Available\n\nThe narrative context of the film does important work for the album. K-POPS! the movie is a story about reinvention and the costs of ambition, specifically the ways in which the pursuit of a creative comeback can damage the relationships that make the pursuit worth pursuing. The album carries this theme in its production choices. Tracks like Caution, the lead single featuring NMIXX, are built for the competitive arena of the fictional K-pop competition series within the film but carry an undercurrent of something more unguarded. The collaboration between .Paak's production sensibility, drawn from the tradition of funk and West Coast soul, and NMIXX's precision vocal style produces something that neither party would have made alone.\n\nSoul Rasheed's appearances on the record are brief but pointed. A father who built a career on confessional R&B about love, loss, and perseverance, allowing his son to step into that tradition on a global stage, is a gesture that the album does not over-explain. It is there, it is legible, and it means what it means.\n\n## The Director Question\n\nAnderson .Paak has been, since the release of Malibu in 2016, one of the more technically accomplished and aesthetically committed musicians working in popular R&B. His collaborations with Knxwledge as NxWorries, his founding role in the Free Nationals, and his Silk Sonic partnership with Bruno Mars have each demonstrated a musician who thinks about what music is doing architecturally, not just emotionally. The decision to direct K-POPS! is consistent with this sensibility. It is the act of an artist who wants to control not just the sound but the context in which the sound lands.\n\nThe result, both film and album, is uneven in the way that ambitious directorial debuts with ambitious soundtracks almost always are. But the unevenness is the interesting part. It reveals where the thinking is still in progress, where the synthesis between .Paak's instincts and the production demands of a Netflix feature has not yet been fully resolved. That unresolution is more interesting than a seamless product would have been. It tells you something about what this project actually cost and what it is still trying to work out.\n\n## What Comes Next\n\nK-POPS! will be discussed primarily as a cultural event. A Black American artist directing a K-pop film. A father featuring his son on a major release. A soundtrack that refused to be merely functional. All of those framings are accurate. None of them is sufficient. The album is also, when you set down the framing and just listen, a record of someone trying to figure out what his voice sounds like when it is in conversation with sounds that emerged from a completely different set of conditions, different industry pressures, different cultural inheritances, different ideas about what a performer owes an audience.\n\nThe conversation is not finished on K-POPS!. It is, however, genuinely underway, and that is rarer than it should be. Anderson .Paak has spent a decade building the credibility to make this kind of move. The move is made. Whatever comes next will have this record as its starting point.\n\n[download:/assets/images/artists/anderson-paak-kpops-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: anderson-paak-kpops.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/anderson-paak-kpops)
echo "HTTP status: $STATUS"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/anderson-paak-kpops&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: anderson-paak-kpops"


# ---- POST 2: ear - Rumspringa ----
echo "--- Deploying: ear-rumspringa ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/ear-rumspringa.jpg'

try:
    html = fetch('https://stereogum.com/2500138/album-of-the-week-ear-rumspringa/reviews/album-of-the-week')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:ear|rumspringa|paz|avtan)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+stereogum[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://consequence.net/2026/05/ear-new-album-rumspringa/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:ear|rumspringa)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://consequence\.net/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence')
        sys.exit(0)
except Exception as e:
    print(f'Consequence failed: {e}')

try:
    html = fetch('https://ra.co/news/85238')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+(?:ear|rumspringa)[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://ra\.co/images/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ra.co/')
        print('Downloaded from RA')
        sys.exit(0)
except Exception as e:
    print(f'RA failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#050a08-#0a1410\" -gravity center -pointsize 52 -fill white -annotate 0 \"ear\" {dest}')
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/ear-rumspringa.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/ear-rumspringa-up.jpg && \
  mv ~/artonly.io/assets/images/artists/ear-rumspringa-up.jpg \
     ~/artonly.io/assets/images/artists/ear-rumspringa.jpg
echo "Image upscaled: ear-rumspringa.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py ear-rumspringa "ear Found the Right Album to Make on the Label That Was Made for Them" music
echo "Social card generated: ear-rumspringa-social-9x16.jpg"
cd ~

cat > ~/artonly.io/posts/ear-rumspringa.json << 'ENDJSON'
{
  "slug": "ear-rumspringa",
  "title": "ear Found the Right Album to Make on the Label That Was Made for Them",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-31",
  "image": "/assets/images/artists/ear-rumspringa.jpg",
  "image_alt": "ear press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/2erjv4mbhMyhxpGlCup7jL]\n\nA24 spent fifteen years building an aesthetic consensus. The production company and distributor that gave us Hereditary and Moonlight and Everything Everywhere All At Once and Midsommar developed, through deliberate curation and an unusually coherent visual and tonal signature, something rarer than critical success: a recognizable feeling. There is a way a film feels when it is A24's. The feeling involves a certain quality of attention, a willingness to hold discomfort longer than commercial logic would typically permit, a preference for atmosphere as meaning rather than atmosphere as decoration. When A24 launched its music imprint and signed ear as one of its earliest acts, the question was not whether the label had good taste. The question was whether good taste in film translates into music.\n\nRumspringa, the second ear album and their first for A24 Music, suggests the answer is yes, with conditions. Jonah Paz and Yaelle Avtan, who formed the duo at Bard College in 2024 and have since split their time between London and upstate New York, make music that sounds like it belongs in an A24 film without sounding like a soundtrack. The distinction matters. Soundtracks are functional, designed to support visual information. What Paz and Avtan make is designed to carry information by itself. The emotional specificity is built into the production. You do not need an image to tell you that Ne Plus Ultra is about the specific vertigo of a decision you cannot unmake. The squealing synth descent over the murmured vocal tells you directly.\n\n## The Amish Framework\n\nThe album takes its name from the Amish practice of allowing teenagers who have grown up within the community to spend time outside its structures before deciding whether to commit to the faith as adults. The word describes a period of deliberate exposure, of trying the other life before choosing. It is also, as Paz and Avtan apply it, a description of the album's emotional project. Rumspringa is what they are calling a choose life record. It arrives in 2026, a moment characterized by what many younger listeners describe as the impossibility of sustained choice in an attention economy that has made every commitment feel provisional. Against that backdrop, an album premised on the idea that choosing is possible and worth doing is not a small statement.\n\nThe music earns the premise without being naive about it. Tracks like Threads and Nothing's Open use the sonic palette they established on The Most Dear and the Future, their 2025 debut, but the deployment has changed. Where the debut felt exploratory, still locating itself in relation to its influences, Rumspringa sounds like an album made by a band that has decided where it stands. The glitchy IDM elements, the murmuring found sound, the hushed vocal harmonies, the occasional burst of sawtooth synth that arrives like an argument you had not expected to hear, all of these are in service of a position rather than a search.\n\n## Comparisons and Their Limits\n\nReviewers have reached for the Postal Service, for mum, for the xx, for the Books. These references are accurate as far as they go. What they do not fully capture is the degree to which Paz and Avtan are doing something specifically attentive to the present moment of sound. The Postal Service made Give Up in 2003, in the early years of digital music distribution. mum made their best albums in the early 2000s as well. ear is making this music in 2026, when the sonic landscape has been so thoroughly processed by algorithmic production and recommendation that handmade specificity, the kind that characterizes every track on Rumspringa, reads as a form of resistance.\n\nThe intimacy is real and not performed. The duo recorded their debut single on Avtan's iPhone in their university library. The production values have increased since then, as they have signed to a label with resources and a clear aesthetic framework. But the fundamental relationship between the listener and the sound remains intimate. You feel placed close to the music, not surveying it from a critical distance. The whispered vocal delivery on Real Life, the track that made several best of 2025 lists as a standalone single, established this quality and Rumspringa sustains it across thirty minutes.\n\n## A24 and What It Means\n\nThe label relationship deserves attention because it tells you something about where ear wants to be positioned. A24 Music, as a label, is not making moves toward mainstream chart presence. It is making moves toward a specific kind of critical cultural positioning, the kind that A24 Film has spent fifteen years establishing. Being an early signee to that label is a bet that the aesthetic framework A24 has built in film is portable into music.\n\nRumspringa is evidence that the bet is paying out. What Paz and Avtan have made is an album that rewards exactly the kind of attention A24 asks you to bring to its films: slow, specific, willing to sit with ambiguity. The thirty minutes pass with the quality of something you watched rather than merely heard. The images the music generates are not external to it. They are the music, assembled by the production into a sequence of states that are emotional and sensory at once.\n\n## The Duration of a Decision\n\nWhen the album ends, the sensation is not completion but pause, the feeling that comes after a decision has been made and the consequences have not yet arrived. That is what a rumspringa is, a period of suspension between two versions of a life. Paz and Avtan have made an album that inhabits that suspension completely, not as irresolution but as the specific heightened clarity that precedes commitment.\n\nThere is a version of this kind of music that mistakes quietness for modesty and intimacy for smallness. ear does not make that mistake. The ambition on Rumspringa is real, it is just expressed through compression rather than scale. Ten songs, thirty minutes, no wasted material. The choose life ethos is not decorative. It is the architectural principle that organized every production decision on the record. That kind of coherence between concept and execution is difficult to achieve. When it arrives, at whatever volume and in whatever duration, it announces itself unmistakably.\n\n[download:/assets/images/artists/ear-rumspringa-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: ear-rumspringa.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/ear-rumspringa)
echo "HTTP status: $STATUS"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ear-rumspringa&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: ear-rumspringa"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@aftermath.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Anderson .Paak and the K-POPS! soundtrack at artonly.io/post/anderson-paak-kpops. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@aftermath.com (Anderson .Paak)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=music@a24films.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on ear and the new album Rumspringa at artonly.io/post/ear-rumspringa. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: music@a24films.com (ear)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-05-31" "Published today:

1. Anderson .Paak - K-POPS!
   https://artonly.io/post/anderson-paak-kpops
   Author: Allastair Voss
   Released: May 29, 2026 (Aftermath/Universal)
   17 tracks, Netflix directorial debut

2. ear - Rumspringa
   https://artonly.io/post/ear-rumspringa
   Author: Leelou Blanc
   Released: May 29, 2026 (A24 Music)
   Stereogum Album of the Week

Outreach:
- Anderson .Paak: email sent to press@aftermath.com
- ear: email sent to music@a24films.com

SSH to DreamHost unavailable from cloud environment. Run deploy script manually."

echo "=== Deploy complete: 2026-05-31 ==="
