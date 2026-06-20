#!/bin/bash
# ArtOnly Deploy: Future article - fix category + validate + IndexNow
# Generated: 2026-06-20
set -e
cd /home/dh_yadmw3
echo "=== ArtOnly: Future fix deploy: $(date) ==="

# Images already downloaded in previous run. Re-publish with category as string.
echo "--- Re-publishing Future with category string ---"
python3 << 'PYEOF'
import urllib.request, json, sys

BODY = """[spotify:artist/1RyvyyTE3xzB2ZywiAwp0i]

On March 22, 2024, Future and Metro Boomin released We Don't Trust You and set Spotify's record for the most streamed album in a single day in 2024. The album debuted at number one on the Billboard 200 with the biggest opening week of any release in the calendar year at that point. The guest list included the Weeknd, Travis Scott, Playboi Carti, Kendrick Lamar, and Rick Ross. The title named a position rather than a mood. It was the most deliberate thing Future had done in years, and it came with immediate consequences that extended well beyond the chart positions.

Nayvadius DeMun Wilburn was born November 20, 1983, in Atlanta, Georgia. He grew up in the Kirkwood neighborhood and came into music through the Dungeon Family collective, the same creative environment that produced OutKast and Goodie Mob. The nickname the Future was given to him by people in that circle, and it was accurate enough to stick. Between 2010 and 2011 he released a run of mixtapes that established his voice and his method. He signed a major deal through Rocko's A1 Recordings with Epic Records, then founded Freebandz as the label infrastructure that would let him operate on his own terms alongside that deal. He kept both running in parallel for the rest of his career.

## The Album That Opened a War

The title We Don't Trust You was not rhetorical. It named the condition of a professional relationship that had soured, and the record's contents made that condition legible to anyone who wanted to understand the subtext. Like That, the track featuring Kendrick Lamar, functioned as the starting pistol for a rap conflict that generated more sustained discussion than anything comparable in recent memory. Drake responded in April 2024 with Push Ups, a track that targeted Metro Boomin specifically. Metro Boomin disclosed later that the fallout with Drake stemmed from something personal, something that had genuinely disappointed him.

Future's role in all of this was less commented on but no less structural. He lent his name, his catalog weight, and his label relationship to a project that became one of the most consequential rap releases in years. The guest list for the album does not assemble around uncertainty. When the Weeknd, Travis Scott, Playboi Carti, Kendrick Lamar, and Rick Ross all appear on the same record, that represents a specific set of relationships that had been built and maintained over many years. Future was the connective tissue between those artists and Metro Boomin. The album was a demonstration of the infrastructure he had spent a decade building.

[img:/assets/images/artists/future-intro.jpg]

## Atlanta and What He Built Before Everything Else

The Dungeon Family gave Future a framework for understanding what Atlanta music could do at its most ambitious. OutKast had demonstrated that Southern rap did not need to adapt to any external expectation. Goodie Mob had demonstrated that the form could carry intellectual and political weight without losing its regional specificity. Future absorbed those lessons and added his own: that pitch correction could function as a primary instrument rather than a corrective tool, and that emotional ambiguity delivered through repetition and haze could be as expressive as any technical display.

What he built in those early years was not just a sound. It was a template that an entire generation of artists copied and modified. The melodic trap mode that became the dominant aesthetic of American rap for the better part of a decade has Future's fingerprints all over it. He did not acknowledge this in interviews. He did not need to. The evidence was in the music of everyone who came after him.

Freebandz operates alongside his Epic Records arrangement as the structure that allows him to make decisions without asking permission. He founded it not as a branding exercise but as a functional operation. The label has housed other artists over the years. None of them have approached his commercial scale, but the infrastructure serves its primary purpose: protecting Future's ability to release music in the form he wants, on the schedule he wants, without interference from anyone who was not in the room when it was being made.

The structure also explains why Future has never been easily reduced to a single narrative. He is not a comeback story. He is not a redemption arc. He is a person who founded his own infrastructure in 2011 and has been operating within it ever since, adjusting the output without adjusting the underlying logic.

[img:/assets/images/artists/future-live.jpg]

## The Metro Boomin Partnership

The most important creative relationship in Future's career is with Metro Boomin, born Leland Tyler Wayne in Atlanta. They have been working together since the early 2010s, and the collaboration on We Don't Trust You and the sequel We Still Don't Trust You represents the peak of what that partnership can produce when both artists are operating at maximum intent.

Metro Boomin's production on We Don't Trust You is some of the densest and most precise work of his career. The beats carry the weight of the album's argument without announcing themselves as the point. They are the environment in which Future's delivery and the guest performances all make their cases. Young Metro, the track featuring the Weeknd, is one of the clearest examples of what happens when Future, Metro Boomin, and a collaborator who operates at equal altitude find the same register. The song gives Metro Boomin his most common public name and is built on a relationship between performer and producer that predates the fame of either.

The scale of what We Don't Trust You achieved, the Spotify record, the Billboard number one, the cultural conversation it ignited, comes from the combination of that longstanding creative relationship with a specific moment in the culture when both artists were willing to make something that took a clear position. They did not hedge the title. They did not soften the guest list. The record is what it is because they decided exactly what they wanted it to be.

[img:/assets/images/artists/future-studio.jpg]

[spotify:album/4iqbFIdGOTzXeDtt9owjQn]

## Mixtape Pluto and the Right to Make Something Quieter

On September 20, 2024, Future released Mixtape Pluto, his seventeenth overall project. It runs 44 minutes and 52 seconds across 17 tracks with no featured artists listed on the artwork. It is a solo commercial mixtape, a format that contemporary rap has largely retired, and it exists in direct contrast to everything We Don't Trust You was in terms of scale and context.

The tracks are not designed for streaming algorithm performance. Too Fast, Ocean, and Surfing a Tsunami exist in the mode Future uses when he is making music for himself and for listeners who have been paying close attention since 2011. The production is heavy. The structure is loose by design. The record does not attempt to explain itself to anyone who arrived recently.

Some critics read it as a minor release, a project sandwiched between larger ones. That reading treats scale as the only measure of seriousness, which is exactly the kind of audience expectation Future has always declined to satisfy. Mixtape Pluto is the proof that We Don't Trust You was a choice, not a capability ceiling. He can make something enormous and then immediately make something that refuses to be enormous, and both of those things can coexist as expressions of the same practice.

The year 2024, taken as a whole, is the clearest picture of what Future's career actually is at this point. He is not in transition. He is not rebuilding after a downturn. He is working in two registers simultaneously, releasing records of different scales and intentions, and letting the body of work do what bodies of work do when they accumulate over time without compromise. The question that follows is not whether he can still make relevant music. That has not been in serious doubt since the first mixtape. The question is whether the audience has caught up to the method.

[img:/assets/images/artists/future-cover.jpg]

[download:/assets/images/artists/future-social-9x16.jpg|Download Social Card]"""

POST = {
    "action": "publish",
    "token": "ao-pub-Neverending48-2026",
    "slug": "future",
    "artist": "Future",
    "image_url": "https://artonly.io/assets/images/artists/future.jpg",
    "post": {
        "title": "Future: The Record That Broke Spotify and the Mixtape That Ignored Everything",
        "date": "2026-06-20",
        "category": "music",
        "pen": "Allastair Voss",
        "image": "/assets/images/artists/future.jpg",
        "image_alt": "Future press photo",
        "image_position": "center 20%",
        "body": BODY,
        "crew": [
            {
                "name": "Metro Boomin",
                "role": "Producer",
                "url": "https://open.spotify.com/artist/0iEtIxbK0KxaSlF7G42ZOp",
                "handle": "@metroboomin"
            },
            {
                "name": "The Weeknd",
                "role": "Featured Artist",
                "url": "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ",
                "handle": "@theweeknd"
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

# Step 7: Validate
echo "--- Validating post ---"
python3 artonly.io/agent/post-validator.py future

# Step 8: IndexNow
echo "--- Submitting to IndexNow ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/future&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== Future fix deploy complete: $(date) ==="
echo "Live at: https://artonly.io/post/future"
