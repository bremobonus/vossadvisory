#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-29
# Posts: ibeyi-offering, chanel-beads-your-day-will-come
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-29.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-29 ==="

# ---- POST 1: Ibeyi - Offering ----
echo "--- Deploying: ibeyi-offering ---"

if [ -f ~/artonly.io/posts/ibeyi-offering.json ]; then
  echo "Post already exists: ibeyi-offering.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/ibeyi-offering.jpg'

# Try MusicNews.com article
try:
    html = fetch('https://musicnews.com/news/2026-06-26-ibeyi-announces-independent-album-offering-and-european-tour')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'musicnews' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://musicnews\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://musicnews.com/')
        print('Downloaded from MusicNews.com')
        sys.exit(0)
except Exception as e:
    print(f'MusicNews failed: {e}')

# Try Line of Best Fit announcement
try:
    html = fetch('https://www.thelineofbestfit.com/news/ibeyi-announce-new-album-offering')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'bestfit' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+thelineofbestfit[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thelineofbestfit.com/')
        print('Downloaded from Line of Best Fit')
        sys.exit(0)
except Exception as e:
    print(f'Line of Best Fit failed: {e}')

# Try FEMMUSIC Magazine
try:
    html = fetch('https://femmusic.com/2026/05/15/ibeyi-offering/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'femmusic' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://femmusic\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://femmusic.com/')
        print('Downloaded from FEMMUSIC')
        sys.exit(0)
except Exception as e:
    print(f'FEMMUSIC failed: {e}')

# Try EnvertMedia
try:
    html = fetch('https://envertmedia.com/ibeyi-offering-album-details/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'envert' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://envertmedia\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://envertmedia.com/')
        print('Downloaded from EnvertMedia')
        sys.exit(0)
except Exception as e:
    print(f'EnvertMedia failed: {e}')

# Try mxdwn Music announcement
try:
    html = fetch('https://music.mxdwn.com/2026/05/18/news/ibeyi-announce-new-album-offering-for-june-2026-release-share-new-single-aset/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'mxdwn' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+mxdwn[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://music.mxdwn.com/')
        print('Downloaded from mxdwn Music')
        sys.exit(0)
except Exception as e:
    print(f'mxdwn failed: {e}')

# Try Fresh Music Freaks announcement
try:
    html = fetch('https://freshmusicfreaks.com/ibeyi-announce-new-album-offering-and-share-spiritually-charged-lead-single-aset/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'ibeyi' in i.lower() or 'freshmusicfreaks' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://freshmusicfreaks\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://freshmusicfreaks.com/')
        print('Downloaded from Fresh Music Freaks')
        sys.exit(0)
except Exception as e:
    print(f'Fresh Music Freaks failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#080808-#141414\" -gravity center -pointsize 52 -fill white -annotate 0 \"Ibeyi\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/ibeyi-offering.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/ibeyi-offering-up.jpg && \
  mv ~/artonly.io/assets/images/artists/ibeyi-offering-up.jpg \
     ~/artonly.io/assets/images/artists/ibeyi-offering.jpg
echo "Image upscaled: ibeyi-offering.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py ibeyi-offering "Ibeyi Strip Everything Away on Offering and Find That the Voice Was Always Enough" music
echo "Social card generated: ibeyi-offering-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/5Q8NEHGX70m1kkojbtm8wa]

The verb that matters most in understanding what Ibeyi have done on their fourth album is not add but remove. From their 2015 debut through 2022's Spell 31, the French-Cuban twin sisters Lisa-Kaindé and Naomi Diaz built their world around two instrumental signatures: Naomi's drum kit, descended from the Batá tradition rooted in the Yoruba religion of their Cuban and Venezuelan heritage, and Lisa-Kaindé's piano, the Western classical instrument they encountered through formal training. These were not simply instruments. They were the terms in which the sisters had been heard and understood. They were the architecture.

On Offering, released June 26 through Ibeyi Records and distributed by AWAL, both are gone. The decision is not subtle. It is a demolition. In their place: heavy bass, synthesizer, and production built to carry weight and texture rather than melodic logic, and underneath all of it, the thing that was always there and is now finally unmistakable. The voices of two sisters who have been harmonizing together since before language was an option.

Independence enabled this clearing. After three albums with XL Recordings, the Diaz sisters left the label infrastructure to found Ibeyi Records, which gives them ownership of their masters and control over every decision about how this music reaches the world. The visuals for the album were shot entirely in Havana, in collaboration with local artists and musicians and members of the sisters' own community. This is a return in the most literal sense, to the geography and the people who form the root system of everything they have ever made, conducted now without a label deciding what that return should look like for a Western music market.

## The Cosmologies at the Center

The opening track, Olokun, is named for the Lucumí deity who governs the ocean, the depths of water, and the subconscious. It is a track of under two minutes that functions less as a song than as a threshold, an acknowledgment before entry. Ibeyi have always worked with Yoruba cosmology and Afro-Cuban religious tradition as active material rather than aesthetic decoration. Their early tracks referenced Elegguá, the orisha of crossroads and beginnings. Their debut's most striking song was a Yoruba lullaby. But the invocations on Offering feel different in weight, possibly because the album itself is a kind of devotional act, made under conditions of complete self-determination.

Aset, the lead single, takes its subject from Egyptian mythology, specifically the story of Aset (more widely known in its Greek transliteration as Isis), who reassembles and resurrects Osiris through the power of devotion. The track arrives as an incantation rather than a narrative, the myth compressed to its essential gesture. For an album made in the first year of complete independence, the choice of subject is not incidental. To invoke Aset is to invoke the principle of making something whole from what has been scattered.

Baba, which addresses Elegguá in a mode of lament rather than invocation, is among the album's quietest moments. The orisha who opens roads is addressed here as absent, or as present in a way that grief rather than gratitude defines. It is the track that best captures the album's emotional complexity, which is not triumphalist despite its independence, not celebratory despite its return. Offering contains joy, but it contains loss at the same weight.

## What the Voices Do Alone

The central argument of this record, the one the production choices are built to make, is that the voices of Lisa-Kaindé and Naomi Diaz have always been the irreducible thing. The drums and piano were not the music. They were the frame around the music. Remove the frame and you have not less. You have the thing itself.

What the electronics provide is environment rather than accompaniment. The heavy bass on Moshpit does not compete with the voices. It creates the space in which the voices can be physically felt rather than simply heard. The distortion that appears across the record does not obscure anything. It adds roughness to surfaces that might otherwise read as too polished for the material they carry. The production, credited to a range of collaborators working alongside the sisters, is in service of the voice in the most complete sense. It makes the voice more itself by giving it context that matches its weight.

Hurry Hurry and Good Life represent the album's most direct engagement with the acoustic world outside the cosmological framework, songs about time, about the pressure to arrive at happiness on a schedule that the modern world imposes, about what it costs to resist that schedule. These are not anthems. They are observations made with the particular clarity that comes from two people who have spent their entire adult lives in public while maintaining the privacy of a shared interior language.

## The Significance of the Independent Moment

It matters that Offering arrives now, in a music industry where independence no longer means what it once did. AWAL and structures like it make global distribution possible without label ownership of masters or creative control. The infrastructure question, which once forced artists into deals that traded artistic freedom for commercial reach, has changed substantially. But the decision to use that infrastructure on your own terms still carries weight. It means the work belongs to the people who made it.

For Ibeyi, a duo whose work has always been explicitly rooted in traditions of Afro-Cuban and Yoruba religious life, the question of who owns the music that carries those traditions is not a legal abstraction. It is a question about who has the right to determine how that inheritance is shared, adapted, and represented. By releasing this music through their own imprint, the Diaz sisters are not simply making a business decision. They are extending the logic of their music, its insistence on self-determined spiritual and cultural identity, into the material conditions of how that music exists in the world.

Offering is twelve tracks and under thirty minutes. This brevity is correct. Every track earns its place. Nothing is present to fill a quota. The album is long enough to do what it came to do and ends before it starts to explain itself. That restraint is a kind of confidence that only comes when the people making the music are also the people deciding when it is finished.

[download:/assets/images/artists/ibeyi-offering-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "ibeyi-offering",
    "title": "Ibeyi Strip Everything Away on Offering and Find That the Voice Was Always Enough",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-29",
    "image": "/assets/images/artists/ibeyi-offering.jpg",
    "image_alt": "Ibeyi press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/ibeyi-offering.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: ibeyi-offering.json")
PYEOF

# Verify live
echo "Verifying ibeyi-offering..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/ibeyi-offering)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ibeyi-offering&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: ibeyi-offering"

fi  # end skip block


# ---- POST 2: Chanel Beads - Your Day Will Come ----
echo "--- Deploying: chanel-beads-your-day-will-come ---"

if [ -f ~/artonly.io/posts/chanel-beads-your-day-will-come.json ]; then
  echo "Post already exists: chanel-beads-your-day-will-come.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/chanel-beads-your-day-will-come.jpg'

# Try RA.co announcement
try:
    html = fetch('https://ra.co/news/85097')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'ra.co' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+ra\.co[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ra.co/')
        print('Downloaded from RA.co')
        sys.exit(0)
except Exception as e:
    print(f'RA.co failed: {e}')

# Try The Fader announcement
try:
    html = fetch('https://www.thefader.com/2026/04/29/chanel-beads-album-announcement-your-day-will-come-2026-title-explanation')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'thefader' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+thefader[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thefader.com/')
        print('Downloaded from The Fader')
        sys.exit(0)
except Exception as e:
    print(f'The Fader failed: {e}')

# Try Exclaim.ca review
try:
    html = fetch('https://exclaim.ca/music/article/chanel-beads-your-day-will-come-album-review')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'exclaim' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://exclaim\.ca/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://exclaim.ca/')
        print('Downloaded from Exclaim.ca')
        sys.exit(0)
except Exception as e:
    print(f'Exclaim.ca failed: {e}')

# Try NME review
try:
    html = fetch('https://www.nme.com/reviews/album/chanel-beads-your-day-will-come-2026-review-3952521')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'nme' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+nme[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.nme.com/')
        print('Downloaded from NME')
        sys.exit(0)
except Exception as e:
    print(f'NME failed: {e}')

# Try Line of Best Fit review
try:
    html = fetch('https://www.thelineofbestfit.com/albums/chanel-beads-your-day-will-come-remain-in-perpetual-present')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'bestfit' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+thelineofbestfit[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.thelineofbestfit.com/')
        print('Downloaded from Line of Best Fit')
        sys.exit(0)
except Exception as e:
    print(f'Line of Best Fit failed: {e}')

# Try Jagjaguwar artist page
try:
    html = fetch('https://jagjaguwar.com/artist/chanelbeads/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'chanel' in i.lower() or 'beads' in i.lower() or 'jagjaguwar' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://jagjaguwar\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://jagjaguwar.com/')
        print('Downloaded from Jagjaguwar')
        sys.exit(0)
except Exception as e:
    print(f'Jagjaguwar failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a0a-#1a1a2a\" -gravity center -pointsize 52 -fill white -annotate 0 \"Chanel Beads\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/chanel-beads-your-day-will-come.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/chanel-beads-your-day-will-come-up.jpg && \
  mv ~/artonly.io/assets/images/artists/chanel-beads-your-day-will-come-up.jpg \
     ~/artonly.io/assets/images/artists/chanel-beads-your-day-will-come.jpg
echo "Image upscaled: chanel-beads-your-day-will-come.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py chanel-beads-your-day-will-come "Chanel Beads Named His Album the Same Thing Twice and Arrived Somewhere Entirely New" music
echo "Social card generated: chanel-beads-your-day-will-come-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/3x11XrMEnyP18hv73pmKRL]

Shane Lavers began calling his new album the same thing as his last album because it amused him. The 2025 Chanel Beads record was called Your Day Will Come. The 2026 Chanel Beads record is also called Your Day Will Come. The explanation Lavers has offered publicly is that the phrase kept resonating past the point where it should have expired, that it kept evoking a tension between certainty and doubt that felt more accurate than any new title could. What started as a goof became, in the process of making the record, a thesis. And the thesis is this: an artist cannot make the same album twice. The title says otherwise. The music proves the thesis.

Released June 26 through Jagjaguwar, this second Your Day Will Come is fourteen tracks recorded in Brooklyn that arrives carrying all the questions that come with a repeated name. Is this a sequel, a reissue, a companion piece, a correction? The answer, audible from the opening of Drums Only, is none of the above. It is a record that sounds like someone who made one album with a specific emotional intention, felt that intention had not been fully realized, and returned to the same question with different tools.

Those tools include, most notably, acoustic instrumentation in a register the 2025 record did not occupy. Lavers has described the album as a move toward a more structured approach, which is accurate but insufficient. The acoustic presence on these tracks does not domesticate the music. It exposes it. When you remove the cushion of ambient texture and ask a song to hold its weight through melody and arrangement alone, the songs either justify themselves or they do not. These do.

## The Phrase and What It Contains

The phrase your day will come lives at an unusual intersection. As a promise, it is consolation. As a threat, it is a warning. As a resignation, it is fatalism. As an aspiration, it is hope. All four readings are active simultaneously, which is what makes it so durable that Lavers was unable to release it with the first record and walk away.

The tension between nihilism and love, which Lavers has cited as the emotional territory of these fourteen tracks, maps onto those four readings. Nihilism is the version of the phrase that reads it as a threat or a resignation. Love is the version that reads it as a promise or an aspiration. The record does not resolve the tension into one meaning. It moves through all four readings, sometimes within a single track, and the result is music that feels emotionally complex without requiring the listener to decode a conceptual framework.

Tracks like The Coward Forgets His Nightmare and Spirit Showing work in this space between dread and tenderness. Song for the Messenger carries a quality of address, of something being delivered to someone who needs to hear it, without specifying what the something is or who the someone should be. This deliberate incompleteness is one of Lavers' most consistent qualities as a songwriter. He writes from inside a feeling rather than about it, which means the listener finds their own point of entry.

## What Brooklyn and Jagjaguwar Make Possible

There is a particular kind of record that gets made in Brooklyn by artists who have spent years building an audience through careful, patient means, through word of mouth in communities that still operate that way, through Bandcamp pages and independent venue circuits and the attention of writers who write for listeners rather than algorithms. Chanel Beads has been part of that ecosystem for long enough to have accumulated a following that follows the work rather than the platform.

This second Your Day Will Come is the Jagjaguwar formalization of that relationship. The label has housed Bon Iver through the recording that changed what Jagjaguwar was, Angel Olsen through the gradual expansion of her critical standing, Hop Along, Hand Habits, and a long list of artists whose careers have benefited from a label that does not require immediate commercial justification for its roster decisions. Chanel Beads in this company is not an aberration. It is a continuation of a philosophy: artists who are working seriously and need infrastructure to keep working, without the pressure to produce the record that makes everything make sense to an outsider.

The Brooklyn context matters here too in ways beyond geography. It is a place that has absorbed and metabolized enough musical history, enough artistic ambition, enough economic pressure and community formation, that the records made there by artists embedded in its networks tend to carry a particular self-awareness about what music does and what it is for. This record is aware of itself in exactly that way. It knows what it is asking of the listener and asks it with confidence.

## The Record That Proves Its Own Title Wrong

The fourteen tracks are sequenced to feel like a discovery in progress rather than a finished argument. Beaten With Sticks, the closing track, does not resolve the tensions of the preceding thirteen. It holds them. The phrase your day will come ends the record in the same state of suspension it opened with, which is to say that nothing has been settled and the settling was never the point.

What has happened across the record is something more interesting than resolution. The music has demonstrated that the question is worth living inside. That returning to the same title and finding entirely different music is not a failure of imagination but evidence of an imagination that refuses to be satisfied by a single pass at something that matters. Lavers could not have made this record with that title and then walked away from both. The title said so.

[download:/assets/images/artists/chanel-beads-your-day-will-come-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "chanel-beads-your-day-will-come",
    "title": "Chanel Beads Named His Album the Same Thing Twice and Arrived Somewhere Entirely New",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-29",
    "image": "/assets/images/artists/chanel-beads-your-day-will-come.jpg",
    "image_alt": "Chanel Beads press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/chanel-beads-your-day-will-come.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: chanel-beads-your-day-will-come.json")
PYEOF

# Verify live
echo "Verifying chanel-beads-your-day-will-come..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/chanel-beads-your-day-will-come)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/chanel-beads-your-day-will-come&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: chanel-beads-your-day-will-come"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Ibeyi / Ibeyi Records (AWAL distribution)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@awal.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Ibeyi and the new album Offering at artonly.io/post/ibeyi-offering. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@awal.com (Ibeyi)"

# Chanel Beads / Jagjaguwar (Secretly Group)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@secretlygroup.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Chanel Beads and the new album Your Day Will Come at artonly.io/post/chanel-beads-your-day-will-come. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@secretlygroup.com (Chanel Beads)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-29" "Published today:

1. Ibeyi - Offering
   https://artonly.io/post/ibeyi-offering
   Author: Allastair Voss
   Spotify: 5Q8NEHGX70m1kkojbtm8wa
   Released: June 26, 2026 (Ibeyi Records / AWAL)
   4th album, first independent release, stripped of piano and drums, Yoruba/Lucumi cosmology + electronics

2. Chanel Beads - Your Day Will Come
   https://artonly.io/post/chanel-beads-your-day-will-come
   Author: Leelou Blanc
   Spotify: 3x11XrMEnyP18hv73pmKRL
   Released: June 26, 2026 (Jagjaguwar)
   14 tracks, second album titled Your Day Will Come, shift to structured indie-pop, nihilism and love

Outreach:
- Ibeyi: email sent to press@awal.com
- Chanel Beads: email sent to press@secretlygroup.com

Both releases from June 26, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-29 ==="
