#!/bin/bash
# ArtOnly Fix: Add youtube embeds, crew, instagram to both posts
# Tierra Whack re-publish (already has image), Micah Thomas first publish
# Generated: 2026-06-21
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-21-fix.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Fix: youtube + crew + instagram: $(date) ==="

UA="Mozilla/5.0 (compatible; ArtOnly/1.0)"

# =====================================================================
# FIX 1: Tierra Whack - re-publish with youtube embed + crew + instagram
# Image already on server from previous run, skip re-download
# =====================================================================

echo ""
echo "--- [1/2] Re-publishing Tierra Whack with youtube + crew + instagram ---"
python3 << 'PYEOF'
import urllib.request, json, sys, re

BODY = """[spotify:artist/4lPl9gqgox3JDiaJ1yklKh]

[youtube:Nup3_s5gojw]

Philadelphia gave us Tierra Whack in 2018 as an artifact of concentrated imagination. "Whack World," her debut visual album, ran exactly fifteen minutes: fifteen songs, one minute each, each with its own music video, the whole thing conceived and executed with the coherence of a single artistic vision. It told you immediately how she thinks. In total environments. The world first, then the sound, then the decision about what fits inside the space she has already built. Genre conventions, label expectations, commercial formats: these are not her constraints. They are, at most, her starting material.

"WHACK'S MUSEUM" arrived June 19, 2026 on Interscope Records. Twelve tracks, twenty-seven minutes, no features. The math announces the intent before you press play. Average track length is just over two minutes. Nothing is padded. Nothing is extended for algorithmic reasons. The title gives you the frame: a museum is a space of preservation and selection, but this one carries Whack's name and she is the curator. What she has chosen to display is her rapping. Pure and without ornament.

This matters as a specific declaration because Whack's career has sometimes been received in a particular way: as the work of a visual artist who also happens to rap. That framing captures something real and misses something important. The visual intelligence, the concept-building, the world-construction quality of her projects has been immediately legible from the beginning. The craft of the bars has been equally present but sometimes positioned as secondary in the conversation. "WHACK'S MUSEUM" is the record that puts the bars at the center and asks the conversation to catch up.

## The Case She Is Making

"WAX PAPER," the lead single, arrived before the album with a music video shot in black and white in Whack's hometown by director Child. It was a statement of intent in the clearest possible register: wordplay delivered with the confidence of someone who knows exactly what they have and is not performing that confidence, just exhibiting it. "TOTEM," released June 17, extended the argument. The production, primarily from Conductor Williams, is gritty and soulful in a way that carries the specific texture of Philadelphia without making that texture decorative.

Both singles do the thing the album does across twelve tracks: they compress a lot of meaning into a small space and move on before you have fully processed what arrived. This is not a casual listening record, though it is accessible. It asks for attention and returns something that functions like revelation when attention is brought to it. That exchange has characterized Whack's work since the beginning. "WHACK'S MUSEUM" simply stages it more directly than any previous project.

The Philadelphia reference running through the production is not ornamental. Whack has consistently positioned her city as a presence in her work. There is something in the sonic character of what Conductor Williams draws from the beats, a grittiness that is also somehow spacious, that carries the feel of the place. The album knows where it comes from and that knowledge is load-bearing.

## The Mixtape Form as Liberation

Calling "WHACK'S MUSEUM" a mixtape rather than an album is a formal choice with consequences. The mixtape format implies freedom from the pressures of the commercial album cycle: no engineered lead single, no carefully managed genre adjacency, no obligation to demonstrate range for the sake of demonstrating range. A mixtape can be exactly what it needs to be. In Whack's case that is twelve tracks of rapping well, over and done in under thirty minutes.

This project follows "WORLD WIDE WHACK" from 2024, which was her most commercially ambitious record. Moving from that to this represents a contraction that is actually an expansion. Fewer ambitions stated, more precisely executed. The museum metaphor operates structurally as well as nominally: you enter at one end and exit at the other, and the sequence is the argument. The album does not work as a shuffle. It works as a walk through a space that has been arranged with specific intent.

The twenty-seven minute runtime is itself a position. In a period when major releases routinely extend to eighteen or twenty-two tracks and seventy minutes, Whack stops when she is done. That is not minimalism as a style choice. It is confidence in the material. The museum visit is short. The work is dense. There is no filler because there was never any interest in filler.

## What She Is Proving

Whack occupies a position in contemporary hip hop that is worth being clear about. She is not pop-adjacent in the sense that many rappers are, where the production is calibrated for passive listening and the hooks are designed to work without sustained attention. She is accessible because she is precise, not because she has made anything easier. "WHACK'S MUSEUM" extends this logic to its endpoint: twelve tracks of relentless lyrical density with no concession to the listener who is not paying attention.

The fact that the record is still enjoyable, still carries joy in places alongside its grit and swagger, is part of the craft. Joy and precision are not in tension for Whack. They are the same quality expressing itself in different registers. The album moves between bittersweet and swaggering and goofy and direct without losing its center, which is the voice and the bars and the particular intelligence behind them.

What you walk away with, if you have been paying attention for twenty-seven minutes, is a clear picture of an artist who has decided exactly what she is, has built a museum around it, and is not interested in explaining the choice to anyone who needs an explanation. The museum is open. The collection is complete. Tierra Whack did not need your permission to put her name on the door.

[download:/assets/images/artists/tierra-whack-whacks-museum-social-9x16.jpg|Download Social Card]"""

clean = re.sub(r'\[(?:spotify|img|download|youtube):[^\]]+\]', '', BODY)
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
        "title": "Tierra Whack Steps Into Her Own Museum and Shows You Exactly What She Is Made Of",
        "date": "2026-06-19",
        "category": "music",
        "author": "Leelou Blanc",
        "instagram": "@tierrawhack",
        "featured": False,
        "image": "/assets/images/artists/tierra-whack-whacks-museum.jpg",
        "image_alt": "Tierra Whack press photo",
        "image_position": "center 20%",
        "body": BODY,
        "crew": [
            {
                "name": "Conductor Williams",
                "role": "Producer",
                "url": "https://open.spotify.com/artist/1VuBGdfqq86BQyiDactQAC",
                "handle": "@conductorwilliams"
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

echo "--- Generating Tierra Whack social card ---"
python3 artonly.io/agent/make-social-card.py tierra-whack-whacks-museum \
  "Tierra Whack Steps Into Her Own Museum and Shows You Exactly What She Is Made Of" music

echo "--- Validating Tierra Whack post ---"
python3 artonly.io/agent/post-validator.py tierra-whack-whacks-museum

echo "--- IndexNow: Tierra Whack ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/tierra-whack-whacks-museum&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== Tierra Whack fix complete ==="

# =====================================================================
# PUBLISH 2: Micah Thomas - first publish with youtube embed + crew
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

[youtube:RCiOzVr1jQM]

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

clean = re.sub(r'\[(?:spotify|img|download|youtube):[^\]]+\]', '', BODY)
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
        "instagram": "@micahmosestejus",
        "featured": False,
        "image": "/assets/images/artists/micah-thomas-lucid.jpg",
        "image_alt": "Micah Thomas press photo",
        "image_position": "center 20%",
        "body": BODY,
        "crew": [
            {
                "name": "Immanuel Wilkins",
                "role": "Featured Artist",
                "url": "https://open.spotify.com/artist/5szMuuBbDzULkagWIfI5LG",
                "handle": "@immanuelwilkins"
            },
            {
                "name": "Kalia Vandever",
                "role": "Featured Artist",
                "handle": "@kalia.vandever"
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

echo "=== Micah Thomas publish complete ==="

# =====================================================================
# Summary email
# =====================================================================

echo ""
echo "--- Sending summary email ---"
python3 artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-06-21 (fix complete)" \
  "Both posts now live with youtube embeds, crew, and instagram:

1. Tierra Whack, WHACK'S MUSEUM
   https://artonly.io/post/tierra-whack-whacks-museum
   By Leelou Blanc | Released June 19, 2026
   Crew: Conductor Williams (Producer)

2. Micah Thomas, Lucid
   https://artonly.io/post/micah-thomas-lucid
   By Allastair Voss | Released June 19, 2026
   Crew: Immanuel Wilkins, Kalia Vandever

Outreach sent:
- Tierra Whack: press@interscope.com
- Micah Thomas: taylor@fullyaltered.com"

echo ""
echo "=== Fix deploy complete: $(date) ==="
echo "Posts live:"
echo "  https://artonly.io/post/tierra-whack-whacks-museum"
echo "  https://artonly.io/post/micah-thomas-lucid"
