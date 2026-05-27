#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-27
# Posts: lowertown-ugly-duckling-union, balming-tiger-gongbu
# Run this on the DreamHost server via SSH:
# sshpass -p PASSWORD ssh dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-27.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-27 ==="

# ---- POST 1: Lowertown - Ugly Duckling Union ----
echo "--- Deploying: lowertown-ugly-duckling-union ---"

# Download press photo (Brooklyn Vegan article image, photo credit Shamshawan Scott)
python3 -c "
import urllib.request, re, sys

def fetch(url, agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'):
    req = urllib.request.Request(url, headers={'User-Agent': agent, 'Accept': 'text/html,application/xhtml+xml'})
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

def download_img(src, dest):
    req = urllib.request.Request(src, headers={'User-Agent': 'Mozilla/5.0', 'Referer': 'https://www.brooklynvegan.com/'})
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        f.write(r.read())

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/lowertown-ugly-duckling-union.jpg'

# Try Brooklyn Vegan article
try:
    html = fetch('https://www.brooklynvegan.com/lowertown-announce-new-album-tour-share-i-like-you-a-lot/')
    imgs = re.findall(r'https?://[^\s\"\'<>]*lowertown[^\s\"\'<>]*\.(jpg|jpeg)', html, re.IGNORECASE)
    if not imgs:
        # get any large article image
        imgs = re.findall(r'https?://[^\s\"\'<>]+media\.brooklynvegan[^\s\"\'<>]*\.(jpg|jpeg)', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0][0] if isinstance(imgs[0], tuple) else imgs[0], dest)
        print('Downloaded from Brooklyn Vegan')
        sys.exit(0)
except Exception as e:
    print(f'Brooklyn Vegan failed: {e}')

# Try Brooklyn Vegan 5/22 notable releases article
try:
    html = fetch('https://www.brooklynvegan.com/notable-releases-of-the-week-5-22/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]*lowertown[^\s\"\'<>]*\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://media\.brooklynvegan\.com/img/[^\s\"\'<>]*\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest)
        print('Downloaded from Brooklyn Vegan weekly')
        sys.exit(0)
except Exception as e:
    print(f'BV weekly failed: {e}')

# Try Still Listening Magazine
try:
    html = fetch('https://www.stilllisteningmagazine.com/features/lowertown-announce-new-album-ugly-duckling-union')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg|webp))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest)
        print('Downloaded from Still Listening')
        sys.exit(0)
except Exception as e:
    print(f'Still Listening failed: {e}')

# Fallback: album art from Bandcamp
try:
    html = fetch('https://lowertown.bandcamp.com/album/ugly-duckling-union')
    imgs = re.findall(r'(https?://f4\.bcbits\.com/img/[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'\"tralbumArt\".*?(https?://[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE | re.DOTALL)
    if imgs:
        download_img(imgs[0], dest)
        print('Downloaded Bandcamp album art as fallback')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp failed: {e}')

print('All image sources failed; using ImageMagick placeholder')
import subprocess
subprocess.run(['convert', '-size', '1200x800', 'gradient:gray20-gray40', dest])
"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert lowertown-ugly-duckling-union.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  lowertown-ugly-duckling-union-up.jpg && mv lowertown-ugly-duckling-union-up.jpg lowertown-ugly-duckling-union.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py lowertown-ugly-duckling-union \
  "In a Basement in New York, Lowertown Built a World" music

# Write post JSON
cat > ~/artonly.io/posts/lowertown-ugly-duckling-union.json << 'JSONEOF'
{
  "slug": "lowertown-ugly-duckling-union",
  "title": "In a Basement in New York, Lowertown Built a World",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-27",
  "image": "/assets/images/artists/lowertown-ugly-duckling-union.jpg",
  "image_alt": "Lowertown press photo",
  "image_position": "center 30%",
  "body": "[spotify:artist/1yI0RRPnOA9BFJmiZ6cEzw]\n\nThere is a specific kind of artistic statement that can only be made from inside a basement. Not the polished version of grit that gets recorded in expensive rooms designed to sound imperfect, but actual imperfection, actual rats, actual walls that breathe with the city above them. Lowertown's second album, Ugly Duckling Union, was written and recorded and produced and mixed entirely by Olivia Osby and Avsha Weinberg in Weinberg's basement in New York, and that fact is not incidental to what the album is. It is the album's first argument.\n\nOsby and Weinberg met in a high school math class in Atlanta in 2018. They were both listening to things no one around them seemed to be listening to, and the shared obsession became a friendship, and the friendship became a band. Lowertown has been building toward this record since then, through years of DIY releases and European tours and a quiet, sustained credibility that comes from never overselling what you are. They signed to Summer Shade, a boutique imprint under Run For Cover Records, and they made an album that earns the trust of everyone who has been watching.\n\nThe first track is called Mice Protection. The title is Weinberg's homage to the rats that shared the basement while the record was being made. That particular detail, a track named after the rodents in the room, tells you almost everything you need to know about Lowertown's relationship to authenticity. This is not an aesthetic choice being performed. This is an account of actual conditions.\n\n## A Story About Who Controls the Story\n\nUgly Duckling Union is a concept album, but it is a concept album in the tradition of Gorillaz and Fugazi rather than in the tradition of prog rock or stadium opera. The concept serves the music rather than demanding it. At its center is Dale, a duckling protagonist who leaves home, finds a community of misfits, and leads them in an effort to dismantle LBH, a tyrannical media corporation that profits from separating and isolating people. The story is told across twelve tracks, and it is accompanied by a playable Minecraft world, a handbook, comics drawn by Doctor Nowhere, and handmade plush dolls of the characters.\n\nThe reference to Gorillaz is one the band has made explicitly. The transmedia dimension of Gorillaz, the cartoon personas and the visual world and the way the music existed as part of a larger project rather than as the whole project, is something Lowertown has taken seriously as a model. But where Gorillaz uses the extended world to maintain a kind of mystery about its creators, Lowertown uses it to invite listeners in. The Minecraft world is not a promotion. It is a place where the community of Ugly Duckling Union can actually gather.\n\nThe Fugazi reference is subtler but more important. Fugazi built a practice of music as a collective resource rather than as a commodity. Their commitment to affordable shows, to direct distribution, to rejecting the machinery that separates artists from audiences, was not a marketing strategy. It was a philosophy. Lowertown does not have Fugazi's intensity or their politics exactly, but they have the same core instinct: that music should actually reach the people it is for, and that the structures built around music often prevent that from happening.\n\nLBH, the villain of Ugly Duckling Union, is obviously a stand-in for those structures. What makes the album's politics function is that they are not abstract. They are embodied in the duckling and his community, in the story of misfits who are better off together than apart.\n\n## What Living in the Margins Sounds Like\n\n[img:/assets/images/artists/lowertown-ugly-duckling-union.jpg]\n\nThe music itself is what Stereogum, in naming it Album of the Week, called gnarled and heady. That is accurate. The album moves between thrashing garage rock and soothing lullaby passages without warning and without explanation, and the transitions feel like the record breathing. The production is lo-fi not because Osby and Weinberg could not afford otherwise but because the grit is load-bearing. Mice Protection opens the record with an acoustic confession. Worst Friend is abrasion and yearning in roughly equal measure. I Like You a Lot, the lead single, is the closest thing to a pop song on the record and still sounds like it was made in the same basement, with the same rats, at the same hour.\n\nPaste Magazine wrote that the album disentangles a friendship in a sprawling, concept-forward meditation on shame, blame, desire, isolation, and companionship. That is a fair description of the content. But the form matters as much as the content here. The fact that this record is self-produced is not a technical detail. It means that every sound on Ugly Duckling Union was chosen by the people who wrote the songs, that no outside process inserted itself between the feeling and the recording of the feeling. That kind of directness is increasingly rare in indie music, where the aesthetics of DIY are often purchased rather than practiced.\n\n## What the Mainstream Missed\n\nLowertown is one of the five best albums of May 22, 2026 according to NPR Music, and Stereogum gave it the week. That recognition matters not because critical attention is the point but because it confirms that the album is operating at a level where the argument it is making can actually be heard.\n\nThe argument is about what music can be when it is made without the infrastructure of the mainstream. Not smaller or quieter, not less ambitious. The Ugly Duckling Union transmedia world is more ambitious than most major label album rollouts. It is just structured differently, for a different kind of attention, for an audience that wants to be participants rather than consumers.\n\nOsby and Weinberg have the talent and the songwriting instincts to navigate the machinery of the music industry if they chose to. The fact that they do not choose to is the point. \"Ugly is not a bad term to me,\" Osby told The Needle Drop in an interview around the album. The world they built in that New York basement is ugly in the best sense, alive with friction and weirdness and the smell of whatever was growing in the walls. It is also, in twelve tracks and a Minecraft world and a handful of plush ducks, a complete argument for a different way of existing in music.\n\nSome Things Never End is the last track on Ugly Duckling Union. The title is the record's final statement. The community Dale builds in the story, the one that defeats the media corporation by refusing to be isolated, does not dissolve when the record ends. It continues, somewhere, in the Minecraft world, in the comics, in the hands of whoever bought the plush doll. Lowertown built a world in a basement. That is not nothing. That is, in fact, the whole point.\n\n[download:/assets/images/artists/lowertown-ugly-duckling-union-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "lowertown-ugly-duckling-union deployed"

# ---- POST 2: Balming Tiger - Gongbu ----
echo "--- Deploying: balming-tiger-gongbu ---"

# Download press photo (by Nikolai Ahn, available via G-A-Y Heaven press materials)
python3 -c "
import urllib.request, re, sys

def fetch(url, referer=None):
    headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(url, headers=headers)
    return urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='ignore')

def download_img(src, dest, referer=None):
    headers = {'User-Agent': 'Mozilla/5.0', 'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8'}
    if referer:
        headers['Referer'] = referer
    req = urllib.request.Request(src, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        f.write(r.read())

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/balming-tiger-gongbu.jpg'

# Try G-A-Y Heaven WordPress image (Photo Credit Nikolai Ahn)
for year_month in ['2024/03', '2024/04', '2023/12', '2025/01']:
    try:
        url = f'https://g-a-yandheaven.co.uk/wp-content/uploads/{year_month}/6f4012d5_Balming-Tiger-Press-Pic-1-Photo-Credit-Nikolai-Ahn.jpg'
        download_img(url, dest, 'https://g-a-yandheaven.co.uk/')
        print(f'Downloaded from G-A-Y Heaven ({year_month})')
        sys.exit(0)
    except Exception as e:
        print(f'G-A-Y Heaven {year_month} failed: {e}')

# Try Shore Fire Media press releases page for downloadable photo
try:
    html = fetch('https://shorefire.com/roster/releases/16540')
    imgs = re.findall(r'(https?://[^\s\"\'<>]*balming.?tiger[^\s\"\'<>]*\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://shorefire\.com/wp-content/uploads/[^\s\"\'<>]*\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, 'https://shorefire.com/')
        print('Downloaded from Shore Fire Media')
        sys.exit(0)
except Exception as e:
    print(f'Shore Fire failed: {e}')

# Try their official site
try:
    html = fetch('https://balmingtiger.com/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]+(?:press|photo|artist|members)[^\s\"\'<>]*\.(?:jpg|jpeg|webp|png))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest, 'https://balmingtiger.com/')
        print('Downloaded from official site')
        sys.exit(0)
except Exception as e:
    print(f'Official site failed: {e}')

# Try Clash Magazine article
try:
    html = fetch('https://www.clashmusic.com/news/balming-tiger-confirm-new-album-gongbu/')
    imgs = re.findall(r'(https?://[^\s\"\'<>]*(?:cdn|media|images)\.clashmusic[^\s\"\'<>]*\.(?:jpg|jpeg))', html, re.IGNORECASE)
    if not imgs:
        imgs = re.findall(r'(https?://[^\s\"\'<>]+\.(?:jpg|jpeg))', html, re.IGNORECASE)
        imgs = [i for i in imgs if 'balming' in i.lower() or 'tiger' in i.lower() or 'clash' in i.lower()]
    if imgs:
        download_img(imgs[0], dest, 'https://www.clashmusic.com/')
        print('Downloaded from Clash Magazine')
        sys.exit(0)
except Exception as e:
    print(f'Clash failed: {e}')

# Fallback: album art from Bandcamp page
try:
    html = fetch('https://balmingtiger.bandcamp.com/')
    imgs = re.findall(r'(https?://f4\.bcbits\.com/img/[^\s\"\'<>]+\.jpg)', html, re.IGNORECASE)
    if imgs:
        download_img(imgs[0], dest)
        print('Downloaded Bandcamp fallback')
        sys.exit(0)
except Exception as e:
    print(f'Bandcamp fallback failed: {e}')

print('All image sources failed; using ImageMagick placeholder')
import subprocess
subprocess.run(['convert', '-size', '1200x800', 'gradient:gray20-gray40', dest])
"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert balming-tiger-gongbu.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  balming-tiger-gongbu-up.jpg && mv balming-tiger-gongbu-up.jpg balming-tiger-gongbu.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py balming-tiger-gongbu \
  "Balming Tiger Builds a Research Institute for the Unconscious Mind" music

# Write post JSON
cat > ~/artonly.io/posts/balming-tiger-gongbu.json << 'JSONEOF'
{
  "slug": "balming-tiger-gongbu",
  "title": "Balming Tiger Builds a Research Institute for the Unconscious Mind",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-27",
  "image": "/assets/images/artists/balming-tiger-gongbu.jpg",
  "image_alt": "Balming Tiger press photo",
  "image_position": "center 25%",
  "body": "[spotify:artist/6vbKIm1WsvhMMDpthYONc1]\n\nThe word gongbu means study in Korean. It is the kind of word that exists in most languages but carries different weight depending on where it lands. In Korean educational culture, where academic achievement has historically functioned as both a survival mechanism and a social pressure system, the word has a specific gravity. Balming Tiger knows this. They named their second full album after the word and then built a fictional research institute around it, calling the whole conceptual framework Gongbu Korea, a facility that uses experimental technologies to observe and document human dreams and the unconscious. The album came out May 19 on their own infrastructure, fourteen tracks of psychedelic electronics and Korean and East Asian musical textures that sound like exactly what the concept describes: a study of something that does not fully cooperate with being studied.\n\nThe Seoul-based collective consists of Omega Sapien, sogumm, Mudd the Student, bj wnjn, Leesuho, and Unsinkable. They have been operating since the early 2020s at the intersection of K-pop, Korean hip-hop, and a kind of alternative weirdness that does not translate neatly into any Western genre category. Their 2022 single Sexy Nukim, featuring RM from BTS, introduced them to a significantly larger international audience. Their 2023 debut album January Never Dies established what they actually were, which was something more patient and stranger than any single viral moment could contain. Gongbu is what comes after the establishment. It is the deeper claim.\n\n## The Research Institute as Frame\n\nThe fictional Gongbu Korea institute is described as a place where experimental technologies observe and document human dreams and the unconscious mind. That description does double work. On the literal level it is a narrative frame, an invented institution that gives the album its visual and conceptual identity. The album artwork, created by artist Keem Dohyeong, depicts all six members within this institutional aesthetic, portraits that look like they could be ID cards for researchers at a facility that does not exist but should.\n\nOn the metaphorical level, the description is an accurate account of what the album actually does. Gongbu is structured like a study. It observes its own cultural materials, the specific textures of Korean popular music, the psychedelic strain running through Seoul's independent music scene, the pressure and longing and humor that exist in a collective of young Korean artists making work for a global audience, and it documents all of this without reducing any of it to an explanation. The unconscious does not explain itself. The album does not either.\n\nThe lead single Home asks each member to reinterpret what home means. Not home as a concept but home as a felt place, as a thing your body knows before your mind catches up. bj wnjn, sogumm, Mudd the Student, Lee Suho, and San Yawn each bring a different version of the answer, and the track works precisely because none of the versions resolves the question. The song ends with the question still open, which is the correct answer to that kind of question.\n\n## The Sound of Studying the Self\n\n[img:/assets/images/artists/balming-tiger-gongbu.jpg]\n\nThe music on Gongbu is psychedelic in the specific sense that it alters perspective rather than simply providing stimulation. The fourteen tracks use synthesizers and live instrumentation in ways that blur where the organic ends and the processed begins. Korean folk music traditions appear as motifs that have been put through something, not erased but transformed, the way memory transforms the things it keeps. The album has been described as dreamlike and nostalgic and faintly hallucinatory, and all three of those words are doing different work. The nostalgia is not sentimental. It is analytical. The dream quality is not escapism. It is method.\n\nBalming Tiger has consistently stated their ambition to create a single worldview in which sound design, visuals, identity, music video direction, and live performance are all consistently connected. This is what the best artists always want and rarely fully achieve. On Gongbu they come closer than they have before. The album sounds like the album looks like how the members describe it in interviews. There is a consistency of sensibility across the whole project that marks it as something built rather than assembled.\n\nThe collective structure matters here. Six people with six different aesthetic instincts, all operating within the same conceptual frame, produces a music that has internal variation and argument. The album does not sound like six separate visions stitched together. It sounds like six people who have been arguing productively for years, who have found the specific harmony that only disagreement over time can produce.\n\n## On Being Korean and International\n\nBalming Tiger occupies a specific cultural position that is worth naming directly. They are Korean artists who have found a global audience without sanitizing their Koreanness, without performing a version of Korean culture that is comfortable for international consumption, and without disappearing into an international style that erases where they came from. This is harder than it sounds. The pressure on Korean artists with global reach to choose between legibility and authenticity is enormous and structural.\n\nGongbu navigates this pressure by choosing the unconscious as its subject matter. The unconscious is not national. Dreams do not submit to cultural translation. When Balming Tiger builds a research institute for the unconscious, they are building a space where the question of what is Korean and what is global becomes secondary to the question of what is real. Not real in the sense of unmediated, because nothing on this album is unmediated. Real in the sense of felt, of belonging to actual experience rather than to the representation of experience.\n\nThe RM collaboration of 2022 raised their profile. Profile is useful but it is not the work. What Balming Tiger has done with the attention is refuse to simplify in response to it. January Never Dies felt like falling down a rabbit hole, as one reviewer noted. Gongbu goes deeper into the same space, further from the entrance, where the logic of the surface world no longer applies.\n\n## What the Study Finds\n\nNPR Music included Gongbu in their New Music Friday roundup for the week of May 22, 2026, a week that also included Bleachers, JPEGMAFIA, Ed O'Brien, and aja monet. That is a good week to be part of and a competitive one. The fact that Gongbu belongs in that company is not obvious to everyone and should be named. It is an album from a Korean collective working in a register that does not have obvious Western analogues, and it is one of the more fully realized records of the year so far.\n\nGongbu Korea, the fictional research institute, studies what cannot be fully known. The six members of Balming Tiger study themselves and their culture and the spaces between. The album they have made is the report from that study, fourteen tracks of findings that do not conclude. Research does not conclude. It deepens, and it asks better questions. Gongbu is the second study. There will be more.\n\n[download:/assets/images/artists/balming-tiger-gongbu-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "balming-tiger-gongbu deployed"

# ---- IndexNow pings ----
echo "--- Pinging IndexNow ---"
LT_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/lowertown-ugly-duckling-union")
echo "artonly.io/post/lowertown-ugly-duckling-union: HTTP $LT_CODE"

BT_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/balming-tiger-gongbu")
echo "artonly.io/post/balming-tiger-gongbu: HTTP $BT_CODE"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/lowertown-ugly-duckling-union&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: lowertown-ugly-duckling-union pinged"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/balming-tiger-gongbu&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: balming-tiger-gongbu pinged"

# ---- Outreach emails ----
echo "--- Sending outreach emails ---"

# Lowertown - Summer Shade / Run For Cover Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@runforcoverrecords.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Lowertown and Ugly Duckling Union at artonly.io/post/lowertown-ugly-duckling-union. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

# Balming Tiger - Shore Fire Media PR
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=balmingtiger@shorefire.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Balming Tiger and Gongbu at artonly.io/post/balming-tiger-gongbu. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

echo "=== Deploy complete ==="
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-05-27" \
  "Published today:\n\nhttps://artonly.io/post/lowertown-ugly-duckling-union\nhttps://artonly.io/post/balming-tiger-gongbu\n\nOutreach: press@runforcoverrecords.com (Lowertown / Summer Shade), balmingtiger@shorefire.com (Balming Tiger / Shore Fire Media)"
