#!/bin/bash
# ArtOnly Blog Expand Script
# Generated: 2026-06-11
# Task: Expand 11 blog posts to 1000-1400 words
# Run this on the DreamHost server via SSH

set -e
echo "=== ArtOnly Blog Expand: 2026-06-11 ==="

# ---- POST 1: wsabe-2024 ----
echo "--- Updating: wsabe-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/wsabe-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Mexico City's electronic music scene has been doing something interesting for long enough now that "emerging" is the wrong word for it. The thing has emerged, it is here, it has produced artists whose work is being heard and respected internationally and whose influence on how electronic music is being made in Latin America is already measurable. WSABE is one of those artists, and her work is the best evidence I know of that what is happening in CDMX is not a local phenomenon but a genuinely global contribution to the form.

The way she combines club music structures with elements from Mexican musical tradition is not pastiche. It is not the kind of "Latin flavouring" that international producers sometimes apply to tracks as a kind of musical tourism. The traditional elements and the electronic elements have equal claim on the music, equal weight in how it functions. This is harder than it looks and more interesting than most people realise. The rhythmic complexity that results, the way things sit against each other and create friction and resolution simultaneously, is extraordinary.

I have played WSABE's recent work to people who primarily listen to European electronic music, Berlin-inflected techno, UK club music, French house, and watched them respond to something that uses a similar vocabulary but speaks with a completely different accent. The comparison is instructive. You hear what the European tradition takes for granted and what the Mexican tradition brings that is not available there.

## The City as Sound

Mexico City is an extraordinary place to make music. The sonic texture of the city, the noise and the music and the religious processions and the traffic and the birds that sound wrong if you grew up in the northern hemisphere, all of it creates an environment that gets into music made there in ways that are subtle and pervasive. WSABE's music has this texture. It sounds like it comes from somewhere dense and alive.

The club culture context is important too. CDMX has developed a cluster of nights and spaces and promoters who are building the infrastructure for adventurous electronic music in the way that London and Berlin built theirs over several decades. This infrastructure, the places where music is played for bodies in the dark, where a DJ or live act can test ideas on an audience that is genuinely listening with their whole physical selves, is what makes music like WSABE's possible to develop and refine.

The specific spaces matter. A club night that consistently books adventurous programming is not just an entertainment venue; it is a laboratory. It is the place where a producer tests whether what she makes in solitude translates into something that moves people collectively. WSABE has built her practice inside this infrastructure, and the music reflects that grounding. It is not music made in isolation for private consumption. It is music designed for rooms and for the particular kind of collective attention those rooms produce.

There is also something to be said about the specific density of Mexico City as a creative environment. The city has roughly nine million people in its urban core, the largest Spanish-speaking city on Earth, and the cultural infrastructure that supports a population of that scale includes every kind of music and tradition simultaneously. A producer growing up there absorbs Mexican popular traditions, classical forms, international electronic music from multiple eras, and the specific sonic texture of urban noise, all at once. The resulting synthesis is not something you can achieve by studying a tradition from the outside. It requires being inside it from the beginning.

## On Looking South

I have spent too much of my listening life looking east and north, towards London and Berlin and New York, towards the traditional centres of gravity in electronic music, and the correction has been revealing. Not in the sense that the music from those centres is less good than I thought, but in the sense that the map I was using was incomplete. South America and Central America and the Caribbean have been making music that is not derivative of European electronic tradition for as long as that tradition has existed. It has been there to be listened to.

WSABE is a reason to recalibrate. Her music is not making a case for being taken seriously. It does not need to. It is simply excellent, and the excellence is its own argument. I have been listening with a gratitude that is partly for the music itself and partly for being corrected about where to look.

The scene in CDMX is continuing to develop. There is a generation of producers and DJs and label people who understand both what the city's musical traditions offer and how those traditions translate into contemporary club contexts. WSABE sits at the intersection of those two things with a clarity that is the product of real immersion, real time spent understanding what both sides of the equation actually require.

## What the Music Actually Does

There is a test I apply to electronic music that I find useful: whether it holds up outside of the context that produced it. Club music that only works in clubs is legitimate but limited. The music that interests me most is music that was made for the dancefloor but that has enough interior life to function when you are alone with it in the middle of the afternoon. WSABE passes this test.

The rhythmic intelligence in her work is never merely technical. The percussion choices are not demonstrations of skill, though the skill is evident. They are decisions about where the listener's body should be pulled, where the tension should accumulate, where the release should come. These are not algorithmic decisions. They are felt ones, made by someone who understands music as a physical experience first and a formal problem second.

The music that comes out of Mexico City right now is not waiting for permission. It is happening on its own terms, in its own time, for its own audience, and for anyone else who finds it. WSABE is making some of the most interesting electronic music anywhere, and the anywhere includes everywhere.

The electronic music coming out of Mexico City is not a trend or a moment. It is a scene with history and continuity and ambition. WSABE is one of the best arguments for paying attention to it. Her music does not need the validation of being discovered by a press that arrives late. But it does need ears, and I am offering mine without qualification.

[download:/assets/images/artists/wsabe-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: wsabe-2024")
PYEOF


# ---- POST 2: yaeji-dancing-in-both-languages ----
echo "--- Updating: yaeji-dancing-in-both-languages ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yaeji-dancing-in-both-languages.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Kathy Yaeji Lee makes music that sounds exactly like what it is: house music made by someone who grew up between cultures and found a way to live inside that gap.

She was born in New York, raised in Seoul, then Atlanta, then back in New York. Her parents are Korean. She sings in both languages, often within the same song. That is not a stylistic choice. It is just how she thinks. The bilingualism is structural, not decorative, a consequence of a life that genuinely occupied multiple cultural spaces simultaneously rather than moving between them as a tourist.

[spotify:artist/2RqrWplViWHSGLzlhmDcbt]

The early EPs on Godmode from 2017 and 2018 are where she made her name. "Raingurl" became the track people played on repeat, a shuffling four-four groove with her voice floating over the top, speaking in a near-whisper about rain and presence. It sounds nothing like what most people associate with club music, but it absolutely works on a dancefloor. The track accumulated millions of streams without radio support, which tells you something about how it found its audience: laterally, through sharing, through the specific networks that trade in music that is genuinely unusual. The intimacy of her delivery is part of what made it travel. It sounds like a private thought made public, which is the kind of thing that people forward to each other.

## What "Raingurl" Set Up

The Godmode EPs established something that her subsequent work has continued to refine: a particular relationship between the body and interiority in dance music. Most house music is extroverted. It is addressed to the room, to the collective, to the shared physical experience of people moving together. Yaeji's music is addressed to that space too, but it also speaks to the person inside the dancer. The club setting is a vehicle for something more internal, a way of being present in public while remaining private, the kind of doubled consciousness that defines life between languages and cultures.

That theme is structural. The bilingual songs are not making a point about code-switching. They are demonstrating what it feels like to carry more than one interior life simultaneously, to have different versions of yourself in permanent negotiation. A line that begins in English and resolves in Korean is not a grammatical experiment. It is a report on what it feels like to think in two languages at once, to reach for the word that fits and find it in the other tongue.

The production across the early work is deceptively simple. Yaeji is working with house templates that her audience recognises, but the choices she makes within those templates, the specific quality of the bass, the placement of silence, the grain of the vocal processing, are decisions that accumulate into something unmistakably her own. Simple-sounding music that is genuinely difficult to replicate is a specific achievement.

## With A Hammer

*WHAT WE DREW* came out in 2020 via XL Recordings. A mixtape in form but an album in ambition. The bilingual structure is more deliberate there, some songs in Korean, some in English, some in both. "MONEY CAT" uses a playful structure that hides how technically precise the production is underneath. The record was made during isolation, which gives it a specific quality of turned-inward attention, the energy of someone working through creative questions with nobody watching.

*With A Hammer* (2023) was her most direct statement yet. She moved away from pure house music into something harder and more physical. The title track has a brutalist quality, drums that hit like machinery, vocals processed in real time. "Submerge FM" from that record is the most fully realised thing she has made: it moves through three different tempos without losing the emotional thread, which is a compositional achievement that gets obscured by how effortless it sounds.

The album arrived with a clear thesis about what club music can hold. The lyrics engage with frustration, societal pressure, the specific weight of being an Asian-American woman in spaces where those identities create friction. The hard beats are not incidental to that content. The ferocity of the production and the directness of the subject matter are the same argument made in two different registers simultaneously.

## The Live Show and What It Demonstrates

Her live sets have evolved significantly since the early DJ sets. The 2023 tour behind *With A Hammer* was reviewed across the board as a step-change in scale and ambition. More theatrical, more physical, more willing to use the stage as something other than a surface for equipment. Reports from those shows describe performances that combined the intimacy of the recorded work with a presence and physicality that recordings can only gesture toward.

This is the live dimension of what makes Yaeji's project coherent: the music she makes in the studio creates conditions that the live show can then inhabit. The performance is not a reproduction of the record. It is the record's argument made physical, made collective, made available to rooms full of people who experience it in their bodies rather than through headphones.

## The Trajectory

The trajectory from "Raingurl" to *With A Hammer* is worth tracing from beginning to end, because it describes an artist making a series of deliberate decisions about what she is willing to ask of her music. Each step increases the stakes. The Godmode EPs are an introduction. *WHAT WE DREW* is an expansion. *With A Hammer* is a declaration.

What she is declaring is that the gap between cultures is not a problem to be solved. It is a location, specific and productive, where music can be made that would not be available from any single place. The bilingual songs are not compromises between two possibilities. They are the thing itself, the music that exists because both languages are present and neither yields.

That is worth paying attention to for a long time.

[download:/assets/images/artists/yaeji-dancing-in-both-languages-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yaeji-dancing-in-both-languages")
PYEOF


# ---- POST 3: yame-ebem-2025 ----
echo "--- Updating: yame-ebem-2025 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yame-ebem-2025.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:album/4UPHNEDkuwpqz1GlcFOm2s]

## Neither and Both

Yame is French. Yame is Cameroonian. On Ebem, his debut album released in June 2025, he is neither trying to reconcile those identities nor keep them separate. He is doing something more interesting: letting them speak to each other in real time, across the same song, sometimes across the same bar.

Ebem means a communal space where wisdom is passed on, a gathering place in Bassa, one of the Cameroonian languages Yame grew up around. The album uses that concept as a frame rather than an answer. Whose gathering? Which version of belonging? The one in Paris where Yame built his career, or the one that lives in the music his family made before he was born? The record proposes that belonging is not a fixed location but a practice, something you enact through the music you make and the people you make it for.

## Afropop Filtered Through French Melancholy

The production on Ebem occupies a genuinely unusual space. There are Cameroonian rhythmic structures, makossa influence, bikutsi patterns, that have been processed through the kind of atmospheric French pop production that Yame absorbed growing up in Paris. The result does not sound like fusion, which is usually a polite word for compromise. It sounds like a native language that happens to be made of two others.

On "Je Reviendrai," the guitar work is unmistakably West African in origin but the chord choices are Europop. The vocal sits between the two without apologizing for either. Yame does not explain the junction. He inhabits it.

That instinct, to present rather than explain, is the defining quality of Ebem as a record. Yame is not making an album about being between cultures. He is making an album from inside that position, which is entirely different and far more valuable. The album's intelligence lies in its refusal to turn its own complexity into subject matter.

The record is layered with electronic beats, textures drawn from French chanson, and African rhythmic foundations. Yame's voice, a high-pitched instrument with theatrical range, moves through this terrain with the assurance of someone who has been preparing for this record for years. The theatrical quality is not performance in the mannered sense. It is delivery, the understanding that a song is a construction that needs to be inhabited rather than simply executed.

## The Voice as Instrument

Yame's voice has unusual warmth in the lower registers and remarkable range at its upper limit. He uses it sparingly. On several tracks he barely pushes above a murmur, which means when he does open up, on the chorus of "Douala," on the final minute of "Mere," it lands harder than any technical display would.

He has cited Stromae, Asa, and Keziah Jones as influences, and you can hear all three without any of them dominating. What Yame has taken from each is not a sound but an attitude: the willingness to be emotionally direct without being sentimental, to be personal without being confessional, to make music that is clearly rooted in a specific life without closing the door on anyone who does not share it.

Asa in particular is a useful reference point because she is herself a Franco-Nigerian artist who navigated similar cultural terrain in her work. The comparison is not about influence in a direct sense but about a shared understanding of what it means to make music that is rooted in African traditions while being shaped by French cultural infrastructure. Yame knows this territory because he has lived it, and the knowing is audible in the specificity of the choices.

## Why This Record Matters Now

The conversation about African artists in European markets has been dominated for the past several years by Afrobeats, a genre that has proven its global reach definitively and irrefutably. Afrobeats is one sound from one part of a continent that contains multitudes. Yame is making music that draws from Central and West African traditions that rarely appear in that conversation, presented through a production sensibility shaped by Paris rather than Lagos or Accra.

That is not a criticism of Afrobeats. It is an observation about what Yame is doing differently, and why Ebem deserves attention that is distinct from the Afrobeats conversation rather than adjacent to it. The makossa and bikutsi influences are not well-known to most European or North American listeners precisely because the circuits through which Central African popular music travels have been different, less connected to the infrastructure of streaming-era global pop.

Yame's viral 2023 COLORS performance of "Becane" drew personal praise from Timbaland and charted across France, Belgium, and Luxembourg. He won Best Male Newcomer at the Victoires de la Musique in 2024 and the grand jury prize at the Music Moves Europe Awards in 2025. That trajectory of recognition confirms what the music itself argues: that specificity travels. The more particular you are about where you come from and what that heritage actually sounds like, the more legible you become to listeners who have no context for that heritage. The particularity is the point of connection.

## What Comes Next

He is twenty-six. Ebem is a debut. Both of those facts feel almost impossible given how settled and self-possessed the record sounds. The composure of a first album this assured usually signals an artist who has been making work for years before the public arrived, building something in private that only becomes visible when the conditions are right.

The conditions are now right. The record places him in a lineage of francophone African artists who have expanded the vocabulary of French pop rather than simply adapting to it. That lineage has historically required patience: the music often arrives to a broad audience on a delayed timeline, the recognition coming later than the work's quality warrants. Ebem is the record that shortens that delay. Pay attention to this name.

[download:/assets/images/artists/yame-ebem-2025-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yame-ebem-2025")
PYEOF


# ---- POST 4: yaya-bey-2023 ----
echo "--- Updating: yaya-bey-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yaya-bey-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/6tpaMMCs8X6o8j9H5OmWmT]

R&B as a genre has a complicated relationship with its own interior life. The expectation, the structural demand, is emotion, vulnerability, the laying bare of feeling. But the form that emotion can take, the range of things that can be said and how they can be said, is more constrained than it looks from the outside. Yaya Bey is pushing against those constraints in ways that are quiet rather than loud, incremental rather than revolutionary, and consequently more interesting than a lot of music that announces its radicalism more explicitly.

*Remember Your North Star* was the record that brought her to the attention of people who were not already paying close attention. Released in June 2022 on Big Dada, the eighteen-track album moves through jazz, R&B, soul, and reggae with a fluency that suggests someone who has absorbed a great deal of music and decided not to pick a lane. What she does with lineage is particular. She is clearly steeped in classic soul and neo-soul. There are moments in her music where I hear Erykah Badu, or Nina Simone, or something even older, the gospel roots that run under all of this, and she uses that lineage not as a costume but as a foundation, something she has built on and is now building away from.

## The Specificity of Grief

There is a specificity to Yaya Bey's emotional world that I find rare and valuable. She is writing about family, about her father, about inheritance in the most literal and most complicated sense, about what it means to love someone who did not give you what you needed and to try to understand why and to carry that understanding into your own adult life. This is not generic heartbreak material. It is the kind of thing that takes time to arrive at, that requires real reckoning with real experience.

The album examines romantic turbulence, female empowerment, fraught parental relationships, and the ongoing work of self-definition. These themes are not arranged as a therapy narrative. They are distributed across the record in the way that actual consciousness distributes them, circling back, contradicting, finding new angles on the same material. The non-linear structure is itself a formal argument about how we actually process things that have wounded us.

The production serves this emotional specificity without overwhelming it. Things are stripped back when they need to be stripped back. The arrangements breathe. Bey's voice, which has this quality of stated plainness, she rarely overperforms, rarely reaches for the note that would demonstrate range at the expense of meaning, sits in the middle of the sound without fighting it, without the kind of vocal theatrics that R&B has sometimes used to substitute for depth.

Tracks like "keisha" and "big daddy ya" demonstrate the range she operates across without losing the sense of a unified artistic perspective. "keisha" is sparse and conversational. "big daddy ya" is more layered, more rhythmically complex. The same writer inhabits both without strain. That range, the ability to move between formal registers while remaining recognisably yourself, is harder to achieve than it looks.

## On Inheritance and Making Something New

Inheritance is a complicated thing in music, as in life. You receive something from those who came before, their methods, their vocabulary, their emotional wisdom, sometimes their actual recordings, and you have to decide what to do with it. You can honour it by repetition, which is preservation but not creation. You can reject it, which is freedom but also a kind of loss. Or you can do the third thing, the difficult thing, which is to absorb it so completely that it becomes part of how you think rather than what you think about, and then make something that could not exist without that absorption but also could not exist if you had not brought yourself entirely to the work.

Bey is doing the third thing. You can hear the lineage in her music and you can hear where it becomes something that belongs entirely to her. That transition, the point where the inheritance becomes the artist's own voice, is the most interesting moment in any career, and Bey is in the middle of it in a way that feels genuinely exciting to follow.

The collaborators on *Remember Your North Star* include producer Aja Grant of Phony Ppl and DJ Nativesun. The range of production across eighteen tracks means that the album never settles into a single sonic register. The variety is not restlessness. It is evidence that Bey is interested in what different sonic environments do to the same emotional content. Grief sounds different over a spare jazz arrangement than it does over a more textured production. She uses both because they reveal different dimensions of the same experience.

## What Specificity Does

I have been pressing her records on people who say they do not really listen to R&B, and I have been watching them listen more carefully than they expected to. That is what specificity does. It cuts through the category resistance. It makes you feel like someone is talking to you, not to a demographic. You cannot dismiss someone who is being that precise about something that actually happened.

The specificity is what stays with me after the record ends. Not a mood, not an atmosphere, not a general sense of having been in the presence of something good. Specific moments: a specific lyric, a specific note held a specific way, a specific arrangement choice that opens something up. Yaya Bey makes music full of specific moments. I keep finding new ones each time I return.

The writing, the lyrics specifically, is what I would point anyone toward first, because it is where the specificity lives most vividly. Bey writes from the inside of experience rather than the outside, from within the feeling rather than looking back at it from a safe distance. The inside view is harder to sustain and more valuable to receive. It is what makes her records feel like accompaniment rather than commentary. She is in it with you. That company is worth seeking out and keeping.

[download:/assets/images/artists/yaya-bey-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yaya-bey-2023")
PYEOF


# ---- POST 5: yayoi-kusama-infinity-rooms-2023-2024 ----
echo "--- Updating: yayoi-kusama-infinity-rooms-2023-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yayoi-kusama-infinity-rooms-2023-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:0-C69t22twQ]
## The Tour That Will Not End

Yayoi Kusama's infinity mirror rooms have been touring global institutions for years now, and the demand shows no sign of diminishing. Through 2023 and into 2024, exhibitions featuring her immersive installations continued to sell out across multiple continents, with wait times for timed entry slots stretching into months. The David Zwirner exhibition "I Spend Each Day Embracing Flowers," which ran from May through July 2023 across three connected gallery spaces in New York, was one of the largest gallery presentations of her career. It introduced a new Infinity Mirror Room called "Dreaming of Earth's Sphericity, I Would Offer My Love," which then traveled to SFMOMA for "Yayoi Kusama: Infinite Love," opening in October 2023 as the artist's first solo museum presentation in Northern California. In an art world that constantly chases the next thing, Kusama's enduring popularity is both remarkable and instructive.

## The Experience Itself

For those who have not yet stepped inside one, an infinity mirror room is difficult to describe adequately. The mirrored walls create the illusion of infinite space, and the carefully positioned lights or objects within that space are reflected endlessly in every direction. The visitor stands inside what looks like a boundless cosmos. The effect is immediate, visceral, and profoundly moving in a way that has nothing to do with intellectual understanding.

This is the key to Kusama's mass appeal. Her installations do not require art historical knowledge or critical vocabulary to appreciate. They operate on a sensory level that is accessible to anyone who walks through the door. A five-year-old and an art history professor will have different frameworks for processing the experience, but both will feel something genuine.

The rooms also achieve something technically difficult: they make the visitor's body part of the work. You are not standing in front of the art looking at it. You are inside it, reflected infinitely, dissolved into the pattern while also remaining distinct. Kusama has spoken for decades about her obsessions with dots and with the dissolution of the self into the universe, and the infinity rooms are the most complete expression of that philosophical project. The philosophical content is not separate from the sensory experience. The two arrive simultaneously.

Each new room adds variables to the investigation. The 2023 "Dreaming of Earth's Sphericity" room uses natural light through colored windows in a way that earlier rooms did not, meaning the experience changes throughout the day and across seasons. Visiting at noon and visiting at dusk produces different works, in effect. That is not the product of an artist repeating herself. It is the product of someone still finding new variables in an equation they have been working on for half a century.

## The Social Media Question

Critics have raised the question of whether the popularity of infinity rooms is driven primarily by their Instagram-friendliness. The rooms are undeniably photogenic, and social media has certainly amplified their visibility. Dismissing the work as mere content fodder is condescending to both the artist and her audience.

People photograph things that move them. The impulse to capture and share the experience of standing inside infinite reflected light is not a corruption of the artistic encounter. It is a natural extension of it. Kusama herself has spoken about wanting to dissolve the boundaries between self and universe, and the act of sharing that dissolution with others through photography is entirely consistent with her artistic philosophy.

The more interesting question is what the social media attention does to the experience of the work. When you enter a Kusama room knowing that thousands of people have photographed themselves there, your experience of the room is not the same as it would have been for an earlier visitor without that context. The collective imagination of the space precedes your arrival. This is not necessarily a problem. It is a feature of how art functions in the current moment, where the conversation around a work is itself part of what the work becomes. Kusama's work, which has always been about the dissolution of boundaries between self and world, accommodates this expansion of meaning better than most art would.

## An Artist Beyond Categorization

Kusama, now in her nineties, continues to produce work at a pace that would exhaust artists half her age. Her studio output remains prolific, and each new exhibition demonstrates that her creative vision has not diminished. The infinity rooms are the most visible expression of a practice that spans painting, sculpture, film, and writing over seven decades.

Her early career is worth recalling in this context. Kusama moved from Japan to New York in the late 1950s, placed herself at the centre of the avant-garde, created proto-performance art, and was largely written out of art history for decades while male artists who absorbed her ideas received the credit. The belated recognition that came later, the retrospectives and the museum surveys and the gallery exhibitions, restored her place in that history but also revealed how extensive the erasure had been. She continued working through all of it. The obsessive quality of her practice, the return to the same motifs across seventy years, is inseparable from her biography. The work is the record of someone who would not stop.

Her continued relevance is not a fluke. It is evidence that art which connects with fundamental human experiences, the experience of smallness in relation to the universe, the desire for dissolution, the fear and attraction of infinity, transcends trends, market cycles, and critical fashion. The rooms will still be selling out when the current art world conversation has moved on from its present preoccupations entirely.

[download:/assets/images/artists/yayoi-kusama-infinity-rooms-2023-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yayoi-kusama-infinity-rooms-2023-2024")
PYEOF

