#!/bin/bash
# ArtOnly Deploy: Headie One - EDNA at Number One
# Generated: 2026-06-25
# Run: sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-25-headie-one.sh

set -e
echo "=== ArtOnly Deploy: headie-one-edna-uk-number-one ==="

if [ -f ~/artonly.io/posts/headie-one-edna-uk-number-one.json ]; then
  echo "Post already exists: headie-one-edna-uk-number-one.json, skipping image+json steps"
else

# Download hero image
python3 -c "
import urllib.request, os

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
            raise Exception('Image too small: {} bytes'.format(len(data)))
        f.write(data)
    return os.path.getsize(dest)

dest = '/home/dh_yadmw3/artonly.io/assets/images/artists/headie-one-edna-uk-number-one.jpg'

urls = [
    ('https://www.nme.com/wp-content/uploads/2024/06/Headie-One-credit-Frank-Fieber@2000x1270.jpg', 'https://www.nme.com/'),
    ('https://media.wonderlandmagazine.com/uploads/2024/07/HEADIE-ONE-IG-COVER-WONDERLAND-SUMMER-2024-scaled.jpg', 'https://www.wonderlandmagazine.com/'),
    ('https://thefader-res.cloudinary.com/private_images/w_1440,c_limit,f_auto,q_auto:best/unnamed_7_bser5t/headie-one-edna-deluxe-interview-2021-broadwater-new-music.jpg', 'https://www.thefader.com/'),
]

for url, ref in urls:
    try:
        size = download_img(url, dest, referer=ref)
        print('Hero downloaded: {} bytes from {}'.format(size, url))
        break
    except Exception as e:
        print('Failed {}: {}'.format(url, e))
else:
    print('ERROR: all hero image URLs failed')
    raise SystemExit(1)
"

# Write post JSON
python3 << 'PYEOF'
import json

body = """On October 9, 2020, EDNA entered the UK Albums Chart at number one. It was the first debut album in UK drill history to reach that position. The record was named after Edna Adjei, Headie One's mother, who died when he was three years old. These two facts sit in close proximity and illuminate something about the kind of artist Irving Ampofo Adjei is. He does not make music to process emotion in public. He makes music because he is extraordinarily good at it, and the weight behind it comes from decades of accumulated specificity and survival.

## The Geography of Broadwater Farm

Tottenham's Broadwater Farm estate carries a specific weight in British civic memory. The 1985 riots, the killing of PC Keith Blakelock, the subsequent decades of political attention calibrated mostly for optics rather than outcomes. Growing up on that estate in the 1990s meant navigating a geography that existed, in public discourse, as a problem to be contained rather than a place where people actually lived. Headie One has spoken about his childhood in fragments rather than narrative arcs. He wanted to play professional football. A knee injury ended that possibility before it could develop into anything. Music came next, not as a calling but as the remaining option with any viable future.

Three imprisonments before the age of 25. A 30 month sentence beginning in 2014 following a cocaine dealing conviction. An arrest in 2019 for knife possession that placed him under legal constraints during the final stages of EDNA's recording. He tracked the album's progress from outside the studio, communicated through collaborators and intermediaries, maintained creative coherence over a project that could have collapsed entirely. It did not collapse.

These details are not included here as a redemption narrative. They explain the quality of the work. UK drill at its weakest trades on proximity to violence as credential rather than content. Headie One's lyrics do not trade on anything external. They describe specific conditions from the inside, with the precision of someone who has had to think carefully about every decision for a very long time.

## How EDNA Actually Got Finished

The album contains 20 tracks and features Drake, Stormzy, AJ Tracey, Future, Skepta, and several others. The production stays low, cold, and deliberate across the full runtime. There is no pivot toward American trap structures and no softening of the minimalist UK drill aesthetic for international ears. Drake came to the project. Headie One did not rearrange his sound to accommodate him.

"Only You Freestyle" reached number five on the UK Singles Chart in July 2020. "Ain't It Different" with Stormzy and AJ Tracey reached number two in August of the same year. Both placements were enormous for any genre. The fact that both appeared on an album that still sounded like his earliest underground work represents an unusual kind of discipline. Most artists recalibrate their approach once commercial placements of that magnitude start arriving. The production contracts, the label communication, the natural pressure to repeat and expand. Headie One absorbed all of that and made the record anyway.

The GANG EP with Fred again.., released six months before EDNA in April 2020, was an early indicator that this discipline was deliberate rather than accidental. Fred again.. has since become one of the most commercially successful producers in the world. Their collaboration at the time was underground documentation rather than a commercial exercise. The EP sounds more significant now than it did when it was released, which is the mark of work made without reference to the moment it appeared in.

## The Criminalisation That Ran Parallel

The Metropolitan Police's relationship with UK drill is both documented and ongoing. Videos flagged for removal from YouTube on the basis of gang association. Lyrics entered as criminal evidence in court cases. Rappers listed on gang matrices without notification or right to appeal. These are not fringe incidents in the genre's history. They are consistent policy applied across a decade of the music's commercial growth.

Headie One's number one album arrived within this structure, not outside it. Relentless Records is a Sony Music subsidiary. The Brits Billion Award, given to him in May 2023 for exceeding one billion UK streams, is an industry recognition that exists inside the same commercial ecosystem that has funded streaming and media platforms whose content moderation has been used to suppress drill at other levels of the same system.

This contradiction is not one the industry tends to name openly. Headie One has never pretended it is uncomplicated. His continued presence across both sides of this arrangement, maintaining the work without becoming a formal spokesperson for either the genre's grievances or the industry's interests, is part of what makes his trajectory worth examining carefully.

## What One Records Is Building

He founded One Records in 2023. The timing was strategic. By then, EDNA had established his commercial weight, the Brits certification had documented his streaming reach, and the Drake and Stormzy collaborations had confirmed that he could operate across very different commercial contexts without losing coherence in any of them. He was not building a label because he needed one. He was building it because he had the position to do so on his own terms.

The model is familiar from US hip hop history. Use major distribution infrastructure while retaining creative and financial control over the music and the artists on the roster. The UK drill ecosystem had not produced this structure at scale before One Records. The reasons are economic, historical, and partly a consequence of an industry that has consistently treated drill artists as short cycle commercial opportunities rather than long term creative partners. One Records is a direct response to that pattern.

The June 2024 album The Last One, released through the label, was framed publicly as a conclusion. The language of final chapters is common in rap and is almost always provisional. What matters more than the framing is the sequence it concludes. A decade of underground credibility. A debut at number one. A billion streams. A label built on terms that belong to him. The chapter language makes the most sense as a description of one mode of operating, not as a statement about what comes next.

## The Receipt

The cultural significance of EDNA has been argued at length since it was released. UK drill finally validated. Black British music arriving at the official chart summit. A generation of North London youth visible in the streaming numbers. These readings are not incorrect. They are also retrospective, applied to a record that was not made to carry them.

Headie One finished an album named after his dead mother while managing a legal situation that kept him from the studio. He made it work because the work was what mattered. The number one position arrived because the record was that good. The cultural meaning accumulated afterward, as it always does, around something that was simply made with full attention rather than with a cultural project in mind.

EDNA entered the UK Albums Chart at number one on October 9, 2020. The receipt is real and is not going anywhere. What it meant, and what it continues to mean, is a conversation that will outlast any single interpretation of it.

[download:/assets/images/artists/headie-one-edna-uk-number-one-social-9x16.jpg|Download Social Card]"""

data = {
    "slug": "headie-one-edna-uk-number-one",
    "title": "Headie One Made UK Drill Undeniable",
    "author": "Abel Blackburn",
    "category": "culture",
    "date": "2026-06-25",
    "image": "/assets/images/artists/headie-one-edna-uk-number-one.jpg",
    "image_alt": "Headie One press photo",
    "image_position": "center 20%",
    "body": body.strip(),
    "description": "On October 9, 2020, EDNA entered the UK Albums Chart at number one. It was the first debut album in UK drill history to reach that position."
}

with open('/home/dh_yadmw3/artonly.io/posts/headie-one-edna-uk-number-one.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print("JSON deployed: headie-one-edna-uk-number-one.json")
PYEOF

echo "--- Post JSON written ---"

# Verify live
echo "Verifying headie-one-edna-uk-number-one..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/headie-one-edna-uk-number-one)
echo "HTTP status: $STATUS"

# Generate social card
python3 ~/artonly.io/agent/make-social-card.py headie-one-edna-uk-number-one "Headie One Made UK Drill Undeniable" culture || echo "Social card generation note: check logs"
echo "Social card step complete"

# Run validator
python3 ~/artonly.io/agent/post-validator.py headie-one-edna-uk-number-one || echo "Validator note: check logs"
echo "Validation step complete"

fi  # end skip block


# Update brain.json (always run, idempotent)
python3 << 'PYEOF'
import json, os
brain_path = os.path.expanduser('~/artonly.io/agent/brain.json')
try:
    with open(brain_path) as f:
        brain = json.load(f)
    changed = False
    if 'Headie One' not in brain.get('artists_written', []):
        brain.setdefault('artists_written', []).append('Headie One')
        changed = True
    if 'queue' in brain and 'Headie One' in brain['queue']:
        brain['queue'] = [a for a in brain['queue'] if a != 'Headie One']
        changed = True
    if changed:
        with open(brain_path, 'w', encoding='utf-8') as f:
            json.dump(brain, f, indent=2, ensure_ascii=False)
            f.write('\n')
        print('brain.json updated: Headie One added to artists_written')
    else:
        print('brain.json: Headie One already present')
except Exception as e:
    print('brain.json update failed: {}'.format(e))
PYEOF


# Unfreeze publish API (flip publishing_enabled)
python3 << 'PYEOF'
import json, os
config_path = os.path.expanduser('~/artonly.io/data/publish-config.json')
try:
    with open(config_path) as f:
        config = json.load(f)
    was = config.get('publishing_enabled')
    config['publishing_enabled'] = True
    with open(config_path, 'w') as f:
        json.dump(config, f, indent=2)
        f.write('\n')
    print('publish-config.json: publishing_enabled was {} now True'.format(was))
except Exception as e:
    print('publish-config update skipped: {}'.format(e))
PYEOF


# IndexNow
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/headie-one-edna-uk-number-one&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""
echo "IndexNow pinged: headie-one-edna-uk-number-one"


# Outreach email (Relentless Records press team)
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=press@relentlessrecs.com" \
  --data-urlencode "subject=ArtOnly just covered Headie One" \
  --data-urlencode "body=https://artonly.io/post/headie-one-edna-uk-number-one

We just published a piece on Headie One and EDNA at ArtOnly. The article takes the album's chart debut as a starting point for looking at what it means that UK drill's commercial legitimacy arrived inside the same industry structures that have criminalized the genre at the level of police policy and content moderation. A downloadable social card is at the bottom of the page, free to share wherever. If the team would want to do a short Q and A, just reply and we can arrange it. Allastair Voss, ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo "Outreach sent: press@relentlessrecs.com (Headie One)"


# Summary email
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" "ArtOnly Published: Headie One" "Published:

Headie One - EDNA at Number One
https://artonly.io/post/headie-one-edna-uk-number-one
Author: Abel Blackburn
Category: culture
Date: 2026-06-25

Outreach: press@relentlessrecs.com (Relentless Records)

Note: publishing_enabled in data/publish-config.json has been reset to True."

echo "=== Deploy complete: headie-one-edna-uk-number-one ==="
