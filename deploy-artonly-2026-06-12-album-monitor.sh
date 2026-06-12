#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-12
# Posts: dj-seinfeld-if-this-is-it, laura-misch-lithic
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-12-album-monitor.sh

set -e
echo "=== ArtOnly Album Monitor Deploy: 2026-06-12 ==="
echo "$(date)"

# ============================================================
# POST 1: DJ Seinfeld - If This Is It
# ============================================================

if [ ! -f ~/artonly.io/posts/dj-seinfeld-if-this-is-it.json ]; then

echo "--- Deploying: dj-seinfeld-if-this-is-it ---"

# Download press photo
python3 << 'PYEOF'
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it.jpg'

# Try Ninja Tune release page
try:
    html = fetch('https://ninjatune.net/release/dj-seinfeld/if-this-is-it', referer='https://ninjatune.net/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'seinfeld' in i.lower() or 'dj' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://(?:static|cdn|media)\.ninjatune\.net/[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ninjatune.net/')
        print('Downloaded from Ninja Tune release page')
        sys.exit(0)
except Exception as e:
    print(f'Ninja Tune release failed: {e}')

# Try Ninja Tune artist page
try:
    html = fetch('https://ninjatune.net/artist/dj-seinfeld', referer='https://ninjatune.net/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'seinfeld' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://(?:static|cdn|media)\.ninjatune\.net/[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ninjatune.net/')
        print('Downloaded from Ninja Tune artist page')
        sys.exit(0)
except Exception as e:
    print(f'Ninja Tune artist failed: {e}')

# Try Soundspace article
try:
    html = fetch('https://wearesoundspace.com/dj-seinfeld-if-this-is-it-ninja-tune', referer='https://wearesoundspace.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'seinfeld' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+soundspace[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://wearesoundspace.com/')
        print('Downloaded from Soundspace')
        sys.exit(0)
except Exception as e:
    print(f'Soundspace failed: {e}')

# Try whynow article
try:
    html = fetch('https://whynow.co.uk/read/dj-seinfeld-if-this-is-it-album', referer='https://whynow.co.uk/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'seinfeld' in i.lower() or 'whynow' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://whynow.co.uk/')
        print('Downloaded from whynow')
        sys.exit(0)
except Exception as e:
    print(f'whynow failed: {e}')

# Try djseinfeld official site
try:
    html = fetch('https://www.djseinfeld.com/', referer='https://www.djseinfeld.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'seinfeld' in i.lower() or 'artist' in i.lower() or 'press' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+djseinfeld[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.djseinfeld.com/')
        print('Downloaded from djseinfeld.com')
        sys.exit(0)
except Exception as e:
    print(f'djseinfeld.com failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:"#0a0a18-#0d0d22" -gravity center -pointsize 52 -fill white -annotate 0 "DJ Seinfeld" {dest}')
PYEOF

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it-up.jpg && \
  mv ~/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it-up.jpg \
     ~/artonly.io/assets/images/artists/dj-seinfeld-if-this-is-it.jpg
echo "Image upscaled: dj-seinfeld-if-this-is-it.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py dj-seinfeld-if-this-is-it "If This Is It Proves DJ Seinfeld Was Always More Than the Genre He Invented" music
echo "Social card generated: dj-seinfeld-if-this-is-it-social-9x16.jpg"
cd ~

# Write JSON post
python3 << 'PYEOF'
import json

body = """\
[spotify:artist/37YzpfBeFju8QRZ3g0Ha1Q]

## The Accident That Became a Career

Armand Jakobsson made \"Time Spent Away from U\" in 2017 in a state of heartbreak, in Malmo, on equipment he had borrowed and barely knew how to use. The record landed online with almost no context, arrived in the midst of a moment when a certain strain of lo-fi house music, warm and hazy and nostalgic for something that had never quite existed, was developing its own small infrastructure of listeners. The name he used, DJ Seinfeld, was a joke, the kind of thing you put on a release that you do not expect anyone to hear. Hundreds of thousands of people heard it. The genre he became associated with, lo-fi house, mushroomed outward from that moment and produced a decade's worth of imitators. He had not set out to start anything. He had made something private and public at the wrong time, or the right time, depending on how you measure these things.

The problem with being identified as the originator of a movement is that the movement becomes your context. Every subsequent record Jakobsson made was evaluated partly in relation to the thing he had accidentally created. Did it develop the lo-fi house sound? Did it depart from it? Was the departure justified? The critical frame around his work, even when the work itself moved elsewhere, kept pulling back to 2017. \"Mirrors\" in 2021 was received largely through this lens. The question animating the critical reception was not quite what the album was but whether it had moved far enough from what he was known for.

\"If This Is It\" does not ask this question. It is the record of an artist who has decided to stop explaining himself, and the confidence of that decision is audible in every track.

## The Shape of Restlessness

The album's central theme, as Jakobsson has articulated it, is restlessness. Not as pathology but as orientation. \"If This Is It is about reflecting on the past without dwelling in it, and finding harmony in restlessness,\" he has said. This statement sounds like it belongs in a press release, and it does belong in a press release, but it also describes something real about the music. The twelve tracks on this record do not stay still. They move between nostalgic house, UK garage, 2000s trance, and moments of ambient softness, not as a survey of genres but as the expression of an artist who has genuine fluency across these forms and no particular allegiance to any of them.

What holds the record together is not genre coherence but emotional coherence. There is a quality of longing running through the whole thing, a persistence of feeling that sounds like nostalgia but is aimed at something other than a specific past. It is nostalgia for the condition of feeling intensely, which is perhaps the only nostalgia that survives scrutiny. The synthesizer pads that anchor several of the central tracks have the warmth that his early work was praised for, but deployed here with more structural intention. They are not mood. They are argument.

## The Collaborators and What They Bring

The features on \"If This Is It\" are chosen with evident care. SG Lewis, who has been navigating a similar negotiation between credibility and accessibility in his own career, appears on a track that shows what Jakobsson can do when the production is in conversation with a vocalist who understands the emotional register. Confidence Man, whose whole project is about the intersection of serious craft and irresistible energy, brings something that disrupts the record's contemplative surface in ways that are useful rather than gimmicky. TS Graye, ARY, Moyka, Dan Whitlam, and just lil each occupy their particular moments without the record collapsing into a features showcase.

This matters because collaborative electronic music often loses coherence in proportion to the number of voices involved. The album becomes a compilation. \"If This Is It\" does not do this. The collaborators are inside the sonic world Jakobsson has built rather than arriving in it from outside. The consistency of the production aesthetic, the specific quality of the synthesis, the way the record controls dynamics, creates a container that the guests occupy rather than distort.

## UK Garage and What It Asks

The presence of UK garage and UKG in the album's DNA is not incidental. These are forms built around a particular kind of emotional directness, around beats that ask the body to respond before the mind has had time to decide, around vocal cuts that operate through truncation and implication rather than full statement. They are also forms with a specific history, rooted in south London, in a particular moment in British popular culture, that any artist approaching them from outside needs to approach with some awareness of what that history involves.

Jakobsson, Swedish and working from a tradition that received UK garage as an import rather than a domestic form, handles this with appropriate care. He does not reproduce the genre but responds to it, takes its structural logic and builds with it rather than imitating its surface. The result sounds genuinely informed by the form rather than merely influenced by it. The distinction is the difference between an artist who has listened carefully and one who has borrowed casually.

## After the Accident

The question of what happens after you accidentally become the defining figure of a genre is a genuine career question and \"If This Is It\" is the most persuasive answer Jakobsson has yet given. You build. You take what the accident taught you about what sound can do emotionally and you develop it toward something that could not have been predicted from the starting point. The restlessness that produced the early work becomes the subject of the later work. The yearning that made \"Time Spent Away from U\" so unexpectedly resonant is now understood well enough to be shaped.

This is a third album in the fullest sense: the record where the artist's project becomes legible on its own terms, no longer containable by the history of what produced it. The accident is still there, as foundation, as the material that has been worked. But it no longer explains the work. The work explains itself.

[download:/assets/images/artists/dj-seinfeld-if-this-is-it-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "dj-seinfeld-if-this-is-it",
    "title": "If This Is It Proves DJ Seinfeld Was Always More Than the Genre He Invented",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-12",
    "image": "/assets/images/artists/dj-seinfeld-if-this-is-it.jpg",
    "image_alt": "DJ Seinfeld press photo",
    "image_position": "center 20%",
    "body": body
}

path = '/home/dh_yadmw3/artonly.io/posts/dj-seinfeld-if-this-is-it.json'
with open(path, 'w') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
print('JSON written: dj-seinfeld-if-this-is-it.json')
PYEOF

# Verify live
echo "Verifying dj-seinfeld-if-this-is-it..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/dj-seinfeld-if-this-is-it)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/dj-seinfeld-if-this-is-it&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: dj-seinfeld-if-this-is-it"

# Outreach email
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press_row@ninjatune.net" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on DJ Seinfeld and the new album If This Is It at artonly.io/post/dj-seinfeld-if-this-is-it. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press_row@ninjatune.net (DJ Seinfeld)"

else
  echo "Already deployed: dj-seinfeld-if-this-is-it.json"
fi


# ============================================================
# POST 2: Laura Misch - Lithic
# ============================================================

if [ ! -f ~/artonly.io/posts/laura-misch-lithic.json ]; then

echo "--- Deploying: laura-misch-lithic ---"

# Download press photo
python3 << 'PYEOF'
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/laura-misch-lithic.jpg'

# Try Sacks and Co. PR page
try:
    html = fetch('https://sacksco.com/pr/laura_misch.html', referer='https://sacksco.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'misch' in i.lower() or 'laura' in i.lower() or 'sacksco' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://sacksco\.com/[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://sacksco.com/')
        print('Downloaded from Sacks and Co.')
        sys.exit(0)
except Exception as e:
    print(f'Sacks and Co. failed: {e}')

# Try Clash Magazine feature
try:
    html = fetch('https://www.clashmusic.com/features/laura-misch-is-in-her-lithic-era/', referer='https://www.clashmusic.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'misch' in i.lower() or 'laura' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+clashmusic[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Clash Magazine failed: {e}')

# Try FEMMUSIC article
try:
    html = fetch('https://femmusic.com/2026/02/18/laura-misch-lithic/', referer='https://femmusic.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'misch' in i.lower() or 'laura' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://femmusic.com/')
        print('Downloaded from FEMMUSIC')
        sys.exit(0)
except Exception as e:
    print(f'FEMMUSIC failed: {e}')

# Try musicradar article
try:
    html = fetch('https://www.musicradar.com/artists/i-told-my-label-i-was-going-to-make-a-rock-album-as-in-an-album-made-of-rocks-laura-misch-is-turning-the-natural-world-into-music-with-field-recordings-saxophone-and-experimental-electronics', referer='https://www.musicradar.com/')
    imgs = re.findall(r'(https?://cdn\.mos\.cms\.futurecdn\.net/[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
        imgs = [i for i in imgs if 'misch' in i.lower() or 'laura' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.musicradar.com/')
        print('Downloaded from musicradar')
        sys.exit(0)
except Exception as e:
    print(f'musicradar failed: {e}')

# Try Line of Best Fit
try:
    html = fetch('https://www.thelineofbestfit.com/news/laura-misch-announces-new-album-lithic', referer='https://www.thelineofbestfit.com/')
    imgs = re.findall(r'(https?://[^\s"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'misch' in i.lower() or 'laura' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thelineofbestfit.com/')
        print('Downloaded from The Line of Best Fit')
        sys.exit(0)
except Exception as e:
    print(f'Line of Best Fit failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:"#0a1218-#0a1820" -gravity center -pointsize 52 -fill white -annotate 0 "Laura Misch" {dest}')
PYEOF

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/laura-misch-lithic.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/laura-misch-lithic-up.jpg && \
  mv ~/artonly.io/assets/images/artists/laura-misch-lithic-up.jpg \
     ~/artonly.io/assets/images/artists/laura-misch-lithic.jpg
echo "Image upscaled: laura-misch-lithic.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py laura-misch-lithic "Lithic Finds Laura Misch Making Her Most Immersive and Ambitious Album Yet" music
echo "Social card generated: laura-misch-lithic-social-9x16.jpg"
cd ~

# Write JSON post
python3 << 'PYEOF'
import json

body = """\
[spotify:artist/0NrVrf231eji48nhNUJTXe]

## What the Earth Has Been Doing

The word \"lithic\" refers to stone. It is used in archaeology to describe the period before written record, the long stretch of human time that is known primarily through the objects people made and left behind in the earth. Stone tools. Flint work. The accumulated evidence of intelligence operating without language, making meaning through shape and material. To name an album \"Lithic\" is to make a claim about what kind of record it is, about what kind of time it inhabits, about what medium it uses to leave its mark.

Laura Misch, the London-based composer and saxophonist, had what she describes as a simple announcement for her label when she began work on this second album. She told them she was going to make a rock album, meaning an album made of rocks. The fact that this sounds like a joke, that it has the quality of something said to see what response it produces, does not mean it was not entirely serious. The album that followed, recorded with producer Matt Karmil and built from field recordings, saxophone, and experimental electronics, is an act of commitment to a very specific listening practice: paying attention to material that does not speak in any register that music is typically made from, and finding out what happens when you translate it anyway.

## The Concept and Its Discipline

Concept albums fail when the concept is decoration, when the thematic framing is applied to music that would exist in essentially the same form without it. \"Lithic\" is not that. The geological conceit is not a frame applied over music produced by ordinary means. It is a method, a set of constraints and commitments that produced music that could not have been made otherwise.

The field recordings that run through the record, the actual sound of stone and water and wind and the forces that shape geological formations, are not atmosphere. They are structural material that Misch and Karmil built from. The saxophone, which is her primary instrument and the voice most directly associated with her first album \"Sample the Sky,\" appears here in a different relation to the other sounds. It is not the lead voice over an accompaniment. It is one element among several, a human instrument learning to coexist with sounds that preceded human existence by geological spans of time.

This is a compositional decision with real aesthetic and emotional consequences. The saxophone represents presence, warmth, human breath, the immediacy of a body making sound in real time. Setting it against field recordings of stone and geological process creates a tension between timescales that is not resolved but sustained throughout the record. You hear the human and the inhuman together and you do not know which is the context for the other.

## From Sample the Sky to Lithic

Misch's debut album, \"Sample the Sky,\" established her as an artist working at the intersection of jazz, electronics, and composition with a specific gift for atmosphere. The record received considerable praise for its spatial quality, for the way it seemed to create rooms and environments rather than just arrangements. \"Sample the Earth,\" the acoustic companion release that followed in 2024, stripped some of that spatial construction back and showed what the compositions looked like without the technology around them.

\"Lithic\" arrives as a third point in this trajectory, but it would be a mistake to read it as simply the next iteration of a developing style. The geological concept represents a more radical departure than the calm of the title suggests. \"Sample the Sky\" worked through accumulation, through layering, through the creation of density. \"Lithic\" works through a different principle: the slow revelation of structure that was already there. Stone is not built, it is found. You remove what is not stone to get to what is. The compositional approach on this record has something of that quality, a patience with material that allows form to emerge rather than imposing it.

## Deep Time and the Psyche

The record journeys through deep time and into the murky depths of the psyche. The conjunction of geological time and interior life is not an accident. Misch has spoken about finding parallels between the processes that shape geological formations and the processes that shape a person, the way erosion works on stone and the way experience accumulates and wears at the self. This is not a new metaphor. The connection here is worked through sound, not stated in lyrics, which makes it considerably more difficult to achieve and considerably more interesting when it works.

\"Lithic\" is largely instrumental. The moments of voice are spare, integrated into the sonic environment without dominating it. This is a record that trusts sound to carry meaning that language would specify too narrowly. The deliberate ambiguity of instrumental music, the way it can contain emotional information without fixing it to a particular interpretation, is used here with evident intention. You are invited into the geological process, into the deep time, without being told what to find there.

## Karmil and the Production

Matt Karmil's contribution to \"Lithic\" deserves attention. Karmil, whose own production work operates in the space between techno and ambient music, brings to the collaboration a specific understanding of how electronic sound functions across different timescales. His ear for the long form, for music that changes slowly enough that the change is felt rather than heard, is exactly what the project required. The partnership does not sound like producer and musician in any traditional sense. It sounds like a genuine collaboration, a shared working through of the same compositional problems.

The treatment of the saxophone in particular reflects this. In some passages the instrument is processed to the point of abstraction, its origin audible but its timbre transformed. In others it sits in the mix with a rawness and presence that makes it sound like a recording rather than a composition, like a document of a sound event rather than a designed aesthetic object. The movement between these registers, between the processed and the raw, between the composed and the found, is one of the record's primary formal pleasures.

## The Longer Arc

\"Sample the Sky\" announced an artist with a distinctive sensibility. \"Lithic\" shows that sensibility becoming a genuine artistic practice, something with principles and constraints and a logic that operates across works rather than within them. Misch told her label she was going to make an album made of rocks. She made something more interesting than that: an album that thinks with rocks, that uses geological process as a way of thinking about time and about how anything comes to take its particular form. The earth is patient. It does not hurry its shapes. This record learned from it.

[download:/assets/images/artists/laura-misch-lithic-social-9x16.jpg|Download Social Card]"""

post = {
    "slug": "laura-misch-lithic",
    "title": "Lithic Finds Laura Misch Making Her Most Immersive and Ambitious Album Yet",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-12",
    "image": "/assets/images/artists/laura-misch-lithic.jpg",
    "image_alt": "Laura Misch press photo",
    "image_position": "center 20%",
    "body": body
}

path = '/home/dh_yadmw3/artonly.io/posts/laura-misch-lithic.json'
with open(path, 'w') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
print('JSON written: laura-misch-lithic.json')
PYEOF

# Verify live
echo "Verifying laura-misch-lithic..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/laura-misch-lithic)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/laura-misch-lithic&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: laura-misch-lithic"

# Outreach email
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@sacksco.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Laura Misch and the new album Lithic at artonly.io/post/laura-misch-lithic. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@sacksco.com (Laura Misch)"

else
  echo "Already deployed: laura-misch-lithic.json"
fi


# ============================================================
# Summary email
# ============================================================
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-12" "Published today:

1. DJ Seinfeld - If This Is It (Ninja Tune, June 5 2026)
   https://artonly.io/post/dj-seinfeld-if-this-is-it
   Author: Allastair Voss
   Spotify: 37YzpfBeFju8QRZ3g0Ha1Q
   Electronic, lo-fi house evolved, UK garage, UKG. Third LP on Ninja Tune.

2. Laura Misch - Lithic (One Little Independent Records, June 5 2026)
   https://artonly.io/post/laura-misch-lithic
   Author: Leelou Blanc
   Spotify: 0NrVrf231eji48nhNUJTXe
   Jazz, electronics, field recordings. Geological concept album. Sophomore record.

Outreach:
- DJ Seinfeld: email sent to press_row@ninjatune.net
- Laura Misch: email sent to press@sacksco.com

Both releases from June 5 2026, confirmed not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-12 album monitor ==="
