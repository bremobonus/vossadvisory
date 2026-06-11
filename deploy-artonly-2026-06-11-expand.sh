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

d["body"] = """Mexico City's electronic music scene has been doing something interesting for long enough now that "emerging" is the wrong wrong word for it. The thing has emerged, it is here, it has produced artists whose work is being heard and respected internationally and whose influence on how electronic music is being made in Latin America is already measurable. WSÁBE is one of those artists, and her work is the best evidence I know of that what is happening in CDMX is not a local phenomenon but a genuinely global contribution to the form.

The way she combines club music structures with elements from Mexican musical tradition is not pastiche. It is not the kind of "Latin flavouring" that international producers sometimes apply to tracks as a kind of musical tourism. The traditional elements and the electronic elements have equal claim on the music, equal weight in how it functions. This is harder than it looks and more interesting than most people realise. The rhythmic complexity that results, the way things sit against each other and create friction and resolution simultaneously, is extraordinary.

I have played WSÁBE's recent work to people who primarily listen to European electronic music, Berlin-inflected techno, UK club music, French house, and watched them respond to something that uses a similar vocabulary but speaks with a completely different accent. The comparison is instructive. You hear what the European tradition takes for granted and what the Mexican tradition brings that is not available there.

## The City as Sound

Mexico City is an extraordinary place to make music. The sonic texture of the city, the noise and the music and the religious processions and the traffic and the birds that sound wrong if you grew up in the northern hemisphere, all of it creates an environment that gets into music made there in ways that are subtle and pervasive. WSÁBE's music has this texture. It sounds like it comes from somewhere dense and alive.

The club culture context is important too. CDMX has developed a cluster of nights and spaces and promoters who are building the infrastructure for adventurous electronic music in the way that London and Berlin built theirs over several decades. This infrastructure, the places where music is played for bodies in the dark, where a DJ or live act can test ideas on an audience that is genuinely listening with their whole physical selves, is what makes music like WSÁBE's possible to develop and refine.

The specific spaces matter. A club night that consistently books adventurous programming is not just an entertainment venue; it is a laboratory. It is the place where a producer tests whether what she makes in solitude translates into something that moves people collectively. WSÁBE has built her practice inside this infrastructure, and the music reflects that grounding. It is not music made in isolation for private consumption. It is music designed for rooms and for the particular kind of collective attention those rooms produce.

## On Looking South

I have spent too much of my listening life looking east and north, towards London and Berlin and New York, towards the traditional centres of gravity in electronic music, and the correction has been revealing. Not in the sense that the music from those centres is less good than I thought, but in the sense that the map I was using was incomplete. South America and Central America and the Caribbean have been making music that is not derivative of European electronic tradition for as long as that tradition has existed. It has been there to be listened to.

WSÁBE is a reason to recalibrate. Her music is not making a case for being taken seriously. It does not need to. It is simply excellent, and the excellence is its own argument. I have been listening with a gratitude that is partly for the music itself and partly for being corrected about where to look.

The scene in CDMX is continuing to develop. There is a generation of producers and DJs and label people who understand both what the city's musical traditions offer and how those traditions translate into contemporary club contexts. WSÁBE sits at the intersection of those two things with a clarity that is the product of real immersion, real time spent understanding what both sides of the equation actually require.

## What the Music Actually Does

There is a test I apply to electronic music that I find useful: whether it holds up outside of the context that produced it. Club music that only works in clubs is legitimate but limited. The music that interests me most is music that was made for the dancefloor but that has enough interior life to function when you are alone with it at three in the afternoon. WSÁBE passes this test.

The rhythmic intelligence in her work is never merely technical. The percussion choices are not demonstrations of skill, though the skill is evident. They are decisions about where the listener's body should be pulled, where the tension should accumulate, where the release should come. These are not algorithmic decisions. They are felt ones, made by someone who understands music as a physical experience.

The music that comes out of Mexico City right now is not waiting for permission. It is happening on its own terms, in its own time, for its own audience, and for anyone else who finds it. WSÁBE is making some of the most interesting electronic music anywhere, and the anywhere includes everywhere.

The electronic music coming out of Mexico City is not a trend or a moment. It is a scene with history and continuity and ambition. WSÁBE is one of the best arguments for paying attention to it. Her music does not need the validation of being discovered by a European press that is a decade late to the party. But it does need ears, and I am offering mine without qualification.

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

She was born in New York, raised in Seoul, then Atlanta, then back in New York. Her parents are Korean. She sings in both languages, often within the same song. That is not a stylistic choice. It is just how she thinks.

[spotify:artist/2RqrWplViWHSGLzlhmDcbt]

The early EPs on Godmode from 2017 and 2018 are where she made her name. "Raingurl" became the track people played on repeat, a shuffling four-four groove with her voice floating over the top, speaking in a near-whisper about rain and presence. It sounds nothing like what most people associate with club music, but it absolutely works on a dancefloor. The track accumulated millions of streams without radio support, which tells you something about how it found its audience: laterally, through sharing, through the specific networks that trade in music that is genuinely unusual.

## What "Raingurl" Set Up

The Godmode EPs established something that her subsequent work has continued to refine: a particular relationship between the body and interiority in dance music. Most house music is extroverted. It is addressed to the room, to the collective, to the shared physical experience of people moving together. Yaeji's music is addressed to that space too, but it also speaks to the person inside the dancer. The club setting is a vehicle for something more internal, a way of being present in public while remaining private, the kind of doubled consciousness that defines life in between languages and cultures.

That theme is structural. The bilingual songs are not making a point about code-switching. They are demonstrating what it feels like to carry more than one interior life simultaneously, to have different versions of yourself in permanent negotiation.

## With A Hammer

*WHAT WE DREW* came out in 2020 via XL Recordings. A mixtape in form but an album in ambition. The bilingual structure is more deliberate there, some songs in Korean, some in English, some in both. "MONEY CAT" uses a playful structure that hides how technically precise the production is underneath.

*With A Hammer* (2023) was her most direct statement yet. She moved away from pure house music into something harder and more physical. The title track has a brutalist quality, drums that hit like machinery, vocals processed in real time. "Submerge FM" from that record is the most fully realised thing she has made: it moves through three different tempos without losing the emotional thread, which is a compositional achievement that gets obscured by how effortless it sounds.

The album arrived with a clear thesis about what club music can hold. Yaeji has described *With A Hammer* as cathartic work, a way of processing frustration through physical sound rather than through complaint. The guitars on "For Granted" have a ferocity that her earlier work would not have supported. She earned the right to that ferocity through a decade of understanding exactly what house music does to bodies and why.

## The Live Show

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

Yamê is French. Yamê is Cameroonian. On Ebem, his debut album released in June 2025 to the kind of quiet critical reception that precedes a much louder second wave, he is neither trying to reconcile those identities nor keep them separate. He is doing something more interesting: letting them speak to each other in real time, across the same song, sometimes across the same bar.

Ebem means a communal space where wisdom is passed on, a gathering place in Bassa, one of the Cameroonian languages Yamê grew up around. The album uses that concept as a frame rather than an answer. Whose gathering? Which version of belonging? The one in Paris where Yamê built his career, or the one that lives in the music his family made before he was born? The answer the record proposes is that the question itself is the point: belonging is not a fixed location but a practice, something you enact through the music you make and the people you make it for.

## Afropop Filtered Through French Melancholy

The production on Ebem occupies a genuinely unusual space. There are Cameroonian rhythmic structures, makossa influence, bikutsi patterns, that have been processed through the kind of atmospheric French pop production that Yamê absorbed growing up in Paris. The result does not sound like fusion, which is usually a polite word for compromise. It sounds like a native language that happens to be made of two others.

On "Je Reviendrai," the guitar work is unmistakably West African in origin but the chord choices are Europop. The vocal sits between the two without apologizing for either. Yamê does not explain the junction. He inhabits it.

That instinct, to present rather than explain, is the defining quality of Ebem as a record. Yamê is not making an album about being between cultures. He is making an album from inside that position, which is entirely different and far more valuable. The album's intelligence lies in its refusal to turn its own complexity into subject matter.

## The Voice as Instrument

Yamê's voice is a baritone with unusual warmth in the lower registers. He uses it sparingly. On several tracks he barely pushes above a murmur, which means when he does open up, on the chorus of "Douala," on the final minute of "Mère," it lands harder than any technical display would.

He has cited Stromae, Asa, and Keziah Jones as influences, and you can hear all three without any of them dominating. What Yamê has taken from each is not a sound but an attitude: the willingness to be emotionally direct without being sentimental, to be personal without being confessional, to make music that is clearly rooted in a specific life without closing the door on anyone who does not share it.

The bilingual approach across Ebem, mixing French and occasional Cameroonian phrases, mirrors the structural principle of the production. Neither language is subordinate. Neither tradition is decorative. Yamê's viral 2023 COLORS performance of "Bécane," which drew personal praise from Timbaland and charted across France, Belgium, and Luxembourg, demonstrated that this approach translates internationally without being diluted. The international recognition, including a win for Best Male Newcomer at the Victoires de la Musique in 2024 and the grand jury prize at the Music Moves Europe Awards in 2025, confirms what the music itself argues: that specificity travels.

## Why This Record Matters Now

The conversation about African artists in European markets has been dominated for the past several years by Afrobeats, a genre that has proven its global reach definitively and irrefutably. But Afrobeats is one sound from one part of a continent that contains multitudes. Yamê is making music that draws from Central and West African traditions that rarely appear in that conversation, presented through a production sensibility shaped by Paris rather than Lagos or Accra.

That is not a criticism of Afrobeats. It is an observation about what Yamê is doing differently, and why Ebem deserves attention that is distinct from the Afrobeats conversation rather than adjacent to it. The makossa and bikutsi influences are not well-known to most European or North American listeners precisely because the circuits through which Central African popular music travels have been different, less connected to the infrastructure of streaming-era global pop.

Ebem is, among other things, an introduction to those traditions for listeners who have not encountered them. But it is not an educational project. It is a personal one, rooted in Yamê's specific biography and the specific choices he has made about what kind of music he wants to make and why. The education is a byproduct of the authenticity.

## What Comes Next

He is twenty-six. Ebem is a debut. Both of those facts feel almost impossible given how settled and self-possessed the record sounds. The composure of a first album this assured usually signals an artist who has been making work for years before the public arrived, building something in private that only becomes visible when the conditions are right.

The conditions are now right. Pay attention to this name.

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

*Remember Your North Star* was the record that brought her to the attention of people who were not already paying close attention. Released in June 2022 on Big Dada, the eighteen-track album moves through jazz, R&B, soul, and reggae with a fluency that suggests someone who has absorbed a great deal of music and decided not to pick a lane. What she does with lineage is particular. She is clearly steeped in classic soul and neo-soul, there are moments in her music where I hear Erykah Badu, or Nina Simone, or something even older, the gospel roots that run under all of this, and she uses that lineage not as a costume but as a foundation, something she has built on and is now building away from.

## The Specificity of Grief

There is a specificity to Yaya Bey's emotional world that I find rare and valuable. She is writing about family, about her father, about inheritance in the most literal and most complicated sense, about what it means to love someone who did not give you what you needed and to try to understand why and to carry that understanding into your own adult life. This is not generic heartbreak material. It is the kind of thing that takes time to arrive at, that requires real reckoning with real experience.

The album examines romantic turbulence, female empowerment, fraught parental relationships, and the ongoing work of self-definition. These themes are not arranged as a therapy narrative. They are distributed across the record in the way that actual consciousness distributes them, circling back, contradicting, finding new angles on the same material. The non-linear structure is itself a formal argument about how we actually process things.

The production serves this emotional specificity without overwhelming it. Things are stripped back when they need to be stripped back. The arrangements breathe. Bey's voice, which has this quality of stated plainness, she rarely overperforms, rarely reaches for the note that would demonstrate range at the expense of meaning, sits in the middle of the sound without fighting it, without the kind of vocal theatrics that R&B has sometimes used to substitute for depth.

## On Inheritance and Making Something New

Inheritance is a complicated thing in music, as in life. You receive something from those who came before, their methods, their vocabulary, their emotional wisdom, sometimes their actual recordings, and you have to decide what to do with it. You can honour it by repetition, which is preservation but not creation. You can reject it, which is freedom but also a kind of loss. Or you can do the third thing, the difficult thing, which is to absorb it so completely that it becomes part of how you think rather than what you think about, and then make something that could not exist without that absorption but also could not exist if you had not brought yourself entirely to the work.

Bey is doing the third thing. You can hear the lineage in her music and you can hear where it becomes something that belongs entirely to her. That transition, the point where the inheritance becomes the artist's own voice, is the most interesting moment in any career, and Bey is in the middle of it in a way that feels genuinely exciting to follow.

The collaborators on *Remember Your North Star* include producer Aja Grant of Phony Ppl and DJ Nativesun, and the range of production across eighteen tracks means that the album never settles into a single sonic register. The variety is not restlessness. It is evidence that Bey is interested in what different sonic environments do to the same emotional content, how grief sounds over a spare jazz arrangement versus how it sounds over a more textured, layered production.

## What Specificity Does

I have been pressing her records on people who say they do not really listen to R&B, and I have been watching them listen more carefully than they expected to. That is what specificity does. It cuts through the category resistance. It makes you feel like someone is talking to you, not to a demographic.

The specificity is what stays with me after the record ends. Not a mood, not an atmosphere, not a general sense of having been in the presence of something good. Specific moments: a specific lyric, a specific note held a specific way, a specific arrangement choice that opens something up. Yaya Bey makes music full of specific moments. I keep finding new ones each time I return.

The writing, the lyrics specifically, is what I would point anyone toward first, because it is where the specificity lives most vividly. Bey writes from the inside of experience rather than the outside, from within the feeling rather than looking back at it from a safe distance. The inside view is harder to sustain and more valuable to receive. It is what makes her records feel like accompaniment rather than commentary. She is in it with you. That company is worth seeking out.

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

For those who have not yet stepped inside one, an infinity mirror room is difficult to describe adequately. The mirrored walls create the illusion of infinite space, and the carefully positioned lights or objects within that space are reflected endlessly in every direction. The visitor stands inside what appears to be a boundless cosmos. The effect is immediate, visceral, and profoundly moving in a way that has nothing to do with intellectual understanding.

This is the key to Kusama's mass appeal. Her installations do not require art historical knowledge or critical vocabulary to appreciate. They operate on a sensory level that is accessible to anyone who walks through the door. A five-year-old and an art history professor will have different frameworks for processing the experience, but both will feel something genuine.

The rooms also achieve something technically difficult: they make the visitor's body part of the work. You are not standing in front of the art looking at it. You are inside it, reflected infinitely, dissolved into the pattern while also remaining distinct. Kusama has spoken for decades about her obsessions with dots and with the dissolution of the self into the universe, and the infinity rooms are the most complete expression of that philosophical project. The philosophical content is not separate from the sensory experience. The two arrive simultaneously.

## The Social Media Question

Critics have raised the question of whether the popularity of infinity rooms is driven primarily by their Instagram-friendliness. The rooms are undeniably photogenic, and social media has certainly amplified their visibility. Dismissing the work as mere content fodder is condescending to both the artist and her audience.

People photograph things that move them. The impulse to capture and share the experience of standing inside infinite reflected light is not a corruption of the artistic encounter. It is a natural extension of it. Kusama herself has spoken about wanting to dissolve the boundaries between self and universe, and the act of sharing that dissolution with others through photography is entirely consistent with her artistic philosophy.

The more interesting question is what the social media attention does to the experience of the work. When you enter a Kusama room knowing that thousands of people have photographed themselves there and shared those photographs, your experience of the room is not the same as it would have been for an earlier visitor without that context. The collective imagination of the space precedes your arrival. This is not necessarily a problem. It is a feature of how art functions in the current moment, where the conversation around a work is itself part of what the work becomes.

## An Artist Beyond Categorization

Kusama, now in her nineties, continues to produce work at a pace that would exhaust artists half her age. Her studio output remains prolific, and each new exhibition demonstrates that her creative vision has not diminished. The infinity rooms are the most visible expression of a practice that spans painting, sculpture, film, and writing over seven decades.

The obessive use of dots and nets and mirrors across her entire career is not repetition in the conventional sense. It is a sustained investigation into the same philosophical territory from different angles and with different materials. Each new room adds something to the investigation. The 2023 "Dreaming of Earth's Sphericity" room uses natural light through colored windows in a way that her earlier rooms did not, meaning the experience changes throughout the day and across seasons. That is not the work of an artist in decline or repetition. It is the work of someone still finding new variables in an equation they have been working on for half a century.

Her continued relevance is not a fluke. It is evidence that art which connects with fundamental human experiences, the experience of smallness in relation to the universe, the desire for dissolution, the fear and attraction of infinity, transcends trends, market cycles, and critical fashion. The rooms will still be selling out when the current art world conversation has moved on from its present preoccupations entirely.

[download:/assets/images/artists/yayoi-kusama-infinity-rooms-2023-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yayoi-kusama-infinity-rooms-2023-2024")
PYEOF


# ---- POST 6: ye-sofi-bully-2026 ----
echo "--- Updating: ye-sofi-bully-2026 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/ye-sofi-bully-2026.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:album/5poA9SAx0Xiz1cf17fWBLS]

There is a scene that keeps circulating from SoFi Stadium this week: a figure standing alone on top of a massive rotating globe, smoke pouring around him, 80,000 people screaming below. It is the kind of image that is either grandiose to the point of self-parody, or so audacious it crosses back into genius. With Ye, it has always been both, and that is exactly the point.

On April 1 and April 3, 2026, Kanye West performed two sold-out shows at SoFi Stadium in Inglewood. Combined, they grossed a reported $33 million, setting a record for the venue and landing among the highest-grossing single concert events in live music history. The Friday night show alone pulled over $18 million. For an artist who has spent the better part of three years being cut from rosters, dropped by labels, stripped of partnerships, and publicly exiled from the mainstream music industry, those numbers are not just impressive. They are a rupture in how we think about power in this business.

## The Industry Wrote Him Off. The Fans Did Not.

The context matters. In the years leading up to these shows, Ye lost virtually everything the traditional music industry had granted him. Adidas terminated their decade-long partnership following his antisemitic public statements, costing him an estimated $1.5 billion in net worth overnight. Gap ended their collaboration. Talent agencies dropped him. Radio stations pulled his records. Major institutions put distance between themselves and his name. By every conventional metric, the gatekeepers had closed the gates.

Two nights, $33 million, sold out.

That math does not work by the old logic. Under the old logic, you needed brand backing, industry infrastructure, radio support, and a clean public image to fill a stadium. Ye proved none of that is actually required when the body of work is strong enough and the fanbase is deep enough. It is uncomfortable for a lot of people to sit with, and it should prompt a more honest conversation about where actual cultural leverage lives. The discomfort does not resolve the question. It is the question.

## What Happened on That Stage

[youtube:k9XpmiAdWdQ]

The set itself was 44 songs across two hours. Not a greatest hits victory lap, a statement. He opened with material from *Bully*, his new album that debuted at No. 2 on the Billboard 200 with 98 million streams in its first week, then spiraled through 20 years of catalog: "Can't Tell Me Nothing," "Power," "Blood on the Leaves," "Heartless," "Runaway." The hits hit harder in a stadium of 80,000 people who have carried them for a decade.

The guests were a flex in their own right. Lauryn Hill joined for a performance of "All Falls Down" and stayed to deliver "Doo Wop (That Thing)" into "Believe What I Say," one of the most genuinely moving moments in recent live music memory. Travis Scott came out for "Father," the lead Bully single, and the crowd lost their minds. CeeLo Green performed the title track. North West, twelve years old, rapped "Talking" and "Piercing on My Hand" on the same stage as her father, and held it down.

The globe stage deserves its own paragraph. Designed to rotate slowly and shift between projections, a bare moon, the spinning Earth, a smoke-emitting orb, it was not just a set piece. It was a declaration. The man the industry tried to shrink to nothing built a world and put himself on top of it.

## The Larger Question

What this run of shows proves is not that controversy has no consequences. Ye's UK ban and the collapse of the Wireless Festival headlining slot make clear there are still real walls. What it proves is that the grip labels and brand partners once had over an artist's entire livelihood was always more conditional than they let on. When the audience relationship is direct enough, deep enough, and old enough, no intermediary controls the outcome.

The economics of this independence are stark. No label taking a cut of recordings. No brand partner extracting a percentage of the Ye name's commercial value. The $33 million goes somewhere other than the usual places. The logistics, the production costs, the crew, the venue, the touring infrastructure, are all substantial. But the structural relationship between the artist and the revenue is completely different from what it would be inside a major label system, and that difference is what makes the numbers so significant as a demonstration of principle.

Independent touring at this scale is not available to most artists. The precondition is having built an audience over twenty years of releasing records that people cared about enough to carry with them. Ye has that audience. The shows at SoFi were the demonstration of what that audience is actually worth when the intermediaries are removed.

The tour continues through Europe and beyond. The album is out. The world keeps spinning.

And Ye keeps standing on top of it.

[download:/assets/images/artists/ye-sofi-bully-2026-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: ye-sofi-bully-2026")
PYEOF


# ---- POST 7: yeule-softscars-2023 ----
echo "--- Updating: yeule-softscars-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yeule-softscars-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/1WZarnZpWEv7dDtjAETt4X]

## Reception Problems

I have tried to play Yeule's music for people who do not already know it and watched their faces do something complicated, a flicker of confusion, maybe discomfort, occasionally a kind of bewilderment that tips into curiosity. It does not land the same way for everyone. Softscars, her third record and probably her most direct, still requires something from the listener that not everyone wants to give.

Yeule, Nat Cmiel, based in London and originally from Singapore, makes music somewhere between shoegaze, hyperpop, and something that does not have a name yet. Her vocals are processed and layered until they become more texture than voice, but the emotional content is never obscured. If anything the processing intensifies it, makes the vulnerability of the lyrics feel more exposed rather than protected. That is a counterintuitive move and it works completely.

Softscars is her hardest record. Not hard as in difficult, though it is that, but hard as in aggressive, distorted, willing to be abrasive in service of something. There are guitars here that sound like something collapsing. The title track is one of the more emotionally overwhelming things I heard all year: a song about self-harm and recovery that does not make either comfortable, that holds both the damage and the survival without resolving them neatly into lesson or warning.

## The Question of Sincerity

Something has happened in indie music over the past few years where sincerity has become aesthetically complicated. Expressing real emotion directly risks feeling naive or uncool. Ironic distance has calcified into a default mode. Yeule is doing something that cuts directly against this. The emotional stakes on Softscars are real and visible and sometimes almost unbearably so.

The line between confession and performance in this music is worth thinking about. The aesthetic elements, the processed vocals, the distortion, the visual world she has built around the record, do not insulate the personal content. They make it more present. There is a Japanese concept, mono no aware, sometimes translated as the pathos of things, a sensitivity to impermanence tinged with both sadness and appreciation. Yeule's music carries that quality. The beauty and the damage are inseparable.

The production on Softscars involves contributions from various collaborators but Yeule's fingerprints are everywhere. The record sounds expensive in its ambition but not slick. It has a rawness that survives all the layers, an essential quality that the production serves rather than obscures. That is a delicate balance and it holds throughout.

## What the Record Is Actually Doing

Softscars was recorded at a period when Yeule was processing significant personal difficulty, including experiences with illness that she has discussed in interviews with precision and care. The album's emotional texture reflects that. It is not a record about suffering in an abstract sense. It is a record about specific kinds of damage and specific kinds of survival, and the specificity is what gives it its force.

The track sequencing is not arbitrary. The album opens with relative accessibility and moves progressively into more difficult territory, so that by the time you reach the most demanding material you have been prepared for it, not by reassurance but by accumulation. You have been shown what the record is capable of before it asks you to receive its most serious content. This is compositional intelligence applied to emotional experience.

The shoegaze influence is real but the comparison only goes so far. Classic shoegaze used sonic density as a form of protection, wrapping feeling in noise in a way that made the vulnerability deniable. Yeule uses sonic density as amplification. The noise makes the feeling louder rather than safer. The effect is the opposite of the protective wall.

## Who This Is For

There is a specificity to Softscars that suggests a particular listener, someone who has spent time in their own head in ways that are not always comfortable, who recognizes something in the texture of the music before processing the lyrics. Yeule has spoken about her own experiences with illness and mental health in ways that are careful and precise, not performing damage but not hiding it either. The music reflects that precision. It knows exactly what it is doing with the most difficult material. Nothing here feels gratuitous.

I find myself returning to this record in late evenings when the light has gone and the city has gone quiet. It fits that specific time in a way I cannot fully explain, something about the frequency, the way the sound moves between soft and harsh, the way Yeule's voice sits in the mix like something overheard rather than performed. There is a privacy to it that is genuinely comforting even when the content is anything but comfortable.

Softscars is not an album I recommend casually. It requires something, it costs something, it gives back in ways that are not immediately comfortable. This profile of experience is exactly what distinguishes art from entertainment, and I am not using those terms pejoratively. Entertainment is valuable, pleasure is valuable. Softscars is doing something else, something that requires the kind of engagement you give to things that matter.

Certain people will find it. The frequency is specific. If you are one of those people, you will know within the first few minutes. I knew immediately. I have been returning ever since.

[download:/assets/images/artists/yeule-softscars-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yeule-softscars-2023")
PYEOF


# ---- POST 8: yu-su-2024 ----
echo "--- Updating: yu-su-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yu-su-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/69zPIMRgsZieOHFtHtvnj0]

Yu Su makes music the way certain novelists write sentences, each element considered for its specific contribution to the whole, nothing decorative, nothing wasted, the form serving the meaning without announcing itself as form. I have been listening to her work across a year now and every listen reveals something I missed before, some production choice or harmonic decision or rhythmic nuance that was there all along but that I did not have the attention to receive yet. That quality of depth that reveals itself incrementally is one of the markers of music that is genuinely well-made.

She is based in Vancouver, originally from China, and her music carries both of those geographical contexts in ways that are not surface-level. The influence of Chinese musical tradition is not in the instrumentation or the scale choices in the way that "world music" fusion often works, a flute here, a pentatonic run there, but in something more fundamental, something about the relationship between sound and silence, between the music and the space it occupies. There is a patience in her work that I associate with certain East Asian aesthetic traditions, the understanding that what you withhold can be as meaningful as what you include.

The electronic music context she operates in, the Vancouver and Montreal scenes, the overlapping circles of producers and DJs and label people, gives her work a contemporary legibility, a sense of being in conversation with the current moment. The current moment alone does not explain the depth. The depth comes from somewhere else.

## The Dance Floor as Contemplative Space

This is a strange thing to claim, because dance floors are by conventional understanding the opposite of contemplative. They are physical, communal, extroverted. But the best dance music, the music that functions at the highest level in those spaces, creates a particular kind of collective contemplation, bodies moving together in response to something that is also addressing something interior. Yu Su understands this. Her DJ sets, which I have listened to in recorded form and heard described by people who have experienced them in rooms, operate at this level. The music does not tell you how to feel. It creates the conditions for feeling.

Her 2020 debut album *Yellow River Blue*, released on Technicolour, established this approach formally. The record moves between ambient electronic passages and club-oriented material with a fluency that declines to separate contemplation from movement. The title itself, referencing the Yellow River of China and the more generalized blue of electronic music's emotional palette, announces the dual geography that her music inhabits without making that duality into an explicit subject.

The production on her records has a similar quality to the DJ sets. You are not being told where the emotion is. You are being given an environment in which emotion can arise, on your own terms, from your own interior. This is a very different project from most music, which is much more directive about the emotional experience it is offering. Most music hands you the feeling pre-packaged. Yu Su gives you the space to find it.

## The Work of Restraint

Restraint in music is often misread as coldness. Yu Su's work demonstrates that restraint is a form of trust, trust that the listener has the capacity to complete what the artist begins, to bring something of their own to what the music offers. The space in her tracks is not emptiness. It is invitation.

This extends to the harmonic choices. She does not resolve tension at the moments when resolution would be easiest and most expected. She holds the unresolved chord, lets it breathe, gives it room to develop its own complexity before deciding what it wants to do next. This produces a particular quality of listening attention, an alertness to what might change, a presence in the moment that more resolved music does not demand.

## On Making Music on Your Own Terms

The phrase "on her own terms" is doing real work. The music industry, even the independent and underground parts of it, has expectations about what artists should do: the release cycle, the promotional activity, the genre legibility that makes you recommendable to algorithms and playlist curators. Yu Su navigates this infrastructure with a clarity about what she will and will not compromise that produces music recognisably her own rather than shaped by external demands.

There is a self-possession in her work, a quality of knowing what it is and being willing to be exactly that, that is rarer than it should be and more valuable than it is given credit for being. Music made freely sounds different from music made under constraint. The autonomy is audible.

I keep coming back to her records late in the evening, when my own demands on the day have relaxed enough to listen properly. They reward that attention every time. The most honest thing I can say is that her music has changed my relationship with what I expect from electronic music, widened it, made it more patient, more willing to sit with something before demanding it give me what I think I want. Yu Su made me a better listener for her work, and for that I am grateful in the specific and lasting way you are grateful for things that change your capacity rather than just your mood.

[download:/assets/images/artists/yu-su-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yu-su-2024")
PYEOF


# ---- POST 9: yussef-dayes-2023 ----
echo "--- Updating: yussef-dayes-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yussef-dayes-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/2rspptKP0lPBdlJJAJHqht]

I saw Yussef Dayes play to a room that was too small for him and I have been thinking about it ever since. The drumming was commanding in the sense of a force that takes possession of a space. There was no moment where the kit was decorative or supporting or filling in the background. The drums were the argument, and everything else was evidence for the argument, and the argument was that rhythm is not time-keeping. Rhythm is meaning.

The moment in British jazz over the last decade has produced several extraordinary musicians, and Dayes is central to it in a way that is both about his own prodigious talent and about his collaborative intelligence, his ability to create contexts in which other musicians are drawn to play beyond their usual capabilities. The Yussef Kamaal project, his collaboration with keyboardist Henry Wu, brought him to wider attention with the 2016 debut *Black Focus* on Brownswood Recordings. The solo work that followed has been establishing his individual voice in ways that are even more interesting to follow.

*Black Classical Music*, the album that arrived in 2023, is an ambitious title that the music earns. It is jazz and it is not jazz; it is electronic music and it is not; it is soul and it is funk and it is something without an adequate name. It moves between these things with a fluency that suggests someone who does not experience them as different things. For Dayes, there seems to be one music with many dialects.

## The Live Show as Primary Text

Dayes is one of those artists for whom the recorded music is a document of something that primarily happens in performance. The records are excellent, and *Black Classical Music* in particular is thoughtfully constructed, but the live experience is something different in kind. The improvisation, the way the music extends and changes direction in real time, the conversation between Dayes and his collaborators, these things are available in the recordings only in compressed form.

This is not unique to jazz, where the live performance has always been the primary text. But it is a reminder that recorded music, as a medium, domesticates certain kinds of musical intelligence. The music that happens between the notes, in the decisions made in real time, in the risk and the recovery and the discovery, this is harder to document than the notes themselves.

What makes the live show specifically important for Dayes is the way the drumming changes when there is an audience. The relationship between a drummer and a room is physical in a way that applies to other instruments only partially. The drummer's attack determines how much air moves, how the sound propagates, how the bodies in the room register the music physically. Dayes understands this. In the footage of the small-room show that I keep returning to, you can see the moment when he makes a decision about how hard to hit something based on what the room needs rather than what the song technically requires. That level of real-time adjustment is what separates great live drummers from good ones.

## On the New British Jazz Moment

A word about context, because context matters. The wave of British jazz that emerged in the early 2010s and has been building since, Yussef Dayes, Moses Boyd, Nubya Garcia, Shabaka Hutchings, Ezra Collective and their orbits, did not emerge from nowhere. It emerged from specific institutions, from Tomorrow's Warriors and the Jazz Refreshers' late-night sessions, from Dalston Jazz Bar and similar spaces, from communities of musicians who were in dialogue with each other and with diasporic musical traditions that British mainstream culture had undervalued. Dayes is a product of this ecosystem and its most visible current standard-bearer.

Tomorrow's Warriors in particular deserves recognition as formative infrastructure. The organisation has been running workshops and performance opportunities for young British jazz musicians for over thirty years, and an astonishing proportion of the current wave passed through it. The scene did not produce itself. It was built by specific people making specific decisions about what to support and how.

What the scene is doing, what Dayes is doing with his live shows and his records, is establishing that jazz is not a finished form, is not a museum piece, is not defined by what happened in New York in the 1950s and 60s. It is a practice that continues, that develops, that absorbs and transforms everything that happens to reach it. That is what living music does. Yussef Dayes is living music.

## The Vocabulary Keeps Expanding

The best argument for Yussef Dayes is Yussef Dayes. Play the records. Watch the live footage. Let the drumming do what it does. The argument makes itself, more efficiently than any words, with a clarity that language can only gesture toward.

The vocabulary keeps expanding. Each record adds new words to the language he is building. Each live show adds new dimensions to the language the records captured. Following Yussef Dayes is the experience of watching a musical language develop in real time, which is one of the most exciting things available to a listener. I intend to keep following for as long as the language keeps developing. Which I suspect is a very long time.

[download:/assets/images/artists/yussef-dayes-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yussef-dayes-2023")
PYEOF


# ---- POST 10: yves-tumor-heaven-2022 ----
echo "--- Updating: yves-tumor-heaven-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/yves-tumor-heaven-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/0qu422H5MOoQxGjd4IzHbS]

## The Specific Sensation

There is a physical experience I associate with Heaven to a Tortured Mind, not a metaphor but an actual sensation, something in the chest and solar plexus, a feeling of rapid descent followed by an involuntary catch. Like a dream-fall. Like the moment before you step off a curb you did not see. Yves Tumor makes music that operates on the body before it operates on the mind, and this album is the most extreme version of that so far.

Yves Tumor, an American artist based in Europe whose gender presentation and personal information are deliberately ambiguous and always evolving, has been making music that resists categorization since at least 2016. The journey from the noise-textured early work through *Safe in the Hands of Love* and then to *Heaven to a Tortured Mind* describes an arc toward something that sounds almost like rock music but has been through so many other things on the way that it emerges transformed.

*Heaven to a Tortured Mind* came out in April 2020 on Warp Records to widespread critical acclaim, earning a Metacritic score of 88 and landing on numerous year-end lists as one of the defining records of that year. I was still inside it in 2022, still finding corners I had not fully explored. That is the kind of record it is. It uses the grammar of 1970s glam and soul, the guitar tones, the call-and-response, the kind of dramatic orchestration that sounds like curtains being drawn, but the context is entirely different, the emotional content more complicated, the sonic palette saturated to the point of distortion.

## What Excess Reveals

This is an album that understands excess as a tool. The production is too much in exactly the right ways, too compressed, too dramatic, too willing to push guitar tones into feedback and let them stay there. It has been said that this is Yves Tumor's rock record, but that framing undersells how alien it sounds. It is rock the way a memory of rock filtered through forty years of subsequent music sounds.

"Kerosene!" is the track I keep reaching for as evidence. Three and a half minutes of something that should sound dated, the guitar tones, the screaming, the gospel-adjacent choir, and instead it sounds urgent and present and slightly dangerous. The danger is not threat exactly. It is more the danger of something genuinely feeling, genuinely reaching for something, genuinely unprotected by irony or aesthetic distance.

Yves Tumor's voice on this record is extraordinary. It moves between falsetto and chest voice with a fluidity that makes the transitions feel less like technique and more like emotional necessity, as if the voice is finding the register that the feeling requires rather than the other way around. There are moments where it breaks, where you can hear the effort and the strain, and those moments are the most alive things on the album.

The lead single "Gospel for a New Century," released to announce the album in February 2020, set the terms for what would follow. The title is both accurate and ironic. The gospel element is real, a tradition of transcendence and community summoned from below the surface of the noise. The "new century" framing acknowledges that the tradition is being brought forward through a great deal of intervening history. The two things together produce something that is neither pure gospel nor pure glam nor pure noise, but something that borrows the structural force of all three.

## The Question of the Body

Much of the writing about Yves Tumor focuses on identity, on queerness, on the way the music moves between genres and gender presentations, on what it means to build an artistic persona that refuses fixed legibility. That is all interesting and relevant. But I find myself most arrested by the physical qualities of this music, by the way it registers in the body before anything else.

This might be what glam was always doing and what the contemporary moment allows us to hear more clearly: the music as body, the music as sensation, the music as something that bypasses signification and goes straight to feeling. Not feeling as sentiment but feeling as physical event.

The cover art of *Heaven to a Tortured Mind*, featuring Yves Tumor in a red dress with another figure, is doing similar work. It is not documentation. It is performance, costume, construction. The record is the sonic version of that construction: something built with great care to produce a specific kind of experience in whoever encounters it.

Falling and catching yourself. That sensation. Something about releasing the tension that holds you upright and then the involuntary response, the catch, the recovery, the moment of relief and adrenaline combined. This record gives me that, every time. I come back to it at specific times, not when I need music exactly, but when I need something to happen that the usual music cannot make happen. The physical response it produces is reliable in a way that feels almost like a bodily function. I have stopped trying to understand why and just accepted that this is one of the things the record does.

Falling and catching yourself. That sensation. This record gives it to me every time.

[download:/assets/images/artists/yves-tumor-heaven-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: yves-tumor-heaven-2022")
PYEOF


# ---- POST 11: zanele-muholi-2022 ----
echo "--- Updating: zanele-muholi-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/zanele-muholi-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:-c02DXHz5bY]
## What Visibility Costs

Zanele Muholi calls themselves a visual activist rather than a photographer. The distinction matters. A photographer documents; a visual activist intervenes. The act of insisting on the visible presence of Black LGBTQ+ lives in South Africa, in images, in archives, in the history of representation, is an act that carries risk and requires commitment beyond the aesthetic.

Muholi's *Somnyama Ngonyama* series, meaning "Hail the Dark Lioness" in Zulu, is where this visual activism takes its most confrontational form. These self-portraits, made in locations around the world over many years, feature Muholi with dramatically darkened skin, a manipulation of exposure and post-processing that intensifies the blackness of the skin to a degree that makes the viewer conscious of seeing Blackness, of the politics of what is seen and how.

This confrontational hypervisibility is itself a response to a history of invisibility, of erasure, of the literal absence of certain kinds of bodies and certain kinds of lives from the archive. To be made very visible, aggressively, undeniably visible, is to counter that erasure. In 2022, the exhibition "Being Muholi: Portraits as Resistance" at the Isabella Stewart Gardner Museum in Boston brought more than 50 works together, pairing the iconic black and white self-portraits with recent paintings and a sculptural bronze, the first museum exhibition to make that specific combination visible.

## The Portrait as Act

The individual portraits in *Somnyama Ngonyama* are among the more powerful things in contemporary photography. They use props and found materials, often sourced from the locations where they are made, to construct images that are simultaneously costume, commentary, and transformation. Muholi appears as warrior, as domestic worker, as archetype, as specific self, in images that refuse any single interpretive frame.

The scale at which these images are printed and exhibited matters. At life size or larger, the gaze of the subject meets the viewer's gaze directly, at eye level. You cannot look down at these images. You cannot maintain the power differential that smaller prints sometimes allow. The eyes in these portraits hold. They do not ask for sympathy or understanding. They simply exist, fully, with a presence that is its own argument.

Muholi's statement about the series is precise: "To me, *Somnyama Ngonyama* is one way of reckoning with this past, to address its politics of race, racism and colonialism, and it is also a way of addressing a past that still informs the present." The past that informs the present is not a metaphor. It is the specific legislative history of South Africa, the specific institutional history of how Black and LGBTQ+ bodies have been treated by systems of power, and the specific ongoing reality of violence against the communities Muholi documents.

Muholi's earlier documentary work, photographing the LGBTQ+ community in South Africa over more than fifteen years, provides the archive of community from which the more formally ambitious self-portrait series grows. The two bodies of work are in dialogue: the community and the self, the documentary and the constructed, the plural and the singular. Neither is complete without the other.

## The World the Work Is Made In

South Africa has some of the highest rates of violent hate crimes against LGBTQ+ people in the world. "Corrective rape" is a documented phenomenon. The legal protections that exist on paper do not translate to safety in daily life for many of the people Muholi has been documenting.

The work is made in this context. It exists in response to this context. The beauty of the images, and they are beautiful, is not an aestheticization of suffering but a refusal to accept that suffering is the only story. The insistence on beauty, on dignity, on full visual presence, in the face of a world that has worked to deny these things, is itself a form of courage.

The materiality of the props is worth attention. Muholi uses electrical cables, latex gloves, cotton wool, combs, sponges, materials that carry associations with labor, with bodily care, with the infrastructure of daily life. Placed on a Black body in high-contrast black and white photography, these objects shift in meaning, become loaded with the histories of who has performed which kinds of labor and under what conditions. The transformation is achieved with objects that cost nothing. The power of the images does not depend on expensive materials or elaborate production. It depends on intelligence and intention.

## The Archive as Resistance

The archive of community that Muholi has built is invaluable independent of its artistic quality, though the artistic quality is real and high. To have this documentation, these images of lives that have been systematically threatened and erased, is itself a form of resistance, a refusal of the invisibility that violence seeks to impose.

The photographs will outlast the hostility that made them necessary. They are already outlasting particular moments of that hostility. They are in collections, in institutions, in the permanent record of what was seen and documented and cared for enough to preserve. The visibility is the act. The preservation is the argument.

I am not sure "art" is the right word for work this embedded in necessity. But "art" is the frame that allows it to travel, to be seen, to make its argument in places it might not otherwise reach. Wherever it lands, the argument holds.

[download:/assets/images/artists/zanele-muholi-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: zanele-muholi-2022")
PYEOF

echo "=== All 11 posts updated ==="
