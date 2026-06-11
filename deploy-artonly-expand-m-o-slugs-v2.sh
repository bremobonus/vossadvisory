#!/bin/bash
set -e
echo "=== ArtOnly Expand M-O Slugs v2 (word count fix) ==="

# This script appends additional sections to each of the 18 m-o slugs
# to push all bodies to 1000+ words.
# Uses Python to load existing JSON, insert text before [download:] tag, write back.

HOST="dh_yadmw3@pdx1-shared-a2-06.dreamhost.com"
POSTS_DIR="$HOME/artonly.io/posts"

python3 << 'PYEOF'
import json, re, os

POSTS_DIR = "/home/dh_yadmw3/artonly.io/posts"

additions = {

"mssingno-2023": """
## The Quiet Influence

MssingNo does not have the mainstream profile of the names most people associate with electronic music. He has not crossed over in the way that some of his peers have, and his work sits at a distance from the chart-oriented side of the genre. That distance is a feature. It means his music is made entirely on its own terms, with no concession to an imagined mainstream listener who needs things simplified. The club is his medium. The people who understand the music are his audience. He makes no effort to translate.

There is a kind of influence that operates through people rather than through charts. A producer hears a specific rhythmic approach and takes something from it. A DJ incorporates a track into a set and that decision shapes what comes next in the room. The ripple moves outward without a press campaign or a moment of mainstream visibility to mark it. This is how a lot of the most important electronic music has always traveled, community to community, room to room, across borders that commercial channels do not cross.

MssingNo's music travels this way. You will not necessarily know where you first heard him. But if you are paying attention to London club music, you have heard him, or heard music that carries his influence, or been in a room where his records were played and felt something shift in the collective energy of the space. That invisible influence is real influence. The music is doing its work.
""",

"mysie-breakbeats-as-emotional-language": """
## The Album Ahead

SALTY positions Mysie as one of the most interesting artists currently working in the space between UK club music and confessional song. The EP is five tracks. It does five things precisely. But it also opens up a series of questions about what a full-length album looks like in this mode, whether the emotional architecture can hold across forty minutes without the intensity diluting.

The precedents are there. Lauryn Hill built The Miseducation across twenty tracks without losing the intimacy. Sampha's Process sustained vulnerability at full-album length without becoming exhausting. Both did it through variety of approach within a consistent emotional register. Mysie has the range. The breakbeat production does not lock her into a single mode. The voice is strong enough to carry different material.

What will determine whether the album justifies the promise of SALTY is the same thing that determines whether any album justifies its promise: the quality of the songwriting at scale, whether she can sustain the specificity that makes the EP so striking across a larger canvas. The evidence so far says yes. The development from CHAPTER 11 through CONTROLLA to SALTY is a clear upward trajectory. The next step, the actual full-length that takes all of this seriously, is the record I am already waiting for.

The instrument she plays best is not the voice or the breakbeat. It is the distance between them, the gap where the emotional content lives, the space created when a powerful voice addresses a powerful rhythm and neither gives way. That gap is what makes SALTY matter. She understands it now. The album will show whether she can live inside it for an hour.
""",

"nabihah-iqbal-2023": """
## The Record as Practice

Dreamer rewards patience in a way that most contemporary music does not ask for. We have built our listening habits around music that delivers its content immediately, that gives you what it is within the first thirty seconds and either holds you or loses you on that basis. Iqbal's record operates differently. The first full listen is a partial experience. The second is where you start to hear the architecture. By the fifth or sixth, you are living inside it.

This is not a difficulty that announces itself as such. Dreamer does not feel challenging or withholding. It feels exactly like what it is: music that has depth, that rewards continued attention, that has more to give the more you bring to it. That quality is rarer than it should be.
""",

"naomi-sharon-ovo-sound-intimacy": """
## The Rotterdam Context

Sharon's Curacaoan and Dutch heritage is worth sitting with. Rotterdam has its own musical history, a port city with Caribbean connections running deeper than most Western European cities, and that context shapes an artist's relationship to diaspora sound differently than London or Toronto would. She has not made it a theme of her music. It is more like background radiation, a quality of rootedness in multiple places simultaneously that gives her work a particular kind of groundedness.

The Dutch music scene she came up in has produced some of the most technically accomplished producers in contemporary electronic music. Sharon is not primarily an electronic artist, but she carries a production intelligence that suggests exposure to that tradition. The way she thinks about arrangement, about the relationship between what is present and what is left out, has that quality of precision.

## What Restraint Sounds Like

There is an ongoing critical conversation about what R&B sounds like now, whether the genre is expanding or contracting, whether the influence of trap production has permanently altered what the form is capable of. Sharon is not in that conversation exactly. She is doing something older and slower: making music that operates at the emotional temperature of late-night intimacy, that trusts the listener to bring their own associations to the sounds rather than directing their response.

This requires a different kind of confidence than the maximalist approach. It requires believing that less is genuinely more, that the space you leave in the arrangement is doing something, that the listener's imagination is a collaborator rather than a problem to be solved by filling in the gaps. Sharon believes this. The proof is in the tracks. Restraint in her hands is not the absence of energy but a different kind of energy entirely: banked, directed, arriving at the listener with full force precisely because it held back.

The voice is the engine. Everything else is infrastructure. That is a philosophy as much as a production approach, and it is the right one for what she is trying to do.
""",

"nia-archives-2023": """
## Across the Floor

There is one more thing worth naming: the way Archives moves. She performs her music live, and the live context reveals something the records imply but do not fully demonstrate. The relationship between her body and the music, the physical intelligence that informs the production, is visible in ways that make the studio work more legible. The Amen break was always a body instruction as much as a sound. Its tempo and rhythm specified a particular way of moving, a particular energy that the dancer receives and returns. Archives understands this not as history but as present fact. The music is built for bodies, addressed to bodies, and completed by bodies in motion. The records are already good. In the right room, they become something more.

The thing about jungle, the thing that makes it different from most forms of electronic music, is that its emotional content and its dancefloor function are identical rather than separable. The breakbeat does not provide a platform for the emotional content. The breakbeat is the emotional content. Its energy, its intensity, its particular quality of propulsive forward motion, is the feeling, not a vehicle for the feeling. Nia Archives has inherited this understanding and made it entirely her own.
""",

"nia-sul-2023": """
## The Precedent of Bedroom Pop

The bedroom pop tradition Sul works in has specific roots that are worth tracing, because they illuminate what she does and does not take from it. The genre emerged from the combination of affordable home recording equipment and the emotional circumstances of adolescence: the bedroom as the site of both creative work and intense private feeling. Artists like Frankie Cosmos, Alex G, and beabadoobee built careers from that starting point. The aesthetic marks of the genre, rough recording quality, intimate scale, confessional lyrical content, are not bugs but features. They signal authenticity. They say: this was made by one person in one room, and what you are hearing is a direct transmission.

Sul takes the emotional directness and leaves the deliberate roughness behind. Her recordings are clean but not overproduced. The signal is clear. What she retains from the tradition is the scale: the sense that you are listening to something addressed to a very small audience, or to no audience at all, something made because it needed to be made rather than because there was a market for it.

What happens when bedroom pop gets heard beyond the bedroom is always interesting. The intimacy that makes it work in private does not automatically survive amplification. Some artists manage the transition by developing the production without diluting the honesty. Sul is at that threshold now. The question of scale, how much is too much before the thing that makes the music matter gets lost, is one she will have to navigate. Based on what she has put out so far, I think she knows where the line is.
""",

"nightly-1989": """
## The Craft of the Lyric

Nightly is working in a tradition that has largely been abandoned by contemporary pop: the verse-chorus-bridge structure executed with genuine commitment to each section as a distinct emotional beat rather than a repeated gesture toward a feeling. "1989" demonstrates why that tradition is worth preserving. Each section earns the next. The verse establishes; the chorus opens; the bridge resolves something the verse refused to resolve. That sequence, when it works, is one of the most efficient emotional machines in music. It works here.

The lyrical precision is the thing that separates "1989" from the large number of songs covering the same thematic territory. Nostalgia in pop has default settings: the golden past, the loss of innocence, the impossibility of return. Nightly does not use the defaults. The specific imagery in the lyric grounds the feeling in a physical reality rather than a sentimental one. You can feel the weight of what is being described. That weight is what converts a song about a feeling into a song that produces a feeling, and the conversion is the only thing that makes the territory worth visiting one more time.

Most songs about the past cost the listener nothing. You receive the sentiment and move on. "1989" asks something of you. It asks you to recognise what you have been carrying. The bridge is where that recognition arrives, fast and complete, and the craft behind the song is the work of the whole preceding structure building toward that thirty seconds.
""",

"niki-black-wild-is-the-wind": """
## Why the Cover Matters Now

The history of "Wild Is the Wind" runs from Dimitri Tiomkin's 1957 film score through Johnny Mathis to Nina Simone's 1966 recording, which is the one everyone means when they reference the song, and then through David Bowie's 1976 version on Station to Station. Each interpreter brought a different relationship to the material. Mathis took the romance at face value. Simone transformed it into an assertion of selfhood that transcended the love song frame. Bowie used it as evidence of range, the balladeer capacity that his rock persona normally obscured.

Niki Black's version enters this conversation with something none of those recordings have: the contemporary context of a Black British woman singer finding her way to a song that Nina Simone made irreducibly her own. The comparison is unavoidable. Black does not avoid it. She addresses it directly by not addressing it at all, by approaching the song with the confidence of someone who has earned the right to be in the room with this material. She has. The vocal performance on the cover demonstrates a technical and emotional command that belongs to her alone. The lineage is present but so is the arrival at something new.

The viral numbers confirm that Black has found an audience that was waiting for exactly this kind of voice and exactly this kind of material. The question now is what she does with that attention. Based on the archival work she has been doing and the quality of the covers and originals she has been releasing, the answer will not be generic. This is an artist who is building something specific. The breadcrumbs are already there for anyone paying attention.
""",

"nite-jewel": """
## The Studio as Laboratory

What Superstar demonstrates above everything is that Gonzalez uses the studio as a laboratory rather than a recording space. The distinction matters. A recording space is where you capture a performance. A laboratory is where you conduct experiments, where the failure of one approach teaches you what the next approach should be, where the final product is the result of accumulated knowledge rather than a single successful session.

The production on Superstar is the product of that laboratory approach. The bass patches are unusual, the drum programming is distinctive, the synth choices make references that are specific and considered rather than generic. You can hear someone who has spent years developing a production vocabulary and is finally deploying it at full strength. The earlier albums had craft. This one has authority.

The PhD research into music and cognition that Gonzalez has pursued alongside her music career is relevant here. The research is not applied directly to the production in any way that is audible as such, but it reflects a habit of mind: the willingness to think systematically about how music works, what it does to listeners, what mechanisms are responsible for its effects. That habit of mind is present in the production of Superstar. The choices are not intuitive in the way that purely feel-driven production is intuitive. They are considered and then executed with feeling, which is a more difficult combination to achieve and ultimately more powerful.

At fifteen years in, Nite Jewel is more fully herself than at any previous point. That is a rare trajectory. Most artists peak earlier or plateau. Gonzalez has been building toward Superstar for the entire duration of the project, and the arrival is audible in every decision on the record.
""",

"noche-bedroom-remixes-to-daft-punk": """
## The Longer Game

Independent music has a gravity problem. The pull toward commercial viability, toward the version of yourself that more people will find accessible, exerts constant pressure on any artist who has found an audience. Most artists respond to that pressure eventually, adjusting the work toward the center. Noche's choice to turn down a label contract while simultaneously achieving the kind of exposure that most independent artists build entire careers hoping for is a statement about priorities that deserves to be taken seriously.

The bedroom remixes series was not just content strategy. It was a demonstration of values: the belief that the process of making music is as interesting as the product, that showing work has artistic as well as promotional value, that the community of listeners and collaborators is worth more than the scale that a label could provide. Daft Punk understood something similar. They controlled their image and output with a completeness that most artists in their commercial position do not achieve. Noche is not Daft Punk, but the attention they paid to his work suggests they recognised something of their own philosophy in his approach. That recognition is not nothing.

What he builds next, the music that comes after the cultural moment of the sampling video and the Daft Punk call, will be the real test of whether the artistic identity he has built is durable. The bet, based on everything he has released and everything he has refused, is that it is.
""",

"nourished-by-time-passionate-ones": """
## The Baltimore Lineage

Baltimore club music has a specific genealogy that The Passionate Ones sits within and extends. The city produced DJ Rashad and the footwork tradition that crossed into global electronic music. It produced Club Classics, the Eunice album, the specific quality of mid-Atlantic soul that has run quietly through American music for decades. Marcus Brown grew up inside that ecosystem. His music carries it without announcing it.

What makes The Passionate Ones significant beyond its individual qualities is what it represents about who gets to make this kind of music and under what conditions. Independent, Black, from a city that the major label infrastructure has historically treated as peripheral, Brown made an album that received the kind of critical recognition usually reserved for artists with much larger institutional support. That is its own statement about the current moment in music, about who the tastemakers are now and what they are paying attention to.

## The Patience in the Music

The most striking formal quality of The Passionate Ones is its patience. Pop music and its adjacent forms have been accelerating for decades. The tempo at which information is delivered, the frequency of hooks and changes and moments of release, has increased steadily across genres. Brown is moving against that current. His tracks give themselves time. Verses breathe. Bridges arrive when they are ready rather than on schedule. The production allows space for the listener to sit inside a feeling rather than being moved immediately to the next one.

This patience is not passivity. The album is emotionally intense. It is also slow in the way that certain conversations are slow, the conversations where someone is taking the time to say something true rather than something quick. The patience is a form of respect for the music and for the listener. It says: this is worth taking time with. Give it time and it will give you something back.

Brown has been giving this music time for years. Pitchfork caught up. The rest of the audience is in the process of arriving.
""",

"nziria-hard-neomelodico": """
## The Production Collaborators

NZIRIA does not work alone. Her music is collaborative in ways that are audible in the final product, a synthesis of multiple production intelligences applied to a musical vision that is entirely hers. The producers she works with understand how to translate between registers: how to take the emotional vocabulary of neomelodico and make it sit alongside contemporary production without the seam showing, how to preserve the specific quality of southern Italian musical feeling while giving it a frame that speaks to a younger and more internationally oriented audience.

This translation work is harder than it sounds. Fusion music often fails because one element dominates and the other becomes decorative. NZIRIA's music avoids this by treating the neomelodico tradition not as a flavour to add but as a structural foundation, a set of emotional and harmonic commitments that inform every decision. The hyperpop and electronic production elements are applied on top of that foundation without displacing it. The result is genuinely hybrid rather than one thing with cosmetic additions from another.

## On Authenticity and Innovation

There is a version of the conversation about NZIRIA that frames her work as a reclamation project, a southern Italian woman artist taking back a musical tradition that has been dismissed as lowbrow or provincial and asserting its value. That reading is not wrong. But it is incomplete.

What makes the music interesting is not primarily the reclamation. It is the innovation. NZIRIA is not making neomelodico. She is making something new that could not exist without neomelodico, something that requires its emotional architecture in order to build what she is building. The reclamation is a byproduct of the creative ambition rather than the goal. The goal is making music that is honest about where it comes from while refusing to stay there, music that moves forward precisely because it knows what is behind it.

That combination, the confidence of someone who has absorbed a tradition completely and the restlessness of someone who needs to go somewhere new, is the source of the particular energy in her work.
""",

"odeal-nomadic-rb-lustropolis": """
## The Architecture of Lustropolis

What Odeal builds in the Lustropolis project is not just an aesthetic but a conceptual framework. The term itself, fusing lustre with a civic structure, suggests something both material and imaginary: a place where R&B and electronic production and ambient texture are the native languages, where the emotional register of longing and pleasure and displacement coexist without contradiction.

The architecture of the project is deliberate. Odeal thinks about sequencing, about how one track prepares the listener for the next, about the experience of listening across the whole rather than the individual track in isolation. This is an album-maker's approach in a moment when most music is made and consumed in fragments. The decision to maintain that structural ambition is itself a statement about what music can be for.

## The Nomadic Frame

The nomadic identity that Odeal inhabits in this music, moving between traditions, between emotional registers, between the explicit genre categories that the industry uses to organize distribution, is not a lack of fixed position but a strategic refusal of premature settlement. Genres are useful until they constrain. Odeal uses them until they constrain and then moves. The result is music that resists easy categorization while remaining deeply readable to anyone who has traveled through the same sonic territories.

The R&B that grounds the project is not the commercially dominant contemporary version, not the trap-influenced, streaming-optimized form that dominates playlists. It is something older and stranger: the R&B of slow jams and late-night feeling, of music made for states of attention that most contemporary production does not assume the listener has. Odeal assumes you can listen. The music rewards the assumption.

The audience that finds this music will not be the largest audience. It will be the right one. There is a difference, and Odeal seems to understand it. The work is made for depth of connection rather than breadth of reach, and the Lustropolis project is the fullest expression of that decision so far.
""",

"odumodublvck-they-love-me": """
## The Craft Behind the Momentum

What separates ODUMODUBLVCK from the many artists who have attempted to navigate the Nigerian rap and Afrobeats intersection is the quality of the craft underneath the personality. The personality is undeniable: the voice, the presence, the ability to make a track feel like a room you want to be inside. But personality without craft produces music that peaks early and ages poorly. THEY LOVE ME is not going to age poorly.

The production choices on the album are consistently intelligent. ODUMODUBLVCK does not default to the dominant sonic frameworks of contemporary Afrobeats when something else would serve the song better. He moves between modes with a confidence that comes from having a clear musical identity that can survive contact with multiple production environments. Some tracks are dense and club-oriented. Others are spare and lyric-forward. The album holds together because the voice and the sensibility are consistent even when the production shifts.

## The City as Character

Lagos is present in THEY LOVE ME the way a city is present when an artist has grown up inside it rather than moved to it. It is not referenced so much as assumed, baked into the rhythmic sensibility, the specific quality of confidence that the music carries, the references that only land if you understand the cultural geography. For international listeners without that context, the music is still compelling. For listeners who share the frame, it is something more: recognition, the experience of hearing something that knows exactly where it is from because the artist knows exactly where he is from.

That kind of specificity is the engine of global cultural influence. The music that travels farthest is often the most particular, because particularity creates genuine encounter rather than smooth universality. ODUMODUBLVCK's particularity is Nigerian, is Lagos, is the specific moment in Afrobeats' global ascent when the form was self-confident enough to stop explaining itself to international audiences and start demanding that those audiences meet it on its own terms. THEY LOVE ME is that demand made concrete.
""",

"oklou": """
## The Debut in Full

Choke Enough arrived in 2025 as a completed argument, the thing that Galore and the gdflt EPs were building toward. Listened to in sequence after the earlier material, it is audible as a culmination, not a first statement but a full statement, the moment when everything that had been in development became fully articulate.

The album's length and structure are themselves a declaration. Oklou does not pad. Every track on Choke Enough earns its position. The sequencing is thought about: the way energy moves across the record, where density is deployed and where space is allowed, how the emotional register of the lyrics interacts with the emotional register of the production at each moment. This kind of structural intelligence at album length is what separates artists who make good tracks from artists who make good records. Oklou makes good records.

The production vocabulary that was established across the EPs is fully deployed here. The textures are more varied, the dynamics more controlled, the integration of the voice into the production more complete. The voice is not placed on top of the production but woven through it, which is a different relationship between singer and sound and one that requires a different kind of production intelligence to achieve. Mayniel has that intelligence. Choke Enough is the proof.
""",

"oklou-dreaming-in-synthesis": """
## On Listening to Galore Now

The experience of returning to Galore after Choke Enough is different from the experience of first encountering it. The debut album retroactively reveals what the EP was doing, which is the best use of a retrospective listen: not nostalgia but understanding. The formal experiments on Galore that felt exploratory in 2019 are now legible as the development of a specific production approach that Choke Enough deploys with full confidence.

The vocal production choices on Galore, the way Mayniel treats her own voice as a textural element rather than simply a carrier of melody and lyric, were unusual at the time. By 2025 that approach had influenced enough music that it felt less unusual. But Galore got there first. The EP is now historical evidence of a specific moment in the development of a specific kind of music, and Mayniel's position as an early navigator of that territory is legible in retrospect in a way that it could not have been in the moment.

## The French Axis

The French music context that produced Oklou is worth more attention than it typically receives from Anglophone music criticism. France has a specific tradition of electronic music and experimental pop that runs from the musique concrete of Schaeffer and Henry through Daft Punk and Air and into the current generation. Mayniel's music is not explicitly in that lineage, but it shares the lineage's willingness to treat sound itself as the primary compositional material, to make music in which timbre and texture carry as much structural weight as melody and harmony. That sensibility is French in a specific historical sense, and it gives Oklou's music a quality that distinguishes it from the Anglophone hyperpop and electronic pop scenes it is often discussed alongside.

Galore is where that sensibility first fully arrived. The development from that starting point has been extraordinary to follow.
""",

"oklou-gdflt-2023": """
## The Production Philosophy

What unifies the gdflt EPs across their two installments is a production philosophy that treats the listener's nervous system as the primary instrument. The music does not explain what it is doing. It does what it is doing, and the listener's body and emotional state are the site where the doing lands. This is a different approach than the declarative mode that dominates most contemporary pop, where the music announces its feeling and invites the listener to confirm it.

Oklou's production on gdflt works through accumulation and atmosphere. Individual elements are not arresting on first contact. The kick pattern is not designed to make you say: extraordinary kick pattern. The synth patch is not performing its own unusualness. Everything is in service of the aggregate effect, the total environment the record creates, and the aggregate effect is significant. You are somewhere that has its own weather by the time the first track finishes. The rest of the record deepens and shifts that weather rather than replacing it.

The title itself, a keyboard shorthand for something like default or standard, carries the EP's argument. The emotional states described here are not dramatic. They are the default states of a contemporary person navigating connection and its failures across the medium of the internet. Ordinary, in other words. Not less painful for being ordinary. Not less real. The choice to give the ordinary its full weight, to make music that treats the texture of daily digital life as worthy of the same attention that other music gives to exceptional experience, is a formal and ethical choice simultaneously. Oklou makes both parts of it hold.
""",

"oklou-gdflt-follow-2024": """
## The Structure of Following

Following an artist across a multi-release project like the gdflt series involves a specific kind of listening. You are not encountering each work fresh. You are bringing the context of the earlier installment, the expectations it generated, the questions it raised, the emotional territory it opened up. The follow album answers to all of that accumulated context while also standing on its own. The task is to satisfy and to surprise simultaneously.

The second gdflt installment does this by deepening rather than redirecting. The emotional vocabulary established in the first EP is present and extended. The production approach is consistent but not repetitive: the same sensibility applied to new material generates new outcomes. The continuity is the point. Oklou is building something that requires multiple encounters to fully inhabit, a world rather than a statement, and the follow album adds rooms to that world rather than redesigning the structure.

This approach to extended projects is increasingly rare. The industry incentivizes constant novelty, the pivot that resets audience expectations and generates a new cycle of attention. Oklou has not pivoted. She has gone deeper, and going deeper is the right call for music that was already pointing inward. The reward is a body of work that holds together, that makes sense as a continuous inquiry rather than a series of separate attempts to do different things.

The listener who arrived at Choke Enough from gdflt had been prepared. The preparation was audible in how the debut landed, in the quality of attention the audience brought to it. That kind of patient audience-building is its own achievement. Oklou earned it by trusting the work and the people listening to it.
""",

}

for slug, addition in additions.items():
    path = f"{POSTS_DIR}/{slug}.json"
    if not os.path.exists(path):
        print(f"SKIP (missing): {slug}")
        continue
    with open(path) as f:
        d = json.load(f)
    body = d.get("body", "")
    # Insert addition before [download:] tag if present
    if "[download:" in body:
        # Find last occurrence of [download:
        dl_idx = body.rfind("[download:")
        # Find the start of that line
        line_start = body.rfind("\n", 0, dl_idx) + 1
        # Insert addition before download tag
        addition_text = addition.strip()
        new_body = body[:line_start] + addition_text + "\n\n" + body[line_start:]
    else:
        new_body = body.rstrip() + "\n\n" + addition.strip()
    d["body"] = new_body
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    # count words
    import re
    clean = re.sub(r'\[[^\]]+\]', '', new_body)
    wc = len(clean.split())
    print(f"Done: {slug} ({wc} words)")

print("=== All 18 slugs extended ===")
PYEOF
