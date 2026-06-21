#!/bin/bash
# ArtOnly Deploy: Album Monitor 2026-06-21
# Posts: Tierra Whack - WHACK'S MUSEUM, Micah Thomas - Lucid
# Generated: 2026-06-21
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-21.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Album Monitor Deploy: $(date) ==="

UA="Mozilla/5.0 (compatible; ArtOnly/1.0)"

# =====================================================================
# POST 1: Tierra Whack - WHACK'S MUSEUM
# =====================================================================

echo ""
echo "--- [1/2] Downloading Tierra Whack hero image ---"
curl -s -L -A "$UA" \
  -o "artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/0/01/Tierra_Whack_MoMA_2018.jpg"
HERO_SIZE=$(wc -c < artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg)
echo "tierra-whack-whacks-museum.jpg: $HERO_SIZE bytes"
if [ "$HERO_SIZE" -lt 5000 ]; then
  echo "ERROR: Tierra Whack hero image too small ($HERO_SIZE bytes)"
  exit 1
fi

echo "--- Upscaling Tierra Whack hero image ---"
OMP_NUM_THREADS=1 convert artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/tierra-whack-whacks-museum-up.jpg \
  && mv artonly.io/assets/images/artists/tierra-whack-whacks-museum-up.jpg \
        artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg

echo "--- Publishing Tierra Whack post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/4lPl9gqgox3JDiaJ1yklKh]

Tierra Whack has spent the better part of a decade building one of the most unusual reputations in American hip hop, consistently operating at the intersection of formal invention and lyrical precision while maintaining a level of independence that most artists in her position would trade for commercial certainty. Her 2018 debut, Whack World, remains one of the most distinctively formatted projects of the streaming era: fifteen tracks in fifteen minutes, each exactly sixty seconds long, delivered as a visual album with its own visual world for every track. The GRAMMY nomination that followed, for Best Music Video for Mumbo Jumbo, confirmed that the larger industry had noticed. The critical consensus that placed her among the most significant voices of her generation followed closely after.

The years between Whack World and WORLD WIDE WHACK, her full-length studio debut released in 2024, were filled with the kind of activity that does not always register in traditional album release cycles: singles, features, internet moments, and a reputation that grew through demonstration rather than repetition. WORLD WIDE WHACK landed on Album of the Year lists from TIME, Rolling Stone, and The Washington Post. It was the formal debut that her career had been preparing for, and it validated everything her early work had promised.

WHACK'S MUSEUM, released on Juneteenth 2026, represents something different. Not an extension of what WORLD WIDE WHACK was but a deliberate subtraction. She has described it as her first true rap project, and the description carries real weight.

## The Stripping Down

Twelve tracks in twenty seven minutes. No featured artists. Production that prioritizes weight and clarity over atmospherics or embellishment. Everything that Whack World and WORLD WIDE WHACK deployed, the visual scaffolding, the concept architecture, the genre spanning formal ambition, is absent here. What remains is the one element that was always present but rarely foregrounded in isolation: the rapper.

The Juneteenth release date names the context without requiring elaboration. Releasing her most explicitly rap centered project on the holiday that marks the end of American slavery is a positioning of her work within a specific tradition, one that does not require outside validation, does not adjust itself for comfort, and does not minimize what it is in order to be received more easily. The date was chosen with the same precision she applies to her wordplay.

The mixtape form is itself a statement. In contemporary music, the term gets applied loosely. Whack is using it in a specific sense: a project made outside the formal album cycle, not for commercial positioning but for creative necessity, because there is something she needed to do that the album format was not the right container for. The container here is the least formal one available, which makes the seriousness of what goes inside it more legible.

## Wax and What It Carries

The titling across WHACK'S MUSEUM announces the album's method immediately. WAX PAPER, BRAZILIAN WAX, CANDLE WAX, EARWAX: the wax motif runs through the project not as a gimmick but as a demonstration of a specific skill. A single syllable contains multitudes. Wax is the material that preserves music on vinyl. It is a cosmetic procedure. It is the texture of a candle burning. It accumulates in the human ear. Whack finds every register a single word can occupy and builds from that multiplicity.

TOTEM is her direct response to any critical framework that attempted to locate her outside the rap tradition. The track does not hedge. It does not couch its claims in irony or retreat into self-deprecation as deflection. It names where she stands and defends that position with the kind of technical precision that makes the argument for itself without requiring additional statement. Her GRAMMY nomination came for a video. The message on TOTEM is that the music does not need a visual to carry its weight.

SIREN, the track accompanied by a visual shot in Philadelphia, represents the project's most geographically specific moment. The Eagles gear, the urban cowboys: these are images that belong to a particular culture and a particular city, and Whack claims them without translating them for an audience that might need explanation. She has spoken about what North Philadelphia gave her, the challenge, the difficulty, the creative necessity, the lesson that being different is a form of power. SIREN puts that formation on screen.

QUEENS CROWN operates in a similar register to TOTEM, claiming territory that belongs to Whack by the quality of the craft rather than by any external endorsement. The absence of features on the album means every claim made here is hers alone to make and hers alone to back up.

## Philadelphia and How It Made Her

Tierra Whack grew up in North Philadelphia, the part of the city that does not appear in its marketing materials. Her mother encouraged the creative impulse and gave it room to develop. At fifteen, she spotted a group with a camera on a Philly street and jumped into a freestyle battle. She performed under the name Dizzle Dizz before finding the name and the identity that has since accumulated press coverage from every major music publication in the country.

The formation matters because WHACK'S MUSEUM is, in a specific sense, a return to that origin. Not a nostalgic return, not a narrative about going back to roots, but a formal demonstration that the impulses that sent a fifteen-year-old into a street freestyle are still the same impulses driving the work in 2026. Signing to Interscope in 2017 gave her resources and reach. It did not give her the instincts she arrived with. This mixtape is those instincts, operating without the resources as buffer.

North Philadelphia also gave Whack the specific sense of humor that runs through WHACK'S MUSEUM. The wordplay is not generic. It belongs to a comedic sensibility that is particular to the city, a tradition of wit deployed under pressure. The titles WIGGIDY WHACK and WHACK JOB announce that sensibility before the tracks even start.

## What It Means to Drop the Visual

Whack's reputation rests significantly on her visual imagination. The Whack World format, the WORLD WIDE WHACK aesthetic, the precise visual grammar she applies to everything she releases: these elements have been central to how her work is received and how the critical discourse around her has developed. Choosing to make a project that centers the lyric above everything else, that strips away the visual scaffolding and makes the writing and the delivery carry the entire weight of the thing, is a meaningful risk.

WHACK'S MUSEUM demonstrates that the writing can carry it. The twelve tracks here do not feel exposed or incomplete without their visual counterparts. They feel like a person who has been waiting for this specific opportunity to show you the part of herself that her previous work, as excellent as it was, did not fully bring to the foreground. The museum metaphor of the title is earned. There is something preserved here, something held up for examination, something that asks you to look carefully at a single object without the distraction of everything surrounding it.

The twenty seven minute runtime follows the same discipline that has characterized every Whack project. She does not add length for the appearance of seriousness. Whack World was fifteen tracks in fifteen minutes. WORLD WIDE WHACK pushed the format while maintaining precision. WHACK'S MUSEUM follows the same logic. Here is exactly what is needed. The rest is silence.

[download:/assets/images/artists/tierra-whack-whacks-museum-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Tierra Whack body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "tierra-whack-whacks-museum",
    "artist": "Tierra Whack",
    "image_url": "https://artonly.io/assets/images/artists/tierra-whack-whacks-museum.jpg",
    "post": {
        "title": "Tierra Whack Strips the Spectacle and Lets Her Pen Do Everything",
        "date": "2026-06-21",
        "category": "music",
        "author": "Leelou Blanc",
        "instagram_handle": "@tierrawhack",
        "featured": False,
        "image": "/assets/images/artists/tierra-whack-whacks-museum.jpg",
        "image_alt": "Tierra Whack press photo",
        "image_position": "center 20%",
        "body": BODY
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

echo "--- Generating Tierra Whack social card ---"
python3 artonly.io/agent/make-social-card.py tierra-whack-whacks-museum \
  "Tierra Whack Strips the Spectacle and Lets Her Pen Do Everything" music

echo "--- Validating Tierra Whack post ---"
python3 artonly.io/agent/post-validator.py tierra-whack-whacks-museum

echo "--- IndexNow: Tierra Whack ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/tierra-whack-whacks-museum&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Tierra Whack ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@interscope.com" \
  -d "subject=Tierra Whack is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Tierra Whack and WHACK'S MUSEUM at artonly.io/post/tierra-whack-whacks-museum. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo ""

echo "=== Tierra Whack post complete. Live at: https://artonly.io/post/tierra-whack-whacks-museum ==="

# =====================================================================
# POST 2: Micah Thomas - Lucid
# =====================================================================

echo ""
echo "--- [2/2] Downloading Micah Thomas hero image ---"
MICAH_IMG="artonly.io/assets/images/artists/micah-thomas-lucid.jpg"
MICAH_DOWNLOADED=0

for MICAH_URL in \
  "https://www.smallslive.com/media/artists/micah-thomas.jpg" \
  "https://d20dvo2rl76z3f.cloudfront.net/artists/2842/main.jpg" \
  "https://fullyaltered.com/wp-content/uploads/micah-thomas-press.jpg" \
  "https://www.allaboutjazz.com/images/musicians/m/micah-thomas.jpg" \
  "https://f4.bcbits.com/img/a2208491004_10.jpg"
do
  curl -s -L -A "$UA" --max-time 15 -o "$MICAH_IMG" "$MICAH_URL" || true
  SZ=$(wc -c < "$MICAH_IMG" 2>/dev/null || echo 0)
  if [ "$SZ" -gt 10000 ]; then
    echo "Downloaded Micah Thomas image from $MICAH_URL ($SZ bytes)"
    MICAH_DOWNLOADED=1
    break
  fi
done

if [ "$MICAH_DOWNLOADED" -eq 0 ]; then
  echo "ERROR: Could not download a valid Micah Thomas hero image from any source"
  exit 1
fi

echo "--- Upscaling Micah Thomas hero image ---"
OMP_NUM_THREADS=1 convert "$MICAH_IMG" \
  -resize 150% \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 92 \
  artonly.io/assets/images/artists/micah-thomas-lucid-up.jpg \
  && mv artonly.io/assets/images/artists/micah-thomas-lucid-up.jpg "$MICAH_IMG"

echo "--- Publishing Micah Thomas post ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/1ocNmvgQknyDwriWQq3OrO]

Jazz has always had a complicated relationship with the concept of balance. The tradition that produced John Coltrane's sheets of sound and Cecil Taylor's percussive maximalism does not recommend restraint as a default posture. But restraint and stillness are different things. Restraint is the holding back of something that wants to emerge. Stillness is the condition in which what needs to emerge can be heard without interference. Micah Thomas's fifth album Lucid, released June 19, 2026, is an investigation of stillness. It is not quiet so much as precise, not minimal so much as exact.

Thomas was born in 1997 in Columbus, Ohio, and came to the piano by ear before he could read music. He received the Jerome L. Greene Fellowship from the Juilliard School, completed his Master of Music there in 2020, and has since become one of the more essential presences in contemporary New York jazz. His long tenure with the Immanuel Wilkins Quartet established his reputation among listeners who pay close attention to who is doing what in the rhythm section of a live performance. His solos there are frequently the kind of thing that makes audiences lean forward. On record, his previous four albums as leader have demonstrated a composer's interest in structure alongside a pianist's interest in what happens when structure encounters improvisation.

## The Quintet as Instrument

Lucid assembles a specific set of collaborators whose shared aesthetic makes the album's ambition legible. Immanuel Wilkins plays alto saxophone. Kalia Vandever plays trombone. Thomas Morgan plays bass. Lesley Mok plays drums. These are not random selections. All of them operate in the space where jazz, chamber music, and experimental music blur into each other, and all of them bring a sophistication about their roles within a group that is rare at any level.

Wilkins, who leads his own quartet in which Thomas has played for years, brings to this session the same quality he brings to his own records: a willingness to be fully inside the specific logic of a project rather than importing the mannerisms of his other contexts. He submerges himself in the parameters Thomas has established without sacrificing the inimitable quality of what he does. This is a meaningful thing to ask of a musician whose own voice is as developed as Wilkins's, and the fact that he accepts the invitation without reservation says something about the quality of the compositional framework Thomas has built.

Vandever, whose own work as a leader has established her as one of the more distinctive trombone voices currently working, provides a rotundity and warmth that functions as the album's connective tissue. She commands a range of tonal approaches that conventional trombone playing rarely reaches, and on Lucid she deploys them with a precision that serves the album's governing logic without calling attention to the technique for its own sake.

Morgan and Mok form a rhythm section that does not announce itself as the rhythm section. Their role is closer to environment than engine. They shape the space in which the harmonic and melodic events above them occur, and they do so with an attentiveness that makes individual moments difficult to isolate from the whole. This is the hardest kind of playing to do well and the kind most likely to go unrecognized by listeners who focus on the front line.

## Phrase as Object

Thomas has spoken about the compositional philosophy driving Lucid in terms of phrase length and its relationship to perception. He is pursuing what he describes as short phrases that have a special tactility, phrases that become like physical objects, things that can be held in the mind's eye with an immediate and all-encompassing awareness. This is a more unusual compositional ambition than it might initially appear. The dominant tradition in jazz composition values development, the phrase as the beginning of something that will extend, elaborate, and transform. Thomas is interested in something closer to the complete object: a phrase that contains its own resolution.

The ten tracks trace this interest through a range of contexts and textures. O opens the album with a statement of the project's intentions, establishing the quintet's sound before any individual voice has established dominance. The track arrives and departs with the kind of completeness that makes you want to play it again immediately, not because it is unresolved but because it is so fully itself that additional exposure feels like a natural response.

Frontier moves into territory that is more openly exploratory, the phrase lengths widening and contracting in ways that make the album's governing logic feel like a discovery rather than a predetermined outcome. Box Heart is the most compressed piece on the record, its emotional content dense within a short duration. The title is accurate: what it describes is small enough to hold in one hand and weighted enough to be felt.

Holiday offers a moment of relative openness, a track that earns its name by feeling like a temporary release from the precision that surrounds it. night and spacetime occupy the album's closing movement and demonstrate what happens when Thomas allows the ensemble's individual voices more room to assert themselves within the overall framework. These are not solos in the conventional sense. They are moments in which the balance between compositional structure and improvisational freedom tips slightly toward the improvisational, while remaining inside the album's governing sensibility.

## The Jazz Gallery and What It Represents

Thomas's career has developed partly through sustained institutional relationships with the venues and organizations that nurture this kind of work. The Jazz Gallery in New York has been central to his development, first as a performer and then as a commissioned artist. The 2022 to 2023 Jazz Gallery Commission Residency and the 2023 to 2024 Roulette Commission represent the kind of sustained investment in a developing artist's vision that this music requires but rarely receives at the level of institutional support.

Those relationships also explain the level of craft that Lucid demonstrates. A pianist who has spent years performing at the standard required by the institutions that have supported him does not arrive at a recording session without that preparation fully integrated into the music. Lucid sounds like the product of sustained thought about what it means to make a jazz record in 2026. Not a record that is trying to justify its existence by referencing the tradition, but one that is adding something specific and traceable to it.

DownBeat Magazine's designation of Thomas as one of the 25 for the Future in 2024 and the Up-and-Comer of the Year designation from the New York City Jazz Records in the same year confirm that the institutional attention is matched by peer and critical recognition. New York City Jazz Records also named him Best International Artist of the Year. These are not awards that measure commercial visibility. They measure the regard of people who listen to this music with the kind of attention it demands.

## What Balance Costs

The album's title is not aspirational. Lucid does not describe an emotional state Thomas is seeking. It describes the condition that the music itself achieves. Listening to it, you do not feel the effort of its making. You feel the result of that effort, which is the stillness that good composition can produce in a listener who surrenders to it.

This is an uncommon thing for a jazz record to deliver. Jazz, even at its most composed, tends to carry the energy of its own making: the sense that something is being negotiated in real time, that the form is being discovered rather than disclosed. Lucid feels disclosed. Not in a way that removes the excitement of the listening experience but in a way that gives it a different quality. You are not watching something being figured out. You are watching something that has been figured out and is now being given to you in the most precise form available.

Five albums in, Thomas has earned the right to make that kind of record. The previous four prepared for this one. Lucid arrives as a demonstration that balance, in jazz as in anything else, is not a compromise position. It is the hardest thing to reach, and the most clearly valuable once reached.

[download:/assets/images/artists/micah-thomas-lucid-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download):[^\]]+\]', '', BODY)
word_count = len(clean.split())
print(f"Micah Thomas body word count: {word_count}", flush=True)
if word_count < 888:
    print(f"ERROR: body only {word_count} words, need 888+", file=sys.stderr)
    sys.exit(1)

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "micah-thomas-lucid",
    "artist": "Micah Thomas",
    "image_url": "https://artonly.io/assets/images/artists/micah-thomas-lucid.jpg",
    "post": {
        "title": "Micah Thomas Finds the Still Point and Builds a Whole World Around It",
        "date": "2026-06-21",
        "category": "music",
        "author": "Allastair Voss",
        "instagram_handle": "@micahmosestejus",
        "featured": False,
        "image": "/assets/images/artists/micah-thomas-lucid.jpg",
        "image_alt": "Micah Thomas press photo",
        "image_position": "center 20%",
        "body": BODY
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

echo "--- Generating Micah Thomas social card ---"
python3 artonly.io/agent/make-social-card.py micah-thomas-lucid \
  "Micah Thomas Finds the Still Point and Builds a Whole World Around It" music

echo "--- Validating Micah Thomas post ---"
python3 artonly.io/agent/post-validator.py micah-thomas-lucid

echo "--- IndexNow: Micah Thomas ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/micah-thomas-lucid&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "--- Outreach: Micah Thomas ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=taylor@fullyaltered.com" \
  -d "subject=Micah Thomas is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Micah Thomas and the new album Lucid at artonly.io/post/micah-thomas-lucid. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"
echo ""

echo "=== Micah Thomas post complete. Live at: https://artonly.io/post/micah-thomas-lucid ==="

# =====================================================================
# Summary email
# =====================================================================

echo ""
echo "--- Sending summary email ---"
python3 artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-21" \
  "Published today:

1. Tierra Whack, WHACK'S MUSEUM
   https://artonly.io/post/tierra-whack-whacks-museum
   By Leelou Blanc | Released June 19, 2026

2. Micah Thomas, Lucid
   https://artonly.io/post/micah-thomas-lucid
   By Allastair Voss | Released June 19, 2026

Outreach:
- Tierra Whack: press@interscope.com (BCC: amosleblanc@gmail.com)
- Micah Thomas: taylor@fullyaltered.com (BCC: amosleblanc@gmail.com)"

echo ""
echo "=== Album Monitor deploy complete: $(date) ==="
echo "Posts live:"
echo "  https://artonly.io/post/tierra-whack-whacks-museum"
echo "  https://artonly.io/post/micah-thomas-lucid"
