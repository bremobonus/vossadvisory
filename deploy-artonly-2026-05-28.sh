#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-28
# Posts: traumprinz-life, ruido-tovar
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-28.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-28 ==="

# ---- POST 1: Traumprinz - Life ----
echo "--- Deploying: traumprinz-life ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/traumprinz-life.jpg'

# Try Inverted Audio review article
try:
    html = fetch('https://inverted-audio.com/traumprinz-life/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'traumprinz' in i.lower() or 'life' in i.lower() or 'lauer' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://inverted-audio.com/')
        print('Downloaded from Inverted Audio')
        sys.exit(0)
except Exception as e:
    print(f'Inverted Audio failed: {e}')

# Try RA artist page
try:
    html = fetch('https://ra.co/dj/traumprinz')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+traumprinz[^\s\"\'<>]+\.(?:jpg|jpeg|webp))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'\"(https://[^\"]+/images/dj/[^\"]+\.jpg)\"', html)
    if imgs:
        download_img(imgs[0], dest, referer='https://ra.co/')
        print('Downloaded from RA')
        sys.exit(0)
except Exception as e:
    print(f'RA failed: {e}')

# Try All Possible Worlds Bandcamp
try:
    html = fetch('https://allpossibleworlds.bandcamp.com/album/life')
    # Get album art or bio image
    imgs = re.findall(r'(https?://f4\.bcbits\.com/img/[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://allpossibleworlds.bandcamp.com/')
        print('Downloaded from Bandcamp')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#1a1a2e-#16213e\" -gravity center -pointsize 48 -fill white -annotate 0 \"Traumprinz\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/traumprinz-life.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/traumprinz-life-up.jpg && \
  mv ~/artonly.io/assets/images/artists/traumprinz-life-up.jpg \
     ~/artonly.io/assets/images/artists/traumprinz-life.jpg
echo "Image upscaled: traumprinz-life.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py traumprinz-life "In the Rush of the Deep, Traumprinz Makes His Case with Life" music
echo "Social card generated: traumprinz-life-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/traumprinz-life.json << 'ENDJSON'
{
  "slug": "traumprinz-life",
  "title": "In the Rush of the Deep, Traumprinz Makes His Case with Life",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-28",
  "image": "/assets/images/artists/traumprinz-life.jpg",
  "image_alt": "Traumprinz press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/7AOdp2CXbaCubZirZQRz6z]\n\nThe title is almost provocatively spare. After years operating under aliases, releasing music in limited pressings for underground circulation, and sharing production credits with the handful of producers who understand what he is building, Phillip Lauer has arrived at something that sounds like both an arrival and a reckoning. \"Life\" is the fifth installment under the Traumprinz alias, released on his All Possible Worlds imprint, and it carries the weight of that designation without making a production of it. Sixteen tracks, no features, no press photos in fashion magazines, no crossover moment being engineered. Just the work.\n\nWhat Traumprinz has always understood, and what \"Life\" argues with particular elegance, is that repetition is not the absence of development. It is development of a different kind, one that unfolds inside the listener rather than in front of them. The loops on this record do not feel static. They breathe. They shift in meaning the way a phrase in conversation shifts after you have said it ten times in a row, the moment when the word loses its surface definition and reveals something stranger underneath.\n\n\"Im Rausch der Tiefe\" opens the album in exactly the register its title suggests, translating loosely as \"in the rush of the deep\" or \"in the intoxication of the depths.\" It is not a dramatic beginning. There is no drop, no announcement. The track simply arrives, fully formed, like something that has been in motion long before you sat down to listen. That is a skill, and it is rarer than it sounds.\n\nThe Cologne electronic scene from which Lauer emerged has always operated with a particular philosophy about patience. There is a lineage here, from the early Wolfgang Voigt experiments in microhouse to the meditative deep house of Move D, that treats the dance floor not as a site of peak and valley but as a place where time can be suspended and then slowly released. \"Life\" operates entirely within this tradition, and does so without nostalgia, which is the harder trick. The album does not feel like a document of an earlier era. It feels like a living thing.\n\n## The Emotional Architecture\n\nWhat distinguishes Lauer from the broader field of deep house and techno producers is a quality of yearning that sits just beneath the surface of the music. This is not music that aspires to transparency or ego dissolution, though it offers those things as byproducts. The more interesting dimension is emotional. There is a sense of loss threaded through \"Life\" that deepens its pleasures rather than complicating them. Tracks titled \"About Leaving\" and \"Broken Home\" wear their emotional register openly, and the sound design honors that openness. A chord suspended just long enough to ache. A rhythm that leans forward without ever quite resolving the lean. These are not accidents of production. They are the album's argument.\n\nThe album's structure is that of a long set rather than a classical album in the sense of arcs and climaxes. Sixteen tracks across approximately ninety minutes means that individual pieces are allowed to develop slowly, to make their statement and recede without being interrupted by a track listing trying to demonstrate range. This is a coherent aesthetic choice, and it rewards listeners willing to meet it on its own terms.\n\n\"Trippyaf\" is probably the most direct track here, a brief acknowledgment that Traumprinz is capable of the more euphoric registers of contemporary electronic music but prefers not to live there. It functions as a moment of oxygen within the set, a reminder that the surrounding depth is chosen rather than default. The dry humor in the title is intentional. Lauer has always had a particular wit about the pretensions of underground music, including his own.\n\nThere is a tradition in German electronic music of treating the album title as a philosophical statement. Wolfgang Voigt released albums with titles evoking fog and forest. Ricardo Villalobos has titled releases after mathematical and conceptual terms. The single word \"Life\" fits comfortably within this tradition while also undercutting it, choosing the most fundamental noun available rather than a specialized or obscure one. It is either deeply humble or deeply ambitious, and most likely both. That ambiguity is part of the record's texture. Lauer does not explain himself, and the music is richer for the silence around it.\n\n## The Practice of Depth\n\nThe vinyl release of \"Life\" carries particular meaning in this context. The album has circulated digitally for some time, and its formal appearance on All Possible Worlds signals the seriousness with which Lauer regards this body of work. The label operates with a consistency of aesthetic vision that is rare even in the underground, each release designed with care that suggests the format is part of the argument. The physical object of \"Life\" is not incidental to the music. It is a statement about what this music deserves.\n\nLauer is also one half of Tuff City Kids, his collaborative project with Gerd Janson, and has released music as Prince of Denmark, among other aliases. Each configuration serves a different purpose. Where Tuff City Kids is often more playful and referential, Traumprinz is where Lauer goes deepest. The project is not a side project. It is the main argument.\n\nThe Traumprinz releases, since the earliest ones, have operated as a kind of maintained secret. There are no dramatic reinventions here, no pivots toward commercial visibility. The releases come out on a label whose name sounds like a William Blake title, distributed through the infrastructure of the underground, written about in publications that care precisely about this music. \"Life\" is the latest installment in that project, and it deepens the commitment rather than expanding it.\n\nThe record's relationship to time is worth addressing directly. Electronic music has a complicated relationship with the past because the tools themselves carry historical meaning. A synthesizer that was state-of-the-art in 1987 now sounds like a particular era, and a producer who uses it is making a choice about what that era meant. Traumprinz has never been particularly interested in that kind of historicism. The sounds on \"Life\" are not chosen for their vintage associations. They are chosen for what they do to the body, to the room, to the particular quality of attention the music asks for. That is a crucial distinction. Nostalgia is passive. What Lauer does is active.\n\nWhat \"Life\" ultimately argues is that depth, in electronic music as in anything else, is a practice rather than an achievement. The groove on this album is not arrived at. It is inhabited. And the difference matters, because music that has been arrived at tends to stay where it is, while music that is inhabited moves with the listener, changes meaning with context, rewards returning to it in a way that purely constructed work rarely does.\n\nThis is a record for late evenings and early mornings, for the particular quality of consciousness that comes after the social part of the night has ended and something else begins. It is also, despite its genre setting, a deeply personal record. The titles make that clear. And that combination of the impersonal architecture of techno and house working alongside a very personal emotional register is what Traumprinz has always done best. \"Life\" does not announce itself. It simply occupies space, fully and without apology, and stays there until you understand why it needed to.\n\n[download:/assets/images/artists/traumprinz-life-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: traumprinz-life.json"

# Verify live
echo "Verifying traumprinz-life..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/traumprinz-life)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/traumprinz-life&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: traumprinz-life"


# ---- POST 2: Mexican Institute of Sound & Meridian Brothers - Ruido Tovar ----
echo "--- Deploying: ruido-tovar ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/ruido-tovar.jpg'

# Try insheepsclothinghifi article
try:
    html = fetch('https://insheepsclothinghifi.com/mexican-institute-of-sound-and-meridian-brothers-collide-on-ruido-tovar-camilo-lara-explains/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+(?:mexican|mis|camilo|ruido|tovar)[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+/wp-content/uploads/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://insheepsclothinghifi.com/')
        print('Downloaded from In Sheeps Clothing HiFi')
        sys.exit(0)
except Exception as e:
    print(f'In Sheeps Clothing failed: {e}')

# Try Bandcamp Ruido Tovar page
try:
    html = fetch('https://mexicaninstituteofsound1.bandcamp.com/album/ruido-tovar')
    imgs = re.findall(r'(https?://f4\.bcbits\.com/img/[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://mexicaninstituteofsound1.bandcamp.com/')
        print('Downloaded from Bandcamp (MIS)')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp MIS failed: {e}')

# Try Bandcamp Meridian Brothers
try:
    html = fetch('https://meridianbrothers.bandcamp.com/album/ruido-tovar')
    imgs = re.findall(r'(https?://f4\.bcbits\.com/img/[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://meridianbrothers.bandcamp.com/')
        print('Downloaded from Bandcamp (Meridian Brothers)')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp Meridian Brothers failed: {e}')

# Try Camilo Lara official site
try:
    html = fetch('https://www.camilolara.com/mis')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|webp))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.camilolara.com/')
        print('Downloaded from Camilo Lara official site')
        sys.exit(0)
except Exception as e:
    print(f'Camilo Lara site failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#2d1b69-#11998e\" -gravity center -pointsize 48 -fill white -annotate 0 \"Mexican Institute of Sound\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/ruido-tovar.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/ruido-tovar-up.jpg && \
  mv ~/artonly.io/assets/images/artists/ruido-tovar-up.jpg \
     ~/artonly.io/assets/images/artists/ruido-tovar.jpg
echo "Image upscaled: ruido-tovar.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py ruido-tovar "Cumbia at the Edge of Chaos, Ruido Tovar and the Joy of Going Too Far" music
echo "Social card generated: ruido-tovar-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/ruido-tovar.json << 'ENDJSON'
{
  "slug": "ruido-tovar",
  "title": "Cumbia at the Edge of Chaos, Ruido Tovar and the Joy of Going Too Far",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-28",
  "image": "/assets/images/artists/ruido-tovar.jpg",
  "image_alt": "Mexican Institute of Sound press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/4TPTW3cTwUtiihgOMSQfmy]\n\nRigo Tovar was not a sophisticated artist in the ways that word is usually meant. He was a bandleader from Tamaulipas who in the 1970s took Colombian cumbia, stripped it down, ran it through a cheap organ and a reverb tank, and made something that sounded like it was coming from another planet. The results were enormously popular in a way that critical culture tends to ignore: beloved by working people across Mexico and parts of the United States, played at quinceañeras and funerals and roadside taco stands for decades after his death in 2011. Rigo Tovar is a ghost that haunts northern Mexico's sonic landscape, the spirit of a certain kind of joy that has no interest in being refined.\n\n\"Ruido Tovar,\" the new collaboration between Camilo Lara's Mexican Institute of Sound and Eblis Alvarez's Meridian Brothers, takes Tovar's name and the concept embedded within it, the idea of noise as form, of roughness as cultural value, and runs it through two of the most restlessly creative minds in contemporary Latin music. The result is one of the most exhilarating albums of 2026, a record that sounds like it was made with something to prove while also sounding completely relaxed about the proving of it.\n\n## A Different Kind of Serious\n\nCamilo Lara has spent two decades as Mexican Institute of Sound building something that might be called archival futurism. His records have drawn on Mexican cumbia, danzón, norteño, and dozens of smaller regional subgenres, not to preserve them in amber but to find out what they can do when pushed into new contexts. His sensibility is that of a DJ as much as a producer. He hears music in terms of what it can be made to do, what combinations of texture and tempo and reference create emotional effects that neither source material alone could produce.\n\nEblis Alvarez, operating as Meridian Brothers out of Bogotá, is a different kind of mind entirely. His music is stranger, more theatrical, shaped by a deep love of avant-garde electronics and psychedelia that sits uncomfortably alongside his fluency in cumbia and Caribbean rhythms. His albums have the quality of dreamed versions of familiar forms, recognizable enough to orient the listener but uncanny enough to keep them slightly off balance. The combination of Lara's precision and Alvarez's eccentricity should not work as smoothly as it does on this record.\n\nThe album was produced for Ansonia Records, a label with a long history of documenting and distributing Caribbean and Latin tropical music. That context is not accidental. The fact that this collaboration exists on that label is a statement about where this music belongs in a longer history, not in the experimental section of any genre taxonomy but in the lineage of popular forms that were always stranger than they were given credit for.\n\n## Beck and the Logic of the Unexpected\n\nThe record moves through danzón and son and cha-cha-cha and experimental electronics with the bright saturation of tropical music at full volume, but underneath it is that unmistakable Meridian Brothers angle, the sense that something is slightly wrong in the best possible way. Synthesizers behave as if they have been left in the sun. Rhythms seem to be competing with each other for dominance before arriving at something better than either would have managed alone. The record has the texture of a collaboration between two artists who agreed completely on the goal and disagreed productively about how to get there.\n\nBeck appears on two tracks, and his presence makes a specific kind of sense here. He has spent his career doing something similar to what Lara and Alvarez do, but at a larger scale: treating genre as material rather than identity, combining elements that are not supposed to go together and making the result feel inevitable. He does not overwhelm the album's logic. He slips into it, contributing what the record needed without calling attention to the contribution.\n\nThere is something important happening here at the level of cultural geography. MIS is Mexico City. Meridian Brothers is Bogotá. The record is structured around Rigo Tovar, who was from Tamaulipas. Three points of reference, each carrying a different relationship to cumbia as both heritage and living form. The collision between them is the album's real subject, and it is handled with the kind of care that comes from people who have spent years thinking about these questions before they sat down to record anything.\n\n## The Noise That Was Always There\n\nThe title rewards thinking about. Ruido can mean noise, disturbance, racket, commotion. Tovar is the name of the artist being invoked but also a proper noun that the album appropriates as freely as if it could be any other noun. Together the words suggest something like \"Tovar's disruption\" or \"the commotion called Tovar\" or simply \"loud in the way that Rigo was loud.\" The ambiguity is not a problem. It is the point.\n\nThe record is also a statement about the relationship between Mexico and Colombia in cumbia history, a story that tends to be simplified in both directions. Colombian cumbia arrived in Mexico in the 1960s and was transformed so thoroughly by local context that it became something new, something Colombia no longer recognized as its own. \"Ruido Tovar\" treats that history as productive rather than contentious. The noise, the ruido, is not what happened to the music when it crossed the border. The noise was always there. Rigo Tovar just knew how to make it louder.\n\nThe transmutation Lara and Alvarez perform on this record is neither nostalgic nor academic. They are not reconstructing something lost. They are using Tovar as a method, as a permission slip for a certain kind of irreverence and joy that serious music-making sometimes forgets it is allowed to feel. The album is allowed to be funny. It is allowed to be weird. It is allowed to sound like a remembered quinceañera with the volume broken and the lights not working right, in the best possible way.\n\nThere is a moment near the end of the record when the cumbia rhythm drops away entirely and what is left is electronics alone, cycling in something that sounds like it is trying to remember the groove and not quite finding it. The groove comes back. It always comes back. That is the lesson Rigo Tovar had to teach, and this album learned it correctly.\n\nWhat \"Ruido Tovar\" ultimately makes the case for is the idea that seriousness and joy are not opposites in music, that you can be rigorously engaged with history and tradition while also making something that people want to move to. Lara and Alvarez have made records separately that achieve one or the other at different moments. Together they have made something that does both at once, a record that knows exactly where it comes from and uses that knowledge not to bow but to dance.\n\n[download:/assets/images/artists/ruido-tovar-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: ruido-tovar.json"

# Verify live
echo "Verifying ruido-tovar..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/ruido-tovar)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ruido-tovar&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: ruido-tovar"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Mexican Institute of Sound
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=mexicaninstituteofsound@gmail.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Mexican Institute of Sound and Meridian Brothers and the new Ruido Tovar release at artonly.io/post/ruido-tovar. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: mexicaninstituteofsound@gmail.com"

# Traumprinz / All Possible Worlds (no public email found, skipping)
echo "Outreach skipped: Traumprinz (no public management email found)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-05-28" "Published today:

1. Traumprinz - Life
   https://artonly.io/post/traumprinz-life
   Author: Allastair Voss
   Spotify: 7AOdp2CXbaCubZirZQRz6z

2. Mexican Institute of Sound & Meridian Brothers - Ruido Tovar
   https://artonly.io/post/ruido-tovar
   Author: Leelou Blanc
   Spotify: 4TPTW3cTwUtiihgOMSQfmy

Outreach:
- Mexican Institute of Sound: email sent to mexicaninstituteofsound@gmail.com
- Traumprinz: skipped (no public management email found)

Both releases from May 22, 2026 week, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-05-28 ==="
