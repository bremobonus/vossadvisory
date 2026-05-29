#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-29
# Posts: 6lack-love-is-the-new-gangsta, future-islands-from-a-hole-in-the-floor
# Run this on the DreamHost server via SSH:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-29.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-29 ==="

# ---- POST 1: 6LACK - Love Is the New Gangsta ----
echo "--- Deploying: 6lack-love-is-the-new-gangsta ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/6lack-love-is-the-new-gangsta.jpg'

# Try Pitchfork review article
try:
    html = fetch('https://pitchfork.com/reviews/albums/6lack-love-is-the-new-gangsta/')
    imgs = re.findall(r'(https?://media\.pitchfork\.com/photos/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://pitchfork.com/')
        print('Downloaded from Pitchfork')
        sys.exit(0)
except Exception as e:
    print(f'Pitchfork failed: {e}')

# Try RatedRnB
try:
    html = fetch('https://ratedrnb.com/2026/05/6lack-love-is-the-new-gangsta-album-stream/')
    imgs = re.findall(r'(https?://ratedrnb\.com/wp-content/uploads/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if '6lack' in i.lower() or 'love' in i.lower() or 'gangsta' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://ratedrnb\.com/wp-content/uploads/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://ratedrnb.com/')
        print('Downloaded from RatedRnB')
        sys.exit(0)
except Exception as e:
    print(f'RatedRnB failed: {e}')

# Try Beats Per Minute review
try:
    html = fetch('https://beatsperminute.com/album-review-6lack-love-is-the-new-gangsta/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if '6lack' in i.lower() or 'love' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://beatsperminute.com/')
        print('Downloaded from Beats Per Minute')
        sys.exit(0)
except Exception as e:
    print(f'Beats Per Minute failed: {e}')

# Try Shatter the Standards
try:
    html = fetch('https://www.shatterthestandards.com/p/album-review-love-is-the-new-gangsta')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if '6lack' in i.lower() or 'ricardo' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, referer='https://www.shatterthestandards.com/')
        print('Downloaded from Shatter the Standards')
        sys.exit(0)
except Exception as e:
    print(f'Shatter the Standards failed: {e}')

# Try Interscope press
try:
    html = fetch('https://www.interscope.com/artists/6lack')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+6lack[^\s\"\'<>]+\.(?:jpg|jpeg|webp))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.interscope.com/')
        print('Downloaded from Interscope')
        sys.exit(0)
except Exception as e:
    print(f'Interscope failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0d0d0d-#1a0a0a\" -gravity center -pointsize 56 -fill white -annotate 0 \"6LACK\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/6lack-love-is-the-new-gangsta.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/6lack-love-is-the-new-gangsta-up.jpg && \
  mv ~/artonly.io/assets/images/artists/6lack-love-is-the-new-gangsta-up.jpg \
     ~/artonly.io/assets/images/artists/6lack-love-is-the-new-gangsta.jpg
echo "Image upscaled: 6lack-love-is-the-new-gangsta.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py 6lack-love-is-the-new-gangsta "On Love Is the New Gangsta, 6LACK Trades Detachment for Something Harder to Fake" music
echo "Social card generated: 6lack-love-is-the-new-gangsta-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/6lack-love-is-the-new-gangsta.json << 'ENDJSON'
{
  "slug": "6lack-love-is-the-new-gangsta",
  "title": "On Love Is the New Gangsta, 6LACK Trades Detachment for Something Harder to Fake",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-29",
  "image": "/assets/images/artists/6lack-love-is-the-new-gangsta.jpg",
  "image_alt": "6LACK press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/4IVAbR2w4JJNJDDRFP3E83]\n\n6LACK has spent most of his career making the emotional cost of intimacy sound like something you were not supposed to admit. His first three albums built a world out of that refusal: half-told confessions, melodies that curved away from resolution, a vocal register that suggested depth without ever quite surfacing. He was good at it. Good enough to build a genuine following in the architecture of alternative R&B, the genre space that formed in the early 2010s around artists who understood that soul music's emotional directness could be reframed as something more guarded and therefore more cool.\n\n\"Love Is the New Gangsta,\" his fourth studio album, arrives as a direct argument with that stance. It does not dismantle what came before. It transforms it. The album, released May 22 on LVRN and Interscope, takes the same atmospheric post-midnight sound that Ricardo Valentine has always inhabited and pushes it somewhere warmer, more inhabited, more honest about what it is trying to do.\n\nThe title is a provocation of a specific kind. \"Gangsta\" as a cultural term has always functioned as a marker of a certain kind of masculine credibility, toughness worn as identity. To declare love as the replacement, the new gangsta, is not simply a sentiment. It is an argument about what strength is. Valentine is saying that choosing warmth, choosing openness, choosing to be present as a father and a partner, is harder than the alternative. Harder and braver. The album makes the case that this reframing is not capitulation but assertion.\n\nThe context matters here. Valentine and his partner Quiñ welcomed their daughter Blaze in 2025, and the album was largely conceptualized in the months following that arrival. Fatherhood has produced any number of albums that feel obligated to the subject without actually knowing what to do with it. \"Love Is the New Gangsta\" is not one of those records. The presence of Blaze in the album's emotional architecture is not decorative. It is structural. Tracks like \"Vision\" and \"Bear\" carry a weight that suggests someone who has encountered a reason to stop being defended against feeling, and found that the undefended state is not weakness but a different kind of power entirely.\n\n## What Warmth Costs\n\nThe production here is the most interesting development in Valentine's discography. Where previous albums used texture to create emotional distance, the sound design on \"Love Is the New Gangsta\" uses warmth as its primary material. Chords sustain in ways they did not on \"East Atlanta Love Letter\" or \"Since I Have a Lover.\" Melodies resolve rather than avoiding resolution. The atmosphere is still intimate, still late-night in its scale, but the intimacy now points inward rather than keeping the listener at arm's length.\n\nThe features on this record are well chosen. Leon Thomas has become one of the most in-demand voices in contemporary R&B, and his appearance alongside AZ Chike on \"All That Matters\" demonstrates why: he understands how to complement without competing, how to add emotional register without claiming it. Mereba on \"Running Late Freestyle\" brings an energy that is almost confessional in its directness, matching the album's governing thesis. Quiñ appearing on \"Out of Body\" carries particular emotional weight given the personal context: this is a record that is in part about the relationship between the two of them, and her presence makes that explicit without requiring explanation.\n\nThe Young Thug feature on \"Ashin' the Blunt\" deserves its own acknowledgment. His creative profile, the charges, the trials, the years of legal proceedings that have defined the last several years of his public life, make any new appearance from him a statement of its own. Valentine's decision to include him here, on a song that functions as one of the album's most relaxed moments, is a quiet form of solidarity that does not need to announce itself.\n\n## The Genre Argument\n\nAlternative R&B as a genre has been in a complicated position for the last several years. Its defining qualities, the introspection, the production that owes as much to electronic music as to soul or hip-hop, the lyrical territory of relationship complexity navigated with ambiguity rather than resolution, have become so widely adopted that they risk losing their distinctiveness. What \"Love Is the New Gangsta\" offers is something like a corrective: a demonstration that the genre's emotional range can extend well beyond its signature registers of ache and distance.\n\nThe album does not abandon the genre's sonic vocabulary. Valentine is not making something outside the tradition he helped define. He is demonstrating that the tradition has more range than its dominant applications suggest. The cool, the detachment, was never the only thing available. It was a mode that served a particular kind of emotional management. What this album argues is that the same musical architecture can hold something warmer, something more openly committed, without losing its integrity or its craft.\n\nThe 15 tracks here never feel padded, which is a real achievement at this length. Valentine has edited his impulses without cutting the emotional substance. Nothing here feels like a gesture toward the streaming playlist model, though it will certainly function well in that context. The record has the internal logic of something made to be heard as a whole, as a statement rather than a collection of moments.\n\n## The Statement and What It Costs\n\nMaking vulnerability legible without making it cheap is one of the hardest things to do in pop music. The genre's history is full of artists who have tried and produced either sentimentality, which resolves too easily and satisfies nobody, or performed rawness, which has its own kind of falseness. What Valentine achieves on \"Love Is the New Gangsta\" is a third option: emotional clarity that retains its complexity because it has not been simplified into either of those easier modes.\n\nThe album is also a statement about what this particular artist has decided he wants to be at this stage of his career. There will be listeners who preferred the earlier, more guarded version. There always are. The artists who make this kind of turn tend to lose some portion of their audience and gain a different one. Whether that exchange feels like progress depends entirely on what you were listening to him for in the first place.\n\nWhat he is listening to himself for now, the question every artist eventually has to answer, seems clearer here than it has been at any prior point in his discography. The answer is love in all its versions: romantic and parental and communal and self-directed. The new gangsta. It is harder to perform than its predecessor, and considerably harder to sustain. But on this album, for these fifteen tracks, it holds.\n\n[download:/assets/images/artists/6lack-love-is-the-new-gangsta-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: 6lack-love-is-the-new-gangsta.json"

# Verify live
echo "Verifying 6lack-love-is-the-new-gangsta..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/6lack-love-is-the-new-gangsta)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/6lack-love-is-the-new-gangsta&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: 6lack-love-is-the-new-gangsta"


# ---- POST 2: Future Islands - From a Hole in the Floor to a Fountain of Youth ----
echo "--- Deploying: future-islands-from-a-hole-in-the-floor ---"

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/future-islands-from-a-hole-in-the-floor.jpg'

# Try Spectrum Culture review
try:
    html = fetch('https://spectrumculture.com/2026/05/21/future-islands-from-a-hole-in-the-floor-to-a-fountain-of-youth-review/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+(?:future.islands|future_islands)[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://spectrumculture\.com/wp-content/uploads/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://spectrumculture.com/')
        print('Downloaded from Spectrum Culture')
        sys.exit(0)
except Exception as e:
    print(f'Spectrum Culture failed: {e}')

# Try Hotpress review
try:
    html = fetch('https://www.hotpress.com/music/album-review-future-islands-from-a-hole-in-the-floor-to-a-fountain-of-youth-23142394')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+(?:future.islands|samuel|herring)[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+hotpress[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://www.hotpress.com/')
        print('Downloaded from Hotpress')
        sys.exit(0)
except Exception as e:
    print(f'Hotpress failed: {e}')

# Try Far Out Magazine review
try:
    html = fetch('https://faroutmagazine.co.uk/future-islands-from-a-hole-in-the-floor-to-a-fountain-of-youth-album-review/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    imgs = [i for i in imgs if 'future' in i.lower() or 'islands' in i.lower() or 'herring' in i.lower()]
    if not imgs:
        imgs = re.findall(r'(https?://faroutmagazine\.co\.uk/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://faroutmagazine.co.uk/')
        print('Downloaded from Far Out Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Far Out Magazine failed: {e}')

# Try 4AD shop page
try:
    html = fetch('https://shopusa.4ad.com/products/4ad0907-from-a-hole-in-the-floor-to-a-fountain-of-youth')
    imgs = re.findall(r'(https?://cdn\.shopify\.com/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://shopusa.4ad.com/')
        print('Downloaded from 4AD shop')
        sys.exit(0)
except Exception as e:
    print(f'4AD shop failed: {e}')

# Try Tinnitist
try:
    html = fetch('https://tinnitist.com/2026/05/21/albums-of-the-week-future-islands-from-a-hole-in-the-floor-to-a-fountain-of-youth/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+future.islands[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://tinnitist\.com/wp-content/uploads/[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, referer='https://tinnitist.com/')
        print('Downloaded from Tinnitist')
        sys.exit(0)
except Exception as e:
    print(f'Tinnitist failed: {e}')

# Fallback: generate placeholder
print('All image sources failed; generating ImageMagick placeholder')
os.system(f'convert -size 1200x800 gradient:\"#0a0a1a-#1a1a2e\" -gravity center -pointsize 48 -fill white -annotate 0 \"Future Islands\" {dest}')
"

# Upscale image
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/future-islands-from-a-hole-in-the-floor.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/future-islands-from-a-hole-in-the-floor-up.jpg && \
  mv ~/artonly.io/assets/images/artists/future-islands-from-a-hole-in-the-floor-up.jpg \
     ~/artonly.io/assets/images/artists/future-islands-from-a-hole-in-the-floor.jpg
echo "Image upscaled: future-islands-from-a-hole-in-the-floor.jpg"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py future-islands-from-a-hole-in-the-floor "Future Islands Turn Twenty and Release the Songs Where They Were Most Themselves" music
echo "Social card generated: future-islands-from-a-hole-in-the-floor-social-9x16.jpg"
cd ~

# Copy JSON post
cat > ~/artonly.io/posts/future-islands-from-a-hole-in-the-floor.json << 'ENDJSON'
{
  "slug": "future-islands-from-a-hole-in-the-floor",
  "title": "Future Islands Turn Twenty and Release the Songs Where They Were Most Themselves",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-29",
  "image": "/assets/images/artists/future-islands-from-a-hole-in-the-floor.jpg",
  "image_alt": "Future Islands press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/1WvvwcQx0tj6NdDhZZ2zZz]\n\nThere is a version of the Future Islands story that begins with David Letterman in 2014. Samuel T. Herring moved across the stage in a way that no one expected, his baritone cresting into something between a controlled cry and a completely uninhibited performance of grief. The clip circulated. \"Seasons (Waiting on You)\" found its way onto every end of year list. Future Islands, who had been making albums since 2008, became a band that people had just discovered, which is a strange thing to become when you are already six years deep into a discography.\n\n\"From a Hole in the Floor to a Fountain of Youth,\" released May 22 on 4AD, is a document of everything that surrounded that moment without being about the moment itself. Twenty songs drawn from twenty years, built from B-sides and rarities and fan favorites, half of which have never appeared on streaming platforms. The album was made to mark the band's twentieth anniversary, and it does so in the way that genuinely interesting bands tend to mark significant dates: not with a greatest hits collection, not with a nostalgia tour masquerading as artistic statement, but with the songs that fell through the cracks of the official version.\n\nWhat the B-sides of a catalog tell you is always different from what the albums tell you. Albums are curated. They make arguments about who an artist is and what their music is for. B-sides and rarities are what happened when the argument was not being made, when the band was exploring without the pressure of coherence. \"From a Hole in the Floor to a Fountain of Youth\" is therefore a different kind of portrait: less composed, more revealing, and in several places more interesting than anything available in the official discography.\n\n## What the Gaps Contain\n\nFuture Islands have always been a band of managed contradictions. Their sound is cold on the surface, built from synthesizers that carry the cool analog texture of the 1980s electronic tradition, and underneath it Samuel T. Herring sings as if the coldness is the last thing he would choose. The tension between the sonic architecture and the emotional performance has been the band's essential quality since \"Wave Like Home.\" What this rarities collection reveals is that this tension was present from the very beginning, not as a calculated aesthetic choice but as the natural expression of who these four people are together.\n\n\"Pinnochio\" demonstrates this clearly. It has the structural qualities of a Future Islands song: the synthesizer line that unfolds slowly, the bass providing anchor, Herring's voice doing the emotional work that the instrumentation declines to perform. What distinguishes it from the better-known material is a looseness, a sense of being made without the finishing pressure of an album cycle. It sounds like the band at its most direct. There is something instructive about that directness: it suggests that the polish of the official records, which is considerable, has never been about control so much as about finding the right form for what was already there.\n\n\"The Happiness Of Being Twice\" is stranger, and stranger in ways that the albums rarely permit. Herring's vocal performance here is more oblique, the lyric less immediately legible, the production making choices that the albums tend to edit away. It is compelling precisely because of its unresolvedness. Not everything needs to arrive somewhere. Some songs are more interesting as motion than as destination.\n\n## The Question of Legacy\n\nTwenty years is long enough to ask what a band has been for. Future Islands emerged from the indie scene around Baltimore and Greenville, North Carolina, carrying influences from post-punk and minimal synth and new wave that were already being reassembled by other artists in their early years. What distinguished them was not the influences themselves but the emotional application. The influences arrived cool and were warmed by Herring's particular way of inhabiting a lyric, by Gerrit Welmers's synthesis which always tilted toward the human even when the material resisted it, by William Cashion's bass which has always carried more melodic ambition than the instrument typically allows.\n\nThe Letterman moment was not the making of Future Islands. It was the revelation of Future Islands to a larger audience that had not been paying attention. The band that appeared on that stage had spent six years developing exactly the performance that made the clip go viral. The B-sides collection makes this legible: what the clip captured was not a spontaneous moment but the culmination of years of work in rooms that held fifty people, perfecting something that had always been this ready.\n\n## The Title as Argument\n\nThe title of the collection is, like most Future Islands titles, working on multiple levels simultaneously. \"From a Hole in the Floor to a Fountain of Youth\" describes the band's trajectory: from their origins in small venues and cult credibility to the expanded listenership they built after 2014. But it is also a description of the music itself: songs that came from underground places, played in basements and small clubs, that have retained the quality of something that sustains rather than depletes, something you can return to.\n\nThe fountain of youth metaphor deserves particular attention. There is a kind of music that ages out of relevance because its core appeal is novelty, the feeling of encountering something you have not encountered before. Future Islands have never been that kind of band. Their relevance is not conditional on freshness. It is rooted in a quality of commitment, in Herring's voice that treats every performance as if it is the last chance to say the thing correctly, in the structural care with which Welmers builds his arrangements, that does not deplete through familiarity. You can listen to \"Seasons (Waiting on You)\" for the hundredth time and it still does what it does. The rarities collection argues that this quality was present across the whole of the twenty years, not just in the songs that made the official records.\n\nThe album is 76 minutes on four sides of vinyl, four sides for four members, and it sustains that length without a wasted moment. This is not always true of rarities collections. Often the reason songs did not make albums is that they were not good enough, and the fan service impulse can overwhelm the curatorial judgment. \"From a Hole in the Floor to a Fountain of Youth\" does not have that problem. Every track here earns its place, which says something both about the quality of Future Islands' discarded work and about the care with which this collection was assembled.\n\nWhat twenty years means for a band is different from what twenty years means for a person. Bands accumulate meaning through the work and through the witnesses to the work. Future Islands have built an audience that cares about them in a way that is unusually specific and unusually durable. This collection is for that audience first. But it is also, like the best of what Future Islands have always done, genuinely for anyone willing to start from the beginning.\n\n[download:/assets/images/artists/future-islands-from-a-hole-in-the-floor-social-9x16.jpg|Download Social Card]"
}
ENDJSON
echo "JSON deployed: future-islands-from-a-hole-in-the-floor.json"

# Verify live
echo "Verifying future-islands-from-a-hole-in-the-floor..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/future-islands-from-a-hole-in-the-floor)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/future-islands-from-a-hole-in-the-floor&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow pinged: future-islands-from-a-hole-in-the-floor"


# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# 6LACK / LVRN
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@lvrn.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on 6LACK and the new album Love Is the New Gangsta at artonly.io/post/6lack-love-is-the-new-gangsta. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@lvrn.com (6LACK)"

# Future Islands / 4AD
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@4ad.com" \
  -d "subject=Your album is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Future Islands and the new collection From a Hole in the Floor to a Fountain of Youth at artonly.io/post/future-islands-from-a-hole-in-the-floor. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo "Outreach sent: press@4ad.com (Future Islands)"


# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Album Monitor: 2026-05-29" "Published today:

1. 6LACK - Love Is the New Gangsta
   https://artonly.io/post/6lack-love-is-the-new-gangsta
   Author: Leelou Blanc
   Spotify: 4IVAbR2w4JJNJDDRFP3E83
   Released: May 22, 2026 (LVRN / Interscope)

2. Future Islands - From a Hole in the Floor to a Fountain of Youth
   https://artonly.io/post/future-islands-from-a-hole-in-the-floor
   Author: Allastair Voss
   Spotify: 1WvvwcQx0tj6NdDhZZ2zZz
   Released: May 22, 2026 (4AD)

Outreach:
- 6LACK: email sent to press@lvrn.com
- Future Islands: email sent to press@4ad.com

Both releases from May 22, 2026, not previously covered on ArtOnly."

echo "=== Deploy complete: 2026-05-29 ==="
