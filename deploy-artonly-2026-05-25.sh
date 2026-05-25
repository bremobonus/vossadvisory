#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-25
# Run: 2026-05-25T07:27Z
# Posts: aho-ssan-the-sun-turned-black, odd-beholder-honest-work
# Run this on the DreamHost server via SSH:
# sshpass -p PASSWORD ssh dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-25.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-25 ==="

# ---- POST 1: AHO SSAN ----
echo "--- Deploying: aho-ssan-the-sun-turned-black ---"

# Download press photo: try Sonic Acts 2026 Biennial, then ICI d'ailleurs, then Spotify oEmbed
echo "Fetching Aho Ssan press photo..."
IMG_URL=$(curl -sL -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  "https://sonicacts.com/biennial/biennial-2026/artists/aho-ssan" 2>/dev/null \
  | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
  | grep -iv 'logo\|icon\|favicon\|header\|arrow\|sprite' | head -1)

if [ -z "$IMG_URL" ]; then
  echo "Sonic Acts failed, trying ICI d'ailleurs..."
  IMG_URL=$(curl -sL -A "Mozilla/5.0" \
    "https://icidailleurs.fr/en/artist/aho-ssan-en/" 2>/dev/null \
    | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
    | grep -iv 'logo\|icon\|favicon' | head -1)
fi

if [ -z "$IMG_URL" ]; then
  echo "ICI d'ailleurs failed, trying Outer Agency..."
  IMG_URL=$(curl -sL -A "Mozilla/5.0" \
    "https://outer-agency.com/artist/aho-ssan/" 2>/dev/null \
    | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
    | grep -iv 'logo\|icon\|favicon\|bg\|thumb-default' | head -1)
fi

if [ -z "$IMG_URL" ]; then
  echo "All artist page fallbacks failed, using Spotify oEmbed..."
  IMG_URL=$(curl -sL "https://open.spotify.com/oembed?url=https://open.spotify.com/artist/6DP0aNDMupNmkyK4drCrvC" 2>/dev/null \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('thumbnail_url',''))" 2>/dev/null)
fi

echo "Downloading image from: $IMG_URL"
curl -L -A "Mozilla/5.0" -o ~/artonly.io/assets/images/artists/aho-ssan-the-sun-turned-black.jpg "$IMG_URL"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert aho-ssan-the-sun-turned-black.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  aho-ssan-the-sun-turned-black-up.jpg && mv aho-ssan-the-sun-turned-black-up.jpg aho-ssan-the-sun-turned-black.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py aho-ssan-the-sun-turned-black \
  "What Aho Ssan Heard in Ghana Was Louder Than Any Beat" music

# Write post JSON
cat > ~/artonly.io/posts/aho-ssan-the-sun-turned-black.json << 'JSONEOF'
{
  "slug": "aho-ssan-the-sun-turned-black",
  "title": "What Aho Ssan Heard in Ghana Was Louder Than Any Beat",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-25",
  "image": "/assets/images/artists/aho-ssan-the-sun-turned-black.jpg",
  "image_alt": "Aho Ssan press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/6DP0aNDMupNmkyK4drCrvC]\n\nThere is a particular kind of dislocation that comes from arriving somewhere that should feel like home and finding that it does not. The landscape is familiar from photographs and family memory. The language reaches back through generations. And yet something in the body resists the assignment of belonging, refuses to settle into the shape the trip was supposed to give it. Paris-based composer and sound designer Désiré Niamké, who records as Aho Ssan, traveled to Ghana and found that exact friction. The Sun Turned Black, his third album under this name, is what he made when he came back.\n\nThe album released May 22, 2026, on Subtext Recordings and Ici, d'ailleurs. It is seven tracks of concentrated sound, built from field recordings gathered on site in Ghana, processed and expanded in collaboration with internationally acclaimed violinist ASIA. There are no percussion elements anywhere on the record. That choice is not incidental. Percussion grounds music in time, in the body, in the immediate present. Niamké was working with a different set of concerns, specifically the way that sound can carry something more like geological weight, like material that has been compressed under years of distance and expectation and then suddenly exposed to air.\n\n## The Shape of the Album\n\n[img:/assets/images/artists/aho-ssan-the-sun-turned-black.jpg]\n\nThe tracklist moves with a kind of ceremonial logic. Sunrise opens the record and does exactly what its name suggests, not as metaphor but as sonic event, a gradual emergence of texture and frequency that takes its time arriving. The 100 Suns sequence, four parts spread across the album's interior, functions as the record's spine. These pieces were born from the work Niamké and ASIA developed together on site, a piece originally called 100 Soleils that became the conceptual blueprint for everything that followed.\n\nAt the center of the album sits The Children of Noise, the first track Niamké composed for this project and the one that contains the clearest statement of what the album is doing. ASIA's violin does not behave like a classical instrument here. It behaves like a kind of processed memory, recognizably stringed but pulled through treatment that makes it shimmer and distort at the edges. The effect is one of something trying to stay intact under enormous ambient pressure.\n\nThe closing title track arrives at the end with the weight of everything that preceded it. The album ends not in resolution but in a kind of considered suspension, the way that questions about identity and origin tend to end when they are approached honestly rather than poetically.\n\n## What the Silence Is Saying\n\nThe absence of percussion matters for reasons that go beyond compositional choice. Electronic music built around rhythm is, in one sense, music about the present tense, about the body moving through time in a specific moment. The Sun Turned Black refuses that orientation entirely. Without rhythm anchoring the listener to a pulse, the music operates in a different temporal register, one that is closer to how memory works, how ancestral connection works, how the experience of visiting a place you carry inside you but have never fully occupied works.\n\nNiamké has described the trip to Ghana as a clarifying moment, one that pushed him toward texture and poetry over formal structure. That shift shows throughout the album in the way sounds are layered and allowed to behave. Field recordings from Ghana appear as source material, but they are not preserved as documentary artifacts. They are transformed, stripped of their original context and reconstituted in a space that is neither Ghana nor France but somewhere in between, in the unresolved country between ancestry and arrival.\n\nThis is music that takes the diasporic experience seriously as a formal problem, not just a subject. The question of how to belong somewhere that claims you across generations while your lived self exists somewhere else entirely is not a question that has a lyrical answer. It is a question that has a sonic shape, and Niamké is working to find it across these seven tracks.\n\n## The Collaboration That Made It Possible\n\nASIA's presence throughout the album deserves its own consideration. Violin carries particular cultural freight in Western classical tradition, and it carries different freight in African musical contexts. The instrument is recognizable across both, which makes it a useful hinge for what the album is trying to do, to occupy a space that does not cleanly belong to either tradition but borrows legitimately from both.\n\nThe way ASIA plays on these recordings, with Niamké's processing wrapped around every phrase, produces something that sounds simultaneously ancient and completely current. There are moments where the violin appears to dissolve entirely into the electronic environment and then re-emerge, still recognizably itself. That cycle of dissolution and re-emergence is as good a metaphor as the album has to offer for what it is actually about.\n\n## Why This Album Arrives at the Right Moment\n\nNiamké has been building toward something like this for a decade. His work with IRCAM, the Paris-based research institute dedicated to acoustic and musical research, has given him a technical vocabulary that most electronic musicians working in this space do not have access to. The craft behind The Sun Turned Black is not visible in the way that conspicuous production tends to be. It operates beneath the surface, shaping the physics of how the sounds behave, creating a listener experience that is physical and immersive without ever announcing itself as such.\n\nThe Sun Turned Black does not resolve the question of where home is. It is not trying to. It is trying to make the question audible, to give it a form that can be held in the body while the mind continues to work through what it means to carry a homeland inside you that you have never fully inhabited. That is a rare and serious project, and Niamké has made it with the kind of patience and precision it required.\n\nSeven tracks. No drums. Everything else.\n\n[download:/assets/images/artists/aho-ssan-the-sun-turned-black-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "aho-ssan-the-sun-turned-black deployed"

# ---- POST 2: ODD BEHOLDER ----
echo "--- Deploying: odd-beholder-honest-work ---"

# Download press photo: try FEMMUSIC article, then Sinnbus, then Spotify oEmbed
echo "Fetching Odd Beholder press photo..."
IMG_URL=$(curl -sL -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  -H "Referer: https://www.google.com/" \
  "https://femmusic.com/2026/02/26/odd-beholder-internet-famous/" 2>/dev/null \
  | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
  | grep -iv 'logo\|icon\|favicon\|avatar\|gravatar\|banner\|ad' | head -1)

if [ -z "$IMG_URL" ]; then
  echo "FEMMUSIC failed, trying Glad We Met..."
  IMG_URL=$(curl -sL -A "Mozilla/5.0" \
    "https://gladwemet.ch/artist/odd-beholder/" 2>/dev/null \
    | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
    | grep -iv 'logo\|icon\|favicon' | head -1)
fi

if [ -z "$IMG_URL" ]; then
  echo "Glad We Met failed, trying Return to Sound article..."
  IMG_URL=$(curl -sL -A "Mozilla/5.0" \
    "https://www.returntosound.co.uk/music-news/odd-beholder-unveils-new-single-called-like-a-chore" 2>/dev/null \
    | grep -oP '(?:src=["\047])\K(https://[^\s"<>\047]+\.(?:jpg|jpeg|png|webp))' \
    | grep -iv 'logo\|icon\|favicon\|banner' | head -1)
fi

if [ -z "$IMG_URL" ]; then
  echo "All artist page fallbacks failed, using Spotify oEmbed..."
  IMG_URL=$(curl -sL "https://open.spotify.com/oembed?url=https://open.spotify.com/artist/3QXIzf05xhPdEUciKVif6v" 2>/dev/null \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('thumbnail_url',''))" 2>/dev/null)
fi

echo "Downloading image from: $IMG_URL"
curl -L -A "Mozilla/5.0" -o ~/artonly.io/assets/images/artists/odd-beholder-honest-work.jpg "$IMG_URL"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert odd-beholder-honest-work.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  odd-beholder-honest-work-up.jpg && mv odd-beholder-honest-work-up.jpg odd-beholder-honest-work.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py odd-beholder-honest-work \
  "The Working Life Has a Soundtrack Now and Odd Beholder Made It" music

# Write post JSON
cat > ~/artonly.io/posts/odd-beholder-honest-work.json << 'JSONEOF'
{
  "slug": "odd-beholder-honest-work",
  "title": "The Working Life Has a Soundtrack Now and Odd Beholder Made It",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-25",
  "image": "/assets/images/artists/odd-beholder-honest-work.jpg",
  "image_alt": "Odd Beholder press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/3QXIzf05xhPdEUciKVif6v]\n\nDaniela Weinmann has spent a career cataloguing the absurdity and texture of contemporary Swiss life under the Odd Beholder name, and her fourth album, Honest Work, may be her most precisely aimed project yet. It is about labor, specifically about what it means to be a person who is also, simultaneously and continuously, an employee, a consumer, a data point, a user, a target. Released May 22, 2026, on Sinnbus Records, the album runs ten tracks in 35 minutes and wastes none of them. This is a record that works as hard as the people it is about.\n\nThe premise of Honest Work is deceptively simple. Weinmann writes character-driven songs about ordinary people in ordinary work situations, nurses on night shifts, office workers summoned to a boss's office for wearing the wrong clothes, someone pumping breast milk in a storage room, someone taking a day off and realizing they no longer remember their own name outside of work. The situations are specific enough to be recognizable and particular enough to feel like fiction. That combination is the album's core technique.\n\n## Electro Wave as Emotional Method\n\n[img:/assets/images/artists/odd-beholder-honest-work.jpg]\n\nThe musical approach is worth naming because it shapes how these characters land. Odd Beholder operates in the space between electro wave, dream pop, and a kind of stripped-down synth-pop that owes something to the late 1980s without being nostalgic about it. The production on Honest Work is clean but deliberately cold in its textures, which is exactly the right choice for an album about systems that reduce people to functions. The music sounds like the emotional temperature of a place where fluorescent lights are always on.\n\nInternet Famous opens the album and positions what follows immediately. The song addresses the creator economy and parasocial relationships with the clinical precision of someone who has spent considerable time watching what the attention economy does to people who try to operate inside it. It is not a song against social media in the way protest songs tend to work. It is more diagnostic than prescriptive, and that distinction matters. Weinmann is not telling you what to think. She is showing you what it looks like.\n\nFocus Disease arrives in the album's back half with the most direct lyrical statement on the record. The line about a doctor and a disease sounds simple until you sit with it. It is about medicalization, about the Ritalin culture of productivity optimization, about the way contemporary work requires you to modify your neurochemistry to match its pace. Weinmann delivers it without drama, which is what makes it land.\n\n## The Album's Structural Intelligence\n\nPart of what makes Honest Work work as a sustained listen rather than a collection of pointed songs is the way Weinmann has arranged the emotional arc. The record moves through different registers of workplace experience, from the ambient anxiety of Drive to the exhausted humor of Second Beer to the quiet devastation of Night Shift. The closer ends the album in a register of physical depletion that is different from the opening's sardonic observation. The listener has traveled somewhere over the course of these ten tracks.\n\nLean Dreams is the track the album bends toward emotionally. The title alone is doing a lot of work. A lean dream is a small dream, a dream that has been trimmed to fit the time and energy that work allows. Weinmann pulls from trip-hop rhythms and the hazy edges of drum-and-bass without committing to either, which puts the song in an appropriately ambiguous space. It sounds like falling asleep at your desk and dreaming somewhere between productivity and surrender.\n\nThe description circulating around this album is petty-bourgeois surrealism, which is accurate but undersells the emotional stakes. Surrealism is a technique for making the familiar strange. What Weinmann is doing is making the strange ordinary, which is the harder and more politically interesting move. The experiences documented on Honest Work are not exceptional. They are the daily conditions of millions of people who have no language for them because the culture that produced those conditions also produced the language used to describe them.\n\n## The Longer Arc\n\nHonest Work follows Feel Better from 2023, which addressed adolescence and intergenerational family dynamics with a similar formal economy. The move from teenage interiority to working adult life is not an arbitrary progression. Weinmann is building something across albums, a portrait of a generation moving through life stages and finding at each one that the social systems they inhabit are not designed for their full humanity.\n\nThis is the kind of record that a different kind of artist might make into a manifesto. Weinmann is not interested in manifesto. She is interested in accuracy. The politics of Honest Work come from its precision, from the fact that it describes things as they actually are rather than as they appear in the language used to justify them. That precision is a form of resistance, and it is one of the more durable kinds.\n\nTen tracks. Thirty-five minutes. Everything honest.\n\n[download:/assets/images/artists/odd-beholder-honest-work-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "odd-beholder-honest-work deployed"

# ---- IndexNow pings ----
echo "--- Checking HTTP status and pinging IndexNow ---"
AHO_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/aho-ssan-the-sun-turned-black")
echo "artonly.io/post/aho-ssan-the-sun-turned-black: HTTP $AHO_CODE"

ODD_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/odd-beholder-honest-work")
echo "artonly.io/post/odd-beholder-honest-work: HTTP $ODD_CODE"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/aho-ssan-the-sun-turned-black&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: aho-ssan-the-sun-turned-black pinged"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/odd-beholder-honest-work&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: odd-beholder-honest-work pinged"

# ---- Outreach emails ----
echo "--- Sending outreach emails ---"
# Aho Ssan - Subtext Recordings press
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@subtextrecordings.net" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Aho Ssan and The Sun Turned Black at artonly.io/post/aho-ssan-the-sun-turned-black. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

# Odd Beholder - Sinnbus Records press
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=peter@sinnbus.de" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Odd Beholder and Honest Work at artonly.io/post/odd-beholder-honest-work. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

echo "=== Deploy complete ==="
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-05-25" \
  "Published today:\n\nhttps://artonly.io/post/aho-ssan-the-sun-turned-black\nhttps://artonly.io/post/odd-beholder-honest-work\n\nOutreach: press@subtextrecordings.net (Aho Ssan), peter@sinnbus.de (Odd Beholder)"
