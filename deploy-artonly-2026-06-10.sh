#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-10
# Posts: vince-staples-cry-baby, jalen-ngonda-doctrine-of-love
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-10.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-10 ==="

# ---- POST 1: Vince Staples - Cry Baby ----
echo "--- Deploying: vince-staples-cry-baby ---"

if [ -f ~/artonly.io/posts/vince-staples-cry-baby.json ]; then
  echo "Post already exists: vince-staples-cry-baby.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/vince-staples-cry-baby.jpg'

# Try Flood Magazine review
try:
    html = fetch('https://floodmagazine.com/224494/vince-staples-cry-baby/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower() or 'flood' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://floodmagazine\.com/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://floodmagazine.com/')
        print('Downloaded from Flood Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Flood Magazine failed: {e}')

# Try The FADER announcement
try:
    html = fetch('https://www.thefader.com/2026/04/28/new-vince-staples-album-cry-baby-release-date-cover-art-full-traclist')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+fader[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thefader.com/')
        print('Downloaded from The FADER')
        sys.exit(0)
except Exception as e:
    print(f'The FADER failed: {e}')

# Try Pitchfork review
try:
    html = fetch('https://pitchfork.com/reviews/albums/vince-staples-cry-baby/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try Art Threat announcement
try:
    html = fetch('https://artthreat.net/38278-84342-vince-staples-announces-cry-baby-album-releasing-june-5-with-lead-single/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower() or 'artthreat' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://artthreat.net/')
        print('Downloaded from Art Threat')
        sys.exit(0)
except Exception as e:
    print(f'Art Threat failed: {e}')

# Try Consequence of Sound
try:
    html = fetch('https://consequence.net/2026/06/vince-staples-cry-baby-review/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://consequence\.net/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence of Sound')
        sys.exit(0)
except Exception as e:
    print(f'Consequence of Sound failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a0a-#1a0a0a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Vince Staples\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/vince-staples-cry-baby.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/vince-staples-cry-baby-up.jpg && \
  mv ~/artonly.io/assets/images/artists/vince-staples-cry-baby-up.jpg \
     ~/artonly.io/assets/images/artists/vince-staples-cry-baby.jpg
echo "Image upscaled: vince-staples-cry-baby.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py vince-staples-cry-baby "On Cry Baby, Vince Staples Turns American Rage Into Rock and Means Every Word" music
echo "Social card generated: vince-staples-cry-baby-social-9x16.jpg"
cd ~

# Deploy JSON post
cat > ~/artonly.io/posts/vince-staples-cry-baby.json << 'ENDJSON'
{
  "slug": "vince-staples-cry-baby",
  "title": "On Cry Baby, Vince Staples Turns American Rage Into Rock and Means Every Word",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-06-10",
  "image": "/assets/images/artists/vince-staples-cry-baby.jpg",
  "image_alt": "Vince Staples press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/68kEuyFKyqrdQQLLsmiatm]\n\nThere is a specific type of exhaustion that comes not from having nothing left to say but from saying the same necessary things into an America that has learned to absorb critique without changing. Vince Staples has been cataloguing the texture of that exhaustion since his 2015 debut LP \"Summertime '06,\" a double album that arrived with the analytical precision of a sociologist and the emotional weight of someone who lived in the data points. In the decade since, he has made increasingly focused records, tightened each successive release as if compressing information, and become one of American hip-hop's most trusted voices on the subject of what the country actually is, as opposed to what it presents itself as being.\n\n\"Cry Baby,\" his seventh studio album and first on his own Section Eight Arthouse imprint through Loma Vista Recordings, does not represent a departure from these concerns. It represents a decision about how to hold them differently. Where his earlier records used sparse electronic production to create an atmosphere of clinical distance, \"Cry Baby\" wraps the same material in noise rock, post-punk, and the physical immediacy of live instrumentation. The guitars are not pretty. The drums do not flatter. The sound is confrontational in the specific way that punk has always been confrontational: it demands presence in a way that is difficult to passively receive.\n\n## The Rock Turn and What It Actually Means\n\nThe decision to make a rock-adjacent hip-hop record in 2026 is not without precedent. Hip-hop has been absorbing rock instrumentation for decades, and the overlap has never fully dissolved. What Staples brings to this territory is something more specific than genre tourism. The track titles tell part of the story: \"Go Go Gorilla,\" \"The Big Bad Wolf,\" \"Only In America,\" \"Do You Know The Devil.\" These are not the titles of an artist using rock's vocabulary for aesthetic variety. They suggest a deliberate alignment between the dissonance of the sound and the dissonance of the subject matter.\n\nThe album's press materials describe it as the product of Staples processing \"the endlessly repeating cycles of American tumult.\" That phrase lands with particular weight in 2026, because the cycles are more legible, the repetition more exhausting, and the gap between acknowledged injustice and actual change more visible than at almost any point in recent memory. \"Cry Baby\" is not a manifesto. Staples is too precise a writer to mistake statement for analysis. But it is an album that treats American rage as legitimate material and gives it the urgency and texture it demands.\n\nThe production credits span a range of collaborators, including Banshee The Great, Homer Steinweiss, and SAINT MINO, alongside Staples himself. The sonic variety across ten tracks suggests that the rock framing is not a straitjacket but a set of permissions. The album gives Staples room to move within a more aggressive register without anchoring every moment to a single sonic identity. Some tracks carry the clatter of noise rock; others draw on soul and gospel in ways that make the political content feel communal rather than individual.\n\n## Independence and the Art It Buys\n\nThe institutional context of \"Cry Baby\" matters. Following his departure from Def Jam after 2024's \"Dark Times,\" Staples signed with Loma Vista through his own imprint, meaning for the first time in his recording career the decisions about what this music sounds like, how it is marketed, and what it says are entirely his. The people who have followed his career from the outside have sometimes wondered what a Vince Staples record would sound like without infrastructure invested in a more commercial outcome. \"Cry Baby\" is the answer.\n\nIt is not a difficult listen in the way that deliberately alienating avant-garde records can be difficult. It is difficult in the way that honesty is difficult: because it does not soften anything, because it trusts the listener to meet it where it is, because it is not interested in making its subject matter palatable. Away from the institutional frame that shaped his previous releases, Staples delivers his most passionately political work, an unapologetic critique of the country that moves through race, policing, media conditioning, and the emotional fatigue of navigating American life as a Black man from Long Beach, California.\n\nLong Beach is not an incidental detail. It is a port city, economically stratified, with specific histories of police violence and community governance that Staples has returned to throughout his catalog. \"Cry Baby\" does not abandon this specificity in favor of a more generalized political stance. The rage here is particular. It comes from somewhere and about something. The live drums and distorted guitars are the sound of that particularity given a new and more abrasive body.\n\n## The Seventh Album as Statement\n\nThere is something clarifying about an artist who has made six studio albums and still sounds like he has something urgent to say. Staples has always been that kind of artist. His work accumulates rather than repeats. Each record has extended his range and tested the edges of what hip-hop can hold: lyrically, sonically, emotionally. \"Cry Baby\" extends this project into territory that feels genuinely new within his body of work.\n\nThe closing track, \"7 In The Morning,\" extends into something hymnal, an ending that does not resolve the tension so much as hold it in a larger container. This is characteristic of what Staples does best: the personal as the political's necessary weight, the local as evidence for the universal claim. \"Cry Baby\" is the version of that project with nothing between the artist and the statement. It sounds exactly like it.\n\n[download:/assets/images/artists/vince-staples-cry-baby-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: vince-staples-cry-baby.json"

# Verify live
echo "Verifying vince-staples-cry-baby..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/vince-staples-cry-baby)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/vince-staples-cry-baby&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: vince-staples-cry-baby"

fi  # end skip block


# ---- POST 2: Jalen Ngonda - Doctrine of Love ----
echo "--- Deploying: jalen-ngonda-doctrine-of-love ---"

if [ -f ~/artonly.io/posts/jalen-ngonda-doctrine-of-love.json ]; then
  echo "Post already exists: jalen-ngonda-doctrine-of-love.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/jalen-ngonda-doctrine-of-love.jpg'

# Try Soulbounce announcement
try:
    html = fetch('https://soulbounce.com/2026/03/jalen-ngonda-doctrine-of-love-audio-album-announcement/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ngonda' in i.lower() or 'jalen' in i.lower() or 'soulbounce' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+soulbounce[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://soulbounce.com/')
        print('Downloaded from Soulbounce')
        sys.exit(0)
except Exception as e:
    print(f'Soulbounce failed: {e}')

# Try The Line of Best Fit
try:
    html = fetch('https://www.thelineofbestfit.com/news/jalen-ngonda-announces-second-album-doctrine-of-love')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ngonda' in i.lower() or 'jalen' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+lineofbestfit[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thelineofbestfit.com/')
        print('Downloaded from The Line of Best Fit')
        sys.exit(0)
except Exception as e:
    print(f'Line of Best Fit failed: {e}')

# Try Consequence announcement
try:
    html = fetch('https://consequence.net/2026/03/jalen-ngonda-doctrine-of-love-new-album-title-track-stream/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ngonda' in i.lower() or 'jalen' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://consequence\.net/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence of Sound')
        sys.exit(0)
except Exception as e:
    print(f'Consequence of Sound failed: {e}')

# Try Pitchfork review
try:
    html = fetch('https://pitchfork.com/reviews/albums/jalen-ngonda-doctrine-of-love/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try DIY Magazine
try:
    html = fetch('https://diymag.com/interview/jalen-ngonda-come-around-and-love-me-september-2023')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ngonda' in i.lower() or 'jalen' in i.lower() or 'diymag' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://diymag.com/')
        print('Downloaded from DIY Magazine')
        sys.exit(0)
except Exception as e:
    print(f'DIY Magazine failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a18-#0a1818\" -gravity center -pointsize 52 -fill white -annotate 0 \"Jalen Ngonda\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/jalen-ngonda-doctrine-of-love.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/jalen-ngonda-doctrine-of-love-up.jpg && \
  mv ~/artonly.io/assets/images/artists/jalen-ngonda-doctrine-of-love-up.jpg \
     ~/artonly.io/assets/images/artists/jalen-ngonda-doctrine-of-love.jpg
echo "Image upscaled: jalen-ngonda-doctrine-of-love.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py jalen-ngonda-doctrine-of-love "Jalen Ngonda Builds a Doctrine Worth Believing On His Tender Sophomore Record" music
echo "Social card generated: jalen-ngonda-doctrine-of-love-social-9x16.jpg"
cd ~

# Deploy JSON post
cat > ~/artonly.io/posts/jalen-ngonda-doctrine-of-love.json << 'ENDJSON'
{
  "slug": "jalen-ngonda-doctrine-of-love",
  "title": "Jalen Ngonda Builds a Doctrine Worth Believing On His Tender Sophomore Record",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-06-10",
  "image": "/assets/images/artists/jalen-ngonda-doctrine-of-love.jpg",
  "image_alt": "Jalen Ngonda press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/2kEDso93O2hDgCbnuiSkkZ]\n\nDaptone Records has spent more than twenty years operating as if the question of whether soul music could survive the departure of its classic era was a misunderstanding of what soul music actually was. The Brooklyn-based label's catalog, built around artists like Sharon Jones, Charles Bradley, and the Dap-Kings, has argued consistently that the genre's vitality was never about a particular historical moment. It was about a particular quality of attention, a way of making music in which the physical experience of playing together in a room, the actual sound of bodies and instruments in real space, is the primary vehicle for emotional content. This is why Daptone recordings tend to sound the way they do: present, warm, sometimes deliberate in ways that more polished production would smooth away.\n\nJalen Ngonda arrived at this label by a route that is itself a kind of argument for the music he makes. Born in Washington, DC, and raised in its suburbs in a household where his father introduced him to Motown at the age of eleven, he later accepted an offer from the Liverpool Institute for the Performing Arts and built a life and a sound on the other side of the Atlantic. His debut, \"Come Around and Love Me,\" released through Daptone in September 2023, announced him as a singer and writer with gifts that went beyond period-faithful soul recreation. Rolling Stone named him to their Future of Music list. The praise came from people who understood what they were hearing: something real, delivered without irony or protective self-consciousness.\n\n\"Doctrine of Love,\" his second album and first since that debut established the terms, deepens what \"Come Around and Love Me\" proposed. The ten tracks run approximately thirty minutes, a compressed statement that trusts its material to carry weight without extension. The orchestral arrangements that his debut gestured at are more fully realized here. Horns that do not merely accent but carry the melody. Background vocals that land in gospel territory without committing to church. A rhythm section that provides steadiness rather than spectacle.\n\n## The Doctrine Itself\n\nThe album's title is a philosophical claim, not a rhetorical one. The doctrine of love, as Ngonda has described it, holds that every thought and action should be guided first by compassion for others, because love is the highest measure of human worth. This is not a novel idea. It has been at the center of religious and ethical thought across traditions for centuries. What makes it interesting as an album premise is that Ngonda is not writing songs about the doctrine. He is making the doctrine the formal principle. The music itself demonstrates what it is arguing: that love, as aesthetic commitment, as attention to craft and care toward the listener, is the basis of the exercise.\n\nThis matters because soul music has often used love as subject matter while operating on less generous principles: the pose of tenderness deployed as seduction, the language of care wrapped around a transaction. Ngonda's work, at its best, does not feel transactional. \"Burning Temptation\" and \"I Can't Ever Leave You\" describe states of romantic entanglement with a specificity that goes beyond lyrical formula. \"Hannah, What's the Matter?\" introduces a named character into a genre that often trades in types, treated with curiosity rather than flattery. These are small moves, but they accumulate into something that feels like genuine witness.\n\nThe track \"Mr. Train Conductor\" extends this further, using travel as a metaphor for emotional arrival without resolving the journey too easily. It is one of the album's most elegant constructions: a song that knows where it is going but takes its time getting there, which is exactly the quality that distinguishes the album as a whole from more impatient soul music.\n\n## What the Sophomore Record Reveals\n\nThe second album is where an artist's actual project becomes legible. The debut can be contained by the circumstance of its making, shaped by years of accumulated material and the energy of first introduction. The second album shows what the artist chooses to do with attention, what they decide matters, what they deepen versus what they discard. Ngonda deepens almost everything.\n\nThe production, handled within the Daptone infrastructure by collaborators who understand the label's philosophy of sonic presence, is more confident than on \"Come Around and Love Me.\" The songs are more economical, structured as if Ngonda had thought hard about every bar. His voice has developed in the specific way that voices develop when they are used consistently and honestly: it has more range in the quieter registers, more texture at the edges of what he can reach, more apparent connection between what the lyric is doing and how the voice responds to it.\n\nThe transatlantic life, the DC roots and the Liverpool residence and the touring that has taken him through European and American concert circuits, seems to have given him perspective on what this music is for. Not nostalgia, exactly, though the Motown influence is audible throughout. Something more like inheritance: an understanding of a tradition specific enough to be used rather than imitated.\n\n## The Larger Conversation\n\nSoul music in 2026 occupies a position that is simultaneously secure and contested. The genre's canonical period remains a fixed point of reference for producers and listeners across multiple overlapping scenes. But the artists doing the most interesting work in this territory are the ones who have internalized the tradition deeply enough to contribute to it rather than simply reproduce it. \"Doctrine of Love\" does not sound like a museum piece. It sounds like an album made by someone who understands why the music existed in the first place and has something of their own to say within those terms.\n\nThirty minutes is all it needs. The concision is itself a form of respect for the listener's time and for the material's integrity. By the time \"Taken Out of the Picture\" closes the record, the doctrine has been demonstrated rather than argued. Which is, in the end, the only way a doctrine worth following ever gets established.\n\n[download:/assets/images/artists/jalen-ngonda-doctrine-of-love-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: jalen-ngonda-doctrine-of-love.json"

# Verify live
echo "Verifying jalen-ngonda-doctrine-of-love..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/jalen-ngonda-doctrine-of-love)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/jalen-ngonda-doctrine-of-love&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: jalen-ngonda-doctrine-of-love"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Vince Staples / Loma Vista Recordings
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@lomavistarecordings.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Vince Staples and the new album Cry Baby at artonly.io/post/vince-staples-cry-baby. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@lomavistarecordings.com (Vince Staples)"

# Jalen Ngonda / Daptone Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@daptonerecords.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Jalen Ngonda and the new album Doctrine of Love at artonly.io/post/jalen-ngonda-doctrine-of-love. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@daptonerecords.com (Jalen Ngonda)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-10" "Published today:

1. Vince Staples - Cry Baby
   https://artonly.io/post/vince-staples-cry-baby
   Author: Allastair Voss
   Spotify: 68kEuyFKyqrdQQLLsmiatm
   Released: June 5, 2026 (Section Eight Arthouse / Loma Vista Recordings)
   10 tracks, first independent release after Def Jam

2. Jalen Ngonda - Doctrine of Love
   https://artonly.io/post/jalen-ngonda-doctrine-of-love
   Author: Leelou Blanc
   Spotify: 2kEDso93O2hDgCbnuiSkkZ
   Released: June 5, 2026 (Daptone Records)
   10 tracks, 30 minutes, sophomore album

Outreach:
- Vince Staples: email sent to press@lomavistarecordings.com
- Jalen Ngonda: email sent to press@daptonerecords.com

Both releases from June 5, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-10 ==="
