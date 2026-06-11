#!/bin/bash
# ArtOnly Blog Expand Script
# Generated: 2026-06-11
# Task: Expand 3 remaining posts to 1000-1400 words
# Posts: ovrkast-jazz-rap-iron, pimmie-dont-come-home, refik-anadol-ai-visual-architect

set -e
echo "=== ArtOnly Blog Expand: Final 3 Posts ==="

python3 << 'PYEOF'
import json, re, os

POSTS_DIR = "/home/dh_yadmw3/artonly.io/posts"

posts = {

"ovrkast-jazz-rap-iron": {
    "addition_before_download": """## The Oakland Geography

Oakland sits across the bay from San Francisco and has spent decades watching wealth accumulate on the other side of the water while the conditions that produced its music, the density, the pressure, the specific community formations of West Coast Black life, get rearranged by displacement. Ovrkast. makes music inside that context. The weight of the city is not metaphor in his work. It is information. The way he writes about navigating situations, about loyalty and its costs, about what it takes to hold a position, draws on a specific knowledge of specific streets. You cannot make this music from somewhere else.

The jazz influence in While The Iron Is Hot is not decorative in the way it sometimes is in the genre. When producers working in jazz rap reach for saxophone samples or double-time piano runs, the effect is often of sophistication signalling, a way of saying this music takes itself seriously. Ovrkast. and his production collaborators use jazz structures differently. The rhythmic looseness is functional. It creates space for the verses to breathe, for meaning to accumulate across a bar rather than landing front-loaded. The patience required to listen to jazz, the willingness to follow an idea as it develops rather than waiting for the hook, is the patience required to hear what he is actually saying.

## The Craft of the Verse

Ovrkast. writes long. His verses do not compress ideas into punchlines. They develop them. A concept introduced in the first quatrain is still being turned over in the third, arriving at a conclusion that the opening could not have predicted. This is difficult to sustain and most rappers working today do not attempt it. The streaming environment rewards hooks and brevity. Ovrkast. ignores that pressure. The verses on While The Iron Is Hot run until they are finished, not until they have hit a format target.

The internal rhyme schemes are worth paying attention to on a close listen. The end rhymes are often conventional. The interesting work is in the middle of the line, where syllables are doing double duty, sounding against each other while also carrying semantic weight. This density of construction means the verses reward transcription. When you write them out, you see the architecture. When you hear them in real time, you feel it without needing to name it.

The subject matter is consistent across the album without being repetitive. He keeps returning to the question of what it costs to remain yourself under pressure, what you trade away and what you refuse to trade, how you account for those decisions over time. The jazz structure is appropriate for that subject matter. Jazz is also music about navigating constraints with integrity, about individual voice inside collective form, about what you choose to hold and what you let go.

## Why the Timing Matters

While The Iron Is Hot arrived at a specific moment in rap: after the trap era had reshaped what the genre's baseline production sound could be, and as a generation of listeners raised on that production were starting to look for something more sonically and lyrically substantial. Ovrkast. is not reacting against trap. He is simply making different music, rooted in different sources, for listeners who want something that sits differently in the body and the brain.

The 300,000 Spotify followers represent a genuine audience. They are people who sought this out, who passed it along, who told other people what they were hearing. That kind of audience formation is slower and more durable than algorithmic placement. It builds through trust rather than exposure. The listeners who find Ovrkast. tend to stay.

The career trajectory ahead is interesting precisely because he has not compromised to grow faster. The music is what it is. The audience that matches it will find it. The question of what happens when a substantially larger audience does find it, whether the music changes in response to that scale, is one worth watching. Based on the evidence of the album, the answer is probably no. This is music made from a position too specific to be adjusted for a broader market. That specificity is exactly its value."""
},

"pimmie-dont-come-home": {
    "addition_before_download": """## What the Production Actually Does

The technical decisions on Don't Come Home are worth sitting with. Pimmie studied her craft before she was visible, and the learning shows in choices that most listeners will feel without being able to name. The low end on the album is unusually warm for contemporary R&B production, which tends toward the sparse and the clean. Her bass frequencies are present and round, sitting under the vocal without competing with it, creating a physical sensation rather than just a sonic one. You feel the bottom of the record in your chest. That is a deliberate engineering choice.

The vocal treatment is equally specific. She does not use excessive compression to smooth the performance into perfect consistency. You can hear the room in her voice, the breath before phrases, the slight variations in volume that mark a performance made in real time rather than assembled from the most technically correct takes. This creates intimacy. The imperfections are kept because they are honest, and honesty is what the album is built on.

The reverb is restrained throughout. In late-night R&B, the temptation to drown the vocal in space is constant. Space can substitute for feeling, can make a mediocre performance sound cinematic. Pimmie does not need that substitution. The dry, present quality of her voice on tracks like "Bet" and "Foul" makes the emotional content land harder than it would if it were cushioned by reverb. You are in the room with her. There is nowhere to hide.

## The OVO Sound Context

Don't Come Home is an OVO Sound release, which means it exists inside a specific label aesthetic and commercial infrastructure. OVO has developed a recognisable sonic profile across its catalogue: the muted palette, the melancholy undertone, the use of space as emotional register. Pimmie fits inside that profile while doing something distinct from the male artists the label is primarily associated with.

The female voice has been present but not central at OVO. Jorja Smith was the clearest precedent. Pimmie is a different case: where Smith's voice is expressive and technically spectacular, Pimmie's strength is precision and control. She does not attempt to overwhelm the listener. She positions a feeling exactly and then trusts it to land. That restraint is an artistic choice and not a limitation.

The commercial logic of the label placement is straightforward: the "PIMMIE'S DILEMMA" feature established a connection to the OVO audience before the signing. The audience was already primed. Don't Come Home is the argument that the connection was not incidental, that there is a sustained body of work here rather than a feature and a follow-up EP.

The argument is made. Ten songs. No features. The sustained body of work exists.

## The No-Features Decision

Ten songs with no features is a statement in 2026. The standard logic of debut albums includes collaborative moments: a rapper on a track, a well-known producer credit, a feature from a labelmate. These things expand the audience and signal industry relationships. Pimmie declined all of it.

The decision forces the listener to reckon with her alone. There is no familiar voice to provide a handhold, no recognisable name to use as a reference point. What you have is the songs and the production and the vocal, and whether or not that is enough is the only question the album asks.

It is enough. The solo format also clarifies something that features would have obscured: the consistency of the vision. Every track on Don't Come Home sounds like it was made by the same person working from the same set of values. The compression levels, the reverb choices, the vocal approach, the emotional register, the harmonic language, all of it is consistent in a way that reveals a complete artistic identity rather than an artist still figuring out who she is.

Houston has produced musicians with that kind of self-sufficiency before: people who understand the full production chain from songwriting to mastering, who do not need intermediaries to translate their vision into sound. Pimmie is working in that tradition, and Don't Come Home is the most complete expression of it she has produced so far.

## What Comes Next

The question after Don't Come Home is what Pimmie does with the scale the album gives her. The OVO audience is large, and critical reception has been strong enough to establish her as a serious artist rather than a promising one. The debut has done its job. The second album is where you find out what an artist does when they are no longer building credibility, when the question is no longer whether they can sustain attention but what they actually want to say with it. The songs she has been making in Houston, in her own setup, on her own timeline, will answer that question. The production philosophy will not change. The voice will not change. The ambition of the subject matter is the only variable left."""
},

"refik-anadol-ai-visual-architect": {
    "addition_before_download": """## What the Data Actually Becomes

The most important thing to understand about Anadol's practice is that the data he uses is not decorative material. He does not feed information into a system and then choose which outputs look good. The data is the subject. When he processes decades of archival photographs of a city, the visual output is not a pretty pattern that happens to be made from photographs. It is an argument about what that archive contains, what patterns emerge when memory is processed at scale, what becomes visible when a machine encounters documents that humans have preserved but cannot hold in consciousness simultaneously.

The Unsupervised series at MoMA in 2022 and 2023 made this argument most explicitly. The installation used hundreds of millions of images from MoMA's own archive as source material. The AI encountered that collection and generated continuous visual output from it. What the audience saw was not the archive; it was the archive's latent structure, the visual logic embedded in a century of modern art becoming visible through machine processing. Whether that constitutes meaning or the simulation of meaning is a question Anadol leaves deliberately open. The work does not answer it. The work poses it in visual form.

## The Architecture of Immersion

Anadol's installations are always site-specific in ways that matter to how they function. The scale is not incidental. When he covers the facade of a building with real-time data flows, the building becomes a different kind of object. Its permanence, its mass, its function as civic infrastructure, is placed in relation to the fluidity and impermanence of the data layer. The contrast is the content.

The sound dimension of his practice is equally considered. He works with composers and sound designers to create acoustic environments that correspond to the visual generation rather than merely accompanying it. The relationship between sound and image in his installations is not illustrative. The sounds are not designed to describe what you are seeing. They operate on the same data material through a different channel, creating a total sensory environment where the same information arrives at the viewer's perception through multiple routes simultaneously.

This produces a specific kind of attention. The viewer cannot process the installation by looking at it in the usual way, scanning for what is important, identifying a focal point, understanding the composition. There is no composition in the stable sense. The image is continuous and evolving. The only way to encounter it is to be inside it over time, to let the patterns register, to notice what the system keeps returning to and what it lets go.

## The Critical Conversation

Anadol's work has attracted genuine critical skepticism alongside the enthusiasm. The skeptical position holds that spectacular scale can substitute for depth, that the visual impressiveness of large-format AI generation can be mistaken for intellectual substance, that the collaboration between artist and machine flatters both without fully belonging to either. This skepticism is worth taking seriously.

The response to it is not that the work is beyond criticism but that the work positions itself precisely inside the questions the criticism raises. Anadol does not present the AI as a tool he controls. He presents the AI as a collaborator whose outputs he cannot fully predict or explain. The claim is not mastery of the machine but a relationship with it. What that relationship produces, and whether the production has aesthetic or intellectual value beyond spectacle, is the question the work invites the viewer to answer for themselves.

The installations at LACMA, the work for the Istanbul Modern, the collaborations with Spotify and NASA on public-scale visualisations of streaming data and telescope imagery, all of them demonstrate the same core proposition: that the combination of machine learning and human artistic intention can produce visual experiences that neither could achieve alone. The proposition is not self-evidently true. Anadol keeps testing it.

## The Question of Authorship

Where does Anadol's authorship reside? Not in the generation itself, which is algorithmic. Not in the data, which belongs to the archives and institutions that preserved it. The authorship is in the framing: the choice of data source, the choice of site, the parameters of the system, the decision about what the encounter between machine and archive is for. These decisions are artistic decisions in the full sense. They determine what the audience encounters and what that encounter means.

Contemporary art has spent decades questioning authorship, delegating it, dispersing it, turning the question itself into subject matter. Anadol's practice extends that inquiry into the domain of machine intelligence without resolving it. The author is present in the work. The author is also, in a specific technical sense, not responsible for most of what the work contains. Living inside that contradiction is where the practice lives, and it is a more interesting place to be than either full mastery of the medium or pure surrender to it.

The current moment in AI-generated art is producing a lot of work that uses technical novelty as content. The fact that a machine made it is offered as sufficient reason for interest. Anadol's work does not rely on that logic. It would be interesting even if the technical method were ordinary, because the questions it poses about memory, scale, and the relationship between data and meaning are worth posing. The technology is a means. The inquiry is the point."""
}

}

for slug, config in posts.items():
    path = f"{POSTS_DIR}/{slug}.json"
    if not os.path.exists(path):
        print(f"SKIP (missing file): {slug}")
        continue
    with open(path) as f:
        d = json.load(f)
    body = d.get("body", "")
    addition = config["addition_before_download"].strip()
    # Insert before [download: tag
    if "[download:" in body:
        dl_idx = body.rfind("[download:")
        line_start = body.rfind("\n", 0, dl_idx) + 1
        new_body = body[:line_start] + addition + "\n\n" + body[line_start:]
    else:
        new_body = body.rstrip() + "\n\n" + addition
    d["body"] = new_body
    with open(path, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)
    # Count words
    clean = re.sub(r'\[[^\]]+\]', '', new_body)
    wc = len(clean.split())
    print(f"Done: {slug} ({wc} words)")

print("=== All 3 posts expanded ===")
PYEOF
