#!/bin/bash
# ArtOnly Blog Fix Script - bump all under-1000 posts to 1000-1400 words
# Generated: 2026-06-11
# Slugs batch: rirkrit, sadeyes, sailorr, salamanda, samara-backroads, samara-detour,
#              sampha, sasha-keable, sault, sega-harold, sega-harold-2022, serpentwithfeet, samara-cyn-backroads

set -e
echo "=== ArtOnly Blog Fix: 2026-06-11-slugfix ==="


# ---- rirkrit-tiravanija-cook-2023 ----
echo "--- Updating: rirkrit-tiravanija-cook-2023 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/rirkrit-tiravanija-cook-2023.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    # Append additional section before the download tag
    addition = """
## The Hospitality Paradox

One thing that gets lost in discussions of Tiravanija's work is how straightforwardly generous it is. The critical apparatus that surrounds relational aesthetics can make the practice sound more abstract than it is. At its core, someone cooked food for strangers and invited them to eat it. The gallery was the venue but the act was ancient. The tension between that ancient act and the institutional context that frames it produces something that neither pure criticism nor pure celebration quite captures.

The people who ate the curry in 1992 were not primarily experiencing a theory. They were eating. The food was good or it was not. The room smelled of cooking. Someone handed them a plate. What the institutional context adds to that experience is the question: why is this art? But the experience precedes the question, and the experience is what matters. Tiravanija has always understood that the doing comes first and the thinking about the doing is secondary.

That sequence matters for how we evaluate the practice. If the thought comes first and the food is merely the vehicle for the idea, then we have a piece of concept art that happens to involve eating. If the food comes first and the thought is what arrives in the space it creates, then we have something much harder to categorize and much more interesting: an act of genuine hospitality that turns out, in the doing, to generate the kind of thinking that galleries are supposedly for.

The evidence is for the second interpretation. Tiravanija has never seemed like a person who leads with theory. He leads with the act. The theory follows, not because he invites it but because galleries invite it, because critics need it, because the art world cannot process generosity without converting it into argument. The conversion is useful and not entirely wrong. But it loses something that the smell of the curry in the room did not lose.

"""
    # Insert before download tag if present
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: rirkrit-tiravanija-cook-2023")
PYEOF


# ---- sadeyes-2024 ----
echo "--- Updating: sadeyes-2024 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sadeyes-2024.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## The City and the Sound

Vancouver's relationship with rain is not incidental to its music. The city receives more precipitation than almost any major Canadian city, and the particular quality of that precipitation, a grey persistent drizzle that discourages outdoor life and encourages interiority, creates conditions for a specific kind of introspective music-making. The ceiling of cloud that sits over the city for months at a time creates a different relationship to light and to space than sunnier climates produce.

This is not determinism. Not every Vancouver artist makes music that sounds like a rainy Tuesday at 2am. But there is a cluster of artists from that city who share a sensibility about interiority, about the relationship between sound and enclosure, about music as something that happens inside rather than in the open air, and sadEyes belongs to that cluster. The production choices, the long reverbs, the sense of a large space heard from inside it, are the choices of someone who grew up in a city where the outside is often not where you want to be.

The algorithm that delivered sadEyes to me was doing something that curation was doing before algorithms existed: putting music in proximity with the listener who needs it. What makes the match feel significant is the specificity of the calibration. This is not music that works for everyone at 3am. It is music that works for a specific kind of 3am listener, someone who is awake by choice rather than by accident, someone who has accepted the wakefulness and is trying to do something with it. That listener is not a demographic. It is a state. sadEyes locates it with precision.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sadeyes-2024")
PYEOF


# ---- sailorr-rawness-as-craft ----
echo "--- Updating: sailorr-rawness-as-craft ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sailorr-rawness-as-craft.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## The Question of Influence and Transmission

The Lauryn Hill and Erykah Badu citations in discussions of SAILORR are accurate as far as they go, but they require precision to be useful. What she has absorbed from those artists is not a sonic palette or a vocal style. It is an ethical stance toward the act of making music: the conviction that personal honesty is not a stylistic choice but a structural requirement, that music which does not come from a real place cannot land in a real place, that the audience can tell the difference.

Chief Keef's presence in her stated influences is the most interesting of the four. The Chicago drill tradition that Keef helped define is not obviously compatible with the soul and R&B lineage of Hill and Badu, but what they share, what SAILORR has extracted from both, is an approach to emotional directness that does not soften for the audience. Keef did not make music designed to be liked. He made music that represented where he was and trusted that people would find it or not. SAILORR applies that same indifference to palatability to emotional material that is much more intimate than what Keef was working with, and the result is songs that do not need your approval to be what they are.

The Frank Ocean connection points in a different direction: toward craft and architectural precision operating in service of emotional revelation rather than emotional display. Ocean's best songs feel constructed in the way that a building is constructed, every element load-bearing, nothing decorative, the beauty emerging from the precision rather than being added to it. Several tracks on From Florida's Finest have this quality. The rawness is not against the craft. The rawness is the craft.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sailorr-rawness-as-craft")
PYEOF


# ---- salamanda-dreams-as-reality ----
echo "--- Updating: salamanda-dreams-as-reality ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/salamanda-dreams-as-reality.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## What Ashbalkum Means in Practice

The title's meaning, the moment you realize what you experienced as reality was a dream, points at something important about how the record functions for the listener. The album does not simply create a dreamlike atmosphere in the decorative sense. It creates a phenomenological state in which the distinction between dreaming and waking becomes genuinely unclear. This is harder to achieve than it sounds. Most ambient music that reaches for dreamlike states produces something that sounds like sleep, which is different: sleep music tells the body to rest, while Salamanda's music keeps some part of the mind alert and curious, wondering what the next sound will be and how it will relate to the last one.

The gaming and Ghibli sonic references embedded in the record serve this function precisely. Those sounds activate a very specific kind of memory: the memory of childhood states of absorption in which reality and representation are not clearly distinguished, in which the world of a game or a film is as real as the world outside the screen. Ashbalkum reaches back to that quality of consciousness and holds it, not as nostalgia but as a description of a state that is available to adults if the conditions are right. The conditions have to be created. The record creates them.

The modular synthesis work that underpins the record is worth noting because modular synthesis, as a process, is itself a kind of productive uncertainty. The interconnections between modules produce sounds that surprise even their makers. The instrument plays back with its own logic, its own tendency to do unexpected things with the signals passed through it. That quality of productive surprise is built into the record's DNA and produces the sense that the music is discovering itself as it plays, which is exactly what dreaming feels like.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: salamanda-dreams-as-reality")
PYEOF


# ---- samara-cyn-backroads-2025 ----
echo "--- Updating: samara-cyn-backroads-2025 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/samara-cyn-backroads-2025.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## Los Angeles as a Character

The city in Backroads is not backdrop. It is a participant. Los Angeles as a subject in music tends toward either glamorization or critique, the place as aspiration or the place as trap. Cyn does neither. She describes Los Angeles the way someone describes the city they actually live in, which is to say: with specificity about particular streets and hours and light conditions and social dynamics, without the need to make a unified argument about what the city means.

The Fairfax corridor that appears in the production references, the particular thrift-store guitar sound that speaks of a specific ecosystem of musicians and makers, the light at certain hours that reads differently in the Cyn songs than it would in a more tourist-facing account of the city, all of this adds up to a Los Angeles that is recognizable to people who live there and specific enough to be vivid for people who do not. That is the skill of the observational mode she works in: the specificity is the universality. The more exact the detail, the more it opens outward.

The DIY underground she came up through in Los Angeles is a context worth understanding because it shaped the album's relationship to its own ambition. When you build an audience slowly, through actual performances for actual people in actual rooms, you develop a different sense of what music is for than when you build an audience through streaming metrics and algorithmic placement. The album knows what it is for. It is for the person in the room, present and paying attention. The streaming numbers are a side effect of that clarity, not its source.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: samara-cyn-backroads-2025")
PYEOF


# ---- samara-cyn-detour-as-destination ----
echo "--- Updating: samara-cyn-detour-as-destination ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/samara-cyn-detour-as-destination.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## What Nineteen Minutes Can Hold

DETOUR is brief but it is not slight. The distinction matters because brevity is often confused with incompleteness, and this EP is completely itself in a way that longer projects often are not. Every choice about what to include and what to leave out reflects a clear understanding of what the project is trying to do and what it does not need to do. That kind of editorial clarity requires knowing your own work well enough to resist the temptation to expand it, to add the track that might work, to give listeners more than they need. Samara Cyn resists that temptation. DETOUR is exactly as long as it should be.

The track "Highest" is worth examining separately because it represents the risk at the center of the project. In a set otherwise characterized by confident positioning and sonic swagger, a moment of genuine emotional exposure lands differently. The track is not constructed around vulnerability as a selling point. It does not perform openness for an audience that has come expecting it. It arrives in the middle of a project that has been establishing authority and it quietly changes the terms of what authority means here. You can be authoritative about your own experience. You can be certain and also hurting. "Highest" demonstrates that Samara Cyn understands this, and that understanding is what separates her from the alt-rap field she is often placed adjacent to.

The production intelligence across both BACKROADS and DETOUR reflects a consistent aesthetic: experimental frameworks in service of emotional clarity rather than experimental frameworks as their own justification. This is rarer than it should be. The most interesting production ideas are the ones you notice because of what they do to the song, not the ones you notice because they are interesting. Samara Cyn and her collaborators have understood this from the beginning, and DETOUR is the best demonstration of it so far.

The question of what comes after this, what the full-length looks like, whether the project can sustain its exactness over a longer form, is a real question. DETOUR does not answer it. But it confirms that the question is worth asking, and that whoever answers it will be someone who has earned the right to the longer runway.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: samara-cyn-detour-as-destination")
PYEOF


# ---- sampha-return-2023 ----
echo "--- Updating: sampha-return-2023 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sampha-return-2023.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## What Six Years of Silence Accumulates

The specific six-year gap between Process and Lahai is not just a biographical fact but a structural element of how Lahai is received. You hear the record knowing that it is the product of a long quiet, and that knowledge changes the quality of listening. You are not just hearing what Sampha made. You are hearing what he made after six years of living with grief, with fatherhood, with the weight of a debut that arrived with enormous critical recognition and then seemed to require some form of response. Lahai is not a response in the defensive sense. It is a continuation in the sense that life is a continuation: the same person, measurably changed, doing the same essential thing they were doing before, but differently.

The fatherhood dimension deserves particular attention because it is not a subject that gets handled well in contemporary music. Most music about becoming a parent either sentimentalizes the experience or treats it as background. Lahai treats it as a subject as serious as any other: as a reckoning with mortality, with continuity, with the way a new life forces a confrontation with everything that preceded it. The grandfather whose name the album carries is present not as a memorial but as a presence, a voice in the conversation that the album is having with itself about what it means to be part of a chain that extends backward and forward beyond the individual life.

That temporal extension is what gives Lahai its particular quality of weight without heaviness. The piano, the voice, the strings, all of it is in service of a meditation on duration that is personal and also ancient: on what passes, what persists, what a song can carry that ordinary speech cannot.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sampha-return-2023")
PYEOF


# ---- sasha-keable-act-ii ----
echo "--- Updating: sasha-keable-act-ii ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sasha-keable-act-ii.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## Flight Club and the Margins

The label context is worth understanding because it has shaped what kind of music Sasha Keable has been able to make. Flight Club Records operates at the margins of commercial UK music in a way that is less about obscurity than about independence: independent from the expectation that every release must chase a chart position or a streaming milestone, independent from the A&R pressure that shapes so much of what gets released under major distribution. That independence has costs, primarily in reach, but it has benefits that are audible in the music itself.

ACT II sounds like a record made by someone who was not second-guessing herself in relation to a commercial brief. The arrangements are exactly what the songs needed them to be, not what a radio plugger might have preferred. The sequencing follows an emotional logic rather than a marketing logic. The album has the coherence of something made by a person who understood what it was and made exactly that thing, without the compromises that scale typically demands.

That kind of creative freedom is increasingly rare in UK R&B, a genre where commercial success has created enormous pressure toward a certain kind of sophistication, a polished surface that communicates ambition without risk. Keable takes risk. TAI CHI is a risk. The kind of vulnerability that appears in heal something is a risk. The fact that the risks land, that the record does not collapse under the weight of its own seriousness, is the result of someone who has developed enough craft to support the emotional weight she is asking her music to carry.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sasha-keable-act-ii")
PYEOF


# ---- sault-acts-of-faith-2022 ----
echo "--- Updating: sault-acts-of-faith-2022 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sault-acts-of-faith-2022.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## The Gospel Tradition and Its Secular Uses

Black gospel music in the American tradition has always understood that the emotional technology of collective spiritual experience is transferable. The call and response, the building intensity, the moment when the congregation stops being separate individuals and becomes a single responsive body, these are techniques that work because they are rooted in something real about human collective experience, not because they require theological agreement to function. SAULT knows this. Inflo knows this. Airs uses gospel's emotional technology to produce spiritual experience in listeners who may not share its theology, and this is not appropriation of sacred form for secular purposes but a recognition that the sacred and secular have always been porous in Black musical tradition.

The production on Airs makes no distinction between what is sacred and what is secular in its arrangement choices. A funk bassline and a choral testimonial can share a track without irony or collision because the tradition Inflo is working in has always understood them as expressions of the same human impulse, the impulse toward collective joy and collective meaning. That understanding is what makes SAULT's music feel different from the kind of gospel-influenced pop that borrows aesthetic elements without engaging with their meaning. Airs does not borrow. It belongs.

The question of whether this music is Christian is less interesting than the question of whether it is devotional, and the answer to the second question is clearly yes. You do not have to believe anything to feel the devotion in this music. The devotion is in the production choices, in the arrangements, in the way the voices are used. It is the devotion of people who care very deeply about what they are making and why.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sault-acts-of-faith-2022")
PYEOF


# ---- sega-bodega-harold ----
echo "--- Updating: sega-bodega-harold ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## Harold as a Name and a Problem

The choice of Harold as the album's title and central identity is stranger than it first appears. Harold is a name with specific cultural associations in British English that are not glamorous or avant-garde. It is an old man's name, a name from a different era, a name that carries connotations of ordinariness and slightly beleaguered dignity. That Navarrete chose this name for a project of considerable sonic aggression and formal ambition is either a joke or a very serious choice or both, and the record sustains all three interpretations simultaneously.

If Harold is a person, he is not a person Navarrete has made easy to like or easy to dismiss. The emotional register shifts so rapidly across the album, from tenderness to violence to something that sits between them without being either, that Harold as a character remains permanently elusive. You know him by what he does and feels rather than by what he looks like or wants. That elusiveness is part of the point: Harold is a name for the self that cannot be finally known even by the person who carries it.

The biographical dimension of the album, Navarrete making a record about his own interior life after years of making records about other people's, is present in every track but never foregrounded. Harold is a pseudonym for the self, a way of making the personal discussable by making it third-person. The production techniques, the distortion, the processing, the way voices are treated as materials rather than communications, serve the same function: they put distance between the feeling and the listener that paradoxically makes the feeling more legible. You cannot look directly at certain things. You need the distortion.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sega-bodega-harold")
PYEOF


# ---- sega-bodega-harold-2022 ----
echo "--- Updating: sega-bodega-harold-2022 ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold-2022.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## What NUXXE Built

The collective context matters in ways that extend beyond the individual record. NUXXE, as a loose affiliation of artists and producers including Shygirl, Oklou, Coucou Chloe, and Sega Bodega, developed a shared aesthetic through years of mutual influence and collaboration. The sound they have collectively occupied, club-adjacent, formally experimental, emotionally direct despite the surface abstraction, represents one of the most coherent aesthetic positions to emerge from UK music in the last decade. Harold is Sega Bodega's most personal contribution to that shared project.

The SOPHIE influence that runs through NUXXE's work is acknowledged and important. What SOPHIE demonstrated, most precisely on Oil of Every Pearl's Un-Insides, was that pop music could be formally radical without being emotionally cold, that the most processed and abstracted sounds could carry genuine feeling if the intention behind them was genuine. The NUXXE artists absorbed this lesson, and harold is a demonstration of it: a record that is formally extreme and emotionally specific at the same time.

The Caroline Polachek collaboration, which came after harold and involved Sega Bodega as a producer, demonstrated that his skills are not limited to the underground context. Working with an artist whose pop sensibility is more conventionally accessible than Shygirl's, he helped make Desire, I Want to Turn Into You, one of the more critically celebrated pop records of recent years. That versatility only confirms what harold already showed: this is a producer who understands what a song needs and can provide it, whether the song is industrial noise pop or baroque synth-art-pop. Harold is where his own needs were the brief.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: sega-bodega-harold-2022")
PYEOF


# ---- serpentwithfeet-deacon-gospel ----
echo "--- Updating: serpentwithfeet-deacon-gospel ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/serpentwithfeet-deacon-gospel.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"Current word count: {words}")
if words >= 1000:
    print("SKIP")
else:
    addition = """
## The GRIP Argument and What It Means

The 2023 album GRIP moved further into R&B, with a cleaner production aesthetic and collaborations that emphasized the pop dimensions of the voice. The reception was divided in the way that mainstreaming always divides: some listeners felt the abstraction and challenge had been sanded down, others heard a fully realized version of the sound that Soil and Deacon were working toward.

The more useful frame for GRIP is not whether it is more or less challenging than the earlier work but whether it continues the argument those records were making. And the answer is yes. The love being documented on GRIP did not change registers. The tenderness did not become ironic or apologetic or coded. The gospel-trained voice is still there, doing what it always does, carrying weight that the lyrics themselves are not required to spell out.

What changes across the three records is the production frame. Each album puts Wise's voice in a different acoustic environment, from Soil's near-bare abstractions to Deacon's warm R&B setting to GRIP's more polished pop context. The voice is the constant. The voice is the argument. The different frames are tests of the argument: how does the love it describes sound when the production is sparse? When it is warm? When it is polished? The answer, across all three records, is that the love sounds real regardless. That consistency is the testament to the quality of the voice and the conviction of the vision.

The full arc of Serpentwithfeet's work to date represents one of the more coherent and serious extended arguments in contemporary music about what devotional love sounds like when it is Black, queer, and rooted in a specific tradition of trained vocal practice. That argument does not require you to share his faith, his identity, or his background to receive. It only requires attention. The gospel-trained voice asks for attention the way all trained things ask for it: by demonstrating what training in the service of genuine conviction can produce.

"""
    if '[download:' in body:
        dl_pos = body.rfind('[download:')
        new_body = body[:dl_pos] + addition.strip() + '\n\n' + body[dl_pos:]
    else:
        new_body = body + '\n\n' + addition.strip()

    d["body"] = new_body
    new_clean = re.sub(r'\[[^\]]+\]', '', new_body)
    new_words = len(new_clean.split())
    print(f"New word count: {new_words}")
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    print("Updated: serpentwithfeet-deacon-gospel")
PYEOF


echo "=== All fixes done ==="
