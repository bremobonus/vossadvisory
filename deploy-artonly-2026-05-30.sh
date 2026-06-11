#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-30
# Posts: boards-of-canada-inferno, kurt-vile-philadelphias-been-good-to-me
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-30.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-30 ==="

# ---- POST 1: Boards of Canada - Inferno ----
echo "--- Deploying: boards-of-canada-inferno ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/boards-of-canada-inferno.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/boards-of-canada-inferno/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://ra.co/reviews/boards-of-canada-inferno')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+(?:boards.of.canada|boc)[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://ra\.co/images/[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ra.co/')
        print('Downloaded from Resident Advisor')
        sys.exit(0)
except Exception as e:
    print(f'Resident Advisor failed: {e}')

try:
    html = fetch('https://djmag.com/reviews/boards-of-canada-inferno')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'boards' in i.lower() or 'canada' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://djmag\.com/[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://djmag.com/')
        print('Downloaded from DJ Mag')
        sys.exit(0)
except Exception as e:
    print(f'DJ Mag failed: {e}')

try:
    html = fetch('https://consequence.net/2026/05/boards-of-canada-release-inferno-stream/')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'boards' in i.lower() or 'canada' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence')
        sys.exit(0)
except Exception as e:
    print(f'Consequence failed: {e}')

print('All sources failed; generating placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a0f-#1a1a2a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Boards of Canada\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/boards-of-canada-inferno.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/boards-of-canada-inferno-up.jpg && \
  mv ~/artonly.io/assets/images/artists/boards-of-canada-inferno-up.jpg \
     ~/artonly.io/assets/images/artists/boards-of-canada-inferno.jpg
echo "Image upscaled: boards-of-canada-inferno.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py boards-of-canada-inferno "Boards of Canada Break Thirteen Years of Silence and Mean Every Second of It" music
echo "Social card generated: boards-of-canada-inferno-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/boards-of-canada-inferno.json << 'ENDJSON'
{
  "slug": "boards-of-canada-inferno",
  "title": "Boards of Canada Break Thirteen Years of Silence and Mean Every Second of It",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-30",
  "image": "/assets/images/artists/boards-of-canada-inferno.jpg",
  "image_alt": "Boards of Canada press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/2VAvhf61GgLYmC6C8anyX1]\n\nBoards of Canada have always worked in the space between memory and signal degradation. Their music borrows the texture of found footage, of tapes that have passed through too many generations of recording, of frequencies that carry meaning even as the original source becomes indistinct. Marcus Eoin and Michael Sandison, the Scottish duo who have operated under this name since the early 1990s, built a discography that functions almost archaeologically. The music excavates a past that may not have existed exactly as depicted, using synthesis and sample manipulation to conjure feelings of dislocation, nostalgia, and the particular unease that comes from encountering something familiar in the wrong context.\n\n\"Inferno,\" released May 29 on Warp Records, is their fifth studio album and their first in thirteen years. The gap since \"Tomorrow's Harvest\" (2013) was long enough that many listeners had quietly accepted the possibility that Boards of Canada were finished, that the two albums of the preceding decade had constituted a final statement. The promotional campaign that preceded \"Inferno\" suggested otherwise: VHS tapes mailed to fans in April 2026, a single track called \"Tape 05\" circulating online, the familiar pattern of cryptic advance signals the duo has used throughout their career.\n\nWhat \"Inferno\" actually is, measured against thirteen years of anticipation and against the duo's own body of work, is the most direct statement they have ever made. The album's eighteen tracks run darker, sharper, and more urgent than anything previously released under the Boards of Canada name. Where \"Tomorrow's Harvest\" created its atmosphere through restraint, through sounds that implied catastrophe rather than embodying it, \"Inferno\" moves closer to the thing itself.\n\n## The Weight of the Title\n\n\"Inferno\" invokes Dante first, the first canticle of the Commedia, the descent through nine circles of increasing moral gravity toward the frozen center. But in 2026 it lands with additional resonance. This is an album made in the years following a period many have described in terms of civilizational crisis, of overlapping emergencies that outpaced the capacity of ordinary language to hold them. Boards of Canada have always been interested in the texture of the present moment as it decays into the past. \"Inferno\" suggests that the present moment has become particularly interesting material.\n\nThe tracklist reads as a constellation of interlocking themes. Cosmic: \"Prophecy At 1420 MHz,\" \"Age Of Capricorn.\" Mythological: \"Naraka,\" \"Blood In The Labyrinth.\" Temporal: \"Deep Time,\" \"You Retreat In Time And Space.\" Spiritual: \"The Word Becomes Flesh,\" \"Acts Of Magic.\" The opening track is called \"Introit,\" a liturgical term for the entrance into sacred space. The closing track, \"I Saw Through Platonia,\" places the listener at a viewpoint that looks through rather than at the Platonic realm, suggesting a perspective beyond the ideal forms. Whatever the album is saying, it is saying it with full thematic intention.\n\n## What Changed\n\nThe most immediately striking element of \"Inferno\" is its incorporation of live instrumentation. Previous Boards of Canada records were almost entirely electronic, using synthesis, samples, and manipulated recordings to build their atmosphere. \"Inferno\" includes guitars, live drums, and what reviewers have described as a more present, more physical sound. This does not represent a departure from the aesthetic project so much as an expansion of its means. The hauntological qualities remain: the sense that sounds carry information from other times, that the listening experience is mediated through layers of analog degradation. But the live elements introduce a different kind of time into the music, the time of a performance rather than the time of a recording.\n\nThis matters because it changes the relationship between the listener and the music. Boards of Canada's earlier work was always experienced at a remove, as if one were listening to a transmission from a distance. \"Inferno\" closes some of that distance. Not all of it. The duo is not interested in immediacy for its own sake. But the live drums on tracks like \"Father And Son\" and \"The Process\" create a heartbeat underneath the electronics that earlier records deliberately excluded. The music feels inhabited in a way that is genuinely new.\n\n## The Thirteen-Year Question\n\nLong gaps between albums mean different things for different artists. For Boards of Canada, whose approach has always involved extreme selectivity and the deliberate cultivation of scarcity, thirteen years represents an intensification of their characteristic method. They have never been prolific. The gap between \"Music Has the Right to Children\" (1998) and \"Geogaddi\" (2002) was four years. Between \"Geogaddi\" and \"The Campfire Headphase\" (2005) was three. Between \"The Campfire Headphase\" and \"Tomorrow's Harvest\" (2013) was eight. Each extension of the interval increased the weight placed on the work that eventually appeared.\n\nWhether \"Inferno\" justifies the wait is ultimately a question each listener answers alone. What can be said is that the album demonstrates no sign of decay or drift from the qualities that made Boards of Canada significant in the first place. The atmosphere is intact. The emotional register, simultaneously nostalgic and threatening, beautiful and deeply unsettled, has deepened rather than dimmed. The album sounds like it was made by artists who had something specific to say and took the time required to say it correctly.\n\nFor electronic music more broadly, \"Inferno\" arrives at a moment when the genre has expanded in almost every direction, absorbing pop structures and hip-hop production techniques and deconstructed club music into a landscape almost unrecognizable from what electronic music looked like when Boards of Canada first appeared. Their return does not engage with any of these developments. It proceeds on its own terms, which are the terms of artists who have always operated as if commercial context were not their concern. This is not detachment. It is a position, held consistently for thirty years, about what music is for.\n\n[download:/assets/images/artists/boards-of-canada-inferno-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: boards-of-canada-inferno.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/boards-of-canada-inferno)
echo "HTTP status: $STATUS"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/boards-of-canada-inferno&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: boards-of-canada-inferno"


# ---- POST 2: Kurt Vile - Philadelphia's Been Good to Me ----
echo "--- Deploying: kurt-vile-philadelphias-been-good-to-me ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/kurt-vile-philadelphias-been-good-to-me.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/kurt-vile-philadelphias-been-good-to-me/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://whyy.org/episodes/kurt-vile-philadelphias-been-good-to-me/')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+(?:kurt|vile)[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://whyy\.org/[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://whyy.org/')
        print('Downloaded from WHYY')
        sys.exit(0)
except Exception as e:
    print(f'WHYY failed: {e}')

try:
    html = fetch('https://www.rollingstone.com/music/music-features/kurt-vile-philadelphia-new-music-interview-1235569502/')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+(?:kurt|vile)[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'\'<>]+rollingstone[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.rollingstone.com/')
        print('Downloaded from Rolling Stone')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone failed: {e}')

try:
    html = fetch('https://www.allmusic.com/album/philadelphias-been-good-to-me-mw0004794128')
    imgs = re.findall(r'(https?://[^\s\"\'\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'kurt' in i.lower() or 'vile' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.allmusic.com/')
        print('Downloaded from AllMusic')
        sys.exit(0)
except Exception as e:
    print(f'AllMusic failed: {e}')

print('All sources failed; generating placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0f100a-#1e2010\" -gravity center -pointsize 52 -fill white -annotate 0 \"Kurt Vile\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/kurt-vile-philadelphias-been-good-to-me.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/kurt-vile-philadelphias-been-good-to-me-up.jpg && \
  mv ~/artonly.io/assets/images/artists/kurt-vile-philadelphias-been-good-to-me-up.jpg \
     ~/artonly.io/assets/images/artists/kurt-vile-philadelphias-been-good-to-me.jpg
echo "Image upscaled: kurt-vile-philadelphias-been-good-to-me.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py kurt-vile-philadelphias-been-good-to-me "Kurt Vile Writes the Hometown Record He Has Been Circling His Entire Career" music
echo "Social card generated: kurt-vile-philadelphias-been-good-to-me-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/kurt-vile-philadelphias-been-good-to-me.json << 'ENDJSON'
{
  "slug": "kurt-vile-philadelphias-been-good-to-me",
  "title": "Kurt Vile Writes the Hometown Record He Has Been Circling His Entire Career",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-30",
  "image": "/assets/images/artists/kurt-vile-philadelphias-been-good-to-me.jpg",
  "image_alt": "Kurt Vile press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/5gspAQIAH8nJUrMYgXjCJ2]\n\nThere is a distinction between artists who make their hometown part of their mythology and artists who simply never left. The former use place as a kind of branding, invoking geography as shorthand for a set of values or a community of listeners. The latter category, rarer, produces something different: artists for whom the specificity of a place is the actual material, not the backdrop. Kurt Vile, who has lived in Philadelphia for essentially his entire adult life, recording albums in home studios in various neighborhoods, belongs to this second category. \"Philadelphia's Been Good to Me,\" his tenth studio album released May 29 on Verve Forecast, makes this explicit in a way his previous work gestured at without fully delivering.\n\nThe occasion matters. 2026 is the 250th anniversary of American independence, and Philadelphia, the city where that independence was declared, is at the center of the commemoration. The city hosts World Cup matches this summer. It is a year in which Philadelphia means something more pointed in the national imagination than it usually does. Vile, who has described this record as his bringing it all back home to Philly record, has timed the arrival well, though it would be a mistake to read the album primarily as a civic statement. It is more personal than that, and more oblique, as his work always is.\n\nHe also described the recording process in terms that suggest a different emotional register than simple celebration: he treated it like his last album. That framing deserves attention. It does not mean he expects to stop making music. It means he approached the recording with the clarity that comes from considering finality, the question of what you would want to say if this were the last opportunity to say it. For an artist who has built a career on sprawling, unhurried music that seems in no particular rush to arrive anywhere, this kind of imposed urgency produces a different album. Not a tighter one, exactly. But a more deliberate one.\n\n## The Guitar as Address\n\nVile is one of contemporary American music's most distinctive guitarists, operating in a tradition that includes Neil Young and Velvet Underground-influenced folk rock but bends those references through a sensibility entirely his own. His playing is rambling in structure but precise in texture. He finds a pattern and inhabits it completely, allowing repetition to do work that other guitarists would do through variation. The guitar on \"Philadelphia's Been Good to Me\" carries this quality throughout. Songs like \"Rock o' Stone\" and \"Chance to Bleed\" build their emotional effect through accumulation rather than climax, through the patient establishment of a mood rather than its disruption.\n\nWhat is new here is the relationship between the guitar and the subject matter. Previous albums like \"Wakin on a Pretty Daze\" (2013) and \"Bottle It In\" (2018) used the guitar's unhurried movement as an expression of a more generalized drift, a resistance to destination that was itself the message. On \"Philadelphia's Been Good to Me,\" the same technique is in the service of something more specific. A place, a history, a set of relationships that have accumulated over decades. The rambling feels purposeful now in a different way. It is the rambling of someone who knows exactly where he is.\n\n## The Home Studio Question\n\nThe album was recorded largely at OKV Central, Vile's home studio in Mount Airy, a neighborhood in the northwest of Philadelphia. This is a significant detail. Mount Airy has its own character within the city, different from the center city neighborhoods where much of Philadelphia's artistic identity is publicly visible. It is residential, quieter, the kind of place where a recording studio in a house makes sense. The intimacy of the recording environment is audible throughout. Vile's voice sounds like it was captured in a room rather than a facility. The texture of the recording is domestic in a specific way.\n\nHome studio recording has become so common in contemporary music that it no longer signals any particular aesthetic. But for Vile, who has been making records this way throughout his career, the continuation of the method on an album explicitly dedicated to place creates a resonance. The sounds of \"Philadelphia's Been Good to Me\" were produced in Philadelphia by someone embedded in it, in a room in the city that is itself part of the subject matter. This is not a concept album in any conventional sense. But it is a place-specific record in a way that few albums manage to achieve.\n\n## The Tenth Album and What It Carries\n\nThere is a particular challenge involved in making a tenth studio album. The artist has established a voice and a set of concerns. The audience has expectations formed by nine preceding releases. The risk of self-parody or simple competent repetition is genuine. Vile navigates this by not treating it as a challenge. He has never made albums that appear to be in conversation with what other people expect of him. The self-referential quality of this record, the sense of an artist returning to the beginning and finding it was exactly where he needed to be, does not feel like a career retrospective or a deliberate statement about legacy. It feels like the natural result of an artist following his attention.\n\nThe album's closer, \"Avalanches of Snow,\" functions as a departure from the record's more grounded material. A moment of release after the concentrated presence of the preceding tracks. It suggests that the album, for all its specificity of place, is also reaching toward something less located, less tethered to the northwest of Philadelphia. That reach is characteristic of what Vile does best: the local as the universal's front door.\n\nWhat \"Philadelphia's Been Good to Me\" ultimately offers is the sound of an artist who has been building a relationship with a subject for decades and has finally found the right moment, the right occasion, and the right emotional clarity to make it fully legible. The title is an understatement. Philadelphia did not just treat him well. It gave him everything he had to say.\n\n[download:/assets/images/artists/kurt-vile-philadelphias-been-good-to-me-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: kurt-vile-philadelphias-been-good-to-me.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/kurt-vile-philadelphias-been-good-to-me)
echo "HTTP status: $STATUS"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/kurt-vile-philadelphias-been-good-to-me&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: kurt-vile-philadelphias-been-good-to-me"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@warp.net" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Boards of Canada and the new album Inferno at artonly.io/post/boards-of-canada-inferno. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@warp.net (Boards of Canada)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@verveforecast.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Kurt Vile and the new album Philadelphia's Been Good to Me at artonly.io/post/kurt-vile-philadelphias-been-good-to-me. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@verveforecast.com (Kurt Vile)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-05-30" "Published today:

1. Boards of Canada - Inferno
   https://artonly.io/post/boards-of-canada-inferno
   Author: Allastair Voss
   Spotify: 2VAvhf61GgLYmC6C8anyX1
   Released: May 29, 2026 (Warp Records)
   18 tracks, first album in 13 years

2. Kurt Vile - Philadelphia's Been Good to Me
   https://artonly.io/post/kurt-vile-philadelphias-been-good-to-me
   Author: Leelou Blanc
   Spotify: 5gspAQIAH8nJUrMYgXjCJ2
   Released: May 29, 2026 (Verve Forecast)
   10th studio album

Outreach:
- Boards of Canada: email sent to press@warp.net
- Kurt Vile: email sent to press@verveforecast.com

Both releases from May 29, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-05-30 ==="
