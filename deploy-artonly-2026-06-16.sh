#!/bin/bash
# ArtOnly Deploy Script: Ruel + Hayley Kiyoko
# Generated: 2026-06-16
# Posts: ruel-kicking-my-feet-screaming, hayley-kiyoko-girls-like-girls-the-album
# Run via GitHub Actions (deploy-artonly.yml)

set -e
echo "=== ArtOnly Deploy: 2026-06-16 Ruel + Hayley Kiyoko ==="
echo "$(date)"

# =============================================================
# POST 1: ruel-kicking-my-feet-screaming
# =============================================================
echo ""
echo "--- Deploying: ruel-kicking-my-feet-screaming ---"

python3 << 'IMGEOF1'
import urllib.request, os, sys

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
    return len(data)

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/ruel-kicking-my-feet-screaming.jpg'

sources = [
    ('https://commons.wikimedia.org/wiki/Special:FilePath/Ruel_van_Dijk_Sydney_2019.jpg', 'https://commons.wikimedia.org/'),
    ('https://commons.wikimedia.org/wiki/Special:FilePath/Ruel_singer.jpg', 'https://commons.wikimedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Ruel_van_Dijk_-_Splendour_in_the_Grass_2019.jpg/800px-Ruel_van_Dijk_-_Splendour_in_the_Grass_2019.jpg', 'https://en.wikipedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/0/0e/Ruel_van_Dijk_-_Splendour_in_the_Grass_2019.jpg', 'https://en.wikipedia.org/'),
]

for src, ref in sources:
    try:
        download_img(src, dest, referer=ref)
        print(f'Hero downloaded: {src}')
        sys.exit(0)
    except Exception as e:
        print(f'Failed: {src}: {e}')

import subprocess
subprocess.run([
    'convert', '-size', '1200x800', 'gradient:#0d0d1a-#1a1a3e',
    '-gravity', 'center', '-pointsize', '60', '-fill', 'white',
    '-annotate', '0', 'Ruel', dest
], check=True)
print('Hero placeholder generated')
IMGEOF1

echo "Ruel hero image done"

OMP_NUM_THREADS=1 convert /home/dh_yadmw3/artonly.io/assets/images/artists/ruel-kicking-my-feet-screaming.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  /home/dh_yadmw3/artonly.io/assets/images/artists/ruel-kicking-my-feet-screaming-up.jpg \
  && mv /home/dh_yadmw3/artonly.io/assets/images/artists/ruel-kicking-my-feet-screaming-up.jpg \
        /home/dh_yadmw3/artonly.io/assets/images/artists/ruel-kicking-my-feet-screaming.jpg

echo "Ruel hero upscaled"

python3 << 'PYEOF1'
import json, os

body = """\
[spotify:artist/5xkAtLTf309LAGZTbvULBn]

The premise of \"Kicking My Feet and Screaming\" is architectural. Ruel's second studio album, \"Kicking My Feet,\" arrived in 2025 with a specific emotional mandate: celebrate the heightened state of early love, the phase where ordinary experience becomes almost unbearable in its brightness. That album did what it set out to do. It leaned into what Ruel has called \"the cringe,\" the butterflies, the walking on air, the particular irrationality of being someone in the grip of wanting another person. \"Kicking My Feet and Screaming,\" released June 12, 2026, on Recess Records and Giant Music, takes the same relationship and walks it through fire.

## The Architecture of Feeling

The structural decision to release the two albums as companions is not a gimmick. It is a way of honoring how love actually moves. The same story has different chapters, and the chapters do not all feel the same. Ruel, born in the UK and raised in Sydney, has been building toward a project with this kind of ambition for over a decade. He signed his first record deal at fourteen. He sold out rooms in cities that typically require years of groundwork before an unknown can fill them. He received early attention from Elton John and Zane Lowe, both of whom recognized something in him that the Australian industry was still catching up to. The trajectory was always pointing toward something that matched the size of his voice, and \"Kicking My Feet and Screaming\" is the fullest realization of that.

The sequencing of the 21 tracks across an hour is careful. \"Hate Myself\" opens not with self-pity but with anger turned inward, the particular feeling of knowing you have made choices that have cost you something irreplaceable. \"In Your Mind\" moves into territory that is harder to name: the space where someone lives inside your imagination even after they have left. \"Faking Smiles\" is the album's clearest statement of emotional exhaustion, the performance of being fine when fine is exactly what you are not. These are not pop themes in the abstract. They are states of being, and Ruel treats them with a precision that most songwriters at twenty-three would not have the craft or the nerve to attempt.

## Production Without a Single Voice

The production on this record was shaped by Joel Little, Julian Bunetta, Kenny Beats, and Dan Wilson, a set of collaborators with no single dominant aesthetic. Little has built major-label careers from the ground up, working with artists like Taylor Swift and Lorde. Bunetta knows how to scale intimacy to arenas without losing the thing that made the song personal in the first place. Kenny Beats operates at the intersection of hip-hop and experimental indie in a way that consistently refuses the easy option. Dan Wilson, who has written songs for Adele and Semisonic, understands architecture. The fact that the record sounds cohesive despite those varied inputs says something about how clearly Ruel knew what he wanted. The collaborators served the album rather than the other way around.

What the record does with grief, which is the correct word for what many of these songs are about even when they do not announce it, is to refuse sentimentality. \"Debbie Don't Cry\" understands how exhausted a person can become by their own feeling, how the body can want to stop producing the emotional response even as the emotional response continues. \"Talking to the Driver\" is stranger and more removed: a song about displacement, about how the mind goes somewhere else when staying present is too costly. \"Since the Day You Left Me\" earns its plainness because it does not mistake transparency for weakness.

## The Second Half Opens Up

The sequencing in the album's second half releases pressure. \"Wild Guess\" and \"When You Walk In The Room\" are both about proximity and what proximity does to someone who has decided it cannot mean anything anymore. \"I Can Die Now\" is the album's most grandiose title and also its most restrained song: a joke about completion that reveals itself as something genuinely felt. \"The Suburbs\" arrives toward the end with a different texture, more space, more distance, the sound of a person who has been running and has finally stopped long enough to look at where they are.

The closer, \"dst (outro),\" is only fifty seconds, and it works precisely because the album has earned that kind of silence. A record with twenty-one tracks could easily overstay its welcome. This one does not, because each track is doing something distinct within a single emotional argument. Ruel has enough compositional intelligence to know that an outro can land harder than a finale.

## What the Double Project Means

The pair of albums is now complete. Part one was about wanting. Part two is about losing and what you do with the body after that. Taken together, they constitute one of the more coherent statements in contemporary indie-pop about what romantic love actually costs, not in the abstract, but in the specific and daily accumulation of moments when you choose to feel rather than protect yourself from feeling.

Elton John and Zane Lowe were both public about what they saw in this artist. That kind of attention at fourteen is a specific kind of pressure. It can produce someone who learns to manage expectations, who shapes their output around the need to justify the early praise. Ruel has done something different. He has built a body of work that justifies the attention on its own terms and on its own timeline. \"Kicking My Feet and Screaming\" does not sound like the record of someone who needed to prove something. It sounds like the record of someone who knew what they were building and took the time to get it right.

Ruel is twenty-three. The architecture he has constructed across these two albums is more structurally sound than most artists build in a full decade. That is the fact about him that is hardest to look at directly: not the talent, which was obvious early, but the patience. He did not rush the story. He waited until he had something to say about what comes after the beginning, and then he said it in twenty-one songs.

[download:/assets/images/artists/ruel-kicking-my-feet-screaming-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "ruel-kicking-my-feet-screaming",
    "title": "Ruel Ends the Story He Started with Kicking My Feet and Screaming",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-16",
    "image": "/assets/images/artists/ruel-kicking-my-feet-screaming.jpg",
    "image_alt": "Ruel press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/ruel-kicking-my-feet-screaming.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF1

echo "Post JSON deployed: ruel-kicking-my-feet-screaming.json"

cd ~/artonly.io/agent
python3 make-social-card.py ruel-kicking-my-feet-screaming "Ruel Ends the Story He Started with Kicking My Feet and Screaming" music
echo "Social card generated: ruel-kicking-my-feet-screaming-social-9x16.jpg"
cd ~

STATUS1=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/ruel-kicking-my-feet-screaming)
echo "HTTP status artonly.io/post/ruel-kicking-my-feet-screaming: $STATUS1"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ruel-kicking-my-feet-screaming&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: ruel-kicking-my-feet-screaming"

curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=info@giantmusic.com.au" \
  --data-urlencode "subject=ArtOnly just covered Ruel and Kicking My Feet and Screaming" \
  --data-urlencode "body=Hi, we published a piece on Ruel and the new album at artonly.io/post/ruel-kicking-my-feet-screaming. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Ruel"

echo ""
echo "=== POST 1 COMPLETE: ruel-kicking-my-feet-screaming ==="

# =============================================================
# POST 2: hayley-kiyoko-girls-like-girls-the-album
# =============================================================
echo ""
echo "--- Deploying: hayley-kiyoko-girls-like-girls-the-album ---"

python3 << 'IMGEOF2'
import urllib.request, os, sys

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
    return len(data)

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album.jpg'

sources = [
    ('https://commons.wikimedia.org/wiki/Special:FilePath/Hayley_Kiyoko_by_Jamie_Alcroft.jpg', 'https://commons.wikimedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Hayley_Kiyoko_by_Jamie_Alcroft.jpg/800px-Hayley_Kiyoko_by_Jamie_Alcroft.jpg', 'https://en.wikipedia.org/'),
    ('https://upload.wikimedia.org/wikipedia/commons/d/d5/Hayley_Kiyoko_by_Jamie_Alcroft.jpg', 'https://en.wikipedia.org/'),
]

for src, ref in sources:
    try:
        download_img(src, dest, referer=ref)
        print(f'Hero downloaded: {src}')
        sys.exit(0)
    except Exception as e:
        print(f'Failed: {src}: {e}')

import subprocess
subprocess.run([
    'convert', '-size', '1200x800', 'gradient:#0d0d1a-#1a1a3e',
    '-gravity', 'center', '-pointsize', '60', '-fill', 'white',
    '-annotate', '0', 'Hayley Kiyoko', dest
], check=True)
print('Hero placeholder generated')
IMGEOF2

echo "Hayley Kiyoko hero image done"

OMP_NUM_THREADS=1 convert /home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  /home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album-up.jpg \
  && mv /home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album-up.jpg \
        /home/dh_yadmw3/artonly.io/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album.jpg

echo "Hayley Kiyoko hero upscaled"

python3 << 'PYEOF2'
import json, os

body = """\
[spotify:artist/3LjhVl7GzYsza1biQjTpaN]

The title \"Girls Like Girls\" has been in the cultural vocabulary since 2015, when Hayley Kiyoko released the song and its accompanying short film as a piece of queer storytelling that reached far beyond the usual reach of a debut single. The video was a teenage love story, specifically a story between two girls, rendered with enough clarity and tenderness to become a touchstone for a generation of young people who were accustomed to not finding themselves in the music they listened to. Kiyoko did not call that audience into being. She simply showed up for it, and it found her.

## A Project a Decade in the Making

\"Girls Like Girls the Album,\" released June 13, 2026, on One Riot, KRO, Rich Youth Records, and Virgin Music Group, is the culmination of everything that has been built around that original moment. It arrives six days before the theatrical release of the Girls Like Girls film, which Kiyoko wrote and directed, through Focus Features. The album is simultaneously a companion piece, a soundtrack, and a standalone record. It does all three things without feeling like it is pulling in different directions.

The film follows Coley, seventeen, from rural Oregon, navigating the terrain of grief and self-discovery after her mother's death. She meets Sonya. What develops between them is the kind of first love that reorganizes everything a person thought they understood about themselves. That emotional topology is exactly what the album traces. Kiyoko has said publicly that some of these songs began as ideas she had at sixteen, when she was experiencing the same feelings the film portrays. The record is not a retrospective exercise. It is a reckoning.

## The Logic of the Sequencing

The 14 tracks are sequenced with a dramatist's instinct. The album understands that a story about first love is also a story about uncertainty, and uncertainty in its rawest form is not simply sad. It is terrifying and luminous simultaneously. Kiyoko writes toward that combination rather than resolving it into something more comfortable. The songs do not offer the listener easy exits.

The collaborators she assembled reflect the emotional range she needed. Young Miko brings a bilingual fluency and an almost physical sense of urgency to their shared track. Tegan and Sara, who have been making music about what it means to love someone of the same gender since before that conversation was common in pop, carry the institutional weight of what queer music has survived and built over the past three decades. Chelsea Cutler, Joy Oladokun, August Ponthier, Gigi Perez, and Snow Wife each bring their own specificity, and none of them blur into the background. They feel chosen rather than assembled, which is the most important thing a collaborator credit can communicate.

## The Difficulty of Writing About Now

The album resists the pull toward pure nostalgia even as it draws on memory. This is harder than it sounds. Music about first love, particularly music made by someone who is also a filmmaker and has spent eleven years building a platform around a single song's legacy, can easily become a careful reconstruction of feeling rather than the thing itself. Kiyoko does not let that happen. The record is pitched at the exact frequency of still being inside the experience rather than looking back at it from safety.

That choice has a cost. Songs that refuse distance require a kind of formal courage that more polished records avoid. Some of the most affecting tracks here are the ones that arrive slightly unguarded, where the production does not fully cushion the lyrical directness. Kiyoko has always been willing to be specific in ways that leave her exposed. That is the quality that made the 2015 single matter, and it is the quality that makes this album matter in a different way eleven years later.

## Where Kiyoko Sits in the Landscape

Hayley Kiyoko's career has always existed in interesting relationship with the mainstream. She acted in Disney productions and Nickelodeon series before making music, which gave her industry access and cultural visibility and almost no credit for what she was actually doing. She built a fanbase that was intensely loyal and somewhat outside the circuits that traditionally award visibility in pop. That combination, insider industry knowledge and outsider cultural positioning, has made her work consistently more interesting than her access to resources might have predicted. She could have made an uncomplicated pop record at any point. She has never done that.

The Girls Like Girls franchise, which began with a song and has grown to include a bestselling novel and now a film, is the work of someone who understood that visibility is not enough on its own, that the work also has to be good, has to be honest, has to hold up outside the context of its own politics. This album holds up. It is the work of a songwriter who started writing these songs in a bedroom and has spent eleven years building the platform to finally say them at scale.

## What the Album Does That the Song Could Not

The scale does not dilute the intimacy. What Kiyoko has built is the rare thing: a project that can live inside a theater, inside a relationship, inside a playlist at two in the morning, and feel equally true in all three places. The film's release on June 19, 2026, through Focus Features gives the album an unusual second context. Most albums exist as audio objects and reach people through speakers or headphones. This album will also exist inside a cinema, attached to images and a narrative that precede it. Kiyoko has said she imagined people listening to the album on the way home from the theater. The music holds enough weight to complete that journey even for people who encounter it in the opposite order.

Queer representation in mainstream film and music has expanded significantly over the past decade, but the expansion has not been even, and it has not always been led by queer artists. Kiyoko has been both a beneficiary of that expansion and one of its architects. The story that started with the 2015 single is not over, but this album is its most complete chapter so far. It is the sound of someone who has spent a decade asking the world to hold space for something true, and has finally made the piece of work that does not need to ask anymore. It makes the argument through the music itself, which is the only argument worth making.

[download:/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album-social-9x16.jpg|Download Social Card]\
"""

post = {
    "slug": "hayley-kiyoko-girls-like-girls-the-album",
    "title": "Hayley Kiyoko Completes the Story She Has Been Telling Since 2015",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-16",
    "image": "/assets/images/artists/hayley-kiyoko-girls-like-girls-the-album.jpg",
    "image_alt": "Hayley Kiyoko press photo",
    "image_position": "center 20%",
    "body": body
}

path = os.path.expanduser('~/artonly.io/posts/hayley-kiyoko-girls-like-girls-the-album.json')
with open(path, 'w', encoding='utf-8') as f:
    json.dump(post, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f'Written: {path}')
PYEOF2

echo "Post JSON deployed: hayley-kiyoko-girls-like-girls-the-album.json"

cd ~/artonly.io/agent
python3 make-social-card.py hayley-kiyoko-girls-like-girls-the-album "Hayley Kiyoko Completes the Story She Has Been Telling Since 2015" music
echo "Social card generated: hayley-kiyoko-girls-like-girls-the-album-social-9x16.jpg"
cd ~

STATUS2=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/hayley-kiyoko-girls-like-girls-the-album)
echo "HTTP status artonly.io/post/hayley-kiyoko-girls-like-girls-the-album: $STATUS2"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/hayley-kiyoko-girls-like-girls-the-album&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: hayley-kiyoko-girls-like-girls-the-album"

curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@oneRiotRecords.com" \
  --data-urlencode "subject=ArtOnly just covered Hayley Kiyoko and Girls Like Girls the Album" \
  --data-urlencode "body=Hi, we published a piece on Hayley Kiyoko and the new album at artonly.io/post/hayley-kiyoko-girls-like-girls-the-album. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  --data-urlencode "bcc=amosleblanc@gmail.com"
echo "Outreach sent for Hayley Kiyoko"

echo ""
echo "=== POST 2 COMPLETE: hayley-kiyoko-girls-like-girls-the-album ==="

# =============================================================
# SUMMARY EMAIL
# =============================================================
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-16" \
  "Published today:

1. Ruel: Ends the Story He Started with Kicking My Feet and Screaming
   https://artonly.io/post/ruel-kicking-my-feet-screaming

2. Hayley Kiyoko: Completes the Story She Has Been Telling Since 2015
   https://artonly.io/post/hayley-kiyoko-girls-like-girls-the-album

Outreach:
- Ruel: sent to info@giantmusic.com.au
- Hayley Kiyoko: sent to press@oneRiotRecords.com

HTTP status: Ruel=$STATUS1, Hayley Kiyoko=$STATUS2"

echo "Summary email sent to amosleblanc@gmail.com"
echo ""
echo "=== Deploy complete: 2026-06-16 ==="
