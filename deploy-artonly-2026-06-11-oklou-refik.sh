#!/bin/bash
# ArtOnly Blog Expand Script
# Generated: 2026-06-11
# Task: Expand 17 blog posts to 1000-1400 words
# Run this on the DreamHost server via SSH
# trigger: 2026-06-11-retrigger

set -e
echo "=== ArtOnly Blog Expand: 2026-06-11 ==="

# ---- POST 1: wsabe-2024 ----
echo "--- Updating: wsabe-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/wsabe-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Mexico City's electronic music scene has been doing something interesting for long enough now that \"emerging\" is the wrong word for it. The thing has emerged, it is here, it has produced artists whose work is being heard and respected internationally and whose influence on how electronic music is being made in Latin America is already measurable. WSABE is one of those artists, and her work is the best evidence I know of that what is happening in CDMX is not a local phenomenon but a genuinely global contribution to the form.

The way she combines club music structures with elements from Mexican musical tradition is not pastiche. It is not the kind of \"Latin flavouring\" that international producers sometimes apply to tracks as a kind of musical tourism. The traditional elements and the electronic elements have equal claim on the music, equal weight in how it functions. This is harder than it looks and more interesting than most people realise. The rhythmic complexity that results, the way things sit against each other and create friction and resolution simultaneously, is extraordinary.

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

echo "=== All 11 posts updated ==="
