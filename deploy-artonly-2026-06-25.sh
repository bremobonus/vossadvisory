#!/bin/bash
# ArtOnly Deploy Script: Myles Smith + Hard-Fi
# Generated: 2026-06-25
# Posts: myles-smith-my-mess-my-heart-my-life, hard-fi-sweating-someone-elses-fever
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-25 Myles Smith + Hard-Fi ==="

IMGDIR="$HOME/artonly.io/assets/images/artists"

# ===== MYLES SMITH =====
echo "--- Deploying: myles-smith-my-mess-my-heart-my-life ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, sys, os, json, re

def download_img(src, dest, referer=None, accept='image/jpeg,image/jpg,image/*;q=0.8'):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': accept,
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

dest = os.path.expandvars('\$IMGDIR/myles-smith-my-mess-my-heart-my-life.jpg')

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Myles_Smith_(musician)'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

try:
    download_img(
        'https://www.mylessmith.co.uk/wp-content/uploads/myles-smith-press.jpg',
        dest,
        referer='https://www.mylessmith.co.uk/'
    )
    print('Hero downloaded from official site')
    sys.exit(0)
except Exception as e:
    print(f'Official site failed: {e}')

try:
    download_img(
        'https://rcarecords.co.uk/wp-content/uploads/myles-smith-press-2024.jpg',
        dest,
        referer='https://rcarecords.co.uk/'
    )
    print('Hero downloaded from RCA Records')
    sys.exit(0)
except Exception as e:
    print(f'RCA failed: {e}')

import os as _os
_os.system('convert -size 1200x800 gradient:\"#0d1117-#1a2744\" -gravity center -pointsize 56 -fill white -annotate 0 \"Myles Smith\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale Myles Smith hero ----
OMP_NUM_THREADS=1 convert "$IMGDIR/myles-smith-my-mess-my-heart-my-life.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/myles-smith-my-mess-my-heart-my-life-up.jpg" && mv "$IMGDIR/myles-smith-my-mess-my-heart-my-life-up.jpg" "$IMGDIR/myles-smith-my-mess-my-heart-my-life.jpg"
echo "Myles Smith hero upscaled"

# ---- Write Myles Smith post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/3bO19AOone0ubCsfDXDtYt]

One billion streams is a number that changes what a debut album can be. Myles Smith hit that figure with Stargazing, a song he wrote in Malibu shortly after signing with RCA Records, before he had made a single album. It soundtracked a quarter million TikTok videos, certified three times platinum in the UK, and quietly began drafting the terms under which everything that followed would be received. The pressure this created for My Mess, My Heart, My Life was not the pressure of obscurity. It was the pressure of abundance, the particular difficulty of making something honest when a large audience has already decided what it wants to hear from you.

What Smith made is not what anyone waiting for another Stargazing would have ordered. It is closer to a testimony. The album title is its own table of contents: three categories marking three territories he was not willing to leave unexamined. The wreckage, the longing, the accumulation of a life. He is twenty-seven, from Luton, the son of a British Jamaican family, and the record asks you to understand where he came from before it asks you to feel anything about where he is now.

## The Mess He Names

The album opens on its hardest material. My Mess was written in part from transcripts of Smith's own therapy sessions, a detail he has made no effort to conceal. The verse that announces the album's intent references a confrontation between his father and a thirteen-year-old boy, the bruise already named, the violence placed cleanly in the past tense. The choice not to soften any of this in the first two minutes is a declaration of purpose. Smith is not performing vulnerability. He is offering documentation.

Across the album's first section, this directness never flinches. Grandma's Place returns again and again to the same geography: a house that functioned as the stable center of an unstable childhood, the way certain domestic spaces become refuges when the broader domestic environment cannot be trusted. The production under these tracks, handled largely by Peter Fenn, is careful and uncluttered, giving Smith room without padding. This is exactly the right instinct. The material does not need atmosphere. It needs clarity.

## Sertraline

The track at the center of the album is the one that will likely define how this record is remembered. Sertraline, named after the antidepressant medication, is structured around a refusal to offer a tidy recovery arc. Smith has been explicit about this in interviews. He was not interested in writing a song that showed someone getting better in the way that recovery is typically sold to an audience. He wanted to document the cycle: the way things improve, and then decline again without warning, and then improve, in a loop that does not resolve on a timeline anyone controls.

This is a more honest account of what living with depression actually looks like than most contemporary pop will allow. The mainstream language around mental health in music tends toward resolution, toward the turning point named and the new day arrived. Smith leaves the ending open because his experience has been open. The track is not a wound displayed for impact. It is a record of ongoing life, which is considerably harder to write and considerably more useful to the people who need it.

The Guardian awarded the album two stars, pointing to Smith's debts to Mumford and Sons, Coldplay, and Ed Sheeran as evidence of derivativeness. Rolling Stone UK gave it four, praising the album's soul-baring honesty and its willingness to commit fully to each emotional register. Both reviews are accurate about the same record. The production does carry those influences, audibly. But influence absorbed honestly is different from imitation. Smith grew up on those records, they shaped his ear, and what he builds from them belongs to him.

## Drive Safe

The record's most commercially anticipated moment is a duet with former One Direction member Niall Horan, which Smith has been careful to distinguish from a strategic pairing. Our friendship shaped the song, he said, and hopefully you can feel it in every line. The track is built on acoustic textures and open production, and its subject is the specific anxiety of watching someone you love move through the world without you present. The ordinary terror of distance, rendered simply enough that it does not need to explain itself.

Horan's contribution is not decorative. His voice adds warmth that the song's structure requires, and the two registers in conversation do work that the lyrics alone could not. In an album mostly concerned with looking backward, Drive Safe is one of the few moments facing entirely forward.

## What Luton Made

Smith began performing at open mic nights at twelve, teaching himself guitar and piano by ear, learning music as a social practice before it was a career. This background shapes the record in ways that his streaming numbers do not. He has the instincts of someone who spent years playing for whoever was in the room, learning to communicate directly rather than impressively.

Luton is a city that tends to appear in British cultural discourse as a transit point or a statistic. Smith carries that geography in the album without making it a thesis. The class consciousness is present in the texture of the family scenes, in the matter-of-fact way financial precarity and emotional unavailability are treated as adjacent conditions rather than exceptional ones. Neither is a metaphor here. Both are just conditions of the life he is documenting.

## The Arrival

A debut album made from a billion streams of accumulated expectation is supposed to be a consolidation, a delivery on the promise of the viral moment. My Mess, My Heart, My Life is something more complicated than that, and considerably less safe. It is uneven in places, and the moments where it reaches for the melodic conventions of its influences are the moments where it sounds least like itself. But the moments where it does not reach, where it simply stands still and accounts for what happened, are genuinely rare in contemporary pop.

Smith did not make the album that his streaming numbers asked for. He made the one that came from the material he had. That is a harder thing to do, and a more lasting one.

[download:/assets/images/artists/myles-smith-my-mess-my-heart-my-life-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "myles-smith-my-mess-my-heart-my-life",
    "title": "Myles Smith Arrives Where the Story Gets Hard",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-25",
    "image": "/assets/images/artists/myles-smith-my-mess-my-heart-my-life.jpg",
    "image_alt": "Myles Smith press photo",
    "image_position": "center 30%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/myles-smith-my-mess-my-heart-my-life.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
words = len(body.split())
print(f'Body word count (approx): {words}')
PYEOF

echo "Myles Smith post JSON deployed"

# ---- Generate Myles Smith social card ----
cd ~/artonly.io/agent
python3 make-social-card.py myles-smith-my-mess-my-heart-my-life "Myles Smith Arrives Where the Story Gets Hard" music
echo "Myles Smith social card generated"
cd ~

# ===== HARD-FI =====
echo "--- Deploying: hard-fi-sweating-someone-elses-fever ---"

# ---- Download hero image ----
python3 -c "
import urllib.request, sys, os, json

def download_img(src, dest, referer=None, accept='image/jpeg,image/jpg,image/*;q=0.8'):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
        'Accept': accept,
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

dest = os.path.expandvars('\$IMGDIR/hard-fi-sweating-someone-elses-fever.jpg')

try:
    api = 'https://en.wikipedia.org/api/rest_v1/page/summary/Hard-Fi'
    req = urllib.request.Request(api, headers={'User-Agent': 'ArtOnly/1.0'})
    data = json.loads(urllib.request.urlopen(req, timeout=20).read())
    img_url = data.get('originalimage', {}).get('source') or data.get('thumbnail', {}).get('source')
    if img_url:
        download_img(img_url, dest)
        print('Hero downloaded from Wikipedia')
        sys.exit(0)
except Exception as e:
    print(f'Wikipedia failed: {e}')

try:
    download_img(
        'https://www.hard-fi.com/wp-content/uploads/hard-fi-press-2026.jpg',
        dest,
        referer='https://www.hard-fi.com/'
    )
    print('Hero downloaded from hard-fi.com')
    sys.exit(0)
except Exception as e:
    print(f'hard-fi.com failed: {e}')

try:
    download_img(
        'https://www.nme.com/wp-content/uploads/2026/06/hard-fi-press-2026.jpg',
        dest,
        referer='https://www.nme.com/'
    )
    print('Hero downloaded from NME')
    sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

import os as _os
_os.system('convert -size 1200x800 gradient:\"#1a0505-#2d1a00\" -gravity center -pointsize 56 -fill white -annotate 0 \"Hard-Fi\" ' + dest)
print('Hero placeholder generated')
"

# ---- Upscale Hard-Fi hero ----
OMP_NUM_THREADS=1 convert "$IMGDIR/hard-fi-sweating-someone-elses-fever.jpg" -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 "$IMGDIR/hard-fi-sweating-someone-elses-fever-up.jpg" && mv "$IMGDIR/hard-fi-sweating-someone-elses-fever-up.jpg" "$IMGDIR/hard-fi-sweating-someone-elses-fever.jpg"
echo "Hard-Fi hero upscaled"

# ---- Write Hard-Fi post JSON ----
python3 << 'PYEOF'
import json, os

body = """\
[spotify:artist/14Gi3Uph96lpNB3utkoVAD]

In El Salvador there is a saying: do not sweat someone else's fever. Do not make yourself sick over a war that was never yours to fight. Richard Archer found this phrase somewhere during fifteen years of not making a Hard-Fi record, and it became the title of the album that ended that silence. This is either philosophy the band earned through experience or a lucky piece of framing. In either case it describes exactly what Sweating Someone Else's Fever sounds like: four people from Surrey playing music because they want to, without the accumulated obligation of what they are supposed to represent.

Hard-Fi's history with the British music press carries a particular weight. Stars of CCTV arrived in 2005 with the kind of attention that turns a band into a referendum on something larger than itself. Working-class four-piece from Staines-upon-Thames. Recorded in a bedroom, a pub, a railway arch. Cash Machine on daytime Radio One, the lyric about going to the ATM and finding out the money is gone. Critics reached for The Clash in a Vauxhall, sometimes as praise, sometimes as an accusation that precision about working poverty is not the same as politics. Their second album reached number one in the UK. Their third debuted at number nine. And then nothing, for fifteen years, which is its own kind of statement.

## The Weight of a Gap

A fifteen-year silence from a band at Hard-Fi's level in 2011 is not neutral. It is not simply time passing. It is the industry telling a story about what is sustainable, about which trajectories curve upward and which ones bend away. Killer Sounds arrived to decidedly quieter notices than Once Upon a Time in the West. The critical arc bends downward and then either you become an oldies circuit act or you disappear. Hard-Fi chose something closer to disappearance, and the return is consequential precisely because it was not inevitable.

The record was made at Cherry Lips, an old taxi office converted into a studio in Staines, the town where all four members of the band are from and where they have remained. Richard Archer, Ross Phillips, Kai Stephens, Steve Kemp. Four men from Surrey who still know each other well enough to make music together without negotiating what kind of band they are trying to be. The album's origin story is almost too good: Archer's ten-year-old son stitched together two old demos on a laptop, got the tempos colliding, and occasionally produced something that sounded genuinely fresh. We did it all properly and suddenly it sounded really fresh, Archer said. The son asked where his cut was. This is approximately the energy Sweating Someone Else's Fever runs on.

## Against Nostalgia

The obvious play would have been to make Stars of CCTV 2: find the social commentary angle on 2026, write the working-poverty anthem for the streaming era, demonstrate continuity with the document that made the band's name. Hard-Fi have chosen not to do this, and the choice is consequential. Clash Magazine's review captured the tension precisely: when the band distances itself from its 2005 classic, it writes songs that sound fresh and forward-facing. When it reaches toward that template, the social commentary can feel constructed rather than lived-in.

The freshest moment on the record is Digo Nada, Spanish for I say nothing, which introduces Colombian rapper Mike Kalle over a cumbia-inflected production that Clash rightly compared to Gorillaz at their most laterally minded. It is the track that most clearly documents what fifteen years of not making records does to you: it gives you permission to make things that carry no obligation to your earlier work. The unexpectedness is what makes it good, and the confidence required to put it on a Hard-Fi record says something about where the band is now relative to where it was.

Humpback Whale addresses artificial intelligence with Archer's characteristic directness. He has said in interviews that AI could save lives, but unless the benefits are shared, it is going to be a nightmare. This is not the most nuanced take on the subject. But nuance was never what Hard-Fi offered. They offered precision at a register where other bands tend to get vague, and the song's concern with distribution rather than with the technology itself is at least the right question.

## The Limit of Return

The Clash review also names the album's honest limitation. On Cash Machine, the social commentary about working poverty felt raw because Archer wrote from inside the condition, from actual scarcity, from the specific frustration of a man who could not cover the cost of getting home. On Sweating Someone Else's Fever, the grievance on tracks like They Ain't Your Friends is angrier at the music industry and at online false allegiances than at concrete material conditions. This is a different kind of anger: the anger of someone who moved through that industry, got chewed on by it, and is now addressing it from a position of survival. It produces a different kind of song.

This is not a failing so much as a fact. You cannot make Stars of CCTV twice. Time changes what you are angry about and who you are angry at, and the album is strongest when it stops trying to locate an enemy and simply plays.

## What Unburdened Sounds Like

The two contributions from Krysten Cummings, an Olivier Award-nominated stage actress appearing on You Rule My Heart (When The Summer's Gone) and A Rose Electric, are the clearest indicator of what this band sounds like when they are building something new instead of revisiting something established. The theatrical quality she brings opens the sound rather than closing it down. These are the album's most forward-facing tracks, the ones that do not look over their shoulder at 2005.

The band have December UK dates scheduled: Brixton Academy, Birmingham, Manchester. The scale is honest, the right size for what this record is. Sweating Someone Else's Fever is not a comeback designed to reclaim a peak. It is four people from Staines playing together without the fever of other people's expectations, and it sounds exactly like that. The album title is a philosophy of creative survival. After fifteen years, Hard-Fi have stopped fighting the war that was never theirs to fight. The result is the most genuinely free music they have made.

[download:/assets/images/artists/hard-fi-sweating-someone-elses-fever-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "hard-fi-sweating-someone-elses-fever",
    "title": "Hard-Fi Return Unburdened, and It Shows",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-25",
    "image": "/assets/images/artists/hard-fi-sweating-someone-elses-fever.jpg",
    "image_alt": "Hard-Fi band press photo",
    "image_position": "center 30%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/hard-fi-sweating-someone-elses-fever.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
words = len(body.split())
print(f'Body word count (approx): {words}')
PYEOF

echo "Hard-Fi post JSON deployed"

# ---- Generate Hard-Fi social card ----
cd ~/artonly.io/agent
python3 make-social-card.py hard-fi-sweating-someone-elses-fever "Hard-Fi Return Unburdened, and It Shows" music
echo "Hard-Fi social card generated"
cd ~

# ===== UPDATE BRAIN =====
python3 << 'BRAINEOF'
import json, os

brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
try:
    with open(brain_path, 'r') as f:
        brain = json.load(f)

    written = brain.get('artists_written', [])
    for artist in ['Myles Smith', 'Hard-Fi']:
        if artist not in written:
            written.append(artist)
            print(f'Added {artist} to artists_written')
    brain['artists_written'] = written

    queue = brain.get('queue', [])
    brain['queue'] = [a for a in queue if a not in ('Myles Smith', 'Hard-Fi', 'Hard Fi')]

    brain['last_published'] = {
        'artist': 'Hard-Fi',
        'slug': 'hard-fi-sweating-someone-elses-fever',
        'title': 'Hard-Fi Return Unburdened, and It Shows',
        'date': '2026-06-25'
    }

    with open(brain_path, 'w') as f:
        json.dump(brain, f, indent=2, ensure_ascii=False)
        f.write('\n')
    print('brain.json updated on server')
except Exception as e:
    print(f'brain.json update skipped: {e}')
BRAINEOF

# ===== VERIFY + INDEXNOW + EMAIL =====
sleep 5

# Verify Myles Smith
STATUS1=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/myles-smith-my-mess-my-heart-my-life)
echo "HTTP status artonly.io/post/myles-smith-my-mess-my-heart-my-life: $STATUS1"

# IndexNow Myles Smith
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/myles-smith-my-mess-my-heart-my-life&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
echo "IndexNow pinged: myles-smith-my-mess-my-heart-my-life"

# Verify Hard-Fi
STATUS2=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/hard-fi-sweating-someone-elses-fever)
echo "HTTP status artonly.io/post/hard-fi-sweating-someone-elses-fever: $STATUS2"

# IndexNow Hard-Fi
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/hard-fi-sweating-someone-elses-fever&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b" || true
echo "IndexNow pinged: hard-fi-sweating-someone-elses-fever"

# Outreach Myles Smith
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=uk.press@sonymusic.com" \
  --data-urlencode "bcc=amosleblanc@gmail.com" \
  --data-urlencode "subject=ArtOnly just covered Myles Smith" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on Myles Smith and My Mess, My Heart, My Life at artonly.io/post/myles-smith-my-mess-my-heart-my-life. No ask, just thought you should see it. The piece focuses on the album's treatment of family trauma, Sertraline, and what it means to make a debut this honest after a billion streams. A downloadable social card is at the bottom of the page. Best, Leelou Blanc, ArtOnly" \
  --data-urlencode "reply_to=allastairvoss@gmail.com" || true
echo "Outreach sent for Myles Smith"

# Outreach Hard-Fi
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=management@hard-fi.com" \
  --data-urlencode "bcc=amosleblanc@gmail.com" \
  --data-urlencode "subject=ArtOnly just covered Hard-Fi" \
  --data-urlencode "body=Hi, I wanted to let you know we published a piece on Hard-Fi and Sweating Someone Else's Fever at artonly.io/post/hard-fi-sweating-someone-elses-fever. No ask, just thought you should see it. The piece looks at the fifteen-year gap, the Cherry Lips studio, what Digo Nada and Krysten Cummings reveal about where the band is now, and the El Salvador philosophy behind the title. A downloadable social card is at the bottom of the page. Best, Allastair Voss, ArtOnly" \
  --data-urlencode "reply_to=allastairvoss@gmail.com" || true
echo "Outreach sent for Hard-Fi"

# Summary email
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-25" "Published today:

1. artonly.io/post/myles-smith-my-mess-my-heart-my-life
   Myles Smith, My Mess, My Heart, My Life (June 19, 2026, RCA Records)
   HTTP $STATUS1

2. artonly.io/post/hard-fi-sweating-someone-elses-fever
   Hard-Fi, Sweating Someone Else's Fever (June 19, 2026, V2 Records)
   HTTP $STATUS2

Outreach:
- Myles Smith: uk.press@sonymusic.com
- Hard-Fi: management@hard-fi.com" || true
echo "Summary email sent"

echo "=== Deploy complete: 2026-06-25 Myles Smith + Hard-Fi ==="
