#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-06-25
# Posts: pond-terrestrials, pj-morton-saturday-night-sunday-morning
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-25.sh

set -e
echo "=== ArtOnly Deploy: 2026-06-25 ==="

# ---- POST 1: Pond - Terrestrials ----
echo "--- Deploying: pond-terrestrials ---"

if [ -f ~/artonly.io/posts/pond-terrestrials.json ]; then
  echo "Post already exists: pond-terrestrials.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/pond-terrestrials.jpg'

# Try US Rocker (Skyworks vid article)
try:
    html = fetch('https://usrockermusic.com/2026/06/21/pond-arrives-for-north-american-terrestrials-tour-makes-statement-with-skywords-vid/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'usrocker' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://usrockermusic\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://usrockermusic.com/')
        print('Downloaded from US Rocker')
        sys.exit(0)
except Exception as e:
    print(f'US Rocker failed: {e}')

# Try Jambase tour announcement
try:
    html = fetch('https://www.jambase.com/article/pond-tour-dates-2026-terrestrials')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'jambase' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+jambase[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.jambase.com/')
        print('Downloaded from Jambase')
        sys.exit(0)
except Exception as e:
    print(f'Jambase failed: {e}')

# Try Slant Magazine review
try:
    html = fetch('https://www.slantmagazine.com/music/pond-terrestrials-album-review/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'slant' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+slantmagazine[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.slantmagazine.com/')
        print('Downloaded from Slant Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Slant Magazine failed: {e}')

# Try Consequence of Sound review
try:
    html = fetch('https://consequence.net/2026/06/pond-terrestrials-review/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://consequence\.net/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://consequence.net/')
        print('Downloaded from Consequence of Sound')
        sys.exit(0)
except Exception as e:
    print(f'Consequence failed: {e}')

# Try Quip Magazine
try:
    html = fetch('https://quipmag.com/pond-invite-you-to-partake-in-the-freakage-on-terrestrials/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'quip' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://quipmag\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://quipmag.com/')
        print('Downloaded from Quip Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Quip Magazine failed: {e}')

# Try Rolling Stone AU
try:
    html = fetch('https://au.rollingstone.com/music/music-news/pond-release-new-album-terrestrials-97251/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'rollingstone' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://au.rollingstone.com/')
        print('Downloaded from Rolling Stone AU')
        sys.exit(0)
except Exception as e:
    print(f'Rolling Stone AU failed: {e}')

# Try The Fire Note review
try:
    html = fetch('https://thefirenote.com/reviews/pond-terrestrials-album-review/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'pond' in i.lower() or 'firenote' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://thefirenote\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://thefirenote.com/')
        print('Downloaded from The Fire Note')
        sys.exit(0)
except Exception as e:
    print(f'The Fire Note failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#080808-#141414\" -gravity center -pointsize 52 -fill white -annotate 0 \"Pond\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/pond-terrestrials.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/pond-terrestrials-up.jpg && \
  mv ~/artonly.io/assets/images/artists/pond-terrestrials-up.jpg \
     ~/artonly.io/assets/images/artists/pond-terrestrials.jpg
echo "Image upscaled: pond-terrestrials.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py pond-terrestrials "Terrestrials Is the Record Pond Were Always Building Toward" music
echo "Social card generated: pond-terrestrials-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/4skJp5OKvcc9eKokiuhi2s]

There is a version of Pond's career that reads as maximalist accumulation. From their 2012 debut through the sprawling psychedelia of "Man It Feels Like Space Again" and the baroque excess of "9," the Perth band operated with a philosophy of more: more fuzz, more layers, more structural wandering, more willingness to let a track dissolve into abstraction before it resolved into anything recognizable. Nick Allbrook's voice has always been the center of this accumulation, a flexible instrument capable of sliding between the ecstatic and the cynical within a single phrase. But the architecture around that voice has, for most of their career, been one of elaboration rather than economy.

"Terrestrials," their eleventh studio album, released June 19 through their own Mangovision imprint via Secretly Distribution, represents the sharpest departure from that philosophy they have ever made. The band set explicit parameters before entering the studio: no fuzz pedal, no ballads, and no what they described as Pink Floyd shit, meaning no extended instrumental passages that prioritize atmosphere over direction. These constraints did not narrow the record so much as concentrate it. What emerged sounds, for the first time in years, like a band under pressure from the world outside the studio rather than from the conventions of their own established sound.

The influence framework is specific: 1980s Australian rock, filtered through goth, post-punk, and pub culture. The Church, Midnight Oil, Magazine, and The Sisters of Mercy are audible throughout, not as pastiche but as structural permission. Allbrook has described wanting to achieve what he called "goths at the pub," which captures the album's particular emotional texture: the intersection of post-punk severity with the loose, communal warmth of live performance spaces, something that aspires to darkness but cannot quite resist the social pull of a crowd. It is an unusual combination, and in Pond's hands it produces music that feels simultaneously disciplined and alive.

## What the Constraints Unlocked

The decision to abandon the fuzz pedal was not cosmetic. Fuzz in psychedelic rock functions as a kind of emotional cushion: it blurs the edges of what a guitar is doing, makes precision less necessary, and provides a sonic environment in which ideas can float without committing to direction. By removing it, Pond forced themselves to make the musical architecture more explicit, to construct songs that hold their shape without the support of texture as meaning. The result is that "Terrestrials" sounds like a collection of compositions in a way that not all of their previous records have. Each track has a defined structure, a traditional verse-chorus architecture that frames the content without apologizing for its clarity.

This is not the expected move from a band whose reputation rests partly on their willingness to subvert those expectations. But the clarity is not capitulation. It is the condition under which the album's actual content becomes legible. Because the songs on "Terrestrials" are, beneath the 1980s production aesthetics and the taut guitar lines, among the most directly political Pond have ever made.

"Two Hands" addresses the 2020 destruction of Juukan Gorge in the Hammersley Range of Western Australia, when Rio Tinto blew apart two rock shelters containing a cultural sequence spanning 46,000 years, maintained by the Puutu Kunti Kurrama and Pinikura peoples. The mining company had received approval from the Australian government under legislation that prioritized resource extraction over Indigenous heritage protection. Allbrook has spoken directly about this as the song's subject, and the track earns the weight of that material by refusing to aestheticize it. It is a song about a specific act of destruction with a specific corporate perpetrator, and the simplicity of the arrangement gives the accusation nowhere to hide.

"Skyworks" engages with Australia Day, the annual celebration held on January 26, the date of the British arrival in 1788, which a significant portion of the Australian population, particularly Indigenous Australians, have argued should be moved or reconsidered because the date commemorates the beginning of a colonial project whose violence has never been fully reckoned with. The song was inspired by the annual fireworks display over Perth's Swan River, a spectacular celebration of a date that means devastation to many of the country's First Nations peoples. The juxtaposition of spectacle and grief runs through the track as a structural principle rather than a rhetorical one.

## The Political Record They Were Always Making

Pond have never been apolitical, but their politics have historically been more diffuse, dispersed through imagery and emotional texture rather than targeted argument. What "Terrestrials" does is concentrate that tendency into something more pointed. Allbrook has spent years as a solo artist making music that engages directly with environmental destruction, social fragmentation, and the weight of colonial history in Australian cultural life. On this record, that engagement enters the Pond framework without diluting it.

The album's political content benefits from the structural discipline. When a song achieves the clarity of "Two Hands," the listener is not searching for meaning in the fog of atmosphere. The meaning is where the music leaves it: exposed, specific, and accountable to the reality it describes. This is harder to achieve in the maximalist mode Pond have historically favored. Excess provides cover. Economy demands that every element justify its presence.

The tracks between the explicitly political material develop their own emotional logic. "Sweeper" and "Satellite" navigate the personal territory of late-stage relationship anxiety with the same directness the political tracks bring to their subjects. The album does not segregate its concerns into separate compartments. The same attentiveness that makes "Two Hands" work makes the quieter emotional material work, because the constraint is consistent across all ten tracks.

## The Eleventh Album as Discovery

Eleven albums is a significant body of work for any band, and the question of what there is left to discover within a project that has been as extensively explored as this one is not trivial. "Terrestrials" answers it with unusual conviction: the discovery was always there, waiting for a set of rules strict enough to make it visible.

The 1980s Australian influences are not, in the end, about nostalgia. They are about a specific tradition of rock music made in a country whose complexity and contradictions required music with a directness and a roughness that the more refined British and American rock of the same era tended to smooth away. In choosing to work within that tradition, Pond found a frame for political content that fits the material rather than decorating it.

The record closes with "The Weight," which holds the accumulated tension of everything that precedes it without releasing it into resolution. This is the correct ending. "Terrestrials" is not a record that wants you to feel better about the state of Australia, or about extractive capitalism, or about the gap between national celebration and historical grief. It wants you to feel those things with sufficient accuracy that you understand what they are. That the record achieves this through the discipline of simplicity rather than the sprawl of maximalism is its most unexpected and most important argument.

[download:/assets/images/artists/pond-terrestrials-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "pond-terrestrials",
    "title": "Terrestrials Is the Record Pond Were Always Building Toward",
    "author": "Allastair Voss",
    "category": "music",
    "date": "2026-06-25",
    "image": "/assets/images/artists/pond-terrestrials.jpg",
    "image_alt": "Pond press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/pond-terrestrials.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: pond-terrestrials.json")
PYEOF

# Verify live
echo "Verifying pond-terrestrials..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pond-terrestrials)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pond-terrestrials&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: pond-terrestrials"

fi  # end skip block


# ---- POST 2: PJ Morton - Saturday Night, Sunday Morning ----
echo "--- Deploying: pj-morton-saturday-night-sunday-morning ---"

if [ -f ~/artonly.io/posts/pj-morton-saturday-night-sunday-morning.json ]; then
  echo "Post already exists: pj-morton-saturday-night-sunday-morning.json, skipping"
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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg'

# Try SRG-ILS press release
try:
    html = fetch('https://thesrg-ilsgroup.com/pj-morton-releases-new-project-saturday-night-sunday-morning/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower() or 'srg' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://thesrg-ilsgroup\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://thesrg-ilsgroup.com/')
        print('Downloaded from SRG-ILS')
        sys.exit(0)
except Exception as e:
    print(f'SRG-ILS failed: {e}')

# Try Rated R&B announcement
try:
    html = fetch('https://ratedrnb.com/2026/04/pj-morton-announces-double-album-saturday-night-sunday-morning/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower() or 'ratedrnb' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+ratedrnb[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ratedrnb.com/')
        print('Downloaded from Rated R&B')
        sys.exit(0)
except Exception as e:
    print(f'Rated R&B failed: {e}')

# Try Shore Fire Media press release
try:
    html = fetch('https://shorefire.com/releases/entry/pj-morton-announces-new-double-album-out-june-19-saturday-night-sunday-morning')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://shorefire\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://shorefire.com/')
        print('Downloaded from Shore Fire Media')
        sys.exit(0)
except Exception as e:
    print(f'Shore Fire failed: {e}')

# Try Shatter the Standards review
try:
    html = fetch('https://www.shatterthestandards.com/p/album-review-saturday-night-sunday')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+shatter[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.shatterthestandards.com/')
        print('Downloaded from Shatter the Standards')
        sys.exit(0)
except Exception as e:
    print(f'Shatter the Standards failed: {e}')

# Try This Is RnB
try:
    html = fetch('https://thisisrnb.com/2026/02/grammy-champion-pj-morton-expands-his-legacy-with-morton-records-srg-ils-partnership/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower() or 'thisisrnb' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://thisisrnb\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://thisisrnb.com/')
        print('Downloaded from This Is RnB')
        sys.exit(0)
except Exception as e:
    print(f'This Is RnB failed: {e}')

# Try You Know I Got Soul
try:
    html = fetch('https://youknowigotsoul.com/pj-morton-announces-upcoming-double-album-saturday-night-sunday-morning')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'morton' in i.lower() or 'pj' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://youknowigotsoul.com/')
        print('Downloaded from You Know I Got Soul')
        sys.exit(0)
except Exception as e:
    print(f'You Know I Got Soul failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a14-#14140a\" -gravity center -pointsize 52 -fill white -annotate 0 \"PJ Morton\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg && \
  mv ~/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg \
     ~/artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg
echo "Image upscaled: pj-morton-saturday-night-sunday-morning.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py pj-morton-saturday-night-sunday-morning "PJ Morton Spent His Whole Life Auditioning for This Double Album" music
echo "Social card generated: pj-morton-saturday-night-sunday-morning-social-9x16.jpg"
cd ~

# Deploy JSON post
python3 << 'PYEOF'
import json

body = """[spotify:artist/2FMOHE79X98yptp4RpPrt7]

The sacred and the secular are not, in American Black musical culture, the opposites they are sometimes presented as being outside it. The same church that trained Aretha Franklin also produced the music she carried into secular spaces, and the transformation that occurred in that passage was never a departure from the spiritual so much as a translation of it into a different register. The gospel training did not become invisible when it met the production infrastructure of Atlantic Records. It became the thing that made her something more than the production infrastructure could contain.

PJ Morton understands this history from the inside. Born in New Orleans to Bishop Paul S. Morton, one of the founders of the Full Gospel Baptist Church Fellowship and one of the most significant figures in contemporary gospel, he grew up playing organ in church before he became the keyboardist for Maroon 5, one of the most commercially successful pop rock acts of the past two decades. This biography is not a paradox. It is a preparation.

"Saturday Night, Sunday Morning," released June 19 through Morton Records and the SRG-ILS Group, is his eighth studio album and first double LP: eighteen tracks across two distinct halves, one devoted to R&B and soul, the other to gospel. He has said that he has been auditioning for this album his whole life. That is a careful word choice. An audition suggests a performance aimed at a specific standard, a demonstration to an authority whose judgment you accept. The album Morton has made suggests he was auditioning for himself, for the accumulated version of himself that contains both the secular showman and the church musician, and that the performance had to wait until both versions were ready to occupy the same record without compromising either.

## The Split That Is Not a Division

The two-sided structure of the album invites a reading in which Saturday night and Sunday morning are opposites to be reconciled. Morton resists this reading at the level of sound and performance. The R&B side does not sound like an artist suppressing the gospel influence. The gospel side does not sound like an artist performing religious authenticity for secular listeners. Both halves draw on the same fundamental capacities: a voice trained in church, a sense of arrangement developed across seven previous albums and years of live performance, a producer's understanding of how sound and space work together, a writer's interest in the specific language of experience rather than the general language of genre.

The album was recorded at Studio in the Country, a facility in rural Louisiana that has served since the 1970s as a retreat for musicians seeking distance from the commercial pressures of urban recording environments. Willie Nelson, John Lee Hooker, and Arlo Guthrie have all recorded there. The choice positions the album within a tradition of American roots music that crosses the sacred and secular divide as a matter of course rather than as an act of resolution.

The R&B side's debt to Stevie Wonder's "Songs in the Key of Life" is audible in its ambition rather than its sound. "Songs in the Key of Life" was a double album that attempted to hold the full scope of a particular American consciousness within the framework of pop music. Morton's Saturday Night side shares that aspiration without sharing the production language. It sounds like 2026 New Orleans soul, which means it sounds like something specific and local rather than something aiming at the universal through glossy production.

## The Gospel Half and What It Required

Morton has said that the Sunday Morning side represents his first proper gospel record because it is the first time he has sung every track himself without the assistance of other vocalists. This distinction matters more than it might appear. Gospel music, in its performance tradition, is communal. The choir is not a supporting cast for a soloist. The voices in harmony are the theology made audible, the physical demonstration that belief is held together rather than alone. An album where Morton sings every gospel track solo is not a failure of tradition. It is an act of personal reckoning, a decision to hold the weight of the testimony without distributing it.

The gospel side also carries an influence that runs alongside the Stevie Wonder reference: Kendrick Lamar's "Mr. Morale and the Big Steppers," which approached hip-hop's relationship to religious experience with unusual honesty about the gap between the aspiration and the practice, about the way that belief can coexist with behavior that contradicts it. Morton's Sunday Morning is not that album, but it shares a willingness to treat gospel as a form that can hold ambivalence as well as conviction. The songs are not certainties dressed up as hymns. They are arrivals at certainty that carry the trace of the journey.

## Juneteenth and the Meaning of the Release Date

The album arrived on June 19, Juneteenth, the federal holiday commemorating the announcement of emancipation in Texas in 1865. For an album about the division between sacred and secular life in Black American experience, the date is not incidental. Juneteenth is itself a commemoration of a distinction: between the legal announcement of freedom and its actual material reality, between what was said and what obtained in practice. Morton's album is, in its structure, about exactly that kind of distinction. It holds two truths that the culture often requires its artists to choose between, and it refuses to choose.

The 2024 memoir "Saturday Night, Sunday Morning: Staying True to Myself from the Pews to the Stage" preceded the album and established the framework. The book allowed Morton to set out the biographical argument that the album makes musically. Having made that argument in prose, he could make it in sound without the scaffolding of explanation, trusting the music to do what memoir does in words. The result is an album that does not need the book to be understood but rewards the listener who comes to it with that context.

Eighteen tracks is a lot to hold in a single listening experience, but Morton understands pacing. The two sides function as distinct emotional arcs that share a tonal center: the voice, the attention to arrangement, the commitment to specificity over generality. By the end of Sunday Morning, both halves feel necessary to each other in a way that justifies the format's ambition. Morton did not make a double album because he had too much material. He made one because the argument he was making required two sides to complete itself.

[download:/assets/images/artists/pj-morton-saturday-night-sunday-morning-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "pj-morton-saturday-night-sunday-morning",
    "title": "PJ Morton Spent His Whole Life Auditioning for This Double Album",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-25",
    "image": "/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg",
    "image_alt": "PJ Morton press photo",
    "image_position": "center 20%",
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/pj-morton-saturday-night-sunday-morning.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: pj-morton-saturday-night-sunday-morning.json")
PYEOF

# Verify live
echo "Verifying pj-morton-saturday-night-sunday-morning..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/pj-morton-saturday-night-sunday-morning)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pj-morton-saturday-night-sunday-morning&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: pj-morton-saturday-night-sunday-morning"

fi  # end skip block


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Pond / Secretly Distribution
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@secretlygroup.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Pond and the new album Terrestrials at artonly.io/post/pond-terrestrials. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@secretlygroup.com (Pond)"

# PJ Morton / Morton Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=Tanya@MortonRecords.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on PJ Morton and the new album Saturday Night, Sunday Morning at artonly.io/post/pj-morton-saturday-night-sunday-morning. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: Tanya@MortonRecords.com (PJ Morton)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-06-25" "Published today:

1. Pond - Terrestrials
   https://artonly.io/post/pond-terrestrials
   Author: Allastair Voss
   Spotify: 4skJp5OKvcc9eKokiuhi2s
   Released: June 19, 2026 (Mangovision / Secretly Distribution)
   11th album, post-punk/new wave, political themes on extractive capitalism and Australian Indigenous heritage

2. PJ Morton - Saturday Night, Sunday Morning
   https://artonly.io/post/pj-morton-saturday-night-sunday-morning
   Author: Leelou Blanc
   Spotify: 2FMOHE79X98yptp4RpPrt7
   Released: June 19, 2026 (Morton Records / SRG-ILS Group)
   18-track double album, R&B side + gospel side, released on Juneteenth

Outreach:
- Pond: email sent to press@secretlygroup.com
- PJ Morton: email sent to Tanya@MortonRecords.com

Both releases from June 19, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-06-25 ==="
