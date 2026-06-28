#!/bin/bash
# ArtOnly Publisher Deploy Script — Shakira
# Generated: 2026-06-28
# Run via: sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-28.sh

set -e
cd ~
echo "=== ArtOnly Deploy: 2026-06-28 | shakira-las-mujeres-ya-no-lloran ==="

python3 << 'PYEOF'
import json, urllib.request, urllib.parse, os, shutil

# ── 0. Re-enable publishing ───────────────────────────────────────────────────
cfg_path = 'artonly.io/data/publish-config.json'
with open(cfg_path) as f:
    cfg = json.load(f)
cfg['publishing_enabled'] = True
with open(cfg_path, 'w') as f:
    json.dump(cfg, f, indent=2)
print('publishing_enabled = True')

# ── 1. Download hero image ────────────────────────────────────────────────────
def download(url, dest):
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'}
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as r, open(dest, 'wb') as f:
        data = r.read()
        if len(data) < 5000:
            raise Exception(f'Too small: {len(data)}b')
        f.write(data)
    return len(data)

img_base = 'artonly.io/assets/images/artists'
hero = f'{img_base}/shakira.jpg'
if not os.path.exists(hero) or os.path.getsize(hero) < 10000:
    n = download('https://64.media.tumblr.com/212b0cda7a04569185586479500dc13b/24e94370502c86e7-c3/s1280x1920/d8ad82426862b663a51cf1054452727230eadc1c.jpg', hero)
    print(f'Hero downloaded: {n}b')
else:
    print('Hero already exists')

# Copy hero to section images
for section in ['opening', 'architecture', 'collaborators', 'numbers', 'sound', 'future']:
    dest = f'{img_base}/shakira-{section}.jpg'
    if not os.path.exists(dest):
        shutil.copy(hero, dest)

# ── 2. Publish ────────────────────────────────────────────────────────────────
body = """[spotify:artist/0TmlxNKjCPRpUOs1nMyaEL]

On March 22, 2024, Sony Music Latin released “Las Mujeres Ya No Lloran,” Shakira’s first studio album in seven years. The album debuted at number one on the Top Latin Albums chart and number 13 on the overall Billboard 200. It won the 2025 Grammy Award for Best Latin Pop Album. None of that happened because of nostalgia or goodwill. It happened because the record was built from specific creative decisions, executed at a level that few artists achieve at any point in their career, let alone after a public divorce the press was already framing as a tragedy.

The comeback narrative was the wrong frame from the beginning. Shakira Isabel Mebarak Ripoll did not need to come back. She had not gone anywhere that mattered commercially or artistically. What she needed was a subject worth writing about and a production infrastructure capable of meeting her at a different creative register.

[img:/assets/images/artists/shakira-opening.jpg]

## The Architecture of Revenge, Rendered Precisely

The comparison between “BZRP Music Sessions, Vol. 53” and the album it eventually anchored is useful precisely because the two objects are doing different things. The January 11, 2023 Bizarrap collaboration was a provocation with a very specific target. It broke 14 Guinness World Records, including 14.4 million Spotify plays in 24 hours, a number that had never been reached by a Latin track. The YouTube video accumulated 63 million views in its first 24 hours. Those figures tell you something about the reach of the weapon, not the intention behind it.

“Las Mujeres Ya No Lloran” is the intention. The album is willing to sit inside ambiguity where the Bizarrap session was percussive and direct. The tracklist ranges from bachata to reggaeton to a kind of synthetic emotional ballad that Shakira has always been better at constructing than critics give her credit for. The album does not chase a coherent sonic identity. That is the point. A woman in the middle of dismantling one version of her life does not sound like one thing.

[img:/assets/images/artists/shakira-architecture.jpg]

## Karol G, Rauw Alejandro, and the Collaborator Selection

“TQG,” the collaboration with Karol G, reached the top ten on the US Billboard Hot 100 and topped the Hot Latin Songs chart for five consecutive weeks. “Te Felicito,” featuring Rauw Alejandro, was certified 13 times platinum in the United States on the Latin chart. These are not supporting acts brought in for name recognition. Karol G and Shakira are the two most commercially dominant Colombian artists in the world right now, and “TQG” was constructed so that neither one defers to the other. The track is built around two voices that are equally specific in their delivery, which is rarer than the feat sounds.

Rauw Alejandro’s role on “Te Felicito” is different in texture. He is not there for name value. The track uses his register to establish a call and response that lets Shakira’s phrasing land harder by contrast. The people assembling this record understood that a collaboration works when each participant is placed precisely, not just featured. Bizarrap’s fingerprints on the wider production sensibility, particularly in how electronic elements are layered against acoustic instrumentation, are part of why the album holds together despite its genre range.

[img:/assets/images/artists/shakira-collaborators.jpg]

## What the Numbers Actually Mean

Shakira has now placed 24 singles at number one on the Billboard Latin Airplay chart. That is the record for female artists. She has sold over 95 million albums globally, won four Grammy Awards and 15 Latin Grammy Awards, and holds 47 Billboard Latin Music Awards, the most won by any female artist in the award’s history.

The number that matters most for understanding where Shakira sits in 2026 is $421.6 million. That is the reported gross revenue from the Las Mujeres Ya No Lloran World Tour, which launched February 11, 2025. That makes it the highest grossing Latin tour in history by a Hispanic artist, attracting 3.3 million attendees across 86 concerts. In Mexico City alone, 12 concerts at Estadio GNP Seguros sold 780,000 tickets at roughly 65,000 per night.

A tour of that scale is not something that happens because a divorce generated press interest. It happens because a performer has maintained global audience relationships across three decades at a quality level sufficient to fill stadiums on every continent. The tour is the most honest evidence available about where her audience actually is.

[img:/assets/images/artists/shakira-numbers.jpg]

## Barranquilla, Heritage, and the Sound Architecture

The most consistently underanalyzed element of Shakira’s work is the Middle Eastern melodic vocabulary that surfaces in her writing, a legacy of her Lebanese heritage through her father. It shows up in the ornamentation of her vocal lines, in the interval choices she makes in hooks, and in the belly dance training that shaped her physical performance practice since childhood in Barranquilla. These are not decorative cultural references. They are structural elements of a sound that does not fully belong to any one tradition.

Laundry Service, released in 2001, sold over 13 million copies globally. It remains the album with the highest global sales among records by a female Latin artist. “Whenever, Wherever” was doing something that mainstream pop radio had not heard in exactly that configuration. The Arabic melodic coloring underneath the rock production was not accidental. It was Shakira writing from her actual musical formation, which happened to hit a moment in the early 2000s when global pop was capable of absorbing it. “Las Mujeres Ya No Lloran” does not chase that formula. It does not need to.

[img:/assets/images/artists/shakira-sound.jpg]

## Where the Empowerment Framing Falls Short

The coverage of “Las Mujeres Ya No Lloran” was dominated by the empowerment frame, which was both accurate and insufficient. Reducing the album to a revenge record misses what makes it interesting as a piece of work. It is actually about the specific difficulty of being a public figure in the middle of a private catastrophe. The songs are not addressed to an audience. They are addressed to the situation, and the audience is allowed to overhear. That is a distinct mode of songwriting, and Shakira has been developing it since around 2005.

The empowerment frame also flattens the production choices. There are tracks on the album that are genuinely vulnerable rather than triumphal, and they complicate the narrative the press preferred. An artist writing from a position of pure strength would not have made those songs. She made them because they were honest, and honesty at that scale, released to tens of millions of people who had already decided what the record was about before they heard it, is a harder thing to execute than any of the chart records suggest.

[spotify:album/3fonA82Hl7huJiQCwKkzGA]

## What Comes After This and Why It Matters

The Las Mujeres Ya No Lloran World Tour runs through October 11, 2026, ending in Madrid. She did not book a residency. She booked stadiums across multiple continents for over a year and a half. A residency is a legacy move. A world tour is a statement that the work is still live.

The 2025 Grammy win for Best Latin Pop Album closed a gap of seven years since her previous Grammy. That gap was not a period of decline. It was a period in which the album she needed to make was not yet ready to be made. Shakira in 2026 is operating from the position of an artist who built a global commercial infrastructure over three decades, made a record that was genuinely good on its own terms, and is now in the middle of the largest tour of her career. The question is what the next record does that this one did not. Given what she had to work with this time, that is not a small question.

[img:/assets/images/artists/shakira-future.jpg]

[download:/assets/images/artists/shakira-social-9x16.jpg|Download Social Card]"""

crew = [
    {"name": "Bizarrap", "role": "Producer", "url": "https://open.spotify.com/artist/716NhGYqD1jl2wI1Qkgq36", "handle": "@bizarrap"},
    {"name": "Rauw Alejandro", "role": "Featured Artist", "url": "https://open.spotify.com/artist/1mcTU81TzQhprhouKaTkpq", "handle": "@rauwalejandro"},
    {"name": "Karol G", "role": "Featured Artist", "url": "https://open.spotify.com/artist/790FomKkXshlbRYZFtlgla", "handle": "@karolg"}
]

payload = json.dumps({
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "shakira-las-mujeres-ya-no-lloran",
    "artist": "Shakira",
    "image_url": "https://64.media.tumblr.com/212b0cda7a04569185586479500dc13b/24e94370502c86e7-c3/s1280x1920/d8ad82426862b663a51cf1054452727230eadc1c.jpg",
    "post": {
        "title": "Las Mujeres Ya No Lloran Proved Shakira Needed No Comeback Narrative",
        "date": "2026-06-28",
        "author": "Allastair Voss",
        "category": 0,
        "body": body,
        "crew": crew
    }
}).encode()

req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=payload,
    headers={'Content-Type': 'application/json'}
)
with urllib.request.urlopen(req, timeout=30) as r:
    result = json.loads(r.read())
print('Publish result:', json.dumps(result))

if not result.get('ok'):
    raise Exception(f"Publish failed: {result}")

print('Published at: https://artonly.io/post/shakira-las-mujeres-ya-no-lloran')
PYEOF

echo "--- Social card ---"
python3 artonly.io/agent/make-social-card.py shakira-las-mujeres-ya-no-lloran "Las Mujeres Ya No Lloran Proved Shakira Needed No Comeback Narrative" 0

echo "--- Validator ---"
python3 artonly.io/agent/post-validator.py shakira-las-mujeres-ya-no-lloran

echo "--- IndexNow ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/shakira-las-mujeres-ya-no-lloran&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"

echo "--- Outreach email ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=alan.nierob@rogersandcowanpmk.com" \
  --data-urlencode "subject=ArtOnly just covered Shakira" \
  --data-urlencode "body=https://artonly.io/post/shakira-las-mujeres-ya-no-lloran

The piece focuses on what makes Las Mujeres Ya No Lloran work formally rather than just commercially, including the architecture of the collaborator selection with Karol G, Rauw Alejandro, and Bizarrap. A social card is downloadable at the bottom of the page and free to share. If Shakira or anyone on her team would be open to a brief Q and A, just reply here.

Allastair Voss
ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"

echo ""
echo "=== Deploy complete: shakira-las-mujeres-ya-no-lloran ==="
