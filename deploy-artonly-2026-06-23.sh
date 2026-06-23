#!/bin/bash
# ArtOnly Deploy: Album Monitor 2026-06-23
# Posts: PJ Morton - Saturday Night / Sunday Morning, The War and Treaty - The Story of Michael and Tanya
# Generated: 2026-06-23
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-23.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Album Monitor Deploy: $(date) ==="

UA="Mozilla/5.0 (compatible; ArtOnly/1.0)"

# =====================================================================
# POST 1: PJ Morton - Saturday Night / Sunday Morning
# =====================================================================

echo ""
echo "--- [1/2] Downloading PJ Morton hero image ---"
PJ_IMG="artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg"
PJ_DOWNLOADED=0

for PJ_URL in \
  "https://commons.wikimedia.org/wiki/Special:FilePath/PJ_Morton_2011.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/4/4c/PJ_Morton_2011.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/PJ_Morton_2011.jpg/800px-PJ_Morton_2011.jpg"
do
  curl -s -L -A "$UA" --max-time 30 -o "$PJ_IMG" "$PJ_URL" || true
  SZ=$(wc -c < "$PJ_IMG" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 10000 ]; then
    echo "Downloaded PJ Morton image from $PJ_URL ($SZ bytes)"
    PJ_DOWNLOADED=1
    break
  fi
done

if [ "$PJ_DOWNLOADED" -eq 0 ]; then
  echo "ERROR: Could not download a valid PJ Morton hero image"
  exit 1
fi

echo "--- Upscaling PJ Morton hero image ---"
OMP_NUM_THREADS=1 convert "$PJ_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg \
  && mv artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning-up.jpg \
        "$PJ_IMG"

echo "--- Publishing PJ Morton post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/2FMOHE79X98yptp4RpPrt7]

[youtube:Vcxp-MypjFk]

PJ Morton grew up knowing that the two sides of his life were supposed to be separate. His father, Bishop Paul S. Morton, is the pastor of Greater St. Stephen Full Gospel Baptist Church in New Orleans, one of the largest and most prominent Baptist congregations in the South. Sunday morning meant church. The week's secular pleasures, the music that moved through the city's bars and clubs and second-line parades, belonged to another register entirely. For the preacher's child, this division was not a doctrine so much as an ambient pressure, the cultural and theological assumption that a person had to choose which of those two worlds they were fully committed to.

Morton spent two decades refusing that choice. He joined Maroon 5 as a keyboardist in 2010, became an official member in 2012, and toured the world playing pop music in arenas while simultaneously building a solo career rooted in New Orleans soul and R&B. He founded Morton Records in 2016 with the explicit ambition of creating the New Orleans Motown, an independent label rooted in the culture of his home city. Six Grammy wins accumulated across that same period. Each of them came for work that drew freely from the sacred and the secular without treating the crossing as a transgression. Saturday Night / Sunday Morning, released on Juneteenth 2026, is the formal announcement of what that career has always been preparing to say.

## The Double Album as the Only Possible Answer

Eighteen tracks divided into two perfect halves. Nine songs of R&B on the Saturday Night disc. Nine songs of gospel on the Sunday Morning disc. Both halves run exactly twenty nine minutes and fourteen seconds. This symmetry is not the coincidence it might appear to be. It is the structural argument of the entire record: that these two modes of experience are equal in duration, equal in weight, equal in what they can carry. Morton did not make a primary record with a bonus disc. He made two complete worlds that occupy the same container without either one being diminished by the presence of the other.

The Saturday Night half draws on the full resources of a live ensemble, strings and horns and a rhythm section that provides the warmth that distinguished Morton's best solo work from the production habits of his contemporaries. Keyon Harrold plays trumpet on Mess, one of several tracks where the brass carries a melodic weight that the production refuses to bury under processing. Harrold is among the most sought-after brass players working in contemporary American music, a presence on records by Maxwell and his own acclaimed projects as a bandleader. His contribution here signals that Morton is operating at the level where the collaborators match the ambition rather than simply executing it. Rukhsana Merrise adds vocal depth to Autopsy, and the production throughout chooses presence and warmth over the surface perfection that can drain recorded music of its humanity.

The Sunday Morning half is not a lesser commitment. Gospel music made with this level of craft, this live ensemble, this refusal to simplify the tradition it draws from, is its own serious artistic undertaking. Feeling Free opens the disc with a directness that signals Morton has no interest in easing the listener into the sacred half by making it more palatable. Yesterday Today Forevermore closes it with a compositional completeness that mirrors the intention across the entire project. The New Orleans sacred music tradition that Morton was raised inside absorbs the full breadth of African American spiritual expression, and that breadth is present throughout the Sunday Morning half without being catalogued or reduced to a display of influences. It is simply what the music is.

## Bogalusa and the Recording History It Holds

Saturday Night / Sunday Morning was recorded at Studio In The Country in Bogalusa, Louisiana, roughly an hour north of New Orleans. The facility carries the accumulated history of American roots music in its rooms. Johnny Cash recorded there. Bonnie Raitt recorded there. Maze recorded there. Willie Nelson recorded there. The choice was not made for nostalgia but for the specific acoustic quality the room provides and for what it means to place this particular record inside that particular lineage.

Morton is making a claim about where this music comes from and what tradition it belongs to, and the choice of Bogalusa rather than Los Angeles or New York is part of that claim. The American South is where the categories that the music industry uses to sort music into separate genres first started breaking down, because the music made in that region has never observed those separations as cleanly as the industry has. Gospel and blues and country and soul came from the same communities and the same human impulses. Bogalusa knows that. Studio In The Country knows it. Saturday Night / Sunday Morning is built to know it too.

## Juneteenth and Who the Music Is For

The Juneteenth release date is a precise choice. The holiday that marks the moment in 1865 when enslaved people in Texas received the news that the Civil War had ended, months after the fact, carries with it the full weight of what Black American cultural life has always contained: the survival of joy in conditions designed to extinguish it, the continuity of a tradition that refused erasure, the refusal to allow the structure of oppression to determine the shape of the culture. That PJ Morton would choose that date to release an album about refusing the division between sacred and secular life is not a marketing decision. It is a statement about where the music comes from and who it is for and what it means.

## What He Was Waiting to Say

The album shares its title with Morton's memoir, published the same year. Book and record illuminate each other. The memoir works through the personal history that the record renders in music: the preacher's son who absorbed both the sanctified tradition of his father's congregation and the secular soul tradition of the city that formed him, who joined one of the most commercially successful pop bands in the world and never stopped making his own music, who built a solo career over two decades without ever fully resolving the apparent tension at its center.

His description of what he was trying to make is the most precise statement of the record's argument: he was the same person when he wrote Let Go Let God as he was when he wrote Say So. He did not want to choose this time. Let Go Let God is gospel. Say So is R&B. Both came from the same person in the same period of his life. Saturday Night / Sunday Morning is the formal proof of that claim, made in full, held together, and released on the day that commemorates the survival of everything it draws from.

[download:/assets/images/artists/pj-morton-saturday-night-sunday-morning-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"PJ Morton body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "pj-morton-saturday-night-sunday-morning",
    "artist": "PJ Morton",
    "image_url": "https://artonly.io/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg",
    "post": {
        "title": "PJ Morton Refuses the Division and Makes the Album His Whole Life Prepared Him For",
        "date": "2026-06-23",
        "category": "music",
        "author": "Leelou Blanc",
        "instagram_handle": "@pjmorton",
        "featured": False,
        "image": "/assets/images/artists/pj-morton-saturday-night-sunday-morning.jpg",
        "image_alt": "PJ Morton press photo",
        "image_position": "center 20%",
        "body": BODY,
        "crew": [
            {
                "name": "Keyon Harrold",
                "role": "Trumpet",
                "url": "https://open.spotify.com/artist/4JG781pl96pL2h0AoERgOA",
                "handle": "@keyonharrold"
            }
        ]
    }
}

data = json.dumps(POST).encode('utf-8')
req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=data,
    headers={'Content-Type': 'application/json'}
)
try:
    with urllib.request.urlopen(req, timeout=60) as r:
        resp = r.read().decode('utf-8')
        print(f"Publish response: {resp}", flush=True)
        parsed = json.loads(resp)
        if not parsed.get('ok'):
            print(f"ERROR: publish failed: {resp}", file=sys.stderr)
            sys.exit(1)
except Exception as e:
    print(f"ERROR publishing: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF

echo "--- Generating PJ Morton social card ---"
python3 artonly.io/agent/make-social-card.py pj-morton-saturday-night-sunday-morning \
  "PJ Morton Refuses the Division and Makes the Album His Whole Life Prepared Him For" music

echo "--- DEBUG: validator instagram check source ---"
grep -n 'instagram' artonly.io/agent/post-validator.py || echo '(no instagram lines found)'

echo "--- DEBUG: Full PJ Morton JSON on disk ---"
python3 -c "import json; print(json.dumps(json.load(open('artonly.io/posts/pj-morton-saturday-night-sunday-morning.json')), indent=2))"

echo "--- Validating PJ Morton post ---"
python3 artonly.io/agent/post-validator.py pj-morton-saturday-night-sunday-morning || true

echo "--- IndexNow: PJ Morton ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/pj-morton-saturday-night-sunday-morning&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== PJ Morton debug complete. ==="
