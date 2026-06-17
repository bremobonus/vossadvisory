#!/bin/bash
# ArtOnly Deploy Script: Olivia Rodrigo + Hayley Kiyoko
# Generated: 2026-06-17
# Posts: olivia-rodrigo-you-seem-pretty-sad, hayley-kiyoko-girls-like-girls
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-17.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-17 ==="
echo "$(date)"

##############################################################################
# POST 1: Olivia Rodrigo
##############################################################################

echo "--- Deploying: olivia-rodrigo-you-seem-pretty-sad ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/olivia-rodrigo-you-seem-pretty-sad.jpg'

try:
    html = fetch('https://pitchfork.com/artists/7498-olivia-rodrigo/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Hero downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    url = 'https://commons.wikimedia.org/wiki/Special:FilePath/Olivia_Rodrigo_performs_%27Get_Him_Back%27_live_02.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 1 failed: {e}')

try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Olivia_Rodrigo_at_the_2022_Met_Gala.jpg/800px-Olivia_Rodrigo_at_the_2022_Met_Gala.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons (Met Gala)')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 2 failed: {e}')

os.system('convert -size 1200x800 gradient:\"#1a0a2e-#2d1855\" -gravity center -pointsize 52 -fill white -annotate 0 \"Olivia Rodrigo\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert olivia-rodrigo-you-seem-pretty-sad.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 olivia-rodrigo-you-seem-pretty-sad-up.jpg && mv olivia-rodrigo-you-seem-pretty-sad-up.jpg olivia-rodrigo-you-seem-pretty-sad.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/1McMsnEElThX1knmY4oliG]

The title of Olivia Rodrigo's third album is a full argument. "you seem pretty sad for a girl so in love" is not a lyric pulled from context. It is a social observation, the kind someone says to you at a party with a note of concern that is also a note of accusation. It encodes an entire system of expectations about how someone in love is supposed to appear, and it uses that system to describe its own failure. You are supposed to look happy when you are in love. What does it mean when you do not.

Rodrigo has been asking questions like this since she was seventeen years old and wrote "drivers license" in her childhood bedroom in Temecula, California. That song arrived in January 2021 and became something larger than a breakup ballad: a document of a specific adolescent ache rendered with a precision that most artists twice her age could not locate. SOUR, the debut album that followed in May 2021, extended that precision into eleven tracks and won her four Grammy Awards, including Best New Artist. She was nineteen. GUTS, released in September 2023, was a record about what happens after the breakup and after the success: the discomfort of celebrity, the anxiety of growth, the uneasy experience of becoming public property at exactly the moment you are trying to figure out who you actually are. It was louder, angrier in places, and more complicated in its emotional math. It won her another Grammy, Best Pop Vocal Album.

"you seem pretty sad for a girl so in love," released June 12, 2026, on Geffen Records, is the third chapter. Produced by Dan Nigro, who has been her primary collaborator since before SOUR, the album takes the emotional intelligence of the previous two records and turns it toward something more specific: what love looks like when you are old enough to understand its cost.

## The Production Logic of Grief

Dan Nigro and Rodrigo have built something unusual over the course of three albums. A creative partnership that has grown in real time with its primary subject. Nigro has said in interviews that working with Rodrigo requires following the emotional argument of whatever she is living through rather than beginning with a predetermined sonic template. The result across SOUR and GUTS was a body of work that shifted textures within albums and between them while maintaining a consistent emotional clarity.

On "you seem pretty sad for a girl so in love," the shift is toward something more atmospheric and cinematic. Rodrigo spent significant time in London during the writing period, and the production carries that influence in its layering, its use of strings alongside synthesizers, its willingness to let sections breathe rather than fill every available space. The album moves through two distinct emotional dispositions: brighter melodies with an underlying tension in the first half, a more inward and deliberate quality in the second. The record is not quiet, but it has room for silence in a way that neither of the previous albums quite allowed.

"The Cure," the second single released on May 22, 2026, is the clearest statement of the album's logic. Rodrigo described it as the thesis statement of the record. It is, at its core, a meditation on the baggage that people carry into relationships, the ways that old damage becomes the obstacle inside the new thing. That is a more complicated emotional terrain than adolescent heartbreak, and the song navigates it without simplifying the difficulty into something easier to process. The rock inflections in the arrangement serve the argument rather than decorating it.

## What a Third Album Means

There is a particular kind of creative pressure that arrives with a third album. The first record announces who an artist is. The second record tests whether the announcement was accurate. The third record either confirms the pattern or breaks it. Rodrigo has been a songwriter first since the beginning. The hooks and the production are precise, but they serve the emotional argument rather than the other way around.

The lead single "drop dead," released April 17, 2026, establishes the album's central tension immediately. The title is aggressive; the emotional content is more complicated than aggression. "Begged," previewed on Saturday Night Live on May 2, 2026, moves in the other direction: vulnerability rendered without the protective coating of anger. Together they define the range the album works within. This is a record about being in love, and about the fear that lives inside love, and about the gap between what love looks like from the outside and what it costs on the inside.

The remaining tracks extend this range without exhausting it. "honeybee" and "maggots for brains" sit at opposite ends of the affection spectrum, the first genuinely tender and the second a study in obsessive fixation that is not quite the same thing as love. "u + me = <3" has the arithmetic certainty of early love written on a notebook cover, which is exactly what makes it complicated when placed inside an album about love's hidden costs. The record plays with these juxtapositions deliberately. The bright surface and the dark underneath are not in conflict. They are the point.

## The Title as Cultural Act

The phrase "you seem pretty sad for a girl so in love" does something beyond setting up a listening experience. It positions the album as a commentary on the expectations placed on people, specifically young women, who are supposed to perform happiness in proportion to the romantic happiness they are understood to possess. It is a critique of the presumption that love should look a certain way from the outside. Rodrigo has always been alert to the social scripts her work exists within and has never simply followed them.

At twenty two years old, with three albums, five Grammy Awards, and a stadium tour behind her, she is already one of the most important songwriters of her generation. "you seem pretty sad for a girl so in love" is evidence of what happens when someone with that level of talent refuses to stay inside the category that made them famous. The record is ambitious in ways that are not loud about their ambition. It does not announce that it has grown. It simply has. The sadness it documents is not a symptom of failure. It is the proof that the love was real enough to carry something.

[download:/assets/images/artists/olivia-rodrigo-you-seem-pretty-sad-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "olivia-rodrigo-you-seem-pretty-sad",
    "title": "Olivia Rodrigo Made the Contradiction Into the Point of the Whole Thing",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-17",
    "image": "/assets/images/artists/olivia-rodrigo-you-seem-pretty-sad.jpg",
    "image_alt": "Olivia Rodrigo press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/olivia-rodrigo-you-seem-pretty-sad.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

# Verify no dashes used as punctuation
for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash character found in body: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} found')
PYEOF

echo "Post 1 JSON deployed: olivia-rodrigo-you-seem-pretty-sad.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py olivia-rodrigo-you-seem-pretty-sad "Olivia Rodrigo Made the Contradiction Into the Point of the Whole Thing" music
echo "Social card generated: olivia-rodrigo-you-seem-pretty-sad-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/olivia-rodrigo-you-seem-pretty-sad)
echo "HTTP status artonly.io/post/olivia-rodrigo-you-seem-pretty-sad: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/olivia-rodrigo-you-seem-pretty-sad&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: olivia-rodrigo-you-seem-pretty-sad"

# ---- Outreach: Olivia Rodrigo ----
# Press contact via Geffen Records / Universal Music Group press team
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@interscope.com" \
  --data-urlencode "subject=ArtOnly just covered Olivia Rodrigo" \
  --data-urlencode "body=https://artonly.io/post/olivia-rodrigo-you-seem-pretty-sad

We published a piece on Olivia Rodrigo and the new album at the link above. No ask attached. We wrote about the production logic of the record, the Dan Nigro collaboration across three albums, and what it means to make a third album that refuses to stay inside the category that made you famous. A downloadable social card is at the bottom of the page. Happy to arrange a conversation if there is appetite, just reply here.

Leelou Blanc
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Olivia Rodrigo"

##############################################################################
# POST 2: Hayley Kiyoko
##############################################################################

echo "--- Deploying: hayley-kiyoko-girls-like-girls ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls.jpg'

try:
    html = fetch('https://pitchfork.com/artists/hayley-kiyoko/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Hero downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

try:
    url = 'https://commons.wikimedia.org/wiki/Special:FilePath/Hayley_Kiyoko_by_Jamie_Alcroft.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia 1 failed: {e}')

try:
    html = fetch('https://www.npr.org/artists/597939237/hayley-kiyoko')
    imgs = re.findall(r'(https?://media\.npr\.org/assets/img/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.npr.org/')
        print('Hero downloaded from NPR')
        sys.exit(0)
except Exception as e:
    print(f'NPR failed: {e}')

os.system('convert -size 1200x800 gradient:\"#2d1855-#1a0a2e\" -gravity center -pointsize 52 -fill white -annotate 0 \"Hayley Kiyoko\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert hayley-kiyoko-girls-like-girls.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 hayley-kiyoko-girls-like-girls-up.jpg && mv hayley-kiyoko-girls-like-girls-up.jpg hayley-kiyoko-girls-like-girls.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/3LjhVl7GzYsza1biQjTpaN]

In June 2015, Hayley Kiyoko released a music video for a song called "Girls Like Girls." It cost approximately twelve thousand dollars to make. Within a year it had over ten million views. The song and video did something that almost nothing in mainstream pop had done before it: placed a queer teenage romance at the center of a narrative and treated it with the same emotional seriousness afforded to heterosexual love stories. No camp, no distance, no apology. Just two girls falling for each other at the end of a summer. The directness of it was startling in 2015. It should not have been startling, but it was.

Eleven years later, Kiyoko has written a novel with the same title, directed a feature film with the same title, and released an album titled "girls like girls the album." The film opens in theaters on June 19, 2026. The album arrived on June 13, one week before. The three things exist in relationship with each other, forming a total world around a single emotional premise: that queer first love is not a subgenre of love. It is love. The album is the musical architecture of that world.

## What the Novel and the Film Required

Kiyoko has spoken about the source material as drawing on her own memories of adolescence, specifically the summer she was sixteen in Los Angeles when she understood something about who she was attracted to that she had not understood before. The original song was a compression of that understanding into three minutes and fifteen seconds. The novel expanded it into a full narrative arc. The film makes the narrative visual. The album does something different from all three.

Fourteen songs, forty five minutes, featuring a roster of collaborators that is, in itself, a kind of argument. Chelsea Cutler, August Ponthier, Snow Wife, Young Miko, Joy Oladokun, Tegan and Sara, Gigi Perez: this is not a list assembled for algorithmic reasons. It is a list of artists whose own work exists in conversation with the themes Kiyoko is exploring. Artists who have spent their careers writing about love and identity from positions that required courage, or at least a certain refusal to make it easier for their audience.

Tegan and Sara, who appear on "postcard," have been making records about queer experience since before queer pop had a marketing category. Their contribution here is not a legacy gesture. It is a passing of something between two generations of artists who have understood the same thing. Gigi Perez, who appears on "collide," is an artist whose own work deals in the same emotional territory that Kiyoko has staked her entire career on. Young Miko, on "die 4 u," brings a perspective from a generation for whom the battles Kiyoko's 2015 video was waging have been partly won, even if they have not been fully resolved. Joy Oladokun, on "trophy," has spent her career making music about the experience of not fitting neatly into the categories available to you and finding something that functions better than fitting anyway.

## The Album Itself

The record opens with "@RollieColey87," a title that lands immediately as the specific idiom of teenage longing: the username of someone you follow and check obsessively. What follows is an album that moves through the emotional topography of a summer, the way that time feels different when you are sixteen and in love for what might be the first time.

"lakeside" and "falling through" are the album's quieter interior moments, songs that exist in the space between what you want to say and what you actually say. "choker" and "red bikini" operate in the register of physical awareness, the way first love is always also a first reckoning with your own body. "nobody should have you," featuring Chelsea Cutler, carries the particular ache of wanting someone who is in some sense already taken, which is one of the oldest narratives in popular music and which lands differently when the wanting itself has historically been framed as transgressive.

The final track is "girls like girls," a new version of the original song or perhaps simply a new song with the same name, returned to after a decade to be understood differently. That decision is structurally meaningful. The original song is the premise. The album is the proof. What Kiyoko is arguing, across fourteen tracks and three media formats, is that the premise was never limited. It was always a story big enough to hold everything she has put into it.

## What It Means to Make the Thing You Needed

One of the consistent threads in Kiyoko's interviews about this project is the idea of making the record she needed when she was sixteen. That is a familiar creative ambition: the work as a gift to a past self that had no access to it. What distinguishes Kiyoko's execution of this idea is the scale of the project and the precision of the execution.

The song came first. Then the following that the song created. Then the recognition that the following was itself evidence of a need: that millions of people had been waiting for a story that looked like theirs. The novel and the film and the album are all responses to the same recognition, that the need was large enough to sustain more. None of the three feels like a cash-in on a catalog moment. They feel like what happens when an artist takes the thing that made them who they are and refuses to leave it alone until they have understood it completely.

The result is an album that operates at the intersection of memory, pop craft, and cultural statement without making any of those three things feel like it is in service of the other two. "girls like girls the album" works as world-building, as Kiyoko said it should. It also works as a pop record. And it works as a document of what it meant to be young and queer and in love in a world that was only beginning to learn how to see that.

Kiyoko said the album asks to be heard as world-building first and pop second. That instruction is worth following. The songs reward it.

[download:/assets/images/artists/hayley-kiyoko-girls-like-girls-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "hayley-kiyoko-girls-like-girls",
    "title": "Hayley Kiyoko Built a World Where the Love Has Always Been This Way",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-17",
    "image": "/assets/images/artists/hayley-kiyoko-girls-like-girls.jpg",
    "image_alt": "Hayley Kiyoko press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/hayley-kiyoko-girls-like-girls.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

# Verify no dashes used as punctuation
for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash character found in body: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} found')
PYEOF

echo "Post 2 JSON deployed: hayley-kiyoko-girls-like-girls.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py hayley-kiyoko-girls-like-girls "Hayley Kiyoko Built a World Where the Love Has Always Been This Way" music
echo "Social card generated: hayley-kiyoko-girls-like-girls-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/hayley-kiyoko-girls-like-girls)
echo "HTTP status artonly.io/post/hayley-kiyoko-girls-like-girls: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/hayley-kiyoko-girls-like-girls&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: hayley-kiyoko-girls-like-girls"

# ---- Outreach: Hayley Kiyoko ----
# Press contact via Virgin Music Group / One Riot Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@hayleykiyoko.com" \
  --data-urlencode "subject=ArtOnly just covered girls like girls the album" \
  --data-urlencode "body=https://artonly.io/post/hayley-kiyoko-girls-like-girls

We published a piece on Hayley Kiyoko and the new album at the link above. No ask attached. We wrote about the eleven years between the original song and this full world of novel, film, and album, the collaborators and what they signal, and what it means to make the thing you needed when you were sixteen. A downloadable social card is at the bottom of the page. Happy to arrange a conversation with Hayley if there is appetite, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Hayley Kiyoko"

##############################################################################
# Summary email
##############################################################################

python3 << 'SUMMARYEOF'
import subprocess, datetime

urls = [
    "https://artonly.io/post/olivia-rodrigo-you-seem-pretty-sad",
    "https://artonly.io/post/hayley-kiyoko-girls-like-girls",
]

subject = "ArtOnly Album Monitor: 2026-06-17"
body = (
    "Published today:\n\n"
    + "\n".join(urls)
    + "\n\nOutreach:\n"
    "  Olivia Rodrigo: sent to press@interscope.com (Geffen / UMG press)\n"
    "  Hayley Kiyoko: sent to info@hayleykiyoko.com (official site contact)\n"
    "  BCC on both: amosleblanc@gmail.com\n\n"
    "Posts: olivia-rodrigo-you-seem-pretty-sad, hayley-kiyoko-girls-like-girls\n"
    "Authors: Leelou Blanc, Allastair Voss\n"
    "Albums: you seem pretty sad for a girl so in love (June 12, 2026), girls like girls the album (June 13, 2026)"
)

result = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py',
     'amosleblanc@gmail.com', subject, body],
    capture_output=True, text=True
)
print(result.stdout)
if result.returncode != 0:
    print(f'gmail-send error: {result.stderr}')
    # Fallback: use artonly send-mail API
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

echo "=== Deploy complete: 2026-06-17 ==="
