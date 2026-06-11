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

