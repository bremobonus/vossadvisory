#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-26
# Posts: myles-smith-my-mess-my-heart-my-life, chloe-timbaland-resurrection
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-26.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-26 ==="


# ---- POST 1: Myles Smith - My Mess, My Heart, My Life ----
echo "--- Deploying: myles-smith-my-mess-my-heart-my-life ---"

if [ -f ~/artonly.io/posts/myles-smith-my-mess-my-heart-my-life.json ]; then
  echo "Post already exists: myles-smith-my-mess-my-heart-my-life.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/myles-smith-my-mess-my-heart-my-life.jpg'

try:
    html = fetch('https://www.clashmusic.com/news/myles-smith-confirms-debut-album-my-mess-my-heart-my-life/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'myles' in i.lower() or 'smith' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+clashmusic[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine news')
        sys.exit(0)
except Exception as e:
    print(f'Clash news failed: {e}')

try:
    html = fetch('https://www.rollingstone.co.uk/music/album-reviews/myles-smith-my-mess-my-heart-my-life-review-62109/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'myles' in i.lower() or 'smith' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+rollingstone[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.rollingstone.co.uk/')
        print('Downloaded from Rolling Stone UK')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone UK failed: {e}')

try:
    html = fetch('https://www.clashmusic.com/reviews/myles-smith-my-mess-my-heart-my-life/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'myles' in i.lower() or 'smith' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine review')
        sys.exit(0)
except Exception as e:
    print(f'Clash review failed: {e}')

try:
    html = fetch('https://www.nme.com/artists/myles-smith/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'myles' in i.lower() or 'smith' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

try:
    html = fetch('https://shepherdexpress.com/music/album-reviews/my-mess-my-heart-my-life-by-myles-smith/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'myles' in i.lower() or 'smith' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://shepherdexpress.com/')
        print('Downloaded from Shepherd Express')
        sys.exit(0)
except Exception as e:
    print(f'Shepherd Express failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#080808-#141414\" -gravity center -pointsize 52 -fill white -annotate 0 \"Myles Smith\" \"{dest}\"')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/myles-smith-my-mess-my-heart-my-life.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/myles-smith-my-mess-my-heart-my-life-up.jpg && \
  mv ~/artonly.io/assets/images/artists/myles-smith-my-mess-my-heart-my-life-up.jpg \
     ~/artonly.io/assets/images/artists/myles-smith-my-mess-my-heart-my-life.jpg
echo "Image upscaled: myles-smith-my-mess-my-heart-my-life.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py myles-smith-my-mess-my-heart-my-life "Myles Smith Finds the Album His Breakthrough Was Always Pointing Toward" music
echo "Social card generated: myles-smith-my-mess-my-heart-my-life-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/3bO19AOone0ubCsfDXDtYt]

The story of "Stargazing" is a story the music industry did not know how to tell in 2024. Myles Smith recorded the song in a bedroom in Warwickshire with a production budget that cost less than most people spend on dinner out, uploaded it without infrastructure or label support, and watched it become the most streamed song by a UK artist globally that year. It passed one billion plays on Spotify. It reached number four in the UK charts. It topped the US Alternative Airplay chart. It became the kind of song people describe as having gotten them through something specific, the kind they play at significant moments in their lives with an intention that was never planned. None of this was the plan because there was no plan. Myles Smith had never made a plan that looked like this because no plan available to him would have imagined it possible.

That is the context in which "My Mess, My Heart, My Life," his debut album, arrives. Released June 19 via RCA Records, the twelve-track record is not simply the fulfillment of the promise of a breakthrough single. It is the attempt by an artist who became famous before he had developed a framework for fame to account for what happened to him, and what was already happening before anyone was listening.

## The Specificity That Made Him

What made "Stargazing" work was not its production, which was minimal to the point of deliberate restraint. It was the specificity of its emotional content: the song was about a very particular quality of longing, the kind that attaches to a person who might not even know you in the same way you know them, and it described that quality with enough precision that listeners recognized themselves in it without being told to. This is not a common skill. The music industry produces enormous quantities of songs about longing that achieve nothing but the outline of the feeling, a sketch without the weight. Smith put the weight in. That was what distinguished him.

The album extends this specificity into territory that is considerably harder. The opening track, "My Mess," addresses childhood abuse and family trauma in language that does not soften itself for the listener's comfort. Smith does not frame these experiences within a narrative of triumph over adversity, a redemption arc, a healing that has completed itself. He frames them as ongoing presences in a life that is nonetheless being lived with attention and intention. This is braver than it sounds. The music industry also produces enormous quantities of songs about difficult experiences that resolve themselves into messages of affirmation, and there is nothing wrong with that impulse. But it is a different and more demanding act to present a difficult experience as one that is still happening, still shaping the person doing the presenting, still available as content rather than as history.

## Five UK Top 40 Hits and What They Signal

Five tracks on the album had already reached the UK Top 40 before the full record arrived. This is unusual. It signals the degree to which Smith had been building his audience incrementally, releasing singles that found their way onto the chart not through the conventional mechanisms of playlist placement and radio promotion but through genuine listener attachment. "Nice to Meet You" reached number six. "Drive Safe," his collaboration with Niall Horan, reached number twenty-seven. "Gold" represents a different register in Smith's catalog, something brighter and more directly anthemic than his baseline emotional mode.

The significance of these chart positions is not about commercial validation in the conventional sense. It is about the relationship between the music and its audience, which appears to be unusually direct. Smith's listeners listen because they have chosen to, not because the song was placed in front of them by an algorithm that determined their taste and served them accordingly. This is not always the case with chart success, and its presence here suggests that the album has a foundation that does not depend on the machinery of promotion for its stability.

## The Tradition He Inhabits and Escapes

There is a tradition of British singer-songwriters who achieve large commercial success while maintaining a relationship to emotional directness that separates them from the more ironic strains of UK guitar music. This tradition includes figures whose appeal crosses genre categories precisely because they refuse the protection that genre affiliation provides. You do not listen to them because they sound like your favorite band. You listen to them because the song reached you before you had time to organize your defenses.

Smith inhabits this tradition while also escaping it in a specific way. The music on this album draws from folk, from R&B, from post-2010s bedroom pop, but it does not align itself definitively with any of those categories. It sounds like someone who listened to everything available to his generation and then made something that reflects the listening rather than imitating any specific source. The result is music that does not announce its influences, that does not perform genre membership, that simply sounds like the person who made it at the specific moment of its making.

## An Arrival That Did Not Know It Was Coming

The record does not signal neat endings. Smith has said in interviews that the album tracks a journey of discovery that has not resolved itself, and the music supports this reading. The songs are not conclusive in the way that traditional album arcs tend to be. They do not move from darkness into light. They move from one register of attention to another, and the attention itself is the constant rather than the emotional direction.

This is the correct choice for an artist who arrived at this moment in the way Smith did. An album that performed resolution would be dishonest about where he actually is. What "My Mess, My Heart, My Life" performs instead is something rarer and more useful: the quality of attention that makes the mess, the heart, and the life visible enough to be held. That is what "Stargazing" promised. This album keeps it.

[download:/assets/images/artists/myles-smith-my-mess-my-heart-my-life-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "myles-smith-my-mess-my-heart-my-life",
    "title": "Myles Smith Finds the Album His Breakthrough Was Always Pointing Toward",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-26",
    "image": "/assets/images/artists/myles-smith-my-mess-my-heart-my-life.jpg",
    "image_alt": "Myles Smith press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/myles-smith-my-mess-my-heart-my-life.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: myles-smith-my-mess-my-heart-my-life.json")
PYEOF

# Verify live
echo "Verifying myles-smith-my-mess-my-heart-my-life..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/myles-smith-my-mess-my-heart-my-life)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/myles-smith-my-mess-my-heart-my-life&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: myles-smith-my-mess-my-heart-my-life"

fi  # end skip block


# ---- POST 2: Chloe & Timbaland - Resurrection ----
echo "--- Deploying: chloe-timbaland-resurrection ---"

if [ -f ~/artonly.io/posts/chloe-timbaland-resurrection.json ]; then
  echo "Post already exists: chloe-timbaland-resurrection.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/chloe-timbaland-resurrection.jpg'

try:
    html = fetch('https://ratedrnb.com/2026/06/chloe-timbaland-resurrection-mixtape/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'resurrection' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+ratedrnb[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ratedrnb.com/')
        print('Downloaded from Rated R&B')
        sys.exit(0)
except Exception as e:
    print(f'Rated RnB failed: {e}')

try:
    html = fetch('https://www.clashmusic.com/news/chloe-bailey-timbaland-align-on-new-mixtape-resurrection/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'resurrection' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+clashmusic[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine news')
        sys.exit(0)
except Exception as e:
    print(f'Clash news failed: {e}')

try:
    html = fetch('https://soulbounce.com/2026/06/chloe-timbaland-talking-dirty-video-resurrection-mixtape/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'timbaland' in i.lower() or 'resurrection' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+soulbounce[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://soulbounce.com/')
        print('Downloaded from SoulBounce')
        sys.exit(0)
except Exception as e:
    print(f'SoulBounce failed: {e}')

try:
    html = fetch('https://thatgrapejuice.net/2026/06/chloe-bailey-timbaland-unveil-resurrection-mixtape-tracklist/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'resurrection' in i.lower() or 'timbaland' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://thatgrapejuice.net/')
        print('Downloaded from That Grape Juice')
        sys.exit(0)
except Exception as e:
    print(f'That Grape Juice failed: {e}')

try:
    html = fetch('https://www.aceshowbiz.com/news/view/00259250.html')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'timbaland' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\' <>]+aceshowbiz[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.aceshowbiz.com/')
        print('Downloaded from Aceshowbiz')
        sys.exit(0)
except Exception as e:
    print(f'Aceshowbiz failed: {e}')

try:
    html = fetch('https://hypehair.com/21426/chloe-bailey-timbaland-resurrection-mixtape/')
    imgs = re.findall(r'(https?://[^\s\"\' <>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chloe' in i.lower() or 'timbaland' in i.lower() or 'resurrection' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://hypehair.com/')
        print('Downloaded from Hype Hair')
        sys.exit(0)
except Exception as e:
    print(f'Hype Hair failed: {e}')

print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0008-#14000f\" -gravity center -pointsize 48 -fill white -annotate 0 \"Chloe x Timbaland\" \"{dest}\"')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/chloe-timbaland-resurrection.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/chloe-timbaland-resurrection-up.jpg && \
  mv ~/artonly.io/assets/images/artists/chloe-timbaland-resurrection-up.jpg \
     ~/artonly.io/assets/images/artists/chloe-timbaland-resurrection.jpg
echo "Image upscaled: chloe-timbaland-resurrection.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py chloe-timbaland-resurrection "Chloe and Timbaland Remind R&B What It Once Risked" music
echo "Social card generated: chloe-timbaland-resurrection-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/1FtBEIWAwvw5ymBen5GICR]

In 1997, Timbaland produced a song called "Are You That Somebody" for Aaliyah. The production was startling enough that it became the subject of analysis rather than simply consumption: the baby-crying sample, the skeletal rhythm that seemed to operate at its own internal tempo rather than deferring to the conventional pulse of R&B at the time, the way it created space inside the beat where the singer could move with unusual freedom. The song was not a departure from contemporary production norms so much as an argument that those norms were insufficient. It proposed a different set of possibilities for what R&B could sound like, and those possibilities were picked up by enough producers and artists in the years that followed that the argument was effectively won.

Timbaland's subsequent catalog proved the argument repeatedly: Missy Elliott's "The Rain," Justin Timberlake's "SexyBack," Jay-Z's "Big Pimpin," Destiny's Child's "Get on the Bus." The unifying element was not a single sonic signature but a consistent relationship to rhythm and space, a willingness to build beats that did not resolve their tension in the expected places, that held the listener in a state of forward momentum by refusing to give them the landing they were anticipating. This is extremely difficult to do and to sustain across a decade of commercial releases, and it is why Timbaland's production from roughly 1997 to 2008 remains as immediately recognizable as it was when the records were new.

Chloe Bailey came up under a different lineage but one that connects. Discovered by Beyonce and signed to Parkwood Entertainment as part of the duo Chloe x Halle in 2015, she received her musical formation within an environment built by someone who had worked with Timbaland during the Destiny's Child years. The sonic vocabulary that Timbaland was developing during that period was part of the air that Beyonce breathed during her formation, and that air carried forward into the infrastructure she built for the artists she mentored.

## What Resurrection Is Trying To Do

The mixtape title announces an intention clearly enough. Something is being brought back. The question worth asking is whether the revival is nostalgic in the limiting sense, an attempt to replicate a past aesthetic because the present offers insufficient alternatives, or whether it is something more interesting: an argument that specific musical capacities developed during that period are still available and still have something to say.

Released June 19 via Parkwood and Columbia Records, "Resurrection" runs twelve tracks and represents the most focused and purposeful project Chloe has released under her solo name. Her previous efforts, "In Pieces" in 2023 and "Trouble In Paradise" in 2024, were promising in ways that remained incompletely realized. There were songs on both that suggested an artist who knew what she wanted and was not always able to find the production framework that would let her reach it. The problem was not Chloe's voice, which is capable of extraordinary things, or her sense of rhythm, which is acute. The problem was architecture. Timbaland provided the architecture.

## The Record That Finally Fits

What "Resurrection" demonstrates above all is that Chloe's particular combination of vocal capacity and rhythmic sensitivity is exactly the kind of material that Timbaland's production approach was built to serve. His beats create the kind of open, pressurized space in which a voice can do more than decorate the rhythm. They require the vocalist to make choices about where to place syllables, where to hold and where to release, in ways that more conventional production does not. The decisions Chloe makes in these spaces are consistently good ones.

"Talking Dirty" and "Main Attraction" establish the framework in the album's first third: both tracks demonstrate how Timbaland's rhythmic architecture functions as a kind of musical problem that the vocal performance solves. "Jittery" represents the record's most formally inventive moment, a track that withholds conventional resolution long enough that when it arrives it carries disproportionate emotional weight. "Better Than She Can" functions as the album's emotional center, the place where Chloe's performance feels most fully inhabited rather than executed.

## The Parkwood Context and What It Demands

Chloe's Parkwood affiliation means that her career exists in permanent proximity to a very specific standard. Beyonce's cultural authority as both an artist and a businessperson is such that every artist she chooses to associate with inherits a set of expectations that most other artists do not face. This is simultaneously an advantage and a burden. The advantage is access to infrastructure, promotion, and an implicit endorsement that carries genuine cultural weight. The burden is that every release is evaluated against a standard established by someone operating at the apex of their craft over multiple decades.

What "Resurrection" does is position Chloe within a different lineage alongside the Parkwood one: the Timbaland lineage, the tradition of production-driven R&B that Aaliyah and Missy Elliott helped define, where the producer and the vocalist are genuine creative partners rather than service providers to each other. This repositioning is strategic in ways that serve the music. By inviting comparison to that tradition, Chloe is saying that she believes she can meet that standard. The mixtape argues that she is right.

## What Gets Resurrected

What "Resurrection" brings back is not a specific sound so much as a specific attitude toward what R&B can risk. The genre spent parts of the 2010s and early 2020s moving toward emotional directness and lyrical confession as its primary creative values, which produced music of genuine importance and beauty but sometimes at the expense of formal experimentation. The question of what a beat can do, what a vocal arrangement can do, what the structural relationship between production and performance can do, receded somewhat as the question of what can be said became dominant.

Timbaland has always operated on the assumption that the how and the what are inseparable, that formal choices carry meaning rather than simply containing it. "Resurrection" restores that assumption to the center of what Chloe is doing, and the music is better for it. Not because emotional directness is wrong but because it has more room to operate when it is supported by production that is itself doing something complex.

This is a record about what R&B knows and sometimes forgets. It is also the Chloe record that the better songs on her previous projects suggested was possible but deferred. Timing, which is everything in music, was waiting for a collaborator who understood the problem and had the tools to solve it.

[download:/assets/images/artists/chloe-timbaland-resurrection-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "chloe-timbaland-resurrection",
    "title": "Chloe and Timbaland Remind R&B What It Once Risked",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-26",
    "image": "/assets/images/artists/chloe-timbaland-resurrection.jpg",
    "image_alt": "Chloe press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/chloe-timbaland-resurrection.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: chloe-timbaland-resurrection.json")
PYEOF

# Verify live
echo "Verifying chloe-timbaland-resurrection..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/chloe-timbaland-resurrection)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/chloe-timbaland-resurrection&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: chloe-timbaland-resurrection"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@rcarecords.co.uk" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Myles Smith and the debut album My Mess, My Heart, My Life at artonly.io/post/myles-smith-my-mess-my-heart-my-life. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@rcarecords.co.uk (Myles Smith)"

curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@parkwoodentertainment.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Chloe and the Resurrection mixtape with Timbaland at artonly.io/post/chloe-timbaland-resurrection. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@parkwoodentertainment.com (Chloe)"


# ---- Summary email ----
python3 << 'PYEOF'
import subprocess

body = """Published today:

1. Myles Smith - My Mess, My Heart, My Life
   https://artonly.io/post/myles-smith-my-mess-my-heart-my-life
   Author: Leelou Blanc
   Spotify ID: 3bO19AOone0ubCsfDXDtYt
   Released: June 19, 2026 (RCA Records)
   UK debut album, indie-soul, 1B+ streams on Stargazing

2. Chloe & Timbaland - Resurrection
   https://artonly.io/post/chloe-timbaland-resurrection
   Author: Allastair Voss
   Spotify ID: 1FtBEIWAwvw5ymBen5GICR
   Released: June 19, 2026 (Parkwood/Columbia Records)
   12-track mixtape, production-driven R&B revival

Outreach:
- Myles Smith: email sent to press@rcarecords.co.uk
- Chloe: email sent to press@parkwoodentertainment.com

Both releases from June 19, 2026. Neither was previously covered on ArtOnly."""

subprocess.run([
    'python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py',
    'amosleblanc@gmail.com',
    'ArtOnly Album Monitor: 2026-06-26',
    body
], check=True)
print("Summary email sent to amosleblanc@gmail.com")
PYEOF

echo "=== Deploy complete: 2026-06-26 ==="
