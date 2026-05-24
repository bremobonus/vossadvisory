#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-24
# Posts: jpegmafia-experimental-rap, bleachers-everyone-for-ten-minutes
# Run this on the DreamHost server via SSH:
# sshpass -p PASSWORD ssh dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-24.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-24 ==="

# ---- POST 1: JPEGMAFIA ----
echo "--- Deploying: jpegmafia-experimental-rap ---"

# Download press photo (Wikimedia Commons - Primavera Sound 2023)
curl -L -o ~/artonly.io/assets/images/artists/jpegmafia-experimental-rap.jpg \
  "https://commons.wikimedia.org/wiki/Special:FilePath/JPEGMAFIA_-_Primavera_Sound_2023_(cropped).jpg"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert jpegmafia-experimental-rap.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  jpegmafia-experimental-rap-up.jpg && mv jpegmafia-experimental-rap-up.jpg jpegmafia-experimental-rap.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py jpegmafia-experimental-rap \
  "JPEGMAFIA Names the Thing Nobody Would and Means Every Word of It" music

# Write post JSON
cat > ~/artonly.io/posts/jpegmafia-experimental-rap.json << 'JSONEOF'
{
  "slug": "jpegmafia-experimental-rap",
  "title": "JPEGMAFIA Names the Thing Nobody Would and Means Every Word of It",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-24",
  "image": "/assets/images/artists/jpegmafia-experimental-rap.jpg",
  "image_alt": "JPEGMAFIA press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/6yJ6QQ3Y5l0s0tn7b0arrO]\n\nThere is something almost confrontational about naming your record EXPERIMENTAL RAP. Not because the label is inaccurate. Because it dares you to disagree. Barrington DeVaughn Hendricks, who performs as JPEGMAFIA, released his sixth studio album on May 21, 2026, into a music landscape that had spent roughly the past decade quietly burying the word experimental under layers of irony and apologetics. The album arrives not as a question but as a declarative sentence, 25 tracks long, with nowhere to run.\n\nThe naming is a provocation, a reclamation, and a dare all at once. Hip-hop has always had a complicated relationship with the word experimental, which gets applied generously to anyone who samples something unusual or keeps the 808 at an unexpected tempo. JPEGMAFIA is something more rigorous and less comfortable than that. He makes music that sounds like a diagnosis, not a mood, and EXPERIMENTAL RAP is the clearest articulation of that practice he has offered yet.\n\n## A Record Built on a Decade of Refusal\n\nThe genealogy of this moment matters. Hendricks emerged from the underground with Veteran in 2018, a record that arrived with the force of something pressurized for years. All My Heroes Are Cornballs in 2019 confirmed that the debut was not a fluke but a method. LP! in 2021, which came in two simultaneous versions, treated the album format itself as a question worth asking again. Scaring the Hoes, his 2023 collaboration with Danny Brown, was two of underground music's most committed practitioners working through what happens when pure sonic eccentricity is taken to its limit. And I Lay Down My Life for You, from 2024, was a reckoning with the weight of a career built on refusing to compromise.\n\nEXPERIMENTAL RAP is what comes after a reckoning. It is not a victory lap. It is more like a settlement, an acknowledgment that the argument has been made and the record is simply the filing of evidence. The 25 tracks here are best understood not as a sprawling statement of purpose but as a personality test. Distorted guitars collide with glitchy samples. Beat switches arrive like interruptions at a dinner party, uninvited and then retrospectively necessary. The first single, \"babygirl,\" sounds like someone pouring rap and punk and noise into a single container and heating it past the point of safety. It is not comfortable. It is also not trying to be.\n\nThere is a track titled \"The Ghost of Emmett Till\" that carries the full weight of that name. Whatever Hendricks does inside it earns that weight or forces you to reckon with why you arrived unprepared for it. This is the kind of track that signals something about an artist's willingness to hold the full range of what Black American history makes available to a Black American artist, not just as subject matter but as a structural force that shapes the sound around it.\n\n## The Claim Behind the Name\n\nThe conversation that preceded the album's release, a public exchange with Earl Sweatshirt that some framed as a feud and others as a dialogue between two of the most serious artists in experimental hip-hop, is worth understanding as part of what the record is arguing. When Hendricks said in a Pigeons and Planes interview that others in his genre pretend to be cool by imitating younger artists rather than maintaining their own aesthetic integrity, he was making a claim that the album itself substantiates. This is not an artist who wants to follow the current. It is an artist who wants to inhabit, completely and without apology, the thing he actually is.\n\nThe production, handled entirely by Hendricks, is the vehicle through which all of this arrives. He has always been both artist and architect of his records, and on this one the production feels less like craft and more like controlled environment. Tracks shift without warning not because the album is undisciplined but because the discipline is calibrated to something other than commercial expectation. A listener who wants continuity across 25 tracks will find the record frustrating. A listener who wants to be surprised will find something that most current music has stopped offering.\n\nThe self-sufficiency of his practice matters here. Hendricks does not rely on a production team or label infrastructure to shape what his music sounds like. He makes the sound. And the sound on EXPERIMENTAL RAP is the fullest expression of that independence: chaotic in surface and disciplined in intent, difficult to categorize and completely recognizable as the work of one specific person with one specific point of view.\n\n## No Apologies, No Ambiguity\n\nThere is a version of this kind of writing that leans too heavily on the provocation and misses the craft. The social media confrontations, the blunt naming conventions, the refusal to hedge. All of these are real but they are the surface. Underneath them is someone who has been making music for over a decade with a level of intentionality that most artists aspire to in interviews and never achieve in the work itself. Across 25 tracks and every gear change and dissonant moment in them, EXPERIMENTAL RAP makes the case for what it means to commit fully to a sound and a vision even when the culture is telling you to dilute both.\n\nAt a time when the word experimental has become a marketing category as much as a description of practice, Hendricks has put his name on the concept and demanded that it mean something. The demand is not polite. The music is the argument for why the demand is justified.\n\nIt is a strong argument.\n\n[download:/assets/images/artists/jpegmafia-experimental-rap-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "jpegmafia-experimental-rap deployed"

# ---- POST 2: BLEACHERS ----
echo "--- Deploying: bleachers-everyone-for-ten-minutes ---"

# Download press photo (Wikimedia Commons - Day-In Day-Out Festival 2024)
curl -L -o ~/artonly.io/assets/images/artists/bleachers-everyone-for-ten-minutes.jpg \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Jack_Antonoff_-_Bleachers_-_Day-In_Day-Out_Festival_Seattle_July_2024.jpg"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert bleachers-everyone-for-ten-minutes.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  bleachers-everyone-for-ten-minutes-up.jpg && mv bleachers-everyone-for-ten-minutes-up.jpg bleachers-everyone-for-ten-minutes.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py bleachers-everyone-for-ten-minutes \
  "Jack Antonoff Made Everyone Elses Records. Then He Came Home." music

# Write post JSON
cat > ~/artonly.io/posts/bleachers-everyone-for-ten-minutes.json << 'JSONEOF'
{
  "slug": "bleachers-everyone-for-ten-minutes",
  "title": "Jack Antonoff Made Everyone Else's Records. Then He Came Home.",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-24",
  "image": "/assets/images/artists/bleachers-everyone-for-ten-minutes.jpg",
  "image_alt": "Bleachers press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/2eam0iDomRHGBypaDQLwWI]\n\nJack Antonoff has fourteen Grammy Awards and a production credit on roughly a third of the most culturally significant pop records of the last decade. He made the ten minute version of \"All Too Well\" with Taylor Swift. He shaped the sonic textures of Lorde's Melodrama and Lana Del Rey's Norman Fucking Rockwell and Carly Rae Jepsen's The Loneliest Time. His fingerprints are on contemporary pop in a way that makes his own band, Bleachers, feel like a secret he keeps returning to. On May 22, 2026, that return took the form of everyone for ten minutes, the fifth Bleachers album and the one that most clearly confronts what it costs to be everyone's collaborator and no one's exclusive creative partner.\n\nThere is a quote making the rounds from Antonoff: \"this version of modernity is trash.\" It reads initially like a slogan, the kind of thing a producer who has made too many records about feelings says when he runs out of more elegant framings. But across eleven tracks, it reveals itself as something closer to a personal inventory. The record grapples not with technology in the abstract but with the specific particular loneliness of maintaining real creative and personal connections inside an attention economy designed to monetize the dissolution of both.\n\n## The New Jersey That Never Left\n\nThe album's sonic inheritance is everywhere. Saxophones appear at moments of emotional climax. The harmonies stack the way they do in recordings from a particular strain of New York and New Jersey rock music that stretches from Bruce Springsteen through Fountains of Wayne and into the present. Antonoff has never apologized for this heritage and he does not apologize for it here. What distinguishes everyone for ten minutes from nostalgia is that the sonic vocabulary is being deployed to process something genuinely contemporary. The reference point is historical. The feeling is completely now.\n\nBleachers is a band in the full sense, six people who have been playing together long enough to know when to pull back and when to push through. The harmonies on \"you and forever\" could not be made by one person, and the way the instrumentation builds through the album's back half has the quality of a collective organism rather than a solo project with a band name attached to it. Antonoff has talked in interviews about belonging, about the way Bleachers represents something that his production work for other artists, however successful, cannot replicate. The record makes that case on its own terms.\n\nThe tracklist opens with \"sideways,\" which establishes the album's emotional logic in under four minutes. The song moves from intimacy to a kind of overwhelm and back again, a pattern that the album repeats in different configurations across all eleven tracks. \"dirty wedding dress\" sits in the middle and carries the most weight of any individual moment, arriving with an arrangement that manages to feel both carefully constructed and emotionally unguarded. \"dancing\" is the record's most direct statement, and it will find its way onto playlists not because it is simpler than the others but because its directness is earned rather than assumed.\n\n## The Cost of Making Everyone Else's Music\n\nThe question that hovers over any Bleachers record is whether Antonoff, who is so capable of giving other artists exactly what they need, can apply that capacity to his own work without the distance of collaboration introducing a layer of self-consciousness. The answer here is more complicated than a simple yes. Antonoff is aware of himself as a producer in a way that occasionally surfaces in the album's construction, where a chord change or a vocal arrangement feels like something applied rather than discovered from the inside. But the better moments on everyone for ten minutes, and there are more of them than not, arrive with the kind of vulnerability that his work for other artists rarely demands of him personally.\n\nThe album confronts the soul-flattening effects of the attention economy not by raging against them but by building something warm and immediate and real against that backdrop. This is an album about frustration with the present that refuses to resolve into bitterness. The album closes in a register of earned tenderness rather than resignation, which is the harder thing to achieve and the more important one.\n\n\"This version of modernity is trash,\" Antonoff said, \"and I still believe music can do something about it.\" Across eleven tracks on everyone for ten minutes, the belief holds. It is the conviction of someone who has watched the best songs of his generation get made and absorbed and turned into streams and still thinks that the next song might break through differently, might reach people at the level where sound becomes feeling and feeling becomes something worth holding.\n\n## Why It Matters That He Keeps Coming Back\n\nThe fact that Antonoff returns to Bleachers at all is the most interesting thing about his career. He does not need to. He is, by any commercial metric, one of the most successful music producers alive. And yet there is something in this band, in these specific six people playing these specific songs in this specific musical dialect, that he cannot get anywhere else. The obsessive quality that makes his production for others so precise and so generous, the need to understand exactly what a song is feeling and give it the arrangement it requires, that same quality applied to his own work produces something that has a different texture. Less precise in its edges, more honest in its center.\n\nEveryone for ten minutes is the best Bleachers album to date not because it is the most accomplished but because it is the most honest. Antonoff made it between sessions of making other people's music, which means he made it in the space where he was most himself, where the Grammy Awards and the production credits and everything that has accrued around him over the past decade all receded and what was left was a songwriter who grew up in New Jersey believing that music could do something real.\n\nThe belief holds. The album is the proof.\n\n[download:/assets/images/artists/bleachers-everyone-for-ten-minutes-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "bleachers-everyone-for-ten-minutes deployed"

# ---- IndexNow pings ----
echo "--- Pinging IndexNow ---"
JPEG_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/jpegmafia-experimental-rap")
echo "artonly.io/post/jpegmafia-experimental-rap: HTTP $JPEG_CODE"

BLEACH_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/bleachers-everyone-for-ten-minutes")
echo "artonly.io/post/bleachers-everyone-for-ten-minutes: HTTP $BLEACH_CODE"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/jpegmafia-experimental-rap&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: jpegmafia-experimental-rap pinged"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/bleachers-everyone-for-ten-minutes&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: bleachers-everyone-for-ten-minutes pinged"

# ---- Outreach emails ----
echo "--- Sending outreach emails ---"
# JPEGMAFIA - AWAL (independent artist)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@awal.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on JPEGMAFIA and EXPERIMENTAL RAP at artonly.io/post/jpegmafia-experimental-rap. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

# Bleachers - Dirty Hit
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@dirtyhit.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Bleachers and everyone for ten minutes at artonly.io/post/bleachers-everyone-for-ten-minutes. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

echo "=== Deploy complete ==="
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-05-24" \
  "Published today:\n\nhttps://artonly.io/post/jpegmafia-experimental-rap\nhttps://artonly.io/post/bleachers-everyone-for-ten-minutes\n\nOutreach: press@awal.com (JPEGMAFIA), press@dirtyhit.com (Bleachers)"
