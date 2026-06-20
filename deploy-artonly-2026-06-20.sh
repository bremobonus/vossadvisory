#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-20
# Posts: sha-ray-dj-haram-critical-thot, alex-zhang-hungtai-orion-mother
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-20.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-20 ==="

# ---- POST 1: Sha Ray & DJ Haram - Critical Thot ----
echo "--- Deploying: sha-ray-dj-haram-critical-thot ---"

if [ -f ~/artonly.io/posts/sha-ray-dj-haram-critical-thot.json ]; then
  echo "Post already exists: sha-ray-dj-haram-critical-thot.json, skipping"
else

# Download press photo
python3 << 'IMGEOF'
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/sha-ray-dj-haram-critical-thot.jpg'

# Try Stereogum announcement
try:
    html = fetch('https://stereogum.com/2502345/sha-ray-dj-haram-announce-new-album-critical-thot-hear-two-songs/music')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['sha', 'haram', 'critical', 'thot'])]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\' <>]+stereogum[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

# Try Everything Is Noise
try:
    html = fetch('https://everythingisnoise.net/reviews/sha-ray-dj-haram-critical-thot/')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['sha', 'haram', 'thot', 'everythingisnoise'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://everythingisnoise.net/')
        print('Downloaded from Everything Is Noise')
        sys.exit(0)
except Exception as e:
    print(f'Everything Is Noise failed: {e}')

# Try Backwoodz Studioz store
try:
    html = fetch('https://backwoodzstudioz.com/collections/sha-ray-dj-haram-critical-thot')
    imgs = re.findall(r'(https?://cdn\.shopify\.com/[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://backwoodzstudioz.com/')
        print('Downloaded from Backwoodz Studioz')
        sys.exit(0)
except Exception as e:
    print(f'Backwoodz Studioz failed: {e}')

# Try Rhymesayers
try:
    html = fetch('https://rhymesayers.com/products/sha-ray-dj-haram-critical-thot-cd')
    imgs = re.findall(r'(https?://cdn\.shopify\.com/[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://rhymesayers.com/')
        print('Downloaded from Rhymesayers')
        sys.exit(0)
except Exception as e:
    print(f'Rhymesayers failed: {e}')

# Fallback: ImageMagick placeholder
print('All image sources failed; generating placeholder')
os.system(f'convert -size 1200x800 gradient:"#0a0a12-#12000a" -gravity center -pointsize 52 -fill white -annotate 0 "Sha Ray x DJ Haram" {dest}')
IMGEOF

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/sha-ray-dj-haram-critical-thot.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/sha-ray-dj-haram-critical-thot-up.jpg && \
  mv ~/artonly.io/assets/images/artists/sha-ray-dj-haram-critical-thot-up.jpg \
     ~/artonly.io/assets/images/artists/sha-ray-dj-haram-critical-thot.jpg
echo "Image upscaled: sha-ray-dj-haram-critical-thot.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py sha-ray-dj-haram-critical-thot "On Critical Thot, Sha Ray and DJ Haram Define Unapologetic Feminine Authority in Rap" music
echo "Social card generated: sha-ray-dj-haram-critical-thot-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

BODY = """[spotify:artist/5Y4Skucz2y4H8UhB0RpTaQ]

The word \"thot\" has a complicated life. It emerged from Black vernacular, was weaponized as misogynist shorthand for dismissiveness, and has been working its way back through reclamation territory for years. When Sha Ray and DJ Haram title their debut album \"Critical Thot,\" they are not being ironic and they are not asking permission. They are doing what has always made the best experimental hip-hop worth paying attention to: taking the terms of a hostile environment and building something precise from the wreckage.

This is Sha Ray's first full-length as a credited recording artist, but her reputation as a Bay Area live act has been accumulating since well before this release. DJ Haram, born Zubeyda Muzeyyen in New Jersey, first caught Sha Ray performing at a Brooklyn show in 2022 and understood immediately that this was someone worth pursuing. Their collaboration developed remotely, with Haram generating productions in Brooklyn and Sha Ray responding from the West Coast with demos and structural ideas. The distance, rather than creating gaps in the record's coherence, seems to have given each artist space to bring their full frame of reference without negotiation.

Haram's context gives some indication of what that frame contains. As one-half of 700 Bliss alongside Moor Mother, she has spent years developing a production philosophy that treats noise, texture, and rhythmic displacement as emotional information rather than aesthetic statement. Her 2025 solo album \"Beside Myself,\" released through Hyperdub, extended this into deconstructed club territory that did not prioritize danceability over conceptual rigor. On \"Critical Thot,\" the productions pull in a different direction without abandoning that philosophy. The beats are hard, dense, sometimes industrial in their refusal of prettiness, and they are designed for a specific voice. They are calibrated to carry the weight of what Sha Ray is saying rather than compete with it.

What Sha Ray is saying is not difficult to hear. She is talking about sex, desire, power, and the particular social position of a woman who does not frame these things apologetically. \"Critical Thot\" takes its title seriously as a conceptual position. The album treats the experience of being a sexually expressive Black woman in rap as a site of genuine critical inquiry, not performance. The inspirations Sha Ray has cited publicly make sense of the project: David Lynch's commitment to the subconscious as legitimate subject matter; Elvira's use of camp and sexuality as authority rather than vulnerability; Gangsta Boo's construction of a feminine persona in rap that was threatening rather than decorative; Future's total immersion in atmosphere and persona as compositional tools.

## The Album as Argument

The nine-track structure is economical, which suits the material. This is not an album interested in duration as evidence of seriousness. The opening track \"The Material\" establishes the terms immediately: beats that compress rather than breathe, a vocal approach that prioritizes clarity over melody, subject matter that treats self-objectification as a choice made with full knowledge of the social machinery operating around it. This is the critical part of the title. The album does not simply celebrate its own transgression. It examines the conditions under which transgression is available, who gets to use it, and what it costs.

\"Champagne and Bouquets\" and \"Thot Daughter\" extend this inquiry into family, lineage, and the inheritance of feminine authority that is never formally acknowledged but gets passed down anyway. These are the album's densest moments conceptually, tracks where the production creates a kind of pressure that the lyric operates within rather than against.

\"Hey Queen,\" featuring Nappy Nina and J Words, is the album's most expansive moment in terms of social geography. Nappy Nina and J Words operate in overlapping but distinct registers from Sha Ray, and their presence on the track opens the album's conversation outward without softening any of its claims. The word \"queen\" in hip-hop can land as empty flattery. In this context, bracketed by everything the album has already said, it arrives as something closer to taxonomy: this is the territory, and these are the people in it.

## The Label Context and What It Means

The Backwoodz Studioz context matters. Founded and operated out of the same underground rap ecosystem that produced Billy Woods and ELUCID, the label has built its catalog on the idea that difficulty and directness are not opposites, that music can be formally adventurous and morally serious at the same time without either quality undermining the other. \"Critical Thot\" is a different kind of addition to that catalog than anything the label has previously released, and the difference is the point. It brings in the deconstructed club influence of Haram's Hyperdub work, the feminist critique that has animated the best of the Moor Mother orbit, and something specific to Sha Ray that none of these frames entirely contain: a debut artist who has been performing long enough to know exactly what she wants to say and has found the right collaborator to say it alongside.

The album was built entirely in correspondence, Haram in Brooklyn and Sha Ray in the Bay, which lends the record a particular quality of intention. Every choice was deliberate. Nothing could be improvised in the room or adjusted in the moment. The collaboration required trust and clarity about what was being made, and that clarity is audible throughout.

## What Debuts Reveal

Debut albums tell you what an artist thinks is worth saying when they finally have the platform to say it. Sha Ray's debut says: self-possession as political position; desire as something that belongs to the person experiencing it; the reclaimed slur as a site of critical engagement rather than dismissal; and noise production as the appropriate sonic environment for material that has never been quiet.

DJ Haram's production is exactly right for these purposes. Dense, physical, hard in the way that things are hard when they do not cushion themselves for reception. \"Critical Thot\" is a debut that arrives knowing exactly what it is and declines to make that easy. Sha Ray is here. She will not be making herself smaller to be better understood.

[download:/assets/images/artists/sha-ray-dj-haram-critical-thot-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "sha-ray-dj-haram-critical-thot",
    "title": "On Critical Thot, Sha Ray and DJ Haram Define Unapologetic Feminine Authority in Rap",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-20",
    "image": "/assets/images/artists/sha-ray-dj-haram-critical-thot.jpg",
    "image_alt": "Sha Ray and DJ Haram press photo",
    "image_position": "center 20%",
    "body": BODY
}

with open('/home/dh_yadmw3/artonly.io/posts/sha-ray-dj-haram-critical-thot.json', 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print('JSON deployed: sha-ray-dj-haram-critical-thot.json')
PYEOF

# Verify live
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/sha-ray-dj-haram-critical-thot)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/sha-ray-dj-haram-critical-thot&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: sha-ray-dj-haram-critical-thot"

fi  # end skip block


# ---- POST 2: Alex Zhang Hungtai - Orion/Mother ----
echo "--- Deploying: alex-zhang-hungtai-orion-mother ---"

if [ -f ~/artonly.io/posts/alex-zhang-hungtai-orion-mother.json ]; then
  echo "Post already exists: alex-zhang-hungtai-orion-mother.json, skipping"
else

# Download press photo
python3 << 'IMG2EOF'
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/alex-zhang-hungtai-orion-mother.jpg'

# Try FLOOD Magazine
try:
    html = fetch('https://floodmagazine.com/225072/alex-zhang-hungtai-tanhauser-gate-tugce-first-listen/')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['zhang', 'hungtai', 'alex', 'orion'])]
    if not imgs:
        imgs = re.findall(r'(https?://floodmagazine[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://floodmagazine.com/')
        print('Downloaded from FLOOD Magazine')
        sys.exit(0)
except Exception as e:
    print(f'FLOOD Magazine failed: {e}')

# Try That Eric Alper
try:
    html = fetch('https://www.thatericalper.com/2026/04/22/alex-zhang-hungtais-ambitious-double-album-orion-mother-arrives-june-19/')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['zhang', 'hungtai', 'alex', 'orion', 'thatericalper'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thatericalper.com/')
        print('Downloaded from That Eric Alper')
        sys.exit(0)
except Exception as e:
    print(f'That Eric Alper failed: {e}')

# Try KLOF Mag
try:
    html = fetch('https://klofmag.com/2026/04/alex-zhang-hungtai-double-album-orion-mother/')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['zhang', 'hungtai', 'alex', 'orion', 'klof'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://klofmag.com/')
        print('Downloaded from KLOF Mag')
        sys.exit(0)
except Exception as e:
    print(f'KLOF Mag failed: {e}')

# Try Destroy/Exist
try:
    html = fetch('https://www.destroyexist.com/2026/05/alex-zhang-hungtai-american-burial.html')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['zhang', 'hungtai', 'alex', 'destroyexist'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.destroyexist.com/')
        print('Downloaded from Destroy/Exist')
        sys.exit(0)
except Exception as e:
    print(f'Destroy/Exist failed: {e}')

# Try Cafe OTO artist page
try:
    html = fetch('https://www.cafeoto.co.uk/artists/alex-zhang-hungtai/')
    imgs = re.findall(r'(https?://[^\s"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['zhang', 'hungtai', 'alex', 'cafeoto'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.cafeoto.co.uk/')
        print('Downloaded from Cafe OTO')
        sys.exit(0)
except Exception as e:
    print(f'Cafe OTO failed: {e}')

# Fallback: ImageMagick placeholder
print('All image sources failed; generating placeholder')
os.system(f'convert -size 1200x800 gradient:"#08080f-#0f0a1a" -gravity center -pointsize 48 -fill white -annotate 0 "Alex Zhang Hungtai" {dest}')
IMG2EOF

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/alex-zhang-hungtai-orion-mother.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/alex-zhang-hungtai-orion-mother-up.jpg && \
  mv ~/artonly.io/assets/images/artists/alex-zhang-hungtai-orion-mother-up.jpg \
     ~/artonly.io/assets/images/artists/alex-zhang-hungtai-orion-mother.jpg
echo "Image upscaled: alex-zhang-hungtai-orion-mother.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py alex-zhang-hungtai-orion-mother "Alex Zhang Hungtai's Double Album Orion and Mother Is the Year's Most Searching Work" music
echo "Social card generated: alex-zhang-hungtai-orion-mother-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PY2EOF'
import json

BODY = """[spotify:artist/0U4w3nZTdH0QyefP5b1q0P]

Alex Zhang Hungtai has been making music under various names and configurations for more than a decade, but his project has always been essentially the same: an investigation into what sound can hold when the person making it is willing to live inside the uncertainty of the process rather than directing it from a safe distance. As Dirty Beaches, the name under which he released \"Badlands\" and \"Drifters/Love Is the Devil\" in the early part of this decade, he built a reputation on records that felt like transmissions from an altered state. Rockabilly filtered through noise, personal mythology rendered in distorted guitar, the figure of the outsider as compositional principle. When he ended that project in 2014 and began releasing music under his own name, something shifted. The persona dissolved. The investigation remained.

\"Orion/Mother\" is his second release of 2026 and his most formally ambitious to date: a double album, each half running as a distinct but related record, connected by the same material circumstances. Zhang Hungtai has described the project as emerging from two weeks of full days in a New York rehearsal space during winter, a period he has called one of intense personal transition. The sessions involved some of New York's finest improvisers, whose home recordings he later sampled and composed on top of, using trumpet as the conceptual narrator throughout. The result is an album about the unconscious and about what surfaces when a person is genuinely inside a transformative experience rather than retrospectively organizing one.

The American Dreams Records context provides the ideal frame. The label, which has spent years building a catalog of experimental and avant-garde American music with a commitment that outpaces market logic, does not ask its artists to resolve what they are doing into legible categories. It provides infrastructure for artists working at the edge of genre, which is exactly where Zhang Hungtai has always operated most productively.

## Two Sides, Two Kinds of Distance

The double album format is not a novelty here. The two halves make distinct emotional claims. \"Orion\" works outward: more open spatially, influenced by the improvisers whose recordings form its structural material, concerned with a quality of expansiveness that the record's title suggests without fully explaining. The trumpet moves through these tracks as a presence rather than a lead instrument, sometimes disappearing into the texture entirely, sometimes emerging as the clearest element in the mix.

\"Mother\" works inward. The material here is more intimate, more personal in the way that the word \"mother\" carries weight in any language: origin, foundation, the prior relationship that conditions everything that follows. Zhang Hungtai has spoken about how the period that generated this music was one of reckoning with the past through improvised present-tense composition. That process is audible in \"Mother.\" There is a quality of raw material that has not been fully domesticated, which does not mean unfinished. It means the work has chosen to preserve the texture of its own making rather than smooth it away in the interest of a cleaner product.

The trumpet's role as what Zhang Hungtai calls the \"grounding force\" becomes clearest on \"Mother.\" Here it functions almost as a voice that is not quite speaking, using the logic of improvisation to respond to material that carries a charge prepared composition could not address. Trumpet improvisation has its own traditions of emotional directness, its own vocabulary for navigating material that resists resolution. Zhang Hungtai brings those traditions to bear on experiences that are genuinely his own without making the music about confessional disclosure. The instrument mediates. The music arrives.

## A Taiwanese-Canadian Artist in New York's Improvised Music Scene

Zhang Hungtai was born in Taiwan and raised in Canada, and his work has always carried a multiple-inheritance quality: a person formed by places and languages that do not resolve into a single coherent identity. As Dirty Beaches, this manifested as the figure of the drifter, the person who belongs fully nowhere and observes acutely from the margin. Under his own name, the same condition is handled differently, not as persona but as the actual texture of how he thinks and what he makes.

The New York improvisers whose recordings form the basis of \"Orion/Mother\" bring their own traditions into the work: American jazz, avant-garde performance practice, the specific community of musicians who have sustained a particular vision of what improvised music can be for generations. Zhang Hungtai's role as an outside composer working on top of the collaborators' recordings is unusual. It creates a particular kind of intimacy in the finished work: the improvisers are present but processed, heard through the sensibility of someone who thinks in different cultural materials. This is not fusion in any conventional sense. It is closer to what photographers do when they are interested in what a subject reveals about something beyond itself. The recordings become a lens, and the compositions that emerge on top of them are the result of that looking.

## The Meaning of This Much Music

That Zhang Hungtai releases a double album as his second project of 2026 is itself a statement. At a moment when the dominant logic of music distribution pushes artists toward singles and short-form content designed for algorithmic recommendation, a double album says something about the artist's relationship to form. It says: this much material belongs together, and it will not be broken into pieces for convenience.

\"Orion/Mother\" earns the format. Neither disc wastes its position or overstays its welcome. The two together create something that neither alone could achieve: a record of genuine transition, of someone moving through a period of difficulty and change and making music that does not organize that experience after the fact but holds it in real time. This is what improvisation is for. This is what Zhang Hungtai has always understood: the best art does not present a finished version of experience. It lets you feel the experience in the making.

[download:/assets/images/artists/alex-zhang-hungtai-orion-mother-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "alex-zhang-hungtai-orion-mother",
    "title": "Alex Zhang Hungtai's Double Album Orion and Mother Is the Year's Most Searching Work",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-20",
    "image": "/assets/images/artists/alex-zhang-hungtai-orion-mother.jpg",
    "image_alt": "Alex Zhang Hungtai press photo",
    "image_position": "center 20%",
    "body": BODY
}

with open('/home/dh_yadmw3/artonly.io/posts/alex-zhang-hungtai-orion-mother.json', 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print('JSON deployed: alex-zhang-hungtai-orion-mother.json')
PY2EOF

# Verify live
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/alex-zhang-hungtai-orion-mother)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/alex-zhang-hungtai-orion-mother&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: alex-zhang-hungtai-orion-mother"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Sha Ray & DJ Haram (Backwoodz Studioz)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=hello@backwoodzstudioz.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Sha Ray and DJ Haram and the new album Critical Thot at artonly.io/post/sha-ray-dj-haram-critical-thot. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: hello@backwoodzstudioz.com (Sha Ray & DJ Haram)"

# Alex Zhang Hungtai (American Dreams Records)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=info@american-dreams.zone" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Alex Zhang Hungtai and the new double album Orion/Mother at artonly.io/post/alex-zhang-hungtai-orion-mother. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: info@american-dreams.zone (Alex Zhang Hungtai)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-20" "Published today:

1. Sha Ray & DJ Haram - Critical Thot
   https://artonly.io/post/sha-ray-dj-haram-critical-thot
   Author: Allastair Voss
   Spotify artist: 5Y4Skucz2y4H8UhB0RpTaQ (DJ Haram)
   Released: June 19, 2026 (Backwoodz Studioz / Rhymesayers)
   9 tracks, debut album for Sha Ray
   Themes: unapologetic feminine authority, reclamation, experimental hip-hop

2. Alex Zhang Hungtai - Orion/Mother
   https://artonly.io/post/alex-zhang-hungtai-orion-mother
   Author: Leelou Blanc
   Spotify artist: 0U4w3nZTdH0QyefP5b1q0P
   Released: June 19, 2026 (American Dreams Records)
   Double album, improvised jazz and ambient, trumpet-led
   Themes: personal transition, NYC winter sessions, improvisation

Outreach:
- Sha Ray / DJ Haram: email sent to hello@backwoodzstudioz.com
- Alex Zhang Hungtai: email sent to info@american-dreams.zone

Both releases from June 19, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-20 ==="
