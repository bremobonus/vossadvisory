#!/bin/bash
# ArtOnly Deploy Script: La Securite Bingo + BIG BRAVE in grief or in hope
# Generated: 2026-06-18
# Posts: la-securite-bingo, big-brave-in-grief-or-in-hope
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-18.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-18 ==="
echo "$(date)"

##############################################################################
# POST 1: La Securite - Bingo!
##############################################################################

echo "--- Deploying: la-securite-bingo ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, re, sys, os

def download_img(src, dest, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
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

def fetch_html(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(url, headers=headers)
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/la-securite-bingo.jpg'

# Try Squarespace CDN from Mothland
try:
    html = fetch_html('https://www.mothland.com/la-securite')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+squarespace[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.mothland.com/')
        print('Hero downloaded from Mothland')
        sys.exit(0)
except Exception as e:
    print(f'Mothland failed: {e}')

# Try Bella Union Shopify CDN
try:
    html = fetch_html('https://bellaunion.com/pages/la-securite')
    imgs = re.findall(r'(https?://cdn\.shopify\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://bellaunion.com/')
        print('Hero downloaded from Bella Union')
        sys.exit(0)
except Exception as e:
    print(f'Bella Union failed: {e}')

# Try Tinnitist (featured Kristin Sollecito press photo)
try:
    html = fetch_html('https://tinnitist.com/2026/06/12/albums-of-the-week-la-securite-bingo/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]*tinnitist[^\s\"\'<>]*\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://tinnitist.com/')
        print('Hero downloaded from Tinnitist')
        sys.exit(0)
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if any(k in i.lower() for k in ['securite','lasecurite','bingo','la-sec','band'])]
    if imgs:
        download_img(imgs[0], dest, referer='https://tinnitist.com/')
        print('Hero downloaded from Tinnitist (matched)')
        sys.exit(0)
except Exception as e:
    print(f'Tinnitist failed: {e}')

# Try DIY Magazine
try:
    html = fetch_html('https://diymag.com/review/album/la-securite-bingo')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'securite' in i.lower() or 'bingo' in i.lower() or 'la-sec' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://diymag.com/')
        print('Hero downloaded from DIY Magazine')
        sys.exit(0)
except Exception as e:
    print(f'DIY Magazine failed: {e}')

# Try Swim Into The Sound (Squarespace)
try:
    html = fetch_html('https://swimintothesound.com/swim-selects/2026/6/16/la-securite-bingo')
    imgs = re.findall(r'(https?://images\.squarespace-cdn\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://swimintothesound.com/')
        print('Hero downloaded from Swim Into The Sound')
        sys.exit(0)
except Exception as e:
    print(f'Swim Into The Sound failed: {e}')

# Placeholder fallback
os.system('convert -size 1200x800 gradient:\"#1a1a2e-#16213e\" -gravity center -pointsize 54 -fill white -font DejaVu-Sans -annotate 0 \"La Securite\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert la-securite-bingo.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 la-securite-bingo-up.jpg && mv la-securite-bingo-up.jpg la-securite-bingo.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/5ijO3JnnKpoAOTU4QaDgdW]

There is a particular kind of band that Montreal produces with some regularity. The kind that cannot be described in genre terms without the description being immediately inadequate. They exist at the intersection of everything and play with the confidence of people who have already decided that genre categories are someone else's problem. La Securite is that kind of band.

Their debut album Stay Safe! arrived in 2023 and made the Polaris Music Prize longlist the following year, which is significant for a band operating somewhere between art punk and the outer rim of pop, trading in a bilingual French and English fluency that positions them precisely in the Montreal cultural tradition of refusing to choose. The Polaris recognition confirmed what anyone who had seen them live already understood. This is a band with serious intentions dressed in clothes that look like a party.

Bingo! (June 12, 2026, Bella Union worldwide and Mothland in Canada and the United States) is their second full album, and it accelerates the argument they started on the first one. The five members, vocalist and multi-instrumentalist Eliane Viens-Synnott, bassist and producer Felix Belisle, guitarist Melissa Di Menna, guitarist and vocalist Laurence-Anne Charest-Gagne, and drummer and guitarist Kenny Smith, have been playing together long enough that the record sounds like collective thought rather than individual contributions arranged together. That is harder to achieve than it sounds. Most bands never get there.

## Why the Sophomore Record Was the Right Moment

The pressure of a second album is often misunderstood. Critics describe it as a test of whether the debut was a fluke. That framing is not particularly useful. The more interesting question is what an artist does with the specific freedom that comes from having made one record already. The first record is an introduction. The second record is the first real statement of intent, made with the knowledge of who is listening and what they are expecting.

La Securite uses the space Bingo! opens with remarkable directness. The record has no interest in consolidating the territory they claimed on Stay Safe! Instead it pushes further into the instability. The polyrhythms that resist the anticipated beat. The chord changes that land sideways. The vocal arrangements that treat melody as a container to be distorted rather than a path to be followed. The comparison to the B-52s and Devo that critics reach for is useful to a point. Those bands understood that pop could be treated as a site of formal experimentation without losing its essential pleasure principle. La Securite understands the same thing.

But they are also doing something neither of those reference points quite accounts for. The bilingual texture of the record, English and French moving between and within tracks without explanation, is not a stylistic choice in the decorative sense. It reflects the actual condition of the band's cultural situation. Making music from a city that contains two linguistic traditions and refuses to treat that as a problem to be resolved. That refusal is an act of cultural confidence that runs through everything the band does, the way they arrange songs, the way the vocals layer, the way the record addresses its listener as someone already located inside the situation rather than someone being introduced to it from outside.

## What the Songs Are Actually About

The tracklist for Bingo! runs ten songs and covers a range of subjects that could look, on paper, like a randomized selection of contemporary concern. Mental health. Dysfunctional relationships. Food. The autonomy of women. Mundane daily experience. And a closing tribute to elderly people on the title track itself. That range is not evidence of thematic incoherence. It is evidence of a band that is interested in the full texture of human experience rather than a single emotional register.

Power Snoozer addresses mental health without the confessional mode that has become the default register for that subject in contemporary music. It treats the subject as ordinary, which is what it actually is. Something that sits alongside food preferences and relationship dynamics and the experience of watching the world from a position that does not require you to find it consistently meaningful. Princesse is more explicitly political in its argument about the autonomy of women, which arrives in the context of the album's overall tone of friendly aggression. The record is not angry in the way that makes people uncomfortable, but it is not neutral either.

Ketchup and Snack City treat food and mundane experience with the same seriousness that other tracks give to larger subjects. This is the record's most pointed formal argument. The energy brought to Snack City is identical to the energy brought to Power Snoozer. The production, which is tight and kinetic throughout, does not distinguish between trivial and significant content. Everything gets the same treatment. That leveling is a statement about what deserves musical attention, which is to say everything, the whole range of experience without hierarchy.

## The Bella Union Signing and What It Signals

La Securite's arrangement with Bella Union for international releases and Mothland for Canada and the United States is not a conventional major label situation. Bella Union was founded in 1997 by Simon Raymonde and Sheryl Marden and has operated consistently as a home for music that does not fit existing commercial categories. Their roster over the years has included Beach House, Father John Misty, Daughter, and Anna Calvi. Artists who share a commitment to working outside the mainstream without positioning themselves explicitly against it.

The partnership makes sense for La Securite because it gives them international reach without requiring them to negotiate the terms of their music with anyone who needs it to be more legible. The record sounds exactly as difficult and exactly as fun as it should. There is no smoothing. The production, credited to Felix Belisle in collaboration with the band, preserves the live intensity that has always made their shows effective. Bingo! sounds like a band playing in a room, which is unusual in contemporary production, where most records sound like a simulation of a band playing in a room.

## The Quality That Cannot Be Named

There is something in Bingo! that is genuinely difficult to name and that constitutes the record's most significant achievement. The record is fun. It is also demanding. These are usually treated as mutually exclusive qualities in discussions of contemporary music, where fun is associated with accessibility and demanding is associated with importance. La Securite refuses the opposition.

The record asks you to work, to track the polyrhythms and follow the logic of chord changes that do not land where you expect, and it rewards that work with genuine pleasure. Not the pleasure of difficulty overcome, but the pleasure of a party where the conversation is actually interesting. The room is moving and the people in it are saying something real.

That is what Montreal produces with some regularity. From Godspeed You Black Emperor through Wolf Parade through a longer list of bands that have used the city's specific cultural situation as material for something larger than local concern. Bingo! places La Securite in that conversation, not because it sounds like any of those bands, but because it carries the same refusal to settle for less than what the form is capable of.

[download:/assets/images/artists/la-securite-bingo-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "la-securite-bingo",
    "title": "La Securite Made the Sophomore Record That Goes Faster Than You Can Follow",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-18",
    "image": "/assets/images/artists/la-securite-bingo.jpg",
    "image_alt": "La Securite press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/la-securite-bingo.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash character found: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} found')
PYEOF

echo "Post 1 JSON deployed: la-securite-bingo.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py la-securite-bingo "La Securite Made the Sophomore Record That Goes Faster Than You Can Follow" music
echo "Social card generated: la-securite-bingo-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/la-securite-bingo)
echo "HTTP status artonly.io/post/la-securite-bingo: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/la-securite-bingo&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: la-securite-bingo"

# ---- Outreach: La Securite ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@mothland.com" \
  --data-urlencode "subject=ArtOnly just covered La Securite and Bingo!" \
  --data-urlencode "body=https://artonly.io/post/la-securite-bingo

We published a piece on La Securite and the new album at the link above. No ask attached. We wrote about what Bingo! does with sophomore pressure, the bilingual texture of the record and what it signals culturally, the Bella Union partnership, and why the range of subjects is the record's most pointed formal argument. A downloadable social card is at the bottom of the page. Happy to connect with the band if there is appetite, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for La Securite"

##############################################################################
# POST 2: BIG|BRAVE - in grief or in hope
##############################################################################

echo "--- Deploying: big-brave-in-grief-or-in-hope ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, re, sys, os

def download_img(src, dest, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
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

def fetch_html(url, referer=None):
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    }
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(url, headers=headers)
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/big-brave-in-grief-or-in-hope.jpg'

# Try official BIG BRAVE site
try:
    html = fetch_html('http://www.bigbrave.ca/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bigbrave' in i.lower() or 'big-brave' in i.lower() or 'brave' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='http://www.bigbrave.ca/')
        print('Hero downloaded from bigbrave.ca')
        sys.exit(0)
except Exception as e:
    print(f'bigbrave.ca failed: {e}')

# Try Thrill Jockey artist page
try:
    html = fetch_html('https://www.thrilljockey.com/artists/big-brave')
    imgs = re.findall(r'(https?://cdn\.shopify\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thrilljockey.com/')
        print('Hero downloaded from Thrill Jockey')
        sys.exit(0)
except Exception as e:
    print(f'Thrill Jockey failed: {e}')

# Try Devolution Magazine article
try:
    html = fetch_html('https://devolutionmagazine.co.uk/2026/06/12/news-bigbrave-release-transcendent-new-album-in-grief-or-in-hope-out-today-via-thrill-jockey/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bigbrave' in i.lower() or 'big-brave' in i.lower() or 'brave' in i.lower() or 'grief' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
        imgs = [i for i in imgs if 'wp-content' in i.lower() or 'upload' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://devolutionmagazine.co.uk/')
        print('Hero downloaded from Devolution Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Devolution Magazine failed: {e}')

# Try Southern Lord (former label still hosts photos)
try:
    html = fetch_html('https://southernlord.com/band/bigbrave/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bigbrave' in i.lower() or 'big-brave' in i.lower() or 'brave' in i.lower() or 'wp-content' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://southernlord.com/')
        print('Hero downloaded from Southern Lord')
        sys.exit(0)
except Exception as e:
    print(f'Southern Lord failed: {e}')

# Try Everything Is Noise review
try:
    html = fetch_html('https://everythingisnoise.net/reviews/big-brave-in-grief-or-in-hope/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'bigbrave' in i.lower() or 'brave' in i.lower() or 'grief' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://everythingisnoise\.net/[^\s\"\'<>]+\.(?:jpg|jpeg|png))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://everythingisnoise.net/')
        print('Hero downloaded from Everything Is Noise')
        sys.exit(0)
except Exception as e:
    print(f'Everything Is Noise failed: {e}')

# Try Wikimedia Commons
try:
    url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Big_Brave_at_Basilica_Hudson_2022.jpg/800px-Big_Brave_at_Basilica_Hudson_2022.jpg'
    download_img(url, dest)
    print('Hero downloaded from Wikimedia Commons')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia failed: {e}')

# Placeholder fallback
os.system('convert -size 1200x800 gradient:\"#0d0d0d-#1a1a1a\" -gravity center -pointsize 54 -fill white -font DejaVu-Sans -annotate 0 \"BIG BRAVE\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale hero image ----
cd /home/dh_yadmw3/artonly.io/assets/images/artists
OMP_NUM_THREADS=1 convert big-brave-in-grief-or-in-hope.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 big-brave-in-grief-or-in-hope-up.jpg && mv big-brave-in-grief-or-in-hope-up.jpg big-brave-in-grief-or-in-hope.jpg
echo "Hero image upscaled"
cd ~

# ---- Write post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/5nlpqhz47LYv7KvarJdh44]

BIG BRAVE has been operating at the intersection of drone, experimental rock, and what might simply be called force for over a decade. Robin Wattie and Mathieu Ball formed the band in Montreal in 2012, and their catalog from Feral Verdure (2014) through the Polaris-longlisted trio of Vital (2021), nature morte (2023), and A Chaos of Flowers (2024) represents one of the most consistent bodies of work in contemporary experimental music. Consistent is the wrong word, actually. The work has developed in specific directions. Each record finding new formal solutions to the same essential problem: how to use volume and silence and the sustained note as emotional language.

In grief or in hope (June 12, 2026, Thrill Jockey Records) arrives as the first BIG BRAVE studio record without their longtime drummer Tasy Hudson, who has stepped back from the band. In Hudson's absence, touring bassist Liam Andrews, also known from the Australian collective MY DISCO, joins Wattie and Ball as a full member for the first time on a studio recording. This is not a minor development in formal terms. The rhythm section has always been the engine of BIG BRAVE's dynamics, the structure against which the guitar drone and Wattie's voice could create tension. An album without drums is not an absence. It is a choice about where the weight lives.

## The Shape of the Thing

Eight tracks, forty-four minutes, titles that read like fragments of an unresolved argument. What May Be the Kindest Way to Leave opens the record at seven and a half minutes, which is not the running time of a song that intends to be easy. The Ineptitude for Mutual Discernment is not a title that offers comfort. An Uttering of Antipathy runs almost seven minutes and is not, presumably, about gratitude. These are titles that come from a tradition of taking the album object seriously as a formal container for specific emotional content. They announce what kind of record this is before the first note plays.

What the record actually sounds like is harder to describe than what it is about. Wattie has said that she wanted to explore catchy, melodic phrasing as a contrast to the sheer weight of the instrumentation. The phrase critics have used is reverse-engineered pop structures, which is a useful formulation. What you hear on in grief or in hope is melody arriving through walls of guitar. It is not the melody of a pop song that has been distorted. It is the idea of melody discovered inside a material that seems to resist it. That discovery is the emotional content of the record.

Wattie's voice has always been the most immediately human element of BIG BRAVE's sound, the thing that keeps the drone from collapsing entirely into abstraction. On this record she leans further into that role than on any previous album. The vocal phrasing is more direct, more present, which creates a specific kind of tension with the instrumentation. The guitars and bass operate at a scale that suggests geological formation. The voice operates at human scale. The album lives in that gap.

## What Grief and Hope Actually Share

The title of the record is not a contrast. Grief and hope are not opposites in the way that the word "or" might suggest. They are, in the experience of actually living through loss, two aspects of the same orientation toward the future. You hope because you grieve. You grieve because you hoped. The album treats this relationship as its central subject, returning repeatedly to the body as the location where this experience happens. Not as abstraction but as weight, as physical condition, as something that happens to a person who cannot step outside themselves to observe it from a safer distance.

Holding Tongue is one of the record's more contained moments, a track whose restraint feels earned rather than imposed. The title names something that anyone who has tried to navigate grief in the presence of others will recognize. The things you do not say because saying them would require the other person to respond, and you are not yet ready for response. Verdure appears as a title in BIG BRAVE's catalog, the name of their earliest full-length from 2014, and its reappearance here suggests that the album is in some sense a conversation with the body of work that preceded it. Skin Ripper is the most aggressive title on a record that is, in its emotional content, about vulnerability. The aggression in the language coexists with the emotional openness of Wattie's delivery. This coexistence is the record's most consistent formal strategy. The sounds that seem like violence contain something that is not violence. The sounds that seem soft carry weight.

## Polaris, Thrill Jockey, and the Long Project

Three Polaris Music Prize longlist nominations across four years constitute a specific kind of critical recognition. The Polaris Prize weights artistic ambition above commercial performance, and BIG BRAVE's nominations reflect a sustained assessment by Canadian music critics that this is work that matters in a way that extends beyond its audience size. The nominations also represent a progressive critical engagement with experimental music that sits, categorically, closer to metal than to indie rock or pop, which are the genres that tend to dominate Polaris consideration.

Thrill Jockey Records, their label since 2021, has been one of the more thoughtful homes for experimental music in North America since its founding in Chicago in 1992. Their roster over three decades has included Tortoise, Trans Am, Bitchin Bajas, and Calexico. Artists for whom the formal possibilities of their chosen instruments are the primary creative concern. BIG BRAVE fits this roster not as a stylistic match but as a commitment: the commitment to treating the record as a space for discovery rather than a container for something already known.

In grief or in hope is their most melodic record and their most emotionally direct, which means it is also their most exposed. Wattie and Ball have spent twelve years building a sound that uses volume as armor. This record removes some of the armor. What is underneath is what the title names: the grief that is already present in any hope that is still active, and the hope that is the only condition under which grief can eventually complete its work.

The album arrived the same week as La Securite's Bingo!, and the two records could not occupy more different positions on the formal spectrum of what music can do. Both are from Montreal. Both are committed to a version of the form that takes the form seriously. The coincidence is pleasing in the way that a city producing two entirely different answers to the same question is always pleasing. The question is what music is for. The answers, in both cases, are worth hearing.

[download:/assets/images/artists/big-brave-in-grief-or-in-hope-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "big-brave-in-grief-or-in-hope",
    "title": "BIG BRAVE Removed the Drums and Found Out What the Voice Had Been Carrying All Along",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-18",
    "image": "/assets/images/artists/big-brave-in-grief-or-in-hope.jpg",
    "image_alt": "BIG BRAVE press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/big-brave-in-grief-or-in-hope.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')

for dash in ['—', '–']:
    if dash in body:
        print(f'WARNING: dash character found: {repr(dash)}')
    else:
        print(f'OK: no {repr(dash)} found')
PYEOF

echo "Post 2 JSON deployed: big-brave-in-grief-or-in-hope.json"

# ---- Generate social card ----
cd ~/artonly.io/agent
python3 make-social-card.py big-brave-in-grief-or-in-hope "BIG BRAVE Removed the Drums and Found Out What the Voice Had Been Carrying All Along" music
echo "Social card generated: big-brave-in-grief-or-in-hope-social-9x16.jpg"
cd ~

# ---- Verify post live ----
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/big-brave-in-grief-or-in-hope)
echo "HTTP status artonly.io/post/big-brave-in-grief-or-in-hope: $STATUS"

# ---- IndexNow ----
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/big-brave-in-grief-or-in-hope&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: big-brave-in-grief-or-in-hope"

# ---- Outreach: BIG|BRAVE ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@thrilljockey.com" \
  --data-urlencode "subject=ArtOnly just covered BIG BRAVE and in grief or in hope" \
  --data-urlencode "body=https://artonly.io/post/big-brave-in-grief-or-in-hope

We published a piece on BIG BRAVE and the new album at the link above. No ask attached. We wrote about what the record does formally without a drummer, the way Wattie's voice works differently at the center of the sound, the relationship between grief and hope in the album's emotional architecture, and what the Polaris nominations and the Thrill Jockey partnership say about where the band stands. A downloadable social card is at the bottom of the page. Happy to connect with the band or management if there is appetite, just reply here.

Leelou Blanc
ArtOnly (artonly.io)" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for BIG BRAVE"

##############################################################################
# Summary email
##############################################################################

python3 << 'SUMMARYEOF'
import subprocess, os

urls = [
    "https://artonly.io/post/la-securite-bingo",
    "https://artonly.io/post/big-brave-in-grief-or-in-hope",
]

subject = "ArtOnly Album Monitor: 2026-06-18"
body = (
    "Published today:\n\n"
    + "\n".join(urls)
    + "\n\nOutreach:\n"
    "  La Securite: sent to info@mothland.com (Mothland Records)\n"
    "  BIG BRAVE: sent to info@thrilljockey.com (Thrill Jockey Records)\n"
    "  BCC on both: amosleblanc@gmail.com\n\n"
    "Posts: la-securite-bingo, big-brave-in-grief-or-in-hope\n"
    "Authors: Allastair Voss (La Securite), Leelou Blanc (BIG BRAVE)\n"
    "Albums: Bingo! (June 12, 2026, Bella Union/Mothland), in grief or in hope (June 12, 2026, Thrill Jockey)"
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

echo "=== Deploy complete: 2026-06-18 ==="
