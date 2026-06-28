#!/bin/bash
# deploy-artonly-2026-06-28c.sh
# Publish: victoria-monet-jaguar (culture, Abel Blackburn, 2026-06-28)

set -e
cd /home/dh_yadmw3

SLUG="victoria-monet-jaguar"
TOKEN="ao-pub-Neverending48-2026"
IMG_DIR="artonly.io/assets/images/artists"

echo "=== STEP 1: Enable publishing ==="
python3 -c "
import json, os
p = 'artonly.io/data/publish-config.json'
os.makedirs(os.path.dirname(p), exist_ok=True)
c = {}
if os.path.exists(p):
    try:
        c = json.load(open(p))
    except Exception:
        c = {}
c['publishing_enabled'] = True
with open(p, 'w') as f:
    json.dump(c, f, indent=2)
print('Config after update:', c)
"

echo "=== STEP 2: Download body images ==="
mkdir -p "$IMG_DIR"

dl() {
    local out="$1" url="$2"
    curl -s -L -A "Mozilla/5.0" -o "$out" "$url"
    local sz
    sz=$(wc -c < "$out")
    echo "$out: ${sz} bytes"
    [ "$sz" -gt 5000 ] && return 0 || { rm -f "$out"; return 1; }
}

dl "$IMG_DIR/$SLUG-intro.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/1/1a/Victoria_Monet_%2833269922475%29_%28cropped%29.jpg" || true

dl "$IMG_DIR/$SLUG-studio.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/1/12/Victoria_Monet_%2832887113080%29_%28cropped%29.jpg" || true

dl "$IMG_DIR/$SLUG-promo.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/1/10/Victoria_Mon%C3%A9t_WHTA_2023.png" || \
dl "$IMG_DIR/$SLUG-promo.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/b/bb/Victoria_Mon%C3%A9t1.jpg" || true

dl "$IMG_DIR/$SLUG-portrait.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/b/bb/Victoria_Mon%C3%A9t1.jpg" || true

dl "$IMG_DIR/$SLUG-live.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/d/de/Victoria_Monet_%2832887113080%29.jpg" || true

echo "Image inventory:"
ls -lh "$IMG_DIR/$SLUG-"*.jpg 2>/dev/null || echo "(none downloaded)"

echo "=== STEP 3: Publish article ==="
python3 << 'PYEOF'
import json, os, urllib.request, urllib.error

SLUG = "victoria-monet-jaguar"
TOKEN = "ao-pub-Neverending48-2026"
IMG_DIR = "/home/dh_yadmw3/artonly.io/assets/images/artists"

def img_ok(name):
    for ext in ("jpg", "png"):
        p = os.path.join(IMG_DIR, f"{SLUG}-{name}.{ext}")
        if os.path.exists(p) and os.path.getsize(p) > 5000:
            return ext
    return None

def img_tag(name):
    ext = img_ok(name)
    if ext:
        return f"\n\n[img:/assets/images/artists/{SLUG}-{name}.{ext}]"
    return ""

BODY = (
"On February 4, 2024, Victoria Monet walked to the stage at Crypto.com Arena in Los Angeles to accept the Grammy for Best New Artist. She was 34 years old. She had been a working professional in the music industry since 2009. The category exists to celebrate new discoveries. Victoria Monet had already appeared on a Grammy ballot in 2019, credited as a songwriter on Ariana Grande's Thank U, Next. She had spent the preceding decade writing songs that generated billions of streams under other people's names.\n\n"
"Winning Best New Artist at 34, after fifteen years of industry work, is not the kind of acknowledgment the Recording Academy usually delivers. It said something structural about how the institution classifies labor. Songwriting is foundational to everything released under a commercial artist's name. It is also almost entirely invisible to the general audience. Victoria Monet spent over a decade as that invisible foundation. Then she decided not to be."
+ img_tag("intro") +
"\n\n## What Purple Reign Left Behind\n\n"
"Victoria Monet McCants was born in Atlanta, Georgia on May 1, 1989, and grew up in Sacramento, California. In 2009, producer Rodney Jerkins invited her to Los Angeles to audition for a girl group called Purple Reign. The group signed to Motown Records and was then dropped before releasing a single song. That sequence, the opening door followed by a closed one, would become a recurring shape in her early career.\n\n"
"Rather than leave, she stayed in Los Angeles and turned to songwriting sessions. She wrote for T.I., Nas, Travis Scott, Fifth Harmony, Selena Gomez, and BlackPink. The range of those artists tells you something about how completely she could inhabit other people's voices. She also began a sustained creative partnership with Ariana Grande that produced some of the most streamed pop songs of the decade. The list includes Thank U, Next, 7 Rings, Needy, and positions. These titles combined for tens of billions of streams. When the Thank U, Next album earned Grammy nominations in 2019, including Album of the Year, Victoria Monet attended the ceremony. She was not introduced from the stage."
+ img_tag("studio") +
"\n\n## Jaguar II and the Record She Was Building Toward\n\n"
"Jaguar II arrived on August 25, 2023, through her own Lovett Music imprint in partnership with RCA Records. It does not sound like a debut from someone trying to prove something. It sounds like a debut from someone who had been building toward a specific sound for a long time and arrived at it with confidence. The production, handled primarily by D'Mile and Jeff Gitelman, is warm and unhurried. Arrangements do not announce themselves. The record gives space to the voice rather than burying it.\n\n"
"The lead single On My Mama was released June 16, 2023. It peaked at number four on the Hot R&B Songs chart and spent 24 consecutive weeks in the top ten. The song works because it is not trying to be larger than it is. It is conversational and specific and delivered by someone who sounds entirely at ease. That ease is a product of years of professional work. She had been in sessions with major producers since her early twenties. By 2023 she knew exactly what it sounded like when a vocal was truly right.\n\n"
"Jaguar II opened to 15,000 equivalent album units in its first week, landing at number six on the Top R&B Albums chart. For a debut from someone the general audience was still learning to identify as a solo artist, those numbers reflected genuine investment rather than manufactured hype. There was a real listener on the other end."
+ img_tag("promo") +
"\n\n## Hazel, the Grammys, and the Weight of the Room\n\n"
"At the 66th Annual Grammy Awards on February 4, 2024, Victoria Monet won three categories: Best New Artist, Best R&B Album for Jaguar II, and Best Engineered Album. She received seven total nominations, the most of any R&B artist in that cycle. Her daughter Hazel Monet Gaines, who was nearly three years old at the time, had been credited as a featured vocalist on Hollywood, a track with Earth, Wind and Fire. Hazel became the youngest Grammy nominee in the history of the awards. Both of them were in the building.\n\n"
"The image of that night carries cultural meaning beyond sentiment. Hazel was born in February 2021, during the period when most live music had stopped entirely and artists were being forced to reckon with what their careers meant without stages. Victoria Monet had a child during that stretch and kept building. The sessions that became Jaguar II took shape over those same years. The Grammy podium in 2024 was the public surface of something assembled in private across a very long time.\n\n"
"In her acceptance speech for Best New Artist, she described the win as a fifteen year pursuit. That is an unusually precise thing to say at a Grammy podium. Most artists reach for gratitude or humility in that moment. Victoria Monet reached for accuracy."
+ img_tag("portrait") +
"\n\n## The Economics of the Invisible Writer\n\n"
"The music industry has a financial and legal structure that rewards songwriting through royalties and publishing income. It also has a promotional apparatus that barely acknowledges songwriters to the people buying records. A writer can receive publishing royalties, performance royalties, and written credits on physical and digital releases. None of that infrastructure generates name recognition the way album campaigns and touring do. Most people who spent 2019 streaming Thank U, Next did not know who Victoria Monet was. Many people in the industry did.\n\n"
"Max Martin has written and produced more number one singles than almost any living person. He can walk through an airport without recognition. That model works if you build a business designed around it. Victoria Monet was building toward something different. She was accumulating a vocal identity, a point of view, and a specific audience in parallel with the session work. The sessions paid the bills. The other project was the real goal.\n\n"
"Her deal structure reflected that. Signing to RCA through Lovett Music gave her creative control that a standard major label arrangement at the beginning of an artist career would not typically include. Jaguar II is not a compromised record. It does not sound like the product of a label A&R committee. It sounds like the product of someone who waited until she had something coherent to say and a clear framework to say it in."
+ img_tag("live") +
"\n\n## Where the Career Is Going in 2026\n\n"
"By June 2026, Victoria Monet is supporting Bruno Mars on The Romantic Tour through European stadium dates. A June 28 stop at Olympiastadion in Berlin and a July appearance at Wembley Stadium in London place her in front of audiences that number in the tens of thousands per night. She signed with Full Stop Management in late 2025, the firm that also handles Harry Styles and Cardi B. The booking and management infrastructure around her career now matches the Grammy recognition she received eighteen months earlier.\n\n"
"The trajectory makes sense to anyone who watched the 2024 Grammy broadcast with attention. The Best New Artist win was not a surprise to people in the industry. It codified a reputation that already existed. What the Grammys did was make that reputation visible to a general audience that had been listening to her songs for years without connecting her name to them.\n\n"
"That visibility is worth something now. Whether it becomes the foundation for a long artist career depends on what comes after Jaguar II. The record has set a high standard. What is clear is that she arrived at this point having built something real during the years nobody was watching. That is usually where real things get built.\n\n"
f"[download:/assets/images/artists/{SLUG}-social-9x16.jpg|Download Social Card]"
)

HERO_URL = "https://upload.wikimedia.org/wikipedia/commons/1/1a/Victoria_Monet_%2833269922475%29_%28cropped%29.jpg"

payload = {
    "action": "publish",
    "token": TOKEN,
    "slug": SLUG,
    "artist": "Victoria Monet",
    "image_url": HERO_URL,
    "post": {
        "title": "Victoria Monet Won Best New Artist After Fifteen Years. The Industry Already Knew.",
        "body": BODY,
        "author": "Abel Blackburn",
        "date": "2026-06-28",
        "category": "culture",
        "category_id": 3
    }
}

data = json.dumps(payload).encode("utf-8")
req = urllib.request.Request(
    "https://artonly.io/api/publish.php",
    data=data,
    headers={"Content-Type": "application/json"},
    method="POST"
)
try:
    with urllib.request.urlopen(req, timeout=30) as resp:
        result = json.loads(resp.read())
        print("PUBLISH OK:", json.dumps(result, indent=2))
except urllib.error.HTTPError as e:
    body_err = e.read().decode("utf-8")
    print(f"PUBLISH ERROR {e.code}:", body_err)
    raise
PYEOF

echo "=== STEP 4: Social card ==="
python3 artonly.io/agent/make-social-card.py \
    victoria-monet-jaguar \
    "Victoria Monet Won Best New Artist After Fifteen Years. The Industry Already Knew." \
    3

echo "=== STEP 5: Validate ==="
python3 artonly.io/agent/post-validator.py victoria-monet-jaguar

echo "=== STEP 6: IndexNow ==="
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/victoria-monet-jaguar&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== STEP 7: Outreach ==="
echo "No verified press contact found for Victoria Monet - outreach skipped per instructions."

echo ""
echo "=== ALL STEPS COMPLETE ==="
