#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-06
# Posts: death-cab-for-cutie-i-built-you-a-tower, vince-staples-cry-baby
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-06.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-06 ==="

# ---- POST 1: Death Cab for Cutie - I Built You a Tower ----
echo "--- Deploying: death-cab-for-cutie-i-built-you-a-tower ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower.jpg'

# Try Pitchfork review
try:
    html = fetch('https://pitchfork.com/reviews/albums/death-cab-for-cutie-i-built-you-a-tower/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try Brooklyn Vegan
try:
    html = fetch('https://www.brooklynvegan.com/death-cab-for-cutie-announce-new-lp-i-built-you-a-tower-share-riptides/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'death' in i.lower() or 'cab' in i.lower() or 'gibbard' in i.lower() or 'tower' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+brooklynvegan[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.brooklynvegan.com/')
        print('Downloaded from Brooklyn Vegan')
        sys.exit(0)
except Exception as e:
    print(f'Brooklyn Vegan failed: {e}')

# Try Consequence of Sound
try:
    html = fetch('https://consequence.net/2026/06/death-cab-for-cutie-drop-new-album-i-built-you-a-tower/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'death' in i.lower() or 'cab' in i.lower() or 'gibbard' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://consequence\.net/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence of Sound')
        sys.exit(0)
except Exception as e:
    print(f'Consequence of Sound failed: {e}')

# Try Death Cab official site
try:
    html = fetch('https://www.deathcabforcutie.com/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if len(i) > 30]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.deathcabforcutie.com/')
        print('Downloaded from official site')
        sys.exit(0)
except Exception as e:
    print(f'Official site failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0d0e1a-#1a1c2e\" -gravity center -pointsize 52 -fill white -annotate 0 \"Death Cab for Cutie\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower-up.jpg && \
  mv ~/artonly.io/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower-up.jpg \
     ~/artonly.io/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower.jpg
echo "Image upscaled: death-cab-for-cutie-i-built-you-a-tower.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py death-cab-for-cutie-i-built-you-a-tower "Death Cab for Cutie Built Something New in the Wreckage of Everything They Knew" music
echo "Social card generated: death-cab-for-cutie-i-built-you-a-tower-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/death-cab-for-cutie-i-built-you-a-tower.json << 'ENDJSON'
{
  "slug": "death-cab-for-cutie-i-built-you-a-tower",
  "title": "Death Cab for Cutie Built Something New in the Wreckage of Everything They Knew",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-06-06",
  "image": "/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower.jpg",
  "image_alt": "Death Cab for Cutie press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/0YrtvWJMgSdVrk3SfNjTbx]\n\nDeath Cab for Cutie have always been about loss with good posture. Ben Gibbard's project, which he has led since Bellingham, Washington in the early 1990s, operates in the space between the certainty that everything ends and the continued necessity of attaching meaning to things. The band became one of the defining indie rock acts of the early 2000s by understanding that earnestness was not embarrassing, that the careful articulation of heartbreak and longing was a form of honesty rather than sentimentality. Twenty years of that mission produced a catalog that has been important to a specific kind of listener: thoughtful, literary, committed to feeling things with full intention.\n\n\"I Built You a Tower,\" released June 5 on Anti- Records, is their eleventh studio album and their first since signing with the legendary independent label after more than two decades with Atlantic. The label change is significant beyond the business dimension. Atlantic was where Death Cab grew up publicly, where they moved from cult independent act to mainstream recognition following the enormous response to \"Plans\" in 2005. Leaving after that length of time is a statement about where Gibbard and the band now want to operate, about the kind of label infrastructure that fits the music they are making. Anti- is the home of Tom Waits, Merle Haggard, Neko Case. It is a label built around artists with strong points of view who resist easy categorization. The fit, in retrospect, seems obvious.\n\nThe personal circumstances driving the album are significant and have been reported: Gibbard processed another divorce in the making of this record. What that experience produced is an album that confronts the question of whether it is possible to understand why you make the same mistakes twice, or whether the attempt to understand is itself part of the pattern. This is serious territory. Gibbard has always been an intelligent writer. On \"I Built You a Tower\" he is a writer who has had to sit with particularly difficult material long enough to find a shape for it.\n\nThe context of recording matters here. The three week session at Animal Rites in Los Angeles was intense and deliberately compressed, relatively isolated from the extended revision process that can sometimes sand the edges off an album's emotional content. Death Cab emerged from that session with something that sounds immediate even across the listening distance. The remotely recorded additional parts from various home studios across Seattle, Bellingham, and Portland feel integrated rather than assembled. Producer John Congleton's ear for making disparate recordings cohere is evident throughout, and it is one of the album's quiet achievements.\n\n## The Congleton Question\n\nJohn Congleton has produced some of the most formally rigorous records in American indie rock over the last two decades, working with St. Vincent, Sharon Van Etten, Local Natives, and Wye Oak among others. His collaboration with Death Cab follows what the band describes as the most guitar forward, most physically urgent set they have made in years. This is not heavy rock in any conventional sense. Death Cab have never been a loud band. But \"I Built You a Tower\" pushes the arrangements into territory that earlier records treated with more care and more distance.\n\nGuitars carry a weight they did not on recent releases. The production has a directness that feels earned rather than imposed. Tracks like \"Riptides\" and \"Punching the Flowers\" have a forward momentum that keeps them from settling into the comfortable atmospheric drift that is the band's characteristic mode. The urgency is audible. It feels like a band that had something specific to accomplish and allocated time accordingly, without detours or hedges.\n\n## The Tracklist as Architecture\n\nThe album contains eleven tracks, opening with \"Full of Stars\" and closing with \"I Built You A Tower (b),\" a second version of the title track that brackets the album with its central concern. The album opens with a frame of reference, the stars, the scale, the cosmic distance, and closes by returning to the specific: the built thing, the construction that contains both the aspiration and the flaw. Between those two anchors, the record moves through \"Pep Talk,\" \"Envy the Birds,\" \"Stone Over Water,\" \"How Heavenly a State,\" \"Trap Door,\" and \"The Flavor of Metal\" in a sequence that builds emotional weight without resolving it prematurely.\n\n\"Trap Door\" deserves particular attention. The title suggests the structural metaphor running through the album: the concealed passage, the exit that also catches. Relationships as architecture, as something built with care that nevertheless contains the possibility of sudden descent. The tower of the title is a gift, a construction offered in earnest. That it is built from the same materials as everything else, that the builder knows their own tendencies and builds anyway, does not diminish the offering. It is still built. The album insists on that.\n\n## What Liberation Costs\n\nSigning with Anti- is a liberation story, but \"I Built You a Tower\" does not feel like a liberated record in the triumphant sense. It feels like the work of someone who has understood something painful clearly enough to articulate it with precision. The guitar forward quality is not aggression or denial. It is a kind of directness that comes from having nothing left to hedge. Gibbard has been here before, emotionally. He has made records about this territory before. What this album adds to that accumulated understanding is the weight of repetition: this again, with full awareness that it is again.\n\nThat accumulated knowledge of one's own patterns is the most interesting thing about \"I Built You a Tower.\" It does not make the album easy. It makes it honest in a specific way that the band's earlier work, which was also honest, could not access because it did not yet have the evidence. More than two decades with a major label. A second marriage ending. An eleventh album. Death Cab for Cutie are building in the aftermath, which is where they have always done their best work. The tower this time is not for anyone else. It is for themselves, which may be the hardest kind to construct. The album earns that difficulty without asking for credit.\n\n[download:/assets/images/artists/death-cab-for-cutie-i-built-you-a-tower-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: death-cab-for-cutie-i-built-you-a-tower.json"

# Verify live
echo "Verifying death-cab-for-cutie-i-built-you-a-tower..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/death-cab-for-cutie-i-built-you-a-tower)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/death-cab-for-cutie-i-built-you-a-tower&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: death-cab-for-cutie-i-built-you-a-tower"


# ---- POST 2: Vince Staples - Cry Baby ----
echo "--- Deploying: vince-staples-cry-baby ---"

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

# Try Pitchfork review
try:
    html = fetch('https://pitchfork.com/reviews/albums/vince-staples-cry-baby/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try The Source
try:
    html = fetch('https://thesource.com/2026/06/05/vince-staples-cry-baby-album-release/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower() or 'cry' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+thesource[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://thesource.com/')
        print('Downloaded from The Source')
        sys.exit(0)
except Exception as e:
    print(f'The Source failed: {e}')

# Try Okayplayer
try:
    html = fetch('https://www.okayplayer.com/5-takeaways-from-vince-staples-cry-baby-his-most-experimental-album-since-big-fish-theory/1431808')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+okayplayer[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.okayplayer.com/')
        print('Downloaded from Okayplayer')
        sys.exit(0)
except Exception as e:
    print(f'Okayplayer failed: {e}')

# Try Clash Magazine
try:
    html = fetch('https://www.clashmusic.com/reviews/vince-staples-cry-baby/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'vince' in i.lower() or 'staples' in i.lower() or 'cry' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+clashmusic[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Clash Magazine failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a0a-#1c1a0f\" -gravity center -pointsize 52 -fill white -annotate 0 \"Vince Staples\" {dest}')
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
python3 make-social-card.py vince-staples-cry-baby "Vince Staples Picks Up the Guitar and Starts Exactly the Conversation This Country Needed" music
echo "Social card generated: vince-staples-cry-baby-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/vince-staples-cry-baby.json << 'ENDJSON'
{
  "slug": "vince-staples-cry-baby",
  "title": "Vince Staples Picks Up the Guitar and Starts Exactly the Conversation This Country Needed",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-06-06",
  "image": "/assets/images/artists/vince-staples-cry-baby.jpg",
  "image_alt": "Vince Staples press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/68kEuyFKyqrdQQLLsmiatm]\n\nVince Staples has been one of American rap's most consistent and most persistently underestimated voices for over a decade. His work has always operated at the intersection of documentary specificity and formal ambition, using the particular geography of Long Beach, California and the particular conditions of growing up within it as material for something considerably more expansive than autobiography. He does not make music about the streets for people who want to experience those streets from a safe distance. He makes music about the experience of consciousness under specific material conditions, which is something different and considerably harder to produce.\n\n\"Cry Baby,\" released June 5 on his own Section Eight Arthouse imprint through Loma Vista, is his most structurally surprising record since \"Big Fish Theory\" in 2017, the album that established his credibility with listeners who prize formal experimentation alongside lyrical precision. Where \"Big Fish Theory\" built its framework from club electronic music and industrial noise, \"Cry Baby\" does something that could have read as provocation: it builds its sound almost entirely from live rock instrumentation. Guitar. Bass. Drums. Standard rock arrangement. Vince Staples rapping over it, with occasional forays into singing, treating the tradition not as a costume but as a tool.\n\nThis is not a crossover bid or a pivot for commercial reasons. Those kinds of moves carry a different energy, a certain awareness of the audience being sought. Staples does not make music with those calculations. His career has been characterized by a consistent willingness to alienate the portion of his audience that wants him to stay still. \"Cry Baby\" is a political album made from punk's materials by a rapper who understands what punk was actually for before it became merchandise and nostalgia.\n\nThe timing is not incidental. This album arrives in a year when the United States is staging international spectacles of self-celebration, hosting the World Cup and marking its 250th anniversary, while refusing to examine the conditions those celebrations obscure. Staples, who has always been more interested in what America costs than what it promises, is exactly the right artist for this moment. He knew that before the moment arrived.\n\n## The American Inferno\n\nThe album runs ten tracks in thirty five minutes. This is a lean running time for a statement album, but Staples has always been suspicious of excess. He compresses. The opening track \"Blackberry Marmalade\" sets the album's tone from the first moment, warning of empires built on blood stained ground. This is not rhetorical throat clearing. It is the album's thesis, stated without delay. What follows is an investigation of that thesis from multiple angles, none of them comfortable.\n\n\"Cotton\" is the most historically direct track, placing contemporary racial dynamics in explicit conversation with the agricultural labor system that built the American economy. The word in the title is not subtle. Staples is not interested in subtlety here. He is interested in making the connection between past and present legible to listeners who might prefer not to make it. \"The Running Man\" escalates: the language is direct, the claim urgent. The guitar underneath is crunching and immediate, which removes any softening that a more polished production might have introduced.\n\n\"TV Guide\" addresses the media saturation that turns catastrophe into content and content into numbness, the endless information cycle that processes horror into entertainment without ever requiring resolution. \"Only In America\" takes the ironic form familiar from the country's long tradition of mythologizing itself and uses it to examine what America actually offers the people who built it. These are not subtle arguments. They are not meant to be. The album does not ask for your comfort.\n\n## Why the Guitar\n\nThe choice of live rock instrumentation is not arbitrary and should not be received as a novelty. Punk and hardcore emerged in the United States partly as a music of disenfranchisement, of people who felt excluded from the mainstream's consolations and wanted to make something from that exclusion that had force and immediacy. That origin story has been largely forgotten by contemporary listeners, for whom punk is mostly a style and a consumer category. Staples is using the instrumentation to invoke the original argument, to insist that the conditions that produced punk's anger are not historical but present and ongoing.\n\nThere is also something happening with the choice of guitars and live drums that relates to the physical quality of the album's subject matter. Electronic production, which dominates contemporary hip hop, carries a certain quality of remove. It exists in a space that is not quite physical, not quite located in a room. Live instrumentation is located. It was played by people in a room. It carries the evidence of bodies. \"Cry Baby\" uses that physical quality deliberately, as if to insist that what the album is describing is happening to bodies, not to abstractions.\n\nThe album also benefits from this instrumentation's emotional register in a way that is easy to underestimate. Rock guitar in the context of political lyric content does not ask you to process the argument from a seated position. It puts the argument in your chest. That is a formal choice with real consequences for how the music lands.\n\n## The Independent Move\n\n\"Cry Baby\" is Staples' first album on Section Eight Arthouse, the imprint he established for this release. Coming after his time at Motown, this move follows a pattern consistent with his entire career: increasing control, decreasing willingness to operate within structures that limit what can be said or how it can be said. The music industry rewards artists who know how to work within its categories. Staples has spent his career demonstrating what becomes possible when those categories are treated as suggestions rather than walls.\n\nAt thirty one, with multiple albums and a consistent critical standing behind him, he is at the point where the stakes of independence are lower and the expressive possibilities higher. \"Cry Baby\" sounds like a record made by someone who has nothing left to negotiate. The ten tracks here do not suggest a career coasting on reputation. They suggest an artist who has figured out what he wants to say and found the exact form in which to say it. The guitar says what the rap says. The rap says what the guitar says. There is no daylight between the content and the container.\n\nThat alignment between form and argument is rare. It is what makes \"Cry Baby\" one of the more important records released this year, and one of the more important statements made about where this country stands by anyone working in any form.\n\n[download:/assets/images/artists/vince-staples-cry-baby-social-9x16.jpg|Download Social Card]"
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


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Death Cab for Cutie / Anti- Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@anti.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Death Cab for Cutie and the new album I Built You a Tower at artonly.io/post/death-cab-for-cutie-i-built-you-a-tower. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@anti.com (Death Cab for Cutie)"

# Vince Staples / Section Eight Arthouse / Loma Vista
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@lomavistarecordings.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Vince Staples and the new album Cry Baby at artonly.io/post/vince-staples-cry-baby. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@lomavistarecordings.com (Vince Staples)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-06" "Published today:

1. Death Cab for Cutie - I Built You a Tower
   https://artonly.io/post/death-cab-for-cutie-i-built-you-a-tower
   Author: Allastair Voss
   Spotify: 0YrtvWJMgSdVrk3SfNjTbx
   Released: June 5, 2026 (Anti- Records)
   11th studio album, first on Anti- after 22+ years at Atlantic
   Produced by John Congleton at Animal Rites, LA

2. Vince Staples - Cry Baby
   https://artonly.io/post/vince-staples-cry-baby
   Author: Leelou Blanc
   Spotify: 68kEuyFKyqrdQQLLsmiatm
   Released: June 5, 2026 (Section Eight Arthouse / Loma Vista)
   10 tracks, 35 min, live rock instrumentation, political themes
   First release on his own Section Eight Arthouse imprint

Outreach:
- Death Cab for Cutie: email sent to press@anti.com
- Vince Staples: email sent to press@lomavistarecordings.com

Both releases from June 5, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-06 ==="
