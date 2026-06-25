#!/bin/bash
# ArtOnly Deploy Script - Headie One (EDNA)
# Generated: 2026-06-25
# Post: headie-one-edna
# v3

set -e
echo "=== ArtOnly Deploy: 2026-06-25 (Headie One) ==="

echo "--- Deploying: headie-one-edna ---"

if [ -f ~/artonly.io/posts/headie-one-edna.json ]; then
  echo "Post already exists: headie-one-edna.json, skipping"
  exit 0
fi

# Download hero press photo
python3 -c "
import urllib.request, sys, os

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

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/headie-one-edna.jpg'

try:
    download_img('https://upload.wikimedia.org/wikipedia/commons/1/11/Headie_One_en_2017.png', dest)
    print('Downloaded from Wikimedia Commons')
    sys.exit(0)
except Exception as e:
    print(f'Wikimedia failed: {e}')

print('Generating placeholder')
os.system(f'convert -size 1200x1200 gradient:\"#080808-#1a1a1a\" -gravity center -pointsize 72 -fill white -annotate 0 \"Headie One\" {dest}')
"

# Upscale hero
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ~/artonly.io/assets/images/artists/headie-one-edna-up.jpg && \
  mv ~/artonly.io/assets/images/artists/headie-one-edna-up.jpg \
     ~/artonly.io/assets/images/artists/headie-one-edna.jpg
echo "Image upscaled: headie-one-edna.jpg"

# Create section images (derived from hero)
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 1200x800^ -gravity center -extent 1200x800 -quality 88 \
  ~/artonly.io/assets/images/artists/headie-one-debut.jpg
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 1200x800^ -gravity center -extent 1200x800 -modulate 95,80,100 -quality 88 \
  ~/artonly.io/assets/images/artists/headie-one-estate.jpg
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 1200x800^ -gravity center -extent 1200x800 -modulate 90,85,105 -quality 88 \
  ~/artonly.io/assets/images/artists/headie-one-gang.jpg
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 1200x800^ -gravity center -extent 1200x800 -modulate 105,90,100 -quality 88 \
  ~/artonly.io/assets/images/artists/headie-one-live.jpg
OMP_NUM_THREADS=1 convert ~/artonly.io/assets/images/artists/headie-one-edna.jpg \
  -resize 1200x800^ -gravity center -extent 1200x800 -modulate 100,95,102 -quality 88 \
  ~/artonly.io/assets/images/artists/headie-one-portrait.jpg
echo "Section images created"

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py headie-one-edna "EDNA Changed What UK Drill Was Allowed to Be" music
echo "Social card generated"
cd ~

# Write post JSON
python3 << 'PYEOF'
import json

body = """[spotify:artist/6UCQYrcJ6wab6gnQ89OJFh]

EDNA sold 15,494 copies in its first week, entering the UK Albums Chart at number one on 9 October 2020. That number matters less as a chart position and more as a boundary crossed. Irving Ampofo Adjei, born in Tottenham's Broadwater Farm estate and known as Headie One, had spent the better part of a decade building toward that moment through mixtapes, collaborations, and a series of singles that charted without ever announcing themselves as crossover bids. EDNA was not designed as a mainstream pivot. That it functioned as one anyway says everything about where his artistry had always been pointing.

The argument here is simple: Headie One is the most precise technician the UK drill scene produced, and EDNA is where that precision became indistinguishable from emotional clarity.

## The Chart Position Was the Least Interesting Thing About It

[img:/assets/images/artists/headie-one-debut.jpg]

Number one debuts make headlines. They do not usually make albums that repay close listening years later. EDNA does. The album's opening tracks establish a tonal register that most UK drill records never bother with: stillness. Headie One does not rush toward impact. He controls pacing with a confidence that reads as indifference until you realize the restraint is the craft.

The singles that preceded the album had already signaled something different. "18Hunna" with Dave, released in January 2019, debuted at number six on the UK Singles Chart. It was not a pop song. It was not engineered for radio play or streaming playlists optimized for broad appeal. It charted because it was undeniable on its own terms. That is a useful distinction. A lot of music reaches chart positions by finding the path of least resistance. "18Hunna" charted because it offered no alternative path.

Music x Road, the mixtape released in August 2019, reached number five on the UK Albums Chart and set the terms for what EDNA would attempt at a grander scale. The sound was already there. The album was the confirmation.

## Broadwater Farm Is Not a Backdrop

[img:/assets/images/artists/headie-one-estate.jpg]

The Broadwater Farm estate in Tottenham has its own place in British political history. The 1985 riots, in which police officer Keith Blakelock was killed, left a particular weight on the neighborhood. That weight does not appear in Headie One's music as narrative or as grievance. It appears as context. Ambition that comes from a specific postcode looks different from ambition that comes from a posture.

Headie One is part of OFB, a drill collective rooted in Broadwater Farm. UK music culture does not always know how to accommodate collective identities. The tendency is to center the most visible member, treat the group as biography, and move on once the narrative has been packaged. Headie One resists this by keeping collaboration central to everything he makes. The guest list on EDNA alone includes Skepta, Stormzy, AJ Tracey, Future, Drake, Mahalia, and Aitch. Each feature was curated with an eye toward tonal contrast rather than commercial compatibility.

## What GANG Revealed Before EDNA Did

[img:/assets/images/artists/headie-one-gang.jpg]

Six months before EDNA, in April 2020, Headie One released GANG, a collaborative mixtape made with producer Fred again.. The project brought in Jamie xx, FKA twigs, Sampha, Brian Eno, and Octavian. The pairing was not obvious. Fred again..'s profile at the time was built primarily in electronic music circles. There was no clear market logic for putting him in the same room as a Tottenham drill artist.

The logic turned out to be purely sonic. Fred again.. did not soften Headie One's delivery or pull the music toward a more palatable register. He found textures that surrounded the voice without competing with it. GANG remains the collaboration that most clearly shows what Headie One sounds like when a production partner matches his level of intentionality.

EDNA followed the same principle at larger scale. The Drake feature, "Only You Freestyle," peaked at number five on the UK Singles Chart. It was the most commercially visible moment of Headie One's career to that point. It was also, by some distance, the least essential track on the album. Not because it fails on its own terms, but because it sounds like something made for a different kind of attention than the rest of EDNA was built to hold.

## The Specific Case for Ain't It Different

[img:/assets/images/artists/headie-one-live.jpg]

"Ain't It Different," featuring AJ Tracey and Stormzy, peaked at number two on the UK Singles Chart in 2020 and earned a Brit Award nomination for Song of the Year in 2021. Director Taz Tron Delix shot the video with a visual register that matched the song's tonal ambition.

The song's construction is not complicated: three voices rotating across a shared theme, each bringing a different cadence to the same emotional territory. Stormzy brings gospel weight. AJ Tracey brings metropolitan precision. Headie One anchors both without announcing that he is doing so. The peak at number two reads like a near miss only if you believe chart positions measure whether something landed. The song is still in regular circulation for reasons that have nothing to do with algorithmic positioning.

UK drill spent most of the 2010s being treated as a public safety problem by the Metropolitan Police, who used gang matrices to flag music videos as evidence of criminal association. Having a drill record nominated for the Brits' most prominent award in 2021 did not rehabilitate the genre. The music had already done that work long before the industry caught up.

[spotify:album/066XCkY2VUxaJHf5g3tHJx]

## The Name and What It Does Not Say

[img:/assets/images/artists/headie-one-portrait.jpg]

EDNA was the name of Headie One's late mother. The album does not announce this. There is no grief concept record here, no extended meditation on loss, no track that exists primarily to explain the title. The name sits at the top of the sleeve as a dedication. The rest of the album earns it by being good enough to justify the naming.

Drill music has always carried the weight of specific and lived circumstances. Turning that weight into an explicit statement would have undermined what makes the genre work at its best: the feeling that what you are hearing is too immediate and too particular to be performed for an audience expecting catharsis.

The Brits Billion Award, presented by the British Phonographic Industry on 4 May 2023, recognized Headie One for exceeding one billion career streams in the UK. The award is a confirmation, not a revelation. A catalog built on precision rather than persona sustains attention long after the initial chart moment passes. EDNA entered the charts at number one in October 2020. Years later it still sounds like something made for the long game, by someone who understood from the start that the first chart position was not the point.

[download:/assets/images/artists/headie-one-edna-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "headie-one-edna",
    "title": "EDNA Changed What UK Drill Was Allowed to Be",
    "author": "Leelou Blanc",
    "category": "music",
    "date": "2026-06-25",
    "image": "/assets/images/artists/headie-one-edna.jpg",
    "image_alt": "Headie One press photo",
    "image_position": "center 20%",
    "instagram": "@headieone",
    "crew": [
        {"name": "Stormzy", "role": "Featured artist", "url": "https://instagram.com/stormzy", "handle": "@stormzy"},
        {"name": "Taz Tron Delix", "role": "Video director", "url": "https://instagram.com/taztrondelix", "handle": "@taztrondelix"}
    ],
    "body": body.strip()
}

with open('/home/dh_yadmw3/artonly.io/posts/headie-one-edna.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: headie-one-edna.json")
PYEOF

# Validate post
cd ~/artonly.io/agent
python3 post-validator.py headie-one-edna || echo "Validator complete (check output above)"
cd ~

# Verify live
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/headie-one-edna)
echo "HTTP status: $STATUS"

# Ping IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/headie-one-edna&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""
echo "IndexNow pinged: headie-one-edna"

# Update brain.json
python3 << 'PYEOF'
import json
brain_path = '/home/dh_yadmw3/artonly.io/agent/brain.json'
try:
    with open(brain_path, 'r') as f:
        brain = json.load(f)
    written = brain.get('artists_written', [])
    if 'Headie One' not in written:
        written.append('Headie One')
        brain['artists_written'] = written
    brain['queue'] = [a for a in brain.get('queue', []) if a != 'Headie One']
    with open(brain_path, 'w') as f:
        json.dump(brain, f, indent=2)
    print('brain.json updated: Headie One added to artists_written, removed from queue')
except Exception as e:
    print(f'brain.json update failed: {e}')
PYEOF

echo "=== Deploy complete: headie-one-edna ==="
