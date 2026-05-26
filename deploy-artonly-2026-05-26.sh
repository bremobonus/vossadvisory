#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-26
# Posts: ed-obrien-blue-morpho, aja-monet-color-of-rain
# Run this on the DreamHost server via SSH:
# sshpass -p PASSWORD ssh dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-26.sh

set -e
echo "=== ArtOnly Deploy: 2026-05-26 ==="

# ---- POST 1: Ed O'Brien - Blue Morpho ----
echo "--- Deploying: ed-obrien-blue-morpho ---"

# Download press photo (Wikimedia Commons - Ed O'Brien at Radiohead 2006)
curl -L -o ~/artonly.io/assets/images/artists/ed-obrien-blue-morpho.jpg \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Ed-obrien2006-05Radiohead.jpg"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert ed-obrien-blue-morpho.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  ed-obrien-blue-morpho-up.jpg && mv ed-obrien-blue-morpho-up.jpg ed-obrien-blue-morpho.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py ed-obrien-blue-morpho \
  "Ed O'Brien Called Himself EOB for Six Years. Blue Morpho Is What Came After." music

# Write post JSON
cat > ~/artonly.io/posts/ed-obrien-blue-morpho.json << 'JSONEOF'
{
  "slug": "ed-obrien-blue-morpho",
  "title": "Ed O'Brien Called Himself EOB for Six Years. Blue Morpho Is What Came After.",
  "author": "Leelou Blanc",
  "category": "music",
  "date": "2026-05-26",
  "image": "/assets/images/artists/ed-obrien-blue-morpho.jpg",
  "image_alt": "Ed O'Brien press photo",
  "image_position": "center 20%",
  "body": "[spotify:artist/3E7aH1Yv84NoaP9JWcrMpE]\n\nThe name mattered. When Ed O'Brien released his first solo record in 2020, he called it Earth and put it out under a kind of alias. Not a disguise exactly, more like a door he could close if he needed to. EOB had enough distance from the weight of Radiohead that it allowed him to be someone else, to try things, to fail in private if failing was what happened. It did not fail. Earth was good. It was the sound of someone discovering what he sounded like when left alone in a room with no one else's blueprint to follow.\n\nBut then came the darkness. O'Brien has spoken about a period of depression that arrived in the years after Earth, a creative and personal collapse that left him unsure whether he had another record in him at all. He walked in the Welsh countryside. He took cold showers according to the teachings of the Dutch athlete Wim Hof, who believes suffering through cold water changes something fundamental in the nervous system. He sat with psilocybin. He listened to Thom Yorke, who told him to catalogue what he had and revisit it. And at some point, somewhere between the cold showers and the woods and the flute music he heard at Glastonbury, he decided to use his own name.\n\nBlue Morpho, released May 22 on Transgressive Records, is the second solo album by Edward John O'Brien of Radiohead. It is the first credited simply to him. \"I'm not hiding any more,\" he said. \"I was hiding behind a doppelgänger called EOB.\" The change in nomenclature is small and total. It signals something that the album then proves.\n\n## What Dropping the Alias Means\n\nThe seven tracks here are produced by Paul Epworth and Riley MacIntyre, the latter being the bassist for Ezra Collective, and the combination explains much of what the album sounds like. Epworth brings the large feeling, the cathedral space, the sense that each note is being placed inside a room with good acoustics and left to find its own resonance. MacIntyre brings something looser, more rhythmically alive, a bass player's understanding of where the room breathes. Shabaka Hutchings, who O'Brien heard playing at Glastonbury in 2023 and whose music moved him to reach out, contributes flute arrangements that arrive in the album's quieter passages as something close to structural. They are not decorative. They carry.\n\nThe tracks unfold: Incantations, Blue Morpho, Sweet Spot, Teachers, Solfeggio, Thin Places, Obrigado. That final word is Portuguese. It means thank you. The tracklist reads like a sentence about gratitude. Solfeggio refers to a system of naming musical notes, but it also refers to solfeggio frequencies, a set of tones used in alternative healing traditions and associated with specific effects on the nervous system. The name is not accidental. The album's relationship to healing is both subject and structure.\n\nO'Brien came through something and the record is the document of that passage. But it is not a therapy diary. The Irish Times wrote that Blue Morpho is \"a beautiful album about an ugly period, and another dispatch from Radiohead's workshop of woe that dwells in the darkness while making you appreciate the light.\" That phrase, the workshop of woe, is more useful than it first appears. What Radiohead has always been very good at is making music that feels like a sustained confrontation with difficulty, one that does not promise resolution but does offer company. Blue Morpho has that quality. It is a record you can sit inside.\n\n## The Shadow and the Exit From It\n\nThe comparison to Radiohead is inevitable and not unfair. Under the Radar Magazine wrote that the album is \"at least the equal of Radiohead's recent output and perhaps more pertinently firmly establishes O'Brien as a solo artist in his own right.\" That second clause is the more significant one. The comparison is a frame, but what O'Brien has built here is not a Radiohead record with him in the foreground instead of Thom Yorke. It is something different, something more grounded and less anxious, with more silence in it and more of a relationship to the physical world, to hills and cold water and the sound of a flute in an outdoor field.\n\nO'Brien has been the guitarist in Radiohead for thirty-five years. He is the one whose job was often described as making everything bigger, filling the space between the guitars with layers and texture, the sound architect working behind the more visible architectures of Yorke and Jonny Greenwood. To be that person for thirty-five years and then step into the foreground requires a different set of muscles. You have to know what you actually sound like when no one else is holding the blueprint. Earth started answering that question. Blue Morpho answers it more completely.\n\n## On Butterflies and Thin Places\n\nThe blue morpho butterfly is one of the largest butterflies in the world. It is iridescent in a way that changes depending on the angle at which light hits it. It is not actually blue in any chemical sense. The blue is a structural phenomenon, a product of how microscopic structures on its wings interact with light. The name for the album is not a coincidence, and it is not simple. Transformation is one of its subjects. So is the idea that what looks like one thing from a distance looks like another thing up close. The album's title track functions as the centre of this inquiry. It is a song about change that does not explain itself or offer a moral. It offers the experience of standing in the presence of something beautiful and knowing that the beauty is real even if you cannot fully account for it.\n\nThin Places is another meaningful title. The phrase comes from Celtic spirituality and refers to locations where the distance between the physical world and something beyond it seems to collapse. Glastonbury is often described as a thin place. Wales, where O'Brien walked and made much of this record, has that reputation too. There is something in the album's best moments that earns that description. They have the quality of music recorded somewhere the boundaries had already been loosened.\n\n## Why This One Lands Differently\n\nEd O'Brien has made a record about coming through depression that does not make depression its central subject. He has made a record about healing that refuses to be self-congratulatory about the achievement. He has stepped out from behind a name he used as a shield and put his own name on something as a declaration. And he has done all of this with a production that sounds like care, with players around him who understand what the record is doing and why the silences between the notes are as important as the notes themselves.\n\nNME called it \"the sound of healing, with Ed O'Brien out of his cocoon and in dazzling flight.\" That is one way to say it. Another is that Blue Morpho is a record that sounds like someone who survived something and came back to say thank you. That is what Obrigado means. And across seven tracks, O'Brien earns the word.\n\n[download:/assets/images/artists/ed-obrien-blue-morpho-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "ed-obrien-blue-morpho deployed"

# ---- POST 2: Aja Monet - the color of rain ----
echo "--- Deploying: aja-monet-color-of-rain ---"

# Download press photo (Wikimedia Commons - Aja Monet 2017)
curl -L -o ~/artonly.io/assets/images/artists/aja-monet-color-of-rain.jpg \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Aja_Monet_2017.jpg"

# Upscale
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert aja-monet-color-of-rain.jpg \
  -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 \
  aja-monet-color-of-rain-up.jpg && mv aja-monet-color-of-rain-up.jpg aja-monet-color-of-rain.jpg

# Generate social card
cd ~/artonly.io/agent
python3 make-social-card.py aja-monet-color-of-rain \
  "Aja Monet Read the News Every Day and Made an Album That Could Survive It" music

# Write post JSON
cat > ~/artonly.io/posts/aja-monet-color-of-rain.json << 'JSONEOF'
{
  "slug": "aja-monet-color-of-rain",
  "title": "Aja Monet Read the News Every Day and Made an Album That Could Survive It",
  "author": "Allastair Voss",
  "category": "music",
  "date": "2026-05-26",
  "image": "/assets/images/artists/aja-monet-color-of-rain.jpg",
  "image_alt": "Aja Monet press photo",
  "image_position": "center 30%",
  "body": "[spotify:artist/6dclGxWbiv1ScMQwT5INQF]\n\nThere is a particular discipline required to make something beautiful in a moment of sustained ugliness. Not a refusal of the ugliness, not a retreat from it, but an insistence that beauty has a function precisely because the ugliness is real. Aja Monet has been developing that discipline for her entire career. With the color of rain, released May 22 on Drink Sum Wtr, she applies it to fifteen tracks and does not blink.\n\nMonet is a self-described surreal blues poet, an Afro-Cuban-American writer and musician who first emerged from the slam poetry world and has spent the years since methodically constructing something more complicated: a practice that lives at the intersection of jazz, spoken word, R&B, and political thought. Her Grammy-nominated debut album when the poems do what they do, released in 2023, established her as one of the most formally interesting artists working in the space where poetry and music overlap. The color of rain is not a departure from that. It is the deepest penetration yet.\n\nThe album was produced by Monet, Justin Brown, and Meshell Ndegeocello, who also conducted the live band that recorded it and appears on the track elsewhere alongside Georgia Anne Muldrow. The band includes Burniss Travis on bass, Josh Johnson on saxophone, Daniel Mintseris on keys, Jermaine Paul on drums, Ambrose Akinmusire on trumpet, and Nico Segal on trumpet. This is not a backing band. These are some of the most technically and spiritually advanced musicians working in any genre. The presence of Akinmusire alone would guarantee a certain quality of listening. The presence of all of them together, gathered around poems about the end of the world, is something else.\n\n## A Record at the Edge of Things\n\nThe central impulse of the color of rain is as clearly stated as impulses ever are in Monet's work: she is trying to figure out how to stay present and protect her soul while the news does what it does. The description accompanying the album says she is doomscrolling past war, greed, and corruption and asking how to remain intact. But that description undersells what she is actually doing, which is refusing the false choice between attention and survival. She does not want to look away. She wants to find the grammar that allows you to look directly and remain whole.\n\nThe title is the key. Rain nourishes. Rain blesses. Rain loves everything it touches. Rain is also the thing that falls in the middle of everything else, indifferent to ceremony, arriving whether or not you are ready. The color of rain is what you see when rain is between you and the light. It is not a comfortable color but it is a real one.\n\nThe track for the Congo carries the weight its name promises. Working class musicians, the track released as the album's first official video, is a statement of solidarity and philosophy, an argument about who art is for and who gets left out when art becomes a luxury. Melting clocks features Mick Jenkins and Vic Mensa, two Chicago MCs whose presence in the sonic context Monet has built functions as a kind of reminder that the conditions she is describing are not abstract. They are the conditions of specific neighborhoods, specific bodies, specific communities making specific decisions about how to survive. To sister, featuring the vocalist Ganavya and harpist Brandee Younger, is something different. It has the quality of a blessing, or a letter, or both at once.\n\n## The Album as a Physical Thing\n\nOne of the things Monet understands that many artists in her genre do not is that poetry and music occupy different kinds of time. Poetry happens in the space where language slows down and each word accumulates weight. Music happens in the flow where weight is carried by rhythm and repetition and the body's response to sound. The color of rain holds both of these temporalities simultaneously. The record does not proceed from track to track the way an album of songs does. It moves the way water moves, which is both toward something and diffuse at once.\n\nThe live band approach matters here. The warped sonics arrive not as production flourishes applied after the fact but as the sound of live musicians choosing, in the moment of recording, to push against the edges of what the material would bear. The drums under a poem about fascism do not suggest that the poem and the fascism are safely contained. They suggest something is still present and alive inside the material. Ndegeocello as conductor is not just an arranger. She is making decisions about urgency and restraint that shape how the poems land, when they land soft and when they land like something thrown.\n\n## On Beauty and Responsibility\n\nMonet performed at Carnegie Hall two nights before this album was released. The timing is not incidental. It is a statement about the fact that this kind of work belongs in the grandest spaces, that jazz and spoken word poetry about the Congo and working class musicians and the color of rain do not belong in the margins. She has been arguing this for years. The color of rain is the clearest version of the argument yet.\n\nThe Grammy nomination for when the poems do what they do confirmed a level of formal recognition. But formal recognition and cultural importance are different things and Monet has always been more interested in the second. What the color of rain does that her debut did not fully accomplish is make the case that attending fully to what is terrible about the present moment and attending fully to what is beautiful about being alive are not opposing activities. They are, in fact, the same activity. The rain is the color of everything at once.\n\nAllMusic gave the album a score of 90. The score is beside the point but it is not wrong. What matters more is that in a moment when a great deal of music is using the sounds of political consciousness to sell something, Monet has made a record that uses political consciousness the way it should be used. As a way of seeing clearly. As a practice. As a thing that might, when done with enough care and enough skill and enough willingness to hold difficulty without resolving it, actually do something in the world.\n\nShe called it the color of rain. She meant it.\n\n[download:/assets/images/artists/aja-monet-color-of-rain-social-9x16.jpg|Download Social Card]"
}
JSONEOF

echo "aja-monet-color-of-rain deployed"

# ---- IndexNow pings ----
echo "--- Pinging IndexNow ---"
EOB_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/ed-obrien-blue-morpho")
echo "artonly.io/post/ed-obrien-blue-morpho: HTTP $EOB_CODE"

AJA_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/aja-monet-color-of-rain")
echo "artonly.io/post/aja-monet-color-of-rain: HTTP $AJA_CODE"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/ed-obrien-blue-morpho&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: ed-obrien-blue-morpho pinged"

curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/aja-monet-color-of-rain&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo "IndexNow: aja-monet-color-of-rain pinged"

# ---- Outreach emails ----
echo "--- Sending outreach emails ---"
# Ed O'Brien - Transgressive Records
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=international@transgressive.co.uk" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Ed O'Brien and Blue Morpho at artonly.io/post/ed-obrien-blue-morpho. No ask, just thought you should see it. Best, Leelou Blanc, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

# Aja Monet - Drink Sum Wtr / Secretly Group
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=press@secretlygroup.com" \
  -d "subject=Your artist is on ArtOnly" \
  -d "body=Hi, I wanted to let you know we published a piece on Aja Monet and the color of rain at artonly.io/post/aja-monet-color-of-rain. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly" \
  -d "bcc=amosleblanc@gmail.com"

echo "=== Deploy complete ==="
python3 ~/artonly.io/api/gmail-send.py "amosleblanc@gmail.com" \
  "ArtOnly Album Monitor: 2026-05-26" \
  "Published today:\n\nhttps://artonly.io/post/ed-obrien-blue-morpho\nhttps://artonly.io/post/aja-monet-color-of-rain\n\nOutreach: international@transgressive.co.uk (Ed O'Brien / Transgressive), press@secretlygroup.com (Aja Monet / Drink Sum Wtr)"
