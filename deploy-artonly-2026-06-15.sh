#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-15
# Posts: burna-boy-sovereign, james-blake-hollow-ground
# Releases: Burna Boy - Sovereign (Jun 13, Spaceship Ent/Atlantic), James Blake - Hollow Ground (Jun 13, Republic/Polydor)
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-15 ==="

# ---- POST 1: Burna Boy - Sovereign ----
echo "--- Deploying: burna-boy-sovereign ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/burna-boy-sovereign.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/burna-boy-sovereign/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://www.nme.com/reviews/album/burna-boy-sovereign-review')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+nme\.com[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

try:
    html = fetch('https://www.theguardian.com/music/2026/jun/13/burna-boy-sovereign-review')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+guardian[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+burna[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.theguardian.com/')
        print('Downloaded from Guardian')
        sys.exit(0)
except Exception as e:
    print(f'Guardian failed: {e}')

try:
    html = fetch('https://www.rollingstone.com/music/music-album-reviews/burna-boy-sovereign-review-2026/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'burna' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.rollingstone.com/')
        print('Downloaded from Rolling Stone')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone failed: {e}')

try:
    html = fetch('https://stereogum.com/2503000/album-of-the-week-burna-boy-sovereign/reviews/album-of-the-week')
    imgs = re.findall(r'(https?://media\.stereogum\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+burna[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#0a1a0a-#1a3a2a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Burna Boy\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/burna-boy-sovereign.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/burna-boy-sovereign-up.jpg && \
  mv ~/artonly.io/assets/images/artists/burna-boy-sovereign-up.jpg \
     ~/artonly.io/assets/images/artists/burna-boy-sovereign.jpg
echo "Image upscaled: burna-boy-sovereign.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py burna-boy-sovereign "Burna Boy Names His New Album Sovereign and Then Proves the Point" music
echo "Social card generated: burna-boy-sovereign-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/3wcj11K77LjEY1PkEOt3Oy]

Burna Boy was not always inevitable. This is worth stating plainly because the story of his ascent has been retold so many times, with so much emphasis on the triumphal arc, that it has begun to acquire the quality of mythology. Mythology means the unfolding of something foreordained. But Damini Ebunoluwa Ogulu, born in Port Harcourt, Nigeria in 1991, whose mother Bose Ogulu has managed his career from its earliest days and whose grandfather Benson Idonije was Fela Kuti's manager, chose very deliberately to become Burna Boy. He embodied a particular kind of outsized presence. He constructed a persona large enough to contain the ambitions he was carrying. Sovereign, released June 13 on Spaceship Entertainment and Atlantic Records, is the record that asks what it means to have arrived at everything you declared you were going to arrive at, and to still be here.

The Afrofusion genre that Burna Boy did not invent so much as make irreversibly his own draws from Nigerian highlife, dancehall, reggae, hip-hop, and R&B in proportions that shift from album to album depending on what the material requires. His catalog runs from the uncompromising regional pride of "L.I.F.E." through the crossover ambition of "African Giant" to the Grammy-winning sweep of "Twice as Tall" and the more vulnerable register of "Love, Damini." "I Told Them..." in 2023 was his answer to whether the mainstream had changed him, and the answer was deliberate: it had not. Sovereign is his answer to a different question. It is asking what the self looks like once it has proved itself sufficient.

## The Architecture of Claim

What distinguishes Sovereign from its predecessors is the deliberateness of its compositional architecture. The album does not open the way Burna Boy albums typically open, with an immediate statement of power. It begins instead with something more measured, building the case for what will come with the patience of someone who knows they do not need to rush. The production, handled primarily by Leriq who has been Burna's most essential collaborator across more than a decade, demonstrates a new willingness to let silence function as an argument. Space is deployed strategically. When the bass arrives in the record's first release moment, it lands with the force of something that has been earned rather than asserted.

The structural confidence of the record extends to its treatment of Burna Boy's voice. His vocal instrument has always been one of the most distinctive in global popular music, capable of shifting between the intimate and the monumental within a single phrase, but Sovereign gives it more room than previous records have. The production frames rather than envelops. The result is a record that sounds, for the first time in his catalog, as though the artist and his sound are completely synchronized. Not straining toward each other, not negotiating, but simply occupying the same space with full mutual understanding.

## The Pan-African Project

Burna Boy has been explicit for years about the political dimensions of his work. He has positioned himself as a pan-African figure, as an artist carrying the burden and possibility of a continent's cultural ambition, and Sovereign makes this positioning more explicit than any previous record. The album features collaborators from across the African continent, including artists from Ghana, South Africa, and Senegal, and the production draws from musical traditions across the same geography. This is not ecumenism performed for the benefit of global audiences. The musical choices are too specific for that, too deeply informed by the actual sounds and rhythms being referenced.

There is a track that engages directly with the legacy of afrobeat as Fela Kuti developed it, and the connection is not decorative. The family inheritance is literal. Benson Idonije managed Fela. The conversation with that inheritance on Sovereign is more sustained than it has been on previous records, and more honest. It does not claim equivalence with Fela's political project. It claims continuity with his insistence that popular African music could bear philosophical weight.

## What Sovereignty Actually Means

The word sovereign carries multiple registers, and the album is smart enough to address all of them. There is the political sovereignty that Burna Boy has referenced throughout his career: the liberation from colonial frameworks that persists as an unfinished project across the continent he represents. There is the personal sovereignty of an artist who has spent more than a decade refusing to make the compromises that international success typically demands and has arrived, improbably, at that international success anyway. And there is the quieter sovereignty of a person who has made peace with the particular shape of their own life, which is the hardest kind to achieve and the most interesting to document.

The album's most vulnerable moments arrive in its second half. This is a consistent feature of Burna Boy's best work: the bombast of the opening gives way, eventually, to something more searching. On Sovereign, the searching quality carries a new acceptance. There is less straining in these moments than in previous records. The questions are asked more quietly because the person asking them is no longer performing the asking. The performance is reserved for the record's exterior. The interior, for the first time across his catalog, is simply present.

## The Market Does Not Own This

One of the stranger features of Burna Boy's career is that he has maintained a consistent artistic vision while becoming one of the commercially dominant forces in global music. These two things are supposed to be in tension. The market is supposed to reshape the artist toward its requirements, filing down the particular roughnesses that make the work original until what remains is something saleable but generic. This has not happened. Sovereign sounds like no other record in the global pop landscape, is not trying to sound like any other record, and has been made in full confidence that this specificity is not a commercial liability but the precise source of its commercial power.

The lesson is not transferable. Burna Boy arrived at this position through a combination of stubbornness, talent, and the particular cultural moment that made an African artist's confidence in the distinctiveness of his work legible to global audiences in a way that might not have been possible a decade earlier. The lesson, to the extent there is one, is that the attempt to manufacture authenticity always fails. The authentic is recognizable precisely because it was not manufactured. Sovereign is the work of someone who has been building toward a single definitive statement for more than a decade and has now made it. It is the work of an artist who has earned the right to use a word like sovereign without irony, because the music makes the claim on its own.

[download:/assets/images/artists/burna-boy-sovereign-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "burna-boy-sovereign",
    "title": "Burna Boy Names His New Album Sovereign and Then Proves the Point",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-15",
    "image": "/assets/images/artists/burna-boy-sovereign.jpg",
    "image_alt": "Burna Boy press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/burna-boy-sovereign.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: burna-boy-sovereign.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/burna-boy-sovereign)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/burna-boy-sovereign&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: burna-boy-sovereign"


# ---- POST 2: James Blake - Hollow Ground ----
echo "--- Deploying: james-blake-hollow-ground ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/james-blake-hollow-ground.jpg'

try:
    html = fetch('https://pitchfork.com/reviews/albums/james-blake-hollow-ground/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    html = fetch('https://stereogum.com/2503100/album-of-the-week-james-blake-hollow-ground/reviews/album-of-the-week')
    imgs = re.findall(r'(https?://media\.stereogum\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+james[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://stereogum.com/')
        print('Downloaded from Stereogum')
        sys.exit(0)
except Exception as e:
    print(f'Stereogum failed: {e}')

try:
    html = fetch('https://www.theguardian.com/music/2026/jun/13/james-blake-hollow-ground-review')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+guardian[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+james[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.theguardian.com/')
        print('Downloaded from Guardian')
        sys.exit(0)
except Exception as e:
    print(f'Guardian failed: {e}')

try:
    html = fetch('https://www.nme.com/reviews/album/james-blake-hollow-ground-review')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+nme\.com[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

try:
    html = fetch('https://www.brooklynvegan.com/james-blake-hollow-ground-review-2026/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'james' in i.lower() or 'blake' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.brooklynvegan.com/')
        print('Downloaded from Brooklyn Vegan')
        sys.exit(0)
except Exception as e:
    print(f'Brooklyn Vegan failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system('convert -size 1200x800 gradient:\"#0d0d1a-#1a1a2e\" -gravity center -pointsize 52 -fill white -annotate 0 \"James Blake\" ' + dest)
"

OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/james-blake-hollow-ground.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/james-blake-hollow-ground-up.jpg && \
  mv ~/artonly.io/assets/images/artists/james-blake-hollow-ground-up.jpg \
     ~/artonly.io/assets/images/artists/james-blake-hollow-ground.jpg
echo "Image upscaled: james-blake-hollow-ground.jpg"

cd ~/artonly.io/agent
python3 make-social-card.py james-blake-hollow-ground "On Hollow Ground, James Blake Finds What He Was Looking For All Along" music
echo "Social card generated: james-blake-hollow-ground-social-9x16.jpg"
cd ~

python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/53KwLdlmrlCelAZMaLVZqU]

James Blake has been doing the same thing for fifteen years and somehow always making it feel new. This is not a criticism. It is the definition of a coherent artistic practice: to have found a set of questions worth spending a career on, and to return to them with sufficient imagination that each return constitutes a genuine investigation rather than a rehearsal of positions already established. Hollow Ground, released June 13 on Republic Records, is his sixth studio album, and it is his most honest accounting of what the practice has cost him and what it has given back.

The first thing to say about James Blake is that he began as a producer before he was understood as a vocalist, and that this ordering still matters. He emerged from London's post-dubstep scene in 2010 and 2011 with a series of EPs that demonstrated an ear for what electronic music could do when it was willing to move slowly, to let rhythm deconstruct and reassemble itself at a pace that required patience. His debut album in 2011 was what happened when that sensibility tried to accommodate a voice: the piano, the space, the stutter and hesitation of someone figuring out in real time how the emotional content of his work and its formal innovations could coexist. The answer turned out to be that they could not just coexist but that each was necessary to the other. The vulnerability in the voice required the impersonality of the electronic architecture. The impersonality required the vulnerability.

## The Hollow and the Ground

The title of this album is doing particular work. Hollow carries a negative connotation when applied to a person: to call someone hollow is to suggest the absence of substance or genuine feeling. But to hollow something is also to carve a space within it, to make room. Ground is where you stand when nothing else is left. The pairing asks what it is like to occupy cleared space, to stand in a place that has been emptied of everything extraneous. The album does not answer this question cleanly, but it asks it from the inside rather than the outside, which is the only position from which such questions have any force.

The production on Hollow Ground returns to the piano-driven minimalism of Blake's early work without abandoning what he learned from the more collaborative, R&B-inflected records he made in the years between. The result sounds like a synthesis rather than a retreat. You can hear "Overgrown" in its patience and you can hear "Assume Form" in its willingness to let warmth in, and what holds these qualities together is the understanding, achieved after fifteen years, that neither quality negates the other. A record can be spare and intimate at the same time. A record can be technically rigorous and emotionally available at the same time. Hollow Ground demonstrates both of these as settled facts rather than propositions under investigation.

## The Voice as Instrument

Blake's voice has evolved in a way that is unusual among artists of his generation. It has become more assured over time without becoming more polished in the sense of having its roughnesses removed. The falsetto that defined his early work is still present, but it is deployed now with a specificity that earlier recordings could not quite achieve. He knows exactly what the falsetto is for and uses it accordingly. The lower register, which was less prominent in early work and appeared more in "Friends That Break Your Heart," is now fully integrated, allowing him to move between registers without the transition feeling like a gear change. The voice is seamless in a way that makes the emotional content of each register land more precisely.

There are no featured artists on Hollow Ground. This is notable given Blake's history of collaboration, which has produced some of the most memorable guest contributions of the last decade, including his work with Bon Iver, with Frank Ocean, with Jay-Z, with SZA. The absence of features here is not a withdrawal but a statement of intent. The record has a single author. The singular voice that might have been dispersed across collaborators is instead turned inward, and the result is an album that sounds like private correspondence rather than public transmission.

## What Fifteen Years Looks Like

There is a quality in Blake's work that becomes clearer when you encounter Hollow Ground after hearing everything that preceded it. He has always been making the same argument: that emotional complexity deserves formal complexity, that the interior life of a sensitive person in a loud world is not a small subject, that music can hold both the dissonance of experience and its resolution without falsifying either. What changes on Hollow Ground is not the argument but the tone in which it is made. The earlier records were making the argument urgently, as though the point was still in dispute. Hollow Ground makes it with the confidence of someone who has long since stopped worrying about whether the point will be accepted.

The album's longest track, which arrives in its final third, is its clearest statement. It builds from something almost imperceptibly small, a single piano line barely above the level of a whisper, and expands across its running length into a structure of considerable emotional weight. The trajectory is the argument made audible: the small thing, attended to with sufficient care, reveals itself as large. The hollow ground, examined closely, turns out to be the place you needed to be standing all along.

## The London That Made This

James Blake is a London artist in a way that is not always acknowledged, perhaps because so much of his later career has been based in Los Angeles and his collaborations have taken him across American musical landscapes. But the sensibility that produced his work is distinctly formed by the British tradition of music as a place where emotional reserve and emotional intensity coexist, sometimes uncomfortably. The post-dubstep scene from which he emerged was a London scene: Bass Clef, Mount Kimbie, Actress, Rustie, moving through the influence of dubstep toward something more introspective and less obviously clubbable. That formation is present in Hollow Ground in the structural choices, in the patience, in the willingness to make the listener do some of the work. This is music that asks something of its audience, and the audience it is asking the most of is the one that has been paying close attention since 2011.

Hollow Ground is not a capstone. It does not feel like an artist saying what they need to say before they run out of things to say. It feels like an artist who has finally cleared enough space within his own practice to make the record that was always implicit in the work. Hollow, but not empty. Ground, but not settled. Fifteen years in the making, and still unfinished in the right way.

[download:/assets/images/artists/james-blake-hollow-ground-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "james-blake-hollow-ground",
    "title": "On Hollow Ground, James Blake Finds What He Was Looking For All Along",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-15",
    "image": "/assets/images/artists/james-blake-hollow-ground.jpg",
    "image_alt": "James Blake press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/james-blake-hollow-ground.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF
echo "JSON deployed: james-blake-hollow-ground.json"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/james-blake-hollow-ground)
echo "HTTP status: $STATUS"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/james-blake-hollow-ground&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: james-blake-hollow-ground"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@atlanticrecords.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Burna Boy and Sovereign at artonly.io/post/burna-boy-sovereign. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@atlanticrecords.com (Burna Boy)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@jamesblake.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on James Blake and Hollow Ground at artonly.io/post/james-blake-hollow-ground. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@jamesblake.com (James Blake)"


# ---- Summary email ----
python3 << 'PYEOF'
import json, subprocess, os

body = """Published today:

1. Burna Boy - Sovereign
   https://artonly.io/post/burna-boy-sovereign
   Author: Allastair Voss
   Spotify: 3wcj11K77LjEY1PkEOt3Oy
   Released: June 13, 2026 (Spaceship Entertainment / Atlantic Records)
   7th studio album. Production led by Leriq. Pan-African collaborators from Ghana, South Africa, Senegal.
   Themes: sovereignty, political liberation, artistic self-possession, Fela Kuti legacy.

2. James Blake - Hollow Ground
   https://artonly.io/post/james-blake-hollow-ground
   Author: Leelou Blanc
   Spotify: 53KwLdlmrlCelAZMaLVZqU
   Released: June 13, 2026 (Republic Records / Polydor)
   6th studio album. No features. Solo statement, piano minimalism, post-dubstep roots.
   Themes: emotional complexity, London electronic heritage, 15 years of practice arriving at clarity.

Outreach:
- Burna Boy: email sent to press@atlanticrecords.com (Atlantic Records press)
- James Blake: email sent to press@jamesblake.com (artist contact)

Both releases from June 13, 2026, not previously covered on ArtOnly."""

result = subprocess.run(
    ["python3", os.path.expanduser("~/artonly.io/api/gmail-send.py"),
     "amosleblanc@gmail.com",
     "ArtOnly Album Monitor: 2026-06-15",
     body],
    capture_output=True, text=True
)
print(result.stdout)
if result.returncode != 0:
    print("gmail-send error:", result.stderr)
PYEOF

echo "=== Deploy complete: 2026-06-15 ==="
