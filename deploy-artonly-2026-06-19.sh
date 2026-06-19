#!/bin/bash
# ArtOnly Deploy Script: Jon Batiste + Tierra Whack
# Generated: 2026-06-19 (retry)
# Posts: jon-batiste-black-mozart, tierra-whack-whacks-museum
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-19 ==="
echo "$(date)"

##############################################################################
# POST 1: Jon Batiste - Black Mozart
##############################################################################

echo "--- Deploying: jon-batiste-black-mozart ---"

# ---- Download hero image ----
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
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/jon-batiste-black-mozart.jpg'

try:
    html = fetch('https://pitchfork.com/artists/jon-batiste/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Hero downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    url = 'https://commons.wikimedia.org/wiki/Special:FilePath/Jon_Batiste_in_Brooklyn_Juneteenth_2020_(94194).jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (Juneteenth 2020)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 1 failed: {e}')

try:
    url = 'https://commons.wikimedia.org/wiki/Special:FilePath/Jon_Batiste_at_the_2022_Met_Gala_(cropped).jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (Met Gala)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 2 failed: {e}')

try:
    html = fetch('https://www.npr.org/artists/208638149/jon-batiste')
    imgs = re.findall(r'(https?://media\.npr\.org/assets/img/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.npr.org/')
        print('Hero downloaded from NPR')
        sys.exit(0)
except Exception as e:
    print(f'NPR failed: {e}')

os.system('convert -size 1200x800 gradient:\"#0a0a2e-#1a1a4e\" -gravity center -pointsize 52 -fill white -annotate 0 \"Jon Batiste\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert jon-batiste-black-mozart.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 jon-batiste-black-mozart-up.jpg && mv jon-batiste-black-mozart-up.jpg jon-batiste-black-mozart.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/0eRbECAGCLLiTyVXPBRexU]

Jon Batiste is one of the most deliberately uncategorizable musicians working today. His career has moved between jazz, soul, pop, film scoring, television bandleading, and now a deepening engagement with the classical piano repertoire, not by negotiating between these spaces but by treating them as a single continuous conversation. That framing matters. Batiste does not code-switch. He plays what he knows, and what he knows comes from a family of musicians that stretches back generations in Louisiana, from the New Orleans second line, from the Baptist church, from Juilliard, from hundreds of nights on stage as a bandleader. All of it is present at once.

"Black Mozart," released June 19, 2026 on Decca Records, is the second volume of his Batiste Piano Series. The first volume, "Beethoven Blues," arrived in 2024 and topped Billboard's Classical Albums chart. It established the method: take repertoire from the European classical canon, play it on solo piano, and bring to the performance the full inheritance of Black American musical tradition without subordinating either. The method sounded simple when described. The execution proved otherwise.

"Black Mozart" extends the project to twelve keyboard works by Mozart. What Batiste does with them is not transcription and not fusion in the usual sense. He reads the score and then reads it again through jazz, through blues, through ragtime, through stride. The Mozart remains recognizable throughout. So does everything else. What he demonstrates, across forty minutes of solo piano, is that these traditions have always been capable of illuminating each other. They were simply kept in separate rooms.

## The Choice of Juneteenth

The release date is not incidental. Batiste announced the album in March 2026 and tied its arrival specifically to June 19, the federal holiday marking the end of American slavery. That act of dating is itself a statement. The classical music establishment has historically treated the European canon as belonging to a European tradition. The unstated corollary is that other traditions belong somewhere else. Batiste's release date refuses that corollary without arguing with it. He simply arrives on Juneteenth with a record that makes the European piano repertoire his own, and in doing so makes plain that the claim was always available to him.

This is how cultural reclamation works when it is done without bitterness: not by dismantling the thing but by demonstrating that your relationship to it has never required the permission you were never asked to seek.

The Mozart project also follows a different kind of cultural positioning than "We Are," the album that won Batiste Album of the Year at the 2022 Grammy Awards. "We Are" was an album about collective joy, about survival, about what communities hold onto when everything around them is eroding. "Black Mozart" is quieter, more individual, more technical. It requires listening rather than celebrating. That is a braver thing to ask of an audience that has given you five Grammys.

## What the Piano Does Here

The choice of solo piano for this project is structurally meaningful. No arrangement, no band, no collaborative buffer between the player and the listener. Just the instrument and the knowledge Batiste brings to it. Piano performance in the classical tradition values precision of voicing, clarity of line, fidelity to what is on the page. Piano performance in the jazz tradition values responsiveness to the moment, dialogue between the hands, a willingness to depart and return. Stride piano, which emerged from ragtime in the early twentieth century, uses the relationship between bass and upper registers in a rhythmic conversation that has its own physics.

Batiste is fluent in all of these vocabularies. On "Black Mozart," he allows them to speak to each other across the same twelve compositions. The result is not a stylistic mashup. It is something closer to a demonstration: that these methods of playing the piano come from related places, that the intelligence underlying them is not bounded by the tradition it was born in, that a pianist trained in New Orleans and Juilliard simultaneously is not playing between two traditions but from inside a single larger one that has always included both.

The album includes a track called "Processional" that Batiste composed himself. It arrives not as an interruption but as a culmination. In it the interpreter steps out from behind the canon and presents something entirely his own. By most accounts it is the album's most fully realized piece. That is either ironic or inevitable, depending on your view of what the preceding tracks have been building toward.

## The Deeper Stakes

Classical music's structural problem is not primarily a matter of individual prejudice. It is a matter of systems: the concert hall, the conservatory, the critical infrastructure, the audience demographics, the programming logic of major institutions. These systems have reproduced themselves across generations with a consistency that cannot be accidental. Artists who have existed outside them have repeatedly produced work of equivalent depth and have repeatedly been received as exceptional cases rather than as evidence that the system's premise was wrong.

Batiste's premise on "Black Mozart" is that the tradition that produced him is not lesser in relation to the European classical canon. That it has its own depths, its own innovations, its own capacity to illuminate a body of repertoire that has historically excluded it. The album makes this argument audible, which is the only form in which such an argument finally matters.

At a moment when the United States is engaged in various ceremonies of self-celebration, hosting international sporting events and approaching its 250th year, an artist releasing a solo piano album of Mozart reinterpretations on Juneteenth is doing something specific with time and attention. He is saying that the history being celebrated and the history being elided are part of the same story, and that music is one of the places where the elision becomes visible.

The visit to this particular record is quiet. It rewards patience. What you take from it depends on what you bring: knowledge of Mozart, knowledge of jazz history, knowledge of what it has cost to stand in certain rooms. Batiste is fluent in all of it. "Black Mozart" is the record where that fluency becomes something more than impressive. It becomes necessary.

[download:/assets/images/artists/jon-batiste-black-mozart-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "jon-batiste-black-mozart",
    "title": "Jon Batiste Plays Mozart on Juneteenth and Rewrites the Terms of Who the Music Belongs To",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-19",
    "image": "/assets/images/artists/jon-batiste-black-mozart.jpg",
    "image_alt": "Jon Batiste press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/jon-batiste-black-mozart.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash found: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} in body')
PYEOF

echo "Post 1 JSON deployed: jon-batiste-black-mozart.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py jon-batiste-black-mozart "Jon Batiste Plays Mozart on Juneteenth and Rewrites the Terms of Who the Music Belongs To" music
echo "Social card generated: jon-batiste-black-mozart-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/jon-batiste-black-mozart)
echo "HTTP status artonly.io/post/jon-batiste-black-mozart: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/jon-batiste-black-mozart&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: jon-batiste-black-mozart"

# ---- Outreach ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@deccaclassics.com" \
  --data-urlencode "subject=ArtOnly just covered Jon Batiste" \
  --data-urlencode "body=https://artonly.io/post/jon-batiste-black-mozart

We published a piece on Jon Batiste and Black Mozart at the link above. No ask attached. We wrote about the Juneteenth release date as a cultural statement, the piano as the instrument where his entire inheritance becomes visible at once, and what it means to make a record that refuses the permissions it was never asked to seek. A downloadable social card is at the bottom of the page. Happy to arrange a conversation if there is appetite, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Jon Batiste"

##############################################################################
# POST 2: Tierra Whack - WHACK'S MUSEUM
##############################################################################

echo "--- Deploying: tierra-whack-whacks-museum ---"

# ---- Download hero image ----
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
    print(f'Downloaded {len(data)} bytes to {dest}')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg'

try:
    html = fetch('https://pitchfork.com/artists/tierra-whack/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Hero downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    url = 'https://commons.wikimedia.org/wiki/Special:FilePath/Tierra_Whack_MoMA_2018.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 1 failed: {e}')

try:
    html = fetch('https://www.npr.org/artists/595210903/tierra-whack')
    imgs = re.findall(r'(https?://media\.npr\.org/assets/img/[^\s\"\x27<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.npr.org/')
        print('Hero downloaded from NPR')
        sys.exit(0)
except Exception as e:
    print(f'NPR failed: {e}')

os.system('convert -size 1200x800 gradient:\"#1a0a2e-#3d0f6e\" -gravity center -pointsize 52 -fill white -annotate 0 \"Tierra Whack\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert tierra-whack-whacks-museum.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 tierra-whack-whacks-museum-up.jpg && mv tierra-whack-whacks-museum-up.jpg tierra-whack-whacks-museum.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/4lPl9gqgox3JDiaJ1yklKh]

Philadelphia gave us Tierra Whack in 2018 as an artifact of concentrated imagination. "Whack World," her debut visual album, ran exactly fifteen minutes: fifteen songs, one minute each, each with its own music video, the whole thing conceived and executed with the coherence of a single artistic vision. It told you immediately how she thinks. In total environments. The world first, then the sound, then the decision about what fits inside the space she has already built. Genre conventions, label expectations, commercial formats: these are not her constraints. They are, at most, her starting material.

"WHACK'S MUSEUM" arrived June 19, 2026 on Interscope Records. Twelve tracks, twenty-seven minutes, no features. The math announces the intent before you press play. Average track length is just over two minutes. Nothing is padded. Nothing is extended for algorithmic reasons. The title gives you the frame: a museum is a space of preservation and selection, but this one carries Whack's name and she is the curator. What she has chosen to display is her rapping. Pure and without ornament.

This matters as a specific declaration because Whack's career has sometimes been received in a particular way: as the work of a visual artist who also happens to rap. That framing captures something real and misses something important. The visual intelligence, the concept-building, the world-construction quality of her projects has been immediately legible from the beginning. The craft of the bars has been equally present but sometimes positioned as secondary in the conversation. "WHACK'S MUSEUM" is the record that puts the bars at the center and asks the conversation to catch up.

## The Case She Is Making

"WAX PAPER," the lead single, arrived before the album with a music video shot in black and white in Whack's hometown by director Child. It was a statement of intent in the clearest possible register: wordplay delivered with the confidence of someone who knows exactly what they have and is not performing that confidence, just exhibiting it. "TOTEM," released June 17, extended the argument. The production, primarily from Conductor Williams, is gritty and soulful in a way that carries the specific texture of Philadelphia without making that texture decorative.

Both singles do the thing the album does across twelve tracks: they compress a lot of meaning into a small space and move on before you have fully processed what arrived. This is not a casual listening record, though it is accessible. It asks for attention and returns something that functions like revelation when attention is brought to it. That exchange has characterized Whack's work since the beginning. "WHACK'S MUSEUM" simply stages it more directly than any previous project.

The Philadelphia reference running through the production is not ornamental. Whack has consistently positioned her city as a presence in her work. There is something in the sonic character of what Conductor Williams draws from the beats, a grittiness that is also somehow spacious, that carries the feel of the place. The album knows where it comes from and that knowledge is load-bearing.

## The Mixtape Form as Liberation

Calling "WHACK'S MUSEUM" a mixtape rather than an album is a formal choice with consequences. The mixtape format implies freedom from the pressures of the commercial album cycle: no engineered lead single, no carefully managed genre adjacency, no obligation to demonstrate range for the sake of demonstrating range. A mixtape can be exactly what it needs to be. In Whack's case that is twelve tracks of rapping well, over and done in under thirty minutes.

This project follows "WORLD WIDE WHACK" from 2024, which was her most commercially ambitious record. Moving from that to this represents a contraction that is actually an expansion. Fewer ambitions stated, more precisely executed. The museum metaphor operates structurally as well as nominally: you enter at one end and exit at the other, and the sequence is the argument. The album does not work as a shuffle. It works as a walk through a space that has been arranged with specific intent.

The twenty-seven minute runtime is itself a position. In a period when major releases routinely extend to eighteen or twenty-two tracks and seventy minutes, Whack stops when she is done. That is not minimalism as a style choice. It is confidence in the material. The museum visit is short. The work is dense. There is no filler because there was never any interest in filler.

## What She Is Proving

Whack occupies a position in contemporary hip hop that is worth being clear about. She is not pop-adjacent in the sense that many rappers are, where the production is calibrated for passive listening and the hooks are designed to work without sustained attention. She is accessible because she is precise, not because she has made anything easier. "WHACK'S MUSEUM" extends this logic to its endpoint: twelve tracks of relentless lyrical density with no concession to the listener who is not paying attention.

The fact that the record is still enjoyable, still carries joy in places alongside its grit and swagger, is part of the craft. Joy and precision are not in tension for Whack. They are the same quality expressing itself in different registers. The album moves between bittersweet and swaggering and goofy and direct without losing its center, which is the voice and the bars and the particular intelligence behind them.

What you walk away with, if you have been paying attention for twenty-seven minutes, is a clear picture of an artist who has decided exactly what she is, has built a museum around it, and is not interested in explaining the choice to anyone who needs an explanation. The museum is open. The collection is complete. Tierra Whack did not need your permission to put her name on the door.

[download:/assets/images/artists/tierra-whack-whacks-museum-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "tierra-whack-whacks-museum",
    "title": "Tierra Whack Steps Into Her Own Museum and Shows You Exactly What She Is Made Of",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-19",
    "image": "/assets/images/artists/tierra-whack-whacks-museum.jpg",
    "image_alt": "Tierra Whack press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/tierra-whack-whacks-museum.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash found: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} in body')
PYEOF

echo "Post 2 JSON deployed: tierra-whack-whacks-museum.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py tierra-whack-whacks-museum "Tierra Whack Steps Into Her Own Museum and Shows You Exactly What She Is Made Of" music
echo "Social card generated: tierra-whack-whacks-museum-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/tierra-whack-whacks-museum)
echo "HTTP status artonly.io/post/tierra-whack-whacks-museum: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/tierra-whack-whacks-museum&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: tierra-whack-whacks-museum"

# ---- Outreach ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@interscope.com" \
  --data-urlencode "subject=ArtOnly just covered Tierra Whack" \
  --data-urlencode "body=https://artonly.io/post/tierra-whack-whacks-museum

We published a piece on Tierra Whack and WHACK'S MUSEUM at the link above. No ask attached. We wrote about the mixtape form as an act of liberation, the Philadelphia in the production from Conductor Williams, and what it means to build a museum with your own name on it and refuse to explain the choice. A downloadable social card is at the bottom of the page. Happy to connect further if there is appetite, just reply here.

Leelou Blanc
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Tierra Whack"

##############################################################################
# Summary email
##############################################################################

python3 << 'SUMMARYEOF'
import subprocess

urls = [
    "https://artonly.io/post/jon-batiste-black-mozart",
    "https://artonly.io/post/tierra-whack-whacks-museum",
]

subject = "ArtOnly Album Monitor: 2026-06-19"
body = (
    "Published today:\n\n"
    + "\n".join(urls)
    + "\n\nOutreach:\n"
    "  Jon Batiste: sent to press@deccaclassics.com (Decca Records press)\n"
    "  Tierra Whack: sent to press@interscope.com (Interscope press)\n"
    "  BCC on both: amosleblanc@gmail.com\n\n"
    "Posts: jon-batiste-black-mozart, tierra-whack-whacks-museum\n"
    "Authors: Allastair Voss, Leelou Blanc\n"
    "Albums: Black Mozart (June 19, 2026, Decca), WHACK'S MUSEUM (June 19, 2026, Interscope)"
)

result = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py',
     'amosleblanc@gmail.com', subject, body],
    capture_output=True, text=True
)
print(result.stdout)
if result.returncode != 0:
    print(f'gmail-send error: {result.stderr}')
    import urllib.request, urllib.parse
    data = urllib.parse.urlencode({
        'to': 'amosleblanc@gmail.com',
        'subject': subject,
        'body': body
    }).encode()
    req = urllib.request.Request('https://artonly.io/api/send-mail.php', data=data)
    resp = urllib.request.urlopen(req, timeout=15)
    print(f'Fallback mail sent: {resp.read().decode()}')
SUMMARYEOF

echo "=== Deploy complete: 2026-06-19 ==="
