#!/bin/bash
# ArtOnly Blog Expand Script - T-slugs batch
# Generated: 2026-06-11
# Task: Expand 15 blog posts to 1000-1400 words
# Run via GitHub Actions (SSH from Actions runner)

set -e
echo "=== ArtOnly Blog Expand: T-slugs 2026-06-11 ==="


# ---- POST 1: tame-impala-deadbeat ----
echo "--- Updating: tame-impala-deadbeat ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tame-impala-deadbeat.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/5INjqkS1o8h1imAzPqGZBb]

Kevin Parker spent the years between The Slow Rush and Deadbeat doing everything except making a Tame Impala album. He produced the majority of Dua Lipa's Radical Optimism. He appeared on Justice's Hyperdrama, co-creating Neverender, which won a Grammy. He joined Dua Lipa onstage at Glastonbury. He wrote with Thundercat. He contributed to the Barbie soundtrack.

And then, in October 2025, he released Deadbeat, and it became immediately clear what all that external work had been building toward.

## The Sound

Deadbeat is Tame Impala's fifth studio album and its most rhythmically adventurous. Parker has described it as house-adjacent, inspired by the rave culture of Western Australia where he grew up. The psychedelic DNA is still present: the swirling textures, the vocals submerged in reverb, the sense that every song exists inside a room with no visible walls. But the pulse underneath is different. It moves faster. It wants to make you dance rather than drift.

Singles Loser and Dracula signaled the shift before the album arrived. Both tracks built on propulsive four-on-the-floor rhythms while maintaining the emotional complexity that has always separated Tame Impala from straightforward dance music. Loser in particular hit differently live, running at a tempo that pushed the Glastonbury crowd into movement in a way that the more ambient passages of The Slow Rush never quite did.

The album operates in a space between psychedelia and club music that very few artists have managed to inhabit convincingly. Parker does not attempt to reconcile the two traditions. He fuses them at a molecular level. The reverb is present not as atmosphere but as rhythm. The synths function not as decoration but as architecture. What sounds like texture on first listen reveals itself, on deeper attention, to be groove.

## The Collaborations

Parker's work with Justice and Dua Lipa in 2024 was not a detour. It was research. The production techniques he absorbed through those collaborations shaped Deadbeat in specific and audible ways. The tighter arrangements on Neverender translated into a willingness to let Tame Impala songs breathe less and pulse more. The more assertive low end he found working on Radical Optimism became a structural principle on Deadbeat rather than a session-specific choice.

Working with other producers at the highest level of the craft taught Parker something about his own instincts. Hearing how other people made decisions about space and density gave him a new vocabulary for Tame Impala's fifth record. The confidence to let a groove run without interrupting it, to trust repetition as a compositional tool rather than a failure of imagination, that confidence came from watching how the best electronic producers in the world approached the same problem.

The result is an album that sounds like the natural evolution of someone who has spent two decades making psychedelic music and has decided, at the peak of his abilities, to see what happens when you add a kick drum and commit to it.

## The Live Show

Deadbeat changed what a Tame Impala concert could be. The 2025 world tour that followed the album's release relocated the band into larger outdoor venues and produced set designs built around the more kinetic material. The four-on-the-floor sections created sustained moments of collective movement in crowds that had previously responded to Tame Impala with the gentle swaying of psychedelic rock audiences. The Coachella 2026 headline performance demonstrated that Parker had become something rarer than a festival headliner: a performer who could shift the energy of a space of that scale deliberately and with precision.

The older catalog, songs like Let It Happen and The Less I Know the Better, sounded different within sets organized around the Deadbeat material. Their rhythmic instincts, always present but previously secondary to the melodic wash, became more audible when placed in proximity to the more dance-oriented new tracks. The sequencing revealed a through-line that had existed in Parker's work from the beginning and had found its fullest expression on the new record.

## The Position

Tame Impala occupies a unique space in contemporary music. Parker is simultaneously one of the most respected producers in the world and one of the most commercially successful psychedelic artists alive. Deadbeat does not resolve that tension. It amplifies it. The album is experimental enough to satisfy the listeners who have followed him since Innerspeaker and accessible enough to fill arenas.

The house-adjacent framing is accurate but incomplete. What Parker made on Deadbeat is music that uses rave culture's formal vocabulary to deliver a fundamentally psychedelic experience. The drums are there to open something, not just to move you. The repetition creates an altered state. The grooves function as a delivery mechanism for the same inner-space exploration that Tame Impala has always been about, just with a different vehicle.

That balance is his gift. Deadbeat is its latest, and possibly greatest, expression.

[download:/assets/images/artists/tame-impala-deadbeat-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tame-impala-deadbeat")
PYEOF


# ---- POST 2: teddy-swims-lose-control ----
echo "--- Updating: teddy-swims-lose-control ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/teddy-swims-lose-control.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/33qOK5uJ8AR2xuQQAhHump]

There are songs that chart. There are songs that go viral. And then there is Lose Control by Teddy Swims, a track that did something neither of those descriptions captures: it simply refused to leave.

Lose Control hit number one on the Billboard Hot 100 in 2024 and then proceeded to set the record for the longest-running top-ten song in Hot 100 history, spending over seventy weeks on the chart. It went Diamond certified. It was nominated for Best New Artist and Best Pop Vocal Album at the 2025 Grammys. And it did all of this without a single gimmick, viral moment, or algorithmic trick.

The song succeeded because of the voice.

## The Voice

Teddy Swims, born Jaten Hodge, possesses one of the most extraordinary vocal instruments in contemporary popular music. His tone is rich and gravelly, capable of moving from a whisper to a roar within a single phrase. He sings with the kind of physical commitment that makes you believe every word is being extracted from somewhere deep and real.

Lose Control is a showcase for that voice, but it is not a showpiece. The production is restrained enough to let the vocal do its work without getting in the way. The melody is simple enough to sing along to and complex enough to reward close listening. The emotional arc of the song, from vulnerability to desperation to release, unfolds naturally rather than being imposed by structural convention.

What separates Lose Control from the crowd of power ballads that circulate through streaming is the specificity of Swims's delivery. He does not perform heartbreak in the generalized way that the genre encourages. He sounds like someone who has lived precisely inside this feeling. The crack in his voice on the bridge is not a calculated technique. It lands like something that could not be helped.

## What the Song Is Actually About

Lose Control is a song about the terror of loving someone more than you can contain. The narrator acknowledges that the relationship is destroying him and cannot stop wanting it anyway. That tension, the simultaneous recognition of damage and desire for more damage, is not a comfortable emotional position to inhabit. Most pop songs resolve this tension by either romanticizing it or treating it as tragedy. Swims does neither. He stays inside the contradiction and lets it be what it is.

This emotional honesty is why the song resonated across demographics that do not usually share chart space. Older listeners who remember the soul tradition heard in Swims a voice trained in that lineage. Younger listeners heard something raw and genuine in a landscape often dominated by production tricks. The voice itself was the bridge.

## The Come-Up

Swims built his audience the old-fashioned way: by being undeniably talented on the internet. His cover videos, spanning genres from R&B to rock to country to hip-hop, demonstrated a versatility that most singers spend careers trying to develop. The covers were not imitations. They were conversations with the original material, Swims bringing his own grain and weight to songs that had already been finished and declared complete by other people.

His debut album I've Tried Everything But Therapy (Part 1) arrived in 2023, followed by Part 2, which received the Grammy nomination. Both records built on the promise of the cover videos while establishing that Swims had original things to say. Lose Control appeared on Part 1 and became the gravitational center around which the rest of the work organized itself in the public ear.

The path from YouTube covers to Diamond certification is not unprecedented, but it is rare, and it requires something that no marketing budget can manufacture: a voice that makes people stop what they are doing and listen.

## The Record

Seventy-plus weeks in the top ten. That number deserves to be repeated because it is genuinely difficult to comprehend. Songs are not supposed to stay that long. Attention is not supposed to sustain that long. The streaming era has accelerated the cultural metabolism to the point where most songs cycle through their moment of visibility in weeks. Lose Control ran for over a year and a half.

The chart longevity was driven by discovery rather than saturation. The song kept finding new listeners who then sent it back up rather than pushing it down with the weight of overexposure. Radio played a role, as did playlist placement, but the primary engine was word of mouth: people sharing the track with specific individuals who they felt needed to hear it. The song functioned as a gift that people gave each other.

Some songs are of their moment. Lose Control is simply a great song, and great songs do not need a moment. They create their own.

[download:/assets/images/artists/teddy-swims-lose-control-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: teddy-swims-lose-control")
PYEOF


# ---- POST 3: tems-love-is-a-kingdom ----
echo "--- Updating: tems-love-is-a-kingdom ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tems-love-is-a-kingdom.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:PhVheAPyX4A]

Tems makes music on her own terms, which is the only way she has ever made it. Love Is a Kingdom, released without announcement on November 21, 2025 through RCA Records and her own Since93 imprint, is a seven track EP recorded in the same London studio where her debut album Born in the Wild took shape. Temilade Openiyi is thirty years old, a Grammy Award winner, and one of the most widely heard Nigerian artists of her generation. Love Is a Kingdom does not try to consolidate that position or expand it into new territory. It makes the case, quietly and with complete assurance, that the position is solid enough to support anything she wants to do next, and that the work itself is more important than what surrounds it. A project this honest and this deliberate belongs to no particular moment and cannot be reduced to one. It simply belongs to her.

## Seven Songs About Love

[img:/assets/images/artists/tems-love-is-a-kingdom-detail.jpg]

The EP moves through love with the patience of someone who has stopped trying to explain it and started simply tracing its different faces across seven carefully constructed tracks. First opens the record with a kind of devotion that is clear and unguarded, setting a tone that the rest of the EP builds on without repeating. I'm Not Sure lets romantic uncertainty spill out in tender waves that feel more honest than resolution would. Big Daddy, released with an official visualizer directed by Jyde Ajala, is the EP's most assertive statement: confident, physical, and built around a groove that stakes its territory without apology. What You Need showcases the strongest vocal performance on the collection, Tems over melancholic production that gives her room to demonstrate what she is technically capable of. Mine brings an explosive energy to the second half of the record before the title track closes with something that sounds like an act of faith: two songs joined together into something larger than either.

The sequencing is not incidental. Each track arrives as a new angle on the same subject rather than a new subject entirely, which gives the EP a coherence that seven-track collections do not always achieve. By the time the title track closes the record, the listener has not been moved through seven separate experiences but through seven facets of a single sustained examination. Love, as Tems presents it here, is not a simple thing but it is a comprehensible one, and the comprehension comes through the accumulation of specific perspectives rather than through any single definitive statement.

## The Producer Who Wrote Her Own EP

[img:/assets/images/artists/tems-love-is-a-kingdom-detail2.jpg]

Love Is a Kingdom is primarily a Tems production. She wrote, composed and produced the majority of the project herself, bringing in trusted collaborators GuiltyBeatz, AOD and LONDON for specific contributions rather than as primary architects of the sound. This is consistent with the direction she has been moving since For Broken Ears, her debut EP from 2020 that established her as a songwriter and producer of real substance before the commercial attention arrived. The EP's sound carries the marks of someone who knows exactly which frequencies she wants and how to get them. The bass sits where she places it. The vocal arrangements reflect choices made by the vocalist herself, not adjustments made in service of a producer's vision. Nothing on Love Is a Kingdom happened without her specific intention.

The production on What You Need is worth particular attention. The melancholic landscape she builds underneath the vocal is sparse enough to give the voice full room and textured enough to support it structurally. The restraint required to leave that space, to resist the temptation to fill it, is a production decision that reflects mature judgment about what the song needs. Most producers would have added more. Tems removed things until the emotional content had nowhere to hide, and then put her voice in the middle of it.

## What the Surprise Release Said

[img:/assets/images/artists/tems-love-is-a-kingdom-detail3.jpg]

Releasing an EP without prior announcement is itself a statement. Love Is a Kingdom arrived with no press campaign, no single rollout, no advance positioning of any kind. It simply appeared. For an artist of Tems's profile, working within a major label infrastructure, that kind of release requires real and sustained insistence. The surprise drop communicated something clear: this was not a commercial project in the conventional sense. It was music released because it was ready, not because a schedule required it. The response was immediate. Streaming numbers confirmed what critics noted within hours of the release: this was a project people wanted to hear, not because it had been marketed into their attention but because the music itself had enough pull to find its own audience and hold it. The lack of a campaign made the quality of the project more visible, not less.

## The Lagos to London Axis

[img:/assets/images/artists/tems-love-is-a-kingdom-detail4.jpg]

Lagos Love, the fifth track on the EP, holds the record's geographic and emotional center. Born in Lagos and now splitting time between Nigeria and the UK, Tems occupies a position in global music that is neither fully local nor fully international in the conventional sense. Her sound draws on Afrobeats structure and Yoruba vocal tradition while operating confidently within the R&B and alternative soul spaces that gave her early international visibility through collaborations with Wizkid and Drake. Love Is a Kingdom does not navigate that complexity. It inhabits it naturally, as if the question of genre and geography had been settled long ago. The EP sounds like it was made by someone who stopped thinking about where the music belongs and focused entirely on what it needs to be.

Lagos Love is the track where this geographic duality becomes most audible and most emotionally loaded. The production carries Afrobeats rhythm in its bones while the lyrical content reaches for something more universal than geography. It does not demand that the listener understand Lagos to understand the song. It demonstrates, through the music itself, that the specificity of a place can be both precise and broadly legible when a songwriter has absorbed it deeply enough to render it on its own terms.

## After the Grammys

[img:/assets/images/artists/tems-love-is-a-kingdom-detail5.jpg]

Tems won her first Grammy Award as a featured artist and her second, in the Best African Music Performance category at the 2025 ceremony, for her own composition Love Me JeJe. Love Is a Kingdom is the work that follows those recognitions without being defined by them. The EP does not reach for the kind of statement a Grammy winning artist is expected to make in order to justify the attention. It is quieter than that, and more certain. It sounds like someone who has been through the cycle of global recognition and found that the work itself is what matters and what sustains. Love Is a Kingdom is seven tracks of music made by an artist who knows who she is, and who is no longer waiting for anyone's permission to say it. That clarity is the whole argument.

[spotify:album/3aI43F5shWPnoW4KMfxM1c]

[download:/assets/images/artists/tems-love-is-a-kingdom-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tems-love-is-a-kingdom")
PYEOF


# ---- POST 4: the-death-of-soundcloud-rap-was-slow-ugly-and-overdue ----
echo "--- Updating: the-death-of-soundcloud-rap-was-slow-ugly-and-overdue ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/the-death-of-soundcloud-rap-was-slow-ugly-and-overdue.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """## An Era Defined by Excess

By 2023, it was clear that the SoundCloud rap era had not so much ended as collapsed under its own weight. The movement that had given us some of the most exciting and chaotic music of the late 2010s had devolved into a cautionary tale about what happens when an entire subculture is strip-mined for content and then abandoned by the industry that profited from it.

The collapse was not sudden. It had been accumulating for years, through a series of deaths that were treated as individual tragedies rather than systemic symptoms, through the legal troubles of artists who had no one around them with the expertise or the incentive to redirect them, through the exhaustion of a listening public that had absorbed the aesthetic and moved on. By 2019 the obituaries were already being written. By 2023 the writing was just archaeology.

## What It Was

At its peak, SoundCloud rap represented a genuine democratization of hip-hop. The platform allowed artists with no industry connections, no studio budgets, and no traditional skills to reach audiences directly. The aesthetic was deliberately lo-fi, the energy was frenetic, and the barriers to entry were nonexistent. For a brief window, this produced genuinely exciting music that challenged every assumption about what rap could sound like.

The early work of Lil Peep, XXXTentacion, and Lil Uzi Vert captured something real about the emotional landscape of a generation raised on the internet. The blurring of genre, the willingness to bring emo and post-punk and metal into rap spaces, was not affectation. It reflected the actual listening habits of a generation that had grown up with Spotify and YouTube rather than radio stations and genre-coded record stores. The music was sometimes ugly, sometimes incoherent, sometimes brilliant. That range was part of what made it interesting.

The production innovations that came out of this period, the pitched-up samples, the blown-out 808s, the deliberate degradation of audio quality as aesthetic choice, genuinely expanded what rap production could do. Producers like Smokeasac and Ronny J were doing things with sound that the mainstream had not yet absorbed. The influence filtered upward over the following years into the mainstream production that followed.

## What It Became

The problems were always visible to anyone willing to look. The scene attracted predatory managers, exploitative label deals, and a culture of substance abuse that the industry treated as aesthetic rather than crisis. Young artists with enormous followings and no support systems were handed large advances and left to navigate fame without infrastructure. The human cost was staggering and well-documented.

Labels that moved quickly to sign SoundCloud acts did so with a specific calculation: capture the value of existing viral audiences at low cost before those artists had the experience to negotiate better terms. The advances that seemed large to teenagers from economically precarious backgrounds were structured to ensure that the label recouped while the artist remained in debt. The management structures around these artists frequently prioritized short-term income extraction over long-term career development.

The deaths of Peep in 2017, XXXTentacion in 2018, and Juice WRLD in 2019 were individual tragedies with individual circumstances. They were also data points in a pattern that the industry had the resources and the responsibility to interrupt and chose not to. The post-mortem discourse around each death generated enormous amounts of content. Almost none of it engaged seriously with the structural conditions that produced the pattern.

## The Aftermath

By 2023, the survivors of the SoundCloud era had largely moved on, matured, or been absorbed into more traditional career paths. The artists who defined the movement's peak had either evolved beyond its aesthetic limitations or been consumed by them. The platform itself had become an afterthought, its cultural relevance transferred to TikTok and other short-form discovery mechanisms.

The aesthetic influence, however, persisted. The blown-out 808s and the emotional directness and the genre collapse that defined SoundCloud rap had become background assumptions in mainstream hip-hop production. The influence was so thoroughly absorbed that it became invisible. Younger listeners hearing contemporary rap that bears the SoundCloud era's fingerprints often do not know where those fingerprints came from.

## Lessons Unlearned

The most dispiriting aspect of the SoundCloud rap retrospective is how few lessons the industry actually absorbed. The same dynamics that defined that era, the discovery of raw young talent, the rapid extraction of commercial value, the abandonment when trends shift, continue to operate with different aesthetics and different platforms. The machine did not break. It just found new fuel.

TikTok has accelerated the same cycle to a speed that makes the SoundCloud era look leisurely by comparison. Artists go from discovery to major label deal to cultural oversaturation in months rather than years. The infrastructure of support that might allow young artists to navigate that acceleration has not materially improved. The industry learned to move faster. It did not learn to be more responsible.

SoundCloud rap deserved better than it got, and the people who profited most from it have the least to say about what went wrong.

[download:/assets/images/artists/the-death-of-soundcloud-rap-was-slow-ugly-and-overdue-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: the-death-of-soundcloud-rap-was-slow-ugly-and-overdue")
PYEOF


# ---- POST 5: the-eras-tour-rewrote-the-rules-of-live-music-forever ----
echo "--- Updating: the-eras-tour-rewrote-the-rules-of-live-music-forever ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/the-eras-tour-rewrote-the-rules-of-live-music-forever.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/06HL4z0CvFAxyc27GXpf02]

## A Stadium Spectacle Beyond Comparison

There is no precedent for what Taylor Swift accomplished with the Eras Tour. Not Madonna. Not the Stones. Not Beyonce. When the numbers finally settled, the tour had grossed over two billion dollars, making it the highest-earning concert run in the history of recorded music. But reducing this phenomenon to its revenue feels like describing the ocean by its salt content.

The tour ran from March 2023 through December 2024, covering six continents and 149 shows. The gross figures are accurate and impressive. They are also the least interesting thing about what happened.

## The Cultural Weight

What made the Eras Tour genuinely significant was its function as a generational gathering point. In an era of algorithmic isolation, where music consumption has become an intensely private act conducted through earbuds and recommendation engines, Swift created something aggressively communal. Friendship bracelets became a currency. Entire cities saw measurable economic surges on show dates. Hotels sold out weeks in advance. Local restaurants created themed menus.

The tour operated as a traveling referendum on fandom itself. Each three-hour-plus performance moved through Swift's entire discography, treating every album as a distinct aesthetic chapter. The staging was relentless, the costume changes theatrical, and the setlist was a masterclass in pacing that most arena acts could never sustain.

The friendship bracelet phenomenon deserves specific attention because it was not manufactured by Swift's team. It emerged organically from the fan community and then became so central to the experience that the concert venue itself was transformed into a marketplace of connection. Strangers approached strangers. Trades happened across languages and across age differences. The bracelets were a visible sign of membership in something, but membership with no gatekeeping: anyone with a bracelet to trade was already inside.

## The Setlist as Architecture

The three-hour-plus runtime was not excess. It was the point. Each Eras Tour show was structured as a survey of Swift's career, with distinct visual and sonic identities for each album era. The shift from the Fearless section to the Folklore section was not just a costume change. It was a gear change, a movement from one emotional register to another, from the brightness of early country-pop to the intimacy of indie folk. The audience tracked these transitions with the attentiveness of people who had done preparation.

The surprise songs, two per show acoustic performances drawn from across her catalog, introduced a lottery element that drove speculation between shows and ensured that each performance was unique. Fans who attended multiple dates had a genuine reason to return beyond the stadium spectacle. The surprise songs were also the section of the show most likely to produce viral moments, which the fan community amplified organically across social media.

## Beyond the Music

The Eras Tour also became a case study in economic power. Economists genuinely debated whether one artist's concert schedule was influencing national inflation figures. Ticketmaster's catastrophic presale failures sparked congressional hearings and renewed antitrust conversations that had been dormant for years. Swift, perhaps inadvertently, exposed the rot at the center of live music's ticketing infrastructure.

The Ticketmaster failures in November 2022, when the presale for the US leg collapsed under demand, were significant not because they were unprecedented but because the scale of public anger they generated was. Hundreds of thousands of fans were locked out of purchases despite waiting for hours. The resulting congressional attention produced the first serious legislative discussion of live music ticketing practices in decades. The conditions that had allowed the ticketing industry to operate as an effective monopoly were suddenly visible to people who had previously paid no attention to them.

## The Lasting Impact

Critics can debate the artistic merit of any individual Swift album, but the Eras Tour transcended that conversation entirely. It demonstrated that live music at its most ambitious can still function as a mass cultural ritual. In an entertainment landscape fractured into a thousand streaming niches, Swift proved that monoculture is not dead. It just requires someone willing to build a world large enough for everyone to inhabit.

The question now is whether anyone else can replicate this scale, or whether the Eras Tour will stand alone as an unrepeatable artifact of one artist's singular grip on the popular imagination.

The answer is almost certainly the latter. The Eras Tour required twenty years of catalog, a fanbase cultivated with unusual directness across every shift in music distribution technology, and a performer willing to commit to a format that demanded total saturation of every hour. The economic and cultural conditions that made the tour possible were specific to this artist at this moment in the music industry's history. No one is positioned to do it again the same way.

What will persist is the template it established: that the concert experience can be designed as a complete world rather than a set of songs in a room, and that audiences will commit to that world with a depth and loyalty that streaming numbers cannot fully capture.

[download:/assets/images/artists/the-eras-tour-rewrote-the-rules-of-live-music-forever-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: the-eras-tour-rewrote-the-rules-of-live-music-forever")
PYEOF


# ---- POST 6: theaster-gates-black-archive-2023 ----
echo "--- Updating: theaster-gates-black-archive-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/theaster-gates-black-archive-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:Byin7zoiiUU]
## Material and Memory

Theaster Gates's practice begins with things that would otherwise be lost: collections of vinyl records, archives of Black magazines and newspapers, the architectural salvage of abandoned buildings in Chicago's South Side. He transforms them into something that has the quality of monument without the coldness of monument. The archive becomes the artwork. The salvage becomes the building. The materials of a culture carry that culture into new forms.

His installation and exhibition work of the past few years has involved the Stony Island Arts Bank, a former bank building on the South Side that Gates purchased and renovated using income from his gallery work, turning it into a library, archive, and cultural centre. A series of major international exhibitions bring the materials of that archive into gallery contexts around the world.

What he does with this material in exhibition is not simply display it. He transforms the context. The gallery becomes something between a library and a cathedral, the objects accumulate into something that has an atmosphere, a weight, a sense of charged presence. The vinyl records stacked floor to ceiling in vitrines are not just collections; they are the visual representation of a culture's self-documentation, of the fact that Black musical culture was rich and abundant and is worth preserving.

The Johnson Publishing Company collection, which Gates acquired and now stewards through the Stony Island Arts Bank, includes the archives of Ebony and Jet magazines, two publications that documented Black American life for decades with a comprehensiveness that no mainstream publication could replicate. The physical objects, the photographs, the layouts, the letters, the administrative records, are themselves a form of evidence. They demonstrate that a culture was present, articulate, and worth preserving before any gallery system decided to pay attention.

## What a Cathedral Does

I use the word cathedral deliberately and with awareness of its fraught relationship to the history of colonialism that Gates's work engages with. Cathedrals were built by powers that also enslaved. The form is not innocent. But Gates uses it knowingly: the soaring space, the quality of light, the sense of something sacred, in a reclamation that is both formal and political.

The Black archive is sacred. The materials of a culture are worth treating with this quality of attention, this quality of care. The cathedral form, applied to the collected evidence of Black life and creativity, is a statement about what deserves to be preserved and how it deserves to be treated.

This is simultaneously art practice and community development work. The distinction between them matters less in Gates's project than in almost any other contemporary art practice. The Stony Island Arts Bank is a real place where real things are stored and real community members have access. The gallery exhibitions generate income that funds the building and the archive. The two things are the same thing.

The Stony Island Arts Bank building itself carries this logic. It was scheduled for demolition when Gates intervened. Its renovation required the same skills that Gates's gallery work draws on: the ability to see value in what the market has written off, the conviction that repair is worth the labor, the understanding that beauty and utility can occupy the same structure. The building is an argument made in architecture. The archive inside it is the argument made in objects.

## The Political Economy

There is a sophistication in how Gates has navigated the art market: using gallery sales and institutional commissions to fund community projects in ways that do not compromise either side. He is not selling out by being in galleries; he is using galleries to do something else. He is not romanticizing poverty by working in underserved communities; he is treating them as the cultural centers they are.

This pragmatism is itself unusual in an art world that often treats commercial engagement and political commitment as incompatible. Gates has found a way to make them aspects of the same project, and the elegance of that solution is part of what his practice demonstrates.

The cathedrals he builds from archival material are beautiful. They are also useful. Those two things being the same is the whole argument.

Walking into a space that has been organized with the intention of making you feel that certain things are sacred: the Stony Island Arts Bank produces this experience. The galleries and installations that Gates builds from its materials carry this quality elsewhere, into the institutions that do not always allow this feeling.

The cathedral built from archives. The sacred made from the discarded. These transformations are not metaphor. They are actual, physical, the result of real labor applied to real materials. The labor is visible in the work. That visibility is the argument.

[download:/assets/images/artists/theaster-gates-black-archive-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: theaster-gates-black-archive-2023")
PYEOF


# ---- POST 7: thugli-sic-em ----
echo "--- Updating: thugli-sic-em ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/thugli-sic-em.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """When Amos Le Blanc returned to direct Thugli's second major video, the question was never whether he could match what he had done before. It was whether he could push the whole idea further. "Sic Em" answers that question completely.

[youtube:-VINQSfMhIw]

Thugli, the Toronto electronic duo of Tom Wrecks and Pat Drastik, built their reputation on a particular kind of brutalism. Their productions hit hard, arrive fast, and leave a mark. The track "Sic Em" moves like a threat. Clattering percussion, chain sounds processed into something mechanical and ancient at once, and a synth that functions more like a siren than a melody. It is the kind of music that demands a visual language equal to its aggression. Le Blanc delivered one.

The video operates as a parable. Money, violence, power, and consequence are arranged into a series of images that are stylized to the point of mythology. Nothing is casual here. Every frame is constructed. Le Blanc and his team, including production designer Andrea Leigh and producer Geoff MacLean, created a world that feels like a trap. Clean surfaces and controlled environments that carry the unmistakable atmosphere of danger.

What separates Le Blanc's direction from the average music video is his insistence on treating choreography as a structural element rather than decoration. The movement in "Sic Em" is precise, deliberate, and weighted. Bodies in this video do not perform for the camera. They exist within the logic of the world the video builds. Every gesture reads as consequence. Every formation reads as power. The choreography does not illustrate the music so much as respond to it, two forces in conversation rather than one subordinated to the other.

This is the kind of decision that defines a director's sensibility. Lesser work uses movement to fill space. Le Blanc uses it to compress meaning. A single held position in "Sic Em" communicates what a lesser director might spend thirty seconds spelling out.

The visual language throughout the video is spare and controlled. Le Blanc strips away everything that does not serve the central logic of the piece. What remains is iconography. The images in "Sic Em" are designed to be remembered individually, lifted out of context and still carry full weight. That is an uncommon achievement in short form visual work, where the temptation is always to pile on detail and movement in order to sustain attention. Le Blanc understands that restraint, used correctly, is far more powerful.

The result won the MMVA for Best Dance Video, a recognition that acknowledged not only the technical craft of the production but the coherence of its vision. Awards at that level tend to go to work that is immediately legible, broad enough to read as accessible across a wide audience. That "Sic Em" won while being as uncompromising as it is says something about how clearly Le Blanc's intentions came through. The video did not soften its edges to earn that recognition. It earned it by being exactly what it was.

Le Blanc had already established his eye with "Run This," the first Thugli video he directed. That project won the Cannes Young Director Award Gold in 2013, an international citation that placed him in conversation with the best short form directors working anywhere. "Sic Em" is not a repetition of that success. It is a development of it. The relationship between Le Blanc and Thugli had deepened by this point, and it shows. There is a trust in the collaboration that produces a different kind of freedom. Le Blanc is not demonstrating a technique. He is building a body of work with a specific group of artists, and that continuity gives the video a weight that isolated projects rarely achieve.

The Cannes Young Director Award is worth pausing on. It is not an industry recognition for technical competence. It is a citation for vision, for the presence of a genuine and developed point of view that is legible in the work itself. Winning it in 2013 placed Le Blanc in the company of directors who went on to significant careers in commercial and narrative filmmaking. "Run This" and "Sic Em" together represent a body of music video work that demonstrates what that point of view looks like when applied to the specific demands of the form.

Andrea Leigh's production design deserves specific attention. The environments in "Sic Em" are not neutral. They are chosen and constructed to amplify the tension that the track generates. The visual world of the video feels sealed, hermetic, a space that has its own physics and its own rules. Leigh and Le Blanc clearly shared a vision of what that world should feel like, and the coherence between the set design and the cinematographic choices is total. This is collaboration at a high level.

Geoff MacLean's production kept that vision intact through execution. A video this controlled does not happen without rigorous management of the conditions under which it is made. The clarity and consistency of the final product reflects a production that gave Le Blanc and his team what they needed to realize the work fully.

For Thugli, "Sic Em" represents the full arrival of a visual identity to match their sonic one. The duo had been building toward a sound that demanded this kind of treatment. The track is not background music. It is not designed for passive consumption. Le Blanc recognized that and met it with a video that requires the same level of attention from its audience. Watch it casually and you get something impressive. Watch it carefully and the construction reveals itself, layer by layer, each element placed with intention.

That is what serious music video direction produces. Not content, but work. "Sic Em" is work in the best sense of that word.

[spotify:artist/3T1RyRHwjOH22Bl04uMffB]

[download:/assets/images/artists/thugli-sic-em-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: thugli-sic-em")
PYEOF


# ---- POST 8: tirzah-minimal-as-heartbeat ----
echo "--- Updating: tirzah-minimal-as-heartbeat ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tirzah-minimal-as-heartbeat.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """A Tirzah song at its most stripped down sounds like three elements held loosely together: her voice, a beat that barely arrives, and silence. The silence is doing something.

Tirzah Mastin is from Essex, England. She has been making music with producer Mica Levi for over a decade, and their collaboration defines her sound completely. Levi writes and produces everything; Tirzah sings over it. The result does not sound like either of them would make separately.

[spotify:artist/6f5lOlSFJw9K79gaNnmWAd]

Devotion (2018) was the first time most people heard her outside of small circles. Songs like Devotion and Fine Again used R&B as a starting point and then subtracted everything that made it recognizable. What is left is something skeletal and genuinely affecting. The beats land like they are unsure whether they want to arrive. The bass frequencies are present as suggestions rather than statements. And Tirzah's voice sits in the middle of all this absence with a quality that most production would bury: presence without effort, intimacy without performance.

## Colourgrade and After

Colourgrade (2021) pushed further. There are moments on that record where the production almost collapses under its own weight: bass that flickers in and out, beats that stutter and restart, melodies that arrive late. It should not work. It does.

The instability is the point. Mica Levi's production on Colourgrade treats structural uncertainty as an emotional register. The music that seems about to fall apart is music that captures something true about how precarious feeling can be, how connection holds on not because the conditions are stable but because both parties are committed to holding it. Do You Know from Colourgrade is probably the closest she gets to accessible, and it is still deeply strange: the rhythm section feels like it is tracking something other than a standard grid.

The 2023 EP trip9love...??? is even more abstracted. If Devotion was Tirzah finding her voice, trip9love is her testing whether voice is necessary at all. It is a short, strange record that rewards patience and punishes impatience in equal measure. The tracks do not develop in the way that listeners trained on conventional song structures expect. They arrive, persist for a while in a state of productive tension, and then leave. What stays is harder to name than feeling but closer to feeling than analysis.

## The Collaboration as Method

The Tirzah and Mica Levi collaboration is unusual enough that it is worth examining as a method rather than a product. Levi is a film composer, best known for the Under the Skin score, who works across multiple disciplines with an evident disinterest in genre fidelity. The music she makes for Tirzah does not sound like her film work except in the most fundamental sense: it uses sound to produce interior states in the listener, treating sound itself as the primary vehicle rather than lyrics or melody.

Tirzah's contribution to this collaboration is not the conventional singer's role of delivering a melodic line over a completed production. Her voice is an instrument in Levi's architecture, placed and processed as carefully as any other element. When it sounds like she is barely singing, that barely is a precise instruction, executed with full control. The restraint is the craft.

They do not do many interviews. Tirzah rarely performs. That distance from the promotional machinery is consistent with the music's own refusal to seek approval. Mica Levi's production is similarly non-promotional: no radio-friendly mixes, no attempts to make the work go bigger than it wants to go.

## Starting Points

Fine Again is the easiest entry point for anyone new to Tirzah's work. The emotional directness of the lyric, a relationship in the process of repair, is unambiguous enough to hold onto while the production does its stranger work around it. Do You Know from Colourgrade is the track that tends to stay with listeners after a first hearing, operating on a frequency that resists easy description but is immediately recognizable on the body.

trip9love the song, from the 2023 EP, is where you go once you need more: more abstraction, more willingness to let the music be what it insists on being rather than what a listener's expectations require of it.

There is a stubbornness to what she does that is increasingly rare. In an industry that rewards consistency and accessibility and the kind of growth that is visible in streaming numbers, Tirzah and Levi make music that resists measurement and rewards the kind of attention that cannot be tracked. The audience that finds their work tends to hold it closely, which is the only kind of relationship this music was ever designed to produce.

[download:/assets/images/artists/tirzah-minimal-as-heartbeat-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tirzah-minimal-as-heartbeat")
PYEOF


# ---- POST 9: tirzah-trip-2022 ----
echo "--- Updating: tirzah-trip-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tirzah-trip-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/6f5lOlSFJw9K79gaNnmWAd]

There is something unsettling about how good this is. I put on Trip for the first time in the back of a cab, headphones in, rain on the window, and I felt immediately like I was intruding on something private. Not private in the way of a diary entry that has been published against someone's better judgment: private in the way of a room where two people are having a conversation that has been happening for years, a conversation with its own shorthand, its own silences, its own grammar. Tirzah makes music like that. Music that assumes you already understand.

Coloured In, her debut, arrived in 2018 and made my year feel suddenly insufficient. She and Mica Levi, her longtime collaborator, the composer who did the Under the Skin score, who understands how unease can be beautiful, built something there that I still do not have the vocabulary for. It occupied a space between R&B and electronica and somehow avoided both categories' worst tendencies. By the time Trip came out I had almost trained myself not to expect too much. I was wrong to have lowered my expectations. She had not.

## Music That Withholds in the Best Way

What Tirzah does, what she and Levi do together, is withhold in a way that creates extraordinary pressure. There is almost nothing happening on these tracks and yet they are saturated. The production is skeletal: a few textures, a beat that sounds like it was recorded through a wall, a bassline that barely commits to being a bassline. And over all of it, her voice, which is not a conventional R&B voice, which is not trying to demonstrate range, which is simply present in the way that only a few singers ever manage to be simply present.

I have thought a lot about what presence means in a vocal performance. It is not loudness. It is not technical facility. It is something closer to the sense that the person singing is genuinely somewhere else, that you are overhearing rather than being performed at. Tirzah sings like she is talking to herself. There is a track called Hive Mind that has been living inside my head for weeks, a fragment of a thing, barely three minutes, and it contains more emotional information than most albums.

The production decisions on Trip are worth attention because they are so precisely calibrated to serve this effect. The beats arrive slightly behind where you expect them, which creates a constant low-level uncertainty that keeps the ear engaged without offering resolution. The bass frequencies are present but not assertive, felt more than heard. Levi treats silence as an active element rather than an absence, and the way the quiet sections of Trip accumulate meaning is one of the record's central achievements.

## The Intimacy Problem

There is a problem that music faces when it gets this intimate, which is that it becomes very easy to dismiss as slight. Critics have done this to Tirzah. I have watched it happen in real time: the reviews that praise but hedge, that use words like minimal as if minimalism were a limitation rather than a philosophy, that seem faintly embarrassed by their own response to the music. We have a cultural habit of valuing scale. Big productions, wide emotional arcs, music that announces itself. Tirzah's music does not announce itself. It sits down next to you and says something quiet.

The scale of an emotional experience is not measured in decibels. I do not know why this needs saying but it does. Trip is a small record that contains multitudes. It is about new parenthood, or it is about love during crisis, or it is about the way your interior life changes when the world outside becomes unbearable. Honestly, I am not sure, and I am not sure it matters. What matters is that it sounds like something true. It sounds like something that was made because it had to be made, not because there was a release cycle to fill or a brand to maintain.

I keep thinking about the word trip: the journey, the stumble, the altered state. All three meanings apply. This album takes you somewhere. It does not tell you where you are going. I have been grateful for that lack of instruction every time I have put it on.

## The Intimacy Is the Achievement

Most music achieves scale and calls it success. Tirzah achieves intimacy and that is harder and rarer and more lasting. I keep going back to Trip not for what it proves but for what it is: small, private, true, and quietly, completely extraordinary.

I return to it at different intervals and find it somehow both familiar and renewed. That quality, the music that can be known and still surprise, is the rarest quality in pop music, where the logic of the form pushes toward everything being immediately legible. Tirzah makes pop music that is not immediately legible and that rewards the time you spend learning to read it.

The album was made during a specific period in Tirzah's life, one that included new parenthood and the particular combination of exhaustion and wonder that produces. The record does not describe that period directly but it carries its texture completely. The simultaneity of things, the way attention splits and the world simultaneously narrows and expands, is present in the music itself, in the way it holds multiple emotional registers at once without resolving them into a single dominant mood.

I have spent the time with this record. The return is ongoing.

[download:/assets/images/artists/tirzah-trip-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tirzah-trip-2022")
PYEOF


# ---- POST 10: tiwayo-outsider ----
echo "--- Updating: tiwayo-outsider ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tiwayo-outsider.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:track/0gGRSOecyoQFL3M67OsgP1]

There is a specific kind of musician who exists out of time. Not nostalgic: nostalgia is a pose. Out of time in the sense that the music they make does not seem to be in conversation with whatever is dominating the charts or the algorithm. It simply exists on its own terms, rooted in something older and more durable than a release cycle. Tiwayo is that kind of musician, and Outsider, his new album, out April 10 on Record Kicks, produced by Grammy winner Adrian Quesada of the Black Pumas, is his most convincing argument yet.

[youtube:c5laE2ZbFbM]

## The Young Old

That is what they call him. Born in Paris, Tiwayo spent years busking across the world: street corners, train stations, wherever someone would listen. He absorbed blues in Mississippi, gospel in Alabama, soul in Memphis. Not as a tourist but as a practitioner, someone who was learning a language by living inside it. His first album, The Gypsy Soul of Tiwayo, arrived in 2019 on Record Kicks and captured that itinerant energy: raw, rootsy, slightly untamed.

Outsider is different. It is still raw, still rooted, but the production has weight. Quesada, whose work with the Black Pumas earned him a Grammy and turned Austin, Texas into a soul music pilgrimage site, brings a fullness to these songs that Tiwayo's earlier recordings sometimes lacked. The pairing makes sense on paper and proves itself on tape. Quesada builds from the bottom up: warm bass, analog keys, drums that breathe rather than punch. Tiwayo's voice, gravelly, weighty, possessed of a roughness that no amount of studio polish could smooth, sits on top of those arrangements like it has always belonged there.

What Quesada understood about Tiwayo's voice is that it does not need help. It needs space and the right frame. The production on Outsider provides the frame without crowding the painting. The analog warmth that defines Quesada's work with the Black Pumas is present throughout, but it serves Tiwayo's rawer instincts rather than smoothing them into something more palatable. The tension between the vintage production approach and Tiwayo's unpolished delivery is the engine of the record.

## Eleven Tracks, No Filler

I've Got to Travel Alone, the lead single released last November, opens the album with a declaration of independence that is neither triumphant nor mournful. It just is. The song moves at a walking pace, acoustic guitar and gentle percussion supporting a vocal that sounds like it was recorded in a single take. The video, shot in Austin at Electric Deluxe Rec, captures the same energy: no cuts, no effects, just a man and a guitar in a room with good light.

Sunshine Lady and Up for Soul push into warmer territory: the kind of slow-burn grooves that could sit comfortably next to Curtis Mayfield or Bill Withers without sounding like imitation. The comparison to those artists is not flattery. It is a description of a specific quality, the ability to make deeply personal emotional content feel universally applicable without losing its specificity. Tiwayo achieves this on both tracks with a consistency that only comes from having spent years making the music in rooms rather than in studios.

Daddy Was Born with the Blues carries the weight of its title with a directness that avoids sentimentality. The lyric is confessional in the way that the blues tradition allows, which is the way that treats confession not as vulnerability but as accuracy. Electric Spanish introduces flamenco textures without ever becoming a genre exercise: the influence is absorbed rather than displayed.

## The Question of Audience

The challenge Tiwayo faces is the same one that confronts every artist making music rooted in tradition: who is this for? The soul revival has been happening for over a decade now: Leon Bridges, the Black Pumas, Brittany Howard, each iteration justifying its own existence. Tiwayo's justification is biographical. He is not reviving anything. He is continuing a practice that he learned on the street, not in a studio, and that distinction matters.

The busking background is not a marketing narrative. It is a description of how the music was built. When you learn songs by playing them for strangers who have not come to hear you, who can walk away at any moment and often do, you develop a relationship with the material that studio-trained musicians rarely achieve. You learn what actually holds attention and what does not. You develop an economy of expression that recording technology tends to dilute.

Outsider carries this economy throughout. Nothing on the record is there for effect alone. The arrangements serve the songs without calling attention to themselves. The production choices are in service of the voice rather than in competition with it. This is what eleven tracks with no filler sounds like when the filler was never a temptation.

Outsider is not a record that will trend on TikTok. It is a record that will find its audience in the way that soul music has always found its audience: slowly, through repetition, through the specific gravity of a voice that earns your trust one song at a time. That Quesada heard that voice and decided to build an entire album around it tells you everything you need to know about what is on offer here.

[download:/assets/images/artists/tiwayo-outsider-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tiwayo-outsider")
PYEOF


# ---- POST 11: tokyo-underground-electronic-2026 ----
echo "--- Updating: tokyo-underground-electronic-2026 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tokyo-underground-electronic-2026.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Tokyo's electronic music scene operates on a different frequency than the rest of the world. Literally and figuratively.

In a city where noise ordinances are strict, venues are small, and cultural norms favor precision over chaos, the electronic music community has developed a sound and a culture that is utterly distinct. It is meticulous where Berlin is raw. It is intimate where London is massive. It is patient where New York is urgent.

## The Venues

The geography of Tokyo's electronic scene is defined by its venues. Clubs like WOMB, Contact, and Pipe occupy spaces that would be considered tiny by European or American standards. Capacity limits are measured in dozens, not thousands. This intimacy is not a limitation. It is the defining feature.

In a room that holds eighty people, the relationship between DJ and audience is fundamentally different than in a space built for two thousand. Every decision the DJ makes is felt immediately. Every transition is audible in detail. The music is not experienced as a wall of sound but as a conversation. WOMB, which has operated in Shibuya since 1999, established the template: multiple floors with different sound philosophies, each room a distinct acoustic environment, the basement in particular developing a reputation for an approach to bass frequencies that treats the body as a resonant chamber rather than a passive receiver.

Contact in Shibuya represents the newer generation of Tokyo venues, smaller and more focused, with a booking philosophy that treats individual nights as curatorial statements. The lineups are assembled with the coherence of a gallery exhibition. Artists from Japan's domestic scene appear alongside international figures in configurations that make sense sonically rather than by name recognition. The result is nights that have an internal logic and an audience that has come specifically to hear that logic.

## The Sound

Tokyo's producers draw from a wider palette than most electronic scenes. The influence of Japanese traditional music, of city pop, of noise, of ambient, of the country's deep history with synthesizers and electronic instruments, creates a foundation that no other city can replicate.

The result is electronic music that is texturally rich in a way that surprises listeners accustomed to Western conventions. A Tokyo techno track might incorporate field recordings from a temple. A house track might borrow melodic ideas from enka, the traditional Japanese popular music form that preceded city pop. An ambient piece might use silence as aggressively as any noise artist, treating the absence of sound as a compositional element with the same weight as the sounds that frame it.

Artists like Foodman, who releases on labels including Hyperdub, demonstrate this eclecticism: his productions draw on footwork rhythms, J-pop melodic sensibility, and abstract electronics without ever sounding like a deliberate fusion exercise. The mixture is natural rather than constructed. The same is true of producers like Masayoshi Iimori, who brought a distinctly Japanese sensibility to the global club conversation through a production style that treats density and restraint as equally valid compositional tools.

## The Community

What makes Tokyo's scene particularly special is its commitment to curation. Club nights are programmed with an attention to sonic coherence that would make a museum curator envious. A night at a Tokyo venue is not a random collection of DJs. It is a curated experience with a beginning, middle, and end.

This curatorial rigor extends to the audience. Tokyo clubgoers listen with an intensity that is almost scholarly. They are there for the music, not for the social performance. The dancefloor is quiet between tracks. Phones are rarely visible. The culture of respectful listening that shapes other Japanese artistic spaces, the concert hall, the cinema, the gallery, has been imported into the club environment and translated into a collective standard. The result is a room full of people who are genuinely paying attention, which changes what the DJ is able to do.

The Japanese music industry's characteristic independence from Western trends is amplified in the club context. Tokyo's scene has developed its own artists, its own labels, its own venues, its own audience, largely without reference to whether the choices being made would play well elsewhere. The domestic market is large enough and specific enough that international validation has historically been less important than quality on local terms.

## The Global Moment

Tokyo's electronic scene has operated in relative international obscurity for decades, content to develop its own ecosystem without seeking outside validation. That isolation has produced something remarkable: a fully formed musical culture that owes nothing to anyone.

In 2026, as the global appetite for electronic music from outside the Euro-American axis grows, Tokyo is positioned to receive attention that is long overdue. Labels like 100% Silk, Hyperdub, and Ninja Tune have been licensing and releasing Japanese artists at increasing rates. International festivals have expanded their bookings. The curiosity is real and the discovery is ongoing.

The question is whether that attention will change the scene or whether the scene will change the attention. Based on Tokyo's track record, the smart money is on the latter. A culture that spent decades developing its own standards without seeking external approval is unlikely to modify those standards simply because the rest of the world arrived late.

[download:/assets/images/artists/tokyo-underground-electronic-2026-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tokyo-underground-electronic-2026")
PYEOF


# ---- POST 12: toro-y-moi-hole-erth ----
echo "--- Updating: toro-y-moi-hole-erth ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/toro-y-moi-hole-erth.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/6O4EGCCb6DoIiR6B1QCQgp]

Chazwick Bundick has spent his career making it impossible for anyone to predict what a Toro y Moi album will sound like. Chillwave. House. Funk. Lo-fi pop. R&B. Each record has shifted the coordinates while maintaining something ineffably Chaz about the whole thing: a warmth in the production, a looseness in the arrangements, a willingness to prioritize feel over precision.

Hole Erth, his eighth studio album, released in September 2024 on Dead Oceans, is the most extreme pivot yet. Pop-punk energy. Autotuned rap. Collaborations with Don Toliver, Kevin Abstract, and Benjamin Gibbard of Death Cab for Cutie. If you came expecting Causers of This Part Two, Hole Erth will disorient you. That is the point.

## The Collaborations

The guest list on Hole Erth is itself a statement of Bundick's range and his refusal to stay in one lane. Don Toliver represents the Houston rap and singing tradition; his presence on the record extends the R&B experiments Bundick has been running since Anything in Return. Kevin Abstract brings the Brockhampton aesthetic, the maximalism and the emotional candor, into conversation with Bundick's more restrained instincts. Benjamin Gibbard of Death Cab for Cutie is the most unexpected: his presence suggests that Hole Erth's pop-punk energy is not ironic or nostalgic but genuine, a real engagement with the emotional directness that defined that genre's best work.

These collaborations work because Bundick gives them room. He does not absorb his guests into his aesthetic and sand off their edges. He builds environments that allow each collaborator to be recognizably themselves while the results still cohere as a Toro y Moi album. This is a production skill that is rarer than it sounds: the ability to create a consistent framework that is permeable enough to let different personalities through without losing its own character.

## Les Sins and the Side Projects

Bundick's side project Les Sins, his more explicitly dance-oriented alias, has been dormant since a joint EP with AceMo in 2020. The last full-length under that name was Michael in 2014. But the influence of Les Sins bleeds into everything Bundick touches. The rhythmic adventurousness, the willingness to let a groove dictate structure rather than verse-chorus convention, is present across all his work.

The fact that Les Sins has been quiet while Toro y Moi has absorbed its energy suggests that Bundick no longer needs the separation. The main project has become capacious enough to hold everything: the psychedelic folk of Outer Peace's predecessors, the dance-oriented material, the R&B experiments, and now the pop-punk turn. The need for a separate alias was always about the limits of expectation rather than the limits of the artist, and Bundick has spent eight albums expanding those expectations until the main project can contain whatever he brings to it.

## The Sandhills EP and What It Set Up

Bundick released the Sandhills EP in 2023, a smaller project that served as a bridge between the lush production of Mahal and the rawer energy of Hole Erth. The EP demonstrated a willingness to let recordings be less finished, to keep the roughness that the chillwave years had trained listeners to hear as intentional imprecision. Hole Erth takes that roughness further: the production sounds deliberate in its unpolished quality, tracks that could have been smoothed but were not, sonic choices that prioritize the feeling of a moment over the perfection of a texture.

## The Tour and What Comes Next

A winter 2025 North American headline tour with Panda Bear as support ran through February and March. An unplugged reworking of Hole Erth, titled Unerthed, was announced for later in 2025. The acoustic reworking is itself a statement: these songs are strong enough structurally to exist without their production conceits, to survive translation into a stripped-down format and remain interesting. That confidence is earned.

## The Career

Toro y Moi is one of the most consistently interesting artists in independent music. Not because every album is a masterpiece, but because every album is a genuine attempt to do something he has not done before. In a landscape where artists are rewarded for repeating themselves, where the algorithm punishes deviation and rewards the reliable delivery of something already known to work, Bundick's refusal to stay still is its own kind of excellence.

Hole Erth is the fullest expression of that refusal. It is an album that almost dares its existing audience to follow it somewhere unexpected. Most of them did. That willingness to go wherever the music leads, and to bring an audience along through the quality of the work rather than the safety of the choices, is the thing that makes a career like this one worth following for the long haul.

[download:/assets/images/artists/toro-y-moi-hole-erth-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: toro-y-moi-hole-erth")
PYEOF


# ---- POST 13: tove-lo-criminally-underrated-heat-2024 ----
echo "--- Updating: tove-lo-criminally-underrated-heat-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tove-lo-criminally-underrated-heat-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:album/5xBJBxfQFowtJ5yq7MnXMG]

There is a particular kind of pop success that works against you. You land a song so culturally sticky that it calcifies into a single data point: the only thing people think you are. Tove Lo has lived inside that trap for a decade. "Habits (Stay High)" hit number three on the Billboard Hot 100 in 2014 and never really left the room. Which is a problem, because what came after it was, frankly, more interesting.

Ebba Tove Elsa Nilsson, born in Stockholm, raised on grunge and honesty, has released five studio albums, co-written songs for Cher Lloyd, Lea Michele, and a dozen others, and spent twelve years building a body of work that most of her casual listeners have never heard. She has over a billion streams on "Habits" alone. She is also, genuinely, one of the most underheard artists working in pop right now.

## What Dirt Femme Got Right

Dirt Femme (2022), her fifth album and the first on her own Pretty Swede Records label, was the record that made this case loudest. It was raw, maximalist, and emotionally exact in a way that most pop refuses to be. "No One Dies From Love" does what great pop should: it says something obvious that nobody else had said so cleanly. "2 Die 4" is a club record with actual stakes. The critical reception was strong: Spectrum Culture called it one of the best pop albums of that year. But mainstream pickup stayed thin. The conversation moved on.

She did not.

The decision to start Pretty Swede Records rather than re-sign to another major after Island Records deserves attention as a business move as much as an artistic one. It meant that Dirt Femme and everything that followed it was made without the structural pressure to deliver something commercially legible to a label that needed to justify the investment. The freedom this produced is audible on the record. The arrangements are bolder, the emotional content is more exposed, the production choices are stranger than anything she had been given space to do previously.

## HEAT and the Queer Club at the Centre of Everything

In June 2024, Tove Lo released HEAT, a four-track collaborative EP with British producer SG Lewis, built entirely around a fictional queer London nightclub called Club Heat. Every track had a corresponding music video, all directed by David Wilson, all following a single protagonist named Ali through one night at the club. It is a complete piece of work: lust-fuelled, inclusive, technically precise, and built for a room at 2am.

The EP's four songs, "Heat," "Let Me Go OH OH," "Busy Girl," and "Desire," draw a line from the dance floor to something closer to liberation. Lewis's production is immaculate: the low end placement on "Heat" alone demonstrates a producer working at the highest level of the craft. Tove Lo's vocal control, always underrated, does things here that most pop stars cannot approximate. This was not a cynical Pride release. It was the real thing.

The fictional Club Heat premise is a conceptual frame that serves the music without constraining it. The four tracks can be experienced as a mini-narrative, following Ali through the emotional arc of a night out, or as standalone club tracks that hit on their own terms. Both readings are valid and neither is the only correct one. That flexibility is a sign of material confident enough in itself to support multiple approaches.

The EP landed at Glastonbury that summer: Club Heat took over the Lonely Hearts Club Stage on June 28, 2024. She played SVN West in San Francisco in September, 3 Dollar Bill in Brooklyn in August. Small rooms, by design. The kind of shows where something actually happens.

## The CAVE Moment

Then came "CAVE." Dom Dolla's track featuring Tove Lo dropped in late 2024 and became a genuine crossover moment, over 11 million streams in its first two months. A Partiboi69 and X CLUB. remix followed in December, transforming it into a 4x4 techno banger that kept the dance floors moving well into 2025. In March 2025, she appeared at Madison Square Garden alongside Dom Dolla, Kid Cudi, and Tiga. That is a significant room.

The CAVE collaboration is notable because it demonstrates that Tove Lo's voice and her instinct for dance-floor-ready melody translates across production contexts. Dom Dolla's tech house aesthetic is different from SG Lewis's UK-inflected production, and both are different from what Dirt Femme sounded like. She sounds at home in all of them. The adaptability is not shapeshifting: it is the sign of an artist with a strong enough center that she can move through different sonic contexts without losing her identity.

## Ten Years of Queen of the Clouds

September 2024 also brought Queen of the Clouds: X, a tenth anniversary reissue of her debut album, expanded with unreleased vault tracks including "Jealousy (From the Vault)," written in 2014 and never released until now. She told fans: "I was such a mess when I wrote these songs but I still feel 100% that this album is me today."

That is the thing about Tove Lo. The music is always her. There is no protective layer of irony or persona management. It costs her a certain kind of mainstream ubiquity and earns her something harder to manufacture: actual loyalty from actual listeners.

## The Argument

Underrated does not mean unheard. It means the conversation around an artist has not caught up to what the work actually is. Tove Lo has a Grammy nomination. She headlined festival stages across three continents in 2024. She runs her own label. She writes songs that other artists perform as the highlights of their careers.

And she is still making music that sounds like it was built for the people who need it most: specifically, and without apology. That is not a small thing. That is the whole thing.

[download:/assets/images/artists/tove-lo-criminally-underrated-heat-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tove-lo-criminally-underrated-heat-2024")
PYEOF


# ---- POST 14: turnstile-coachella-2026 ----
echo "--- Updating: turnstile-coachella-2026 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/turnstile-coachella-2026.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:track/0vbdCsYHg1by09QKOGO4PR]

There is no version of Turnstile that holds back. That has been true since the Baltimore hardcore band started playing basements in 2010, and it was violently, beautifully true at the Outdoor Theatre on Friday at 8:05 PM, when they played what might have been the most emotionally loaded set of their career.

## Three Mosh Pits Deep

[youtube:UEjGgpX5SA0]

Within the first thirty seconds of the opening track, three separate mosh pits had formed in the Outdoor Theatre crowd. Not the choreographed circle pits of festival hardcore: these were organic, chaotic, joyful expressions of a crowd that had been waiting all day for permission to lose it. Turnstile gave them that permission and then kept pushing.

The Grammy-winning "Birds" arrived early in the set and hit with the force of a band that knows exactly what that song means now. It is the track that took hardcore punk to the Grammy stage, the one that made rock critics and punk lifers argue about whether that was a good thing. Brendan Yates sang it like the argument was irrelevant, like the only thing that mattered was the room and the sound and the people in it.

The Never Enough album cuts sounded enormous in the open desert air. The production of that record, which had been criticized by some hardcore traditionalists for its polish and its willingness to incorporate melody and dynamics that the genre does not always permit, revealed its design in the outdoor setting: these songs were made for spaces this large. The distortion carries further. The dynamic shifts, the moments where the band pulls back before the next surge, register as physical events when you are standing in a field of several thousand people all moving together.

## The Dev Hynes Moment

Midway through the set, Dev Hynes, Blood Orange himself, walked onstage carrying a cello. "Seein' Stars," already one of the best rock songs released in the last five years, became something else entirely with live strings cutting through the distortion. The collaboration made perfect sense in a way that should not work on paper. Hynes, the genre-fluid art-pop polymath, sitting with a cello amid the wreckage of a hardcore set, and the music breathed differently. The mosh pits paused. People looked at each other. Then the chorus hit and everyone moved again.

The Hynes guest appearance encapsulated what makes Turnstile's current position in music unusual. They are a hardcore band beloved by people who do not listen to hardcore, collaborating with artists from completely different aesthetic traditions, and doing so without any sense that the genre boundaries are being violated. They are simply playing with people whose work they respect. The result is music that sounds like it could not have been made by anyone else, which is the definition of a band operating at the height of their powers.

## Playing Through Pain

What most of the crowd did not know, and what made the set resonate on a deeper frequency, was the context. Earlier that week, former guitarist Brady Ebert had been charged with second-degree attempted murder after allegedly hitting Brendan Yates's father, William Yates, with a car. The band did not address it directly. But after "Seein' Stars," a message appeared briefly on the screens: a tribute to Bill Yates, followed by a red tape heart in memory of Bo Lueders, the Harm's Way guitarist who died recently.

Yates stood still for a moment. The crowd held its breath. Then the band launched into the next song with a ferocity that felt less like performance and more like survival.

The decision to play through that weight rather than acknowledge it with words was consistent with how Turnstile has always approached the relationship between personal experience and public performance. The music holds what cannot be spoken. The physical intensity of the show is not separate from the emotional content but continuous with it. What the crowd received in that moment was not a performance of grief but grief itself, expressed in the only language the band has ever fully trusted.

## Why Turnstile at Coachella Matters

Hardcore punk at Coachella has always been a negotiation: the genre's intensity versus the festival's curation, the pit versus the sponsored lounge. Turnstile does not negotiate. They showed up as exactly what they are: a band that has won Grammys, sold out arenas, and still plays like every show is in a Baltimore basement. The Never Enough album cuts sounded enormous in the open desert air, and the older material, "Mystery," "Holiday," proved that the catalog is deeper than most rock bands achieve in twice the career.

The size of the crowd that showed up for an 8pm hardcore set in the desert was itself a statement. Coachella audiences are not typically hardcore audiences. The fact that Turnstile drew the numbers they drew, and held them for the entire set, and sent them out looking like they had just experienced something they could not immediately explain, is evidence of a band that has found a way to make the intensity of their music legible to people who did not grow up with the genre.

Friday night belonged to a lot of artists. But at 8:05 PM, in the golden hour before the sun fully set, Turnstile owned the Outdoor Theatre in a way that felt permanent.

**Follow Turnstile on Instagram: [@turnstilehc](https://instagram.com/turnstilehc)**

[download:/assets/images/artists/turnstile-coachella-2026-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: turnstile-coachella-2026")
PYEOF


# ---- POST 15: tyler-chromakopia-2024 ----
echo "--- Updating: tyler-chromakopia-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/tyler-chromakopia-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/4V8LLVI7PbaPR0K2TGSxFF]

## The Evolution Continues

Every Tyler the Creator album since Flower Boy has represented a distinct creative identity, and CHROMAKOPIA continued that pattern with an ambition that somehow still managed to surprise. After the lush maximalism of CALL ME IF YOU GET LOST, Tyler pivoted again, delivering a record that felt both deeply personal and sonically adventurous in ways his audience had not anticipated.

CHROMAKOPIA arrived in October 2024 with almost no advance notice. Tyler announced it on a Monday morning and released it the following Friday. The approach was consistent with his history of controlling his own narrative: no industry rollout, no radio servicing, no months of pre-release positioning. The album arrived on its own terms and let the music speak before the commentary apparatus could organize itself around it.

## Sound as Architecture

CHROMAKOPIA operates like a built environment. The production choices are spatial, layered, and intentional in a way that rewards headphone listening. Tyler has always been a skilled producer, but this album demonstrated a maturity in arrangement that positioned him alongside artists working in entirely different traditions. The way he constructs sonic space, leaving room for silence, building tension through texture rather than volume, showed an artist thinking about music as a three-dimensional experience.

The drum programming across CHROMAKOPIA is among the most inventive of his career. The rhythms do not settle into patterns that can be easily anticipated, which keeps the listener in a state of active engagement rather than passive reception. The samples are used as atmosphere rather than as melody: textures that inform the emotional environment of a track without announcing themselves as reference points. Everything has been processed to sound like it exists inside the same space, which is the fundamental acoustic achievement of the record.

## Thematic Depth

The album grappled with themes of legacy, parenthood, and the weight of creative success with a directness that Tyler had previously approached only obliquely. There is a vulnerability on this record that feels earned rather than performed. When he addresses the complexities of growing into adulthood while maintaining the restless creative energy that defined his earlier work, the result is writing that resonates beyond its genre.

The announcement earlier in 2024 that Tyler had become a father gave the record's parental themes an immediacy that listeners processed in real time. The songs about what it means to be present, to inherit and to pass on, to carry the weight of what your parents gave you and decide what to do with it, landed differently knowing the biographical context. But the writing holds up without that context. The specificity of the emotional content is genuine rather than performative: these are not gestures toward themes but full engagements with them.

The tracks addressing his relationship with his own mother carry the heaviest emotional freight on the record. Tyler's willingness to sit with the complexity of that relationship, the love and the difficulty and the gratitude and the residual pain, without resolving it into a clean narrative, is the most artistically mature thing on an album full of mature choices.

## The Visual Identity

The visual identity of the album, the masked promotional imagery, the color palette, the accompanying short films, extended the thematic concerns into a complete artistic package. Tyler has always understood that an album is more than its tracklist, and CHROMAKOPIA represented his most cohesive vision to date.

The mask imagery in particular carried specific weight. The character of Igor, introduced on his 2019 album, had established Tyler's willingness to work through personae. The CHROMAKOPIA character is not Igor's successor but something different: a figure whose concealment is less about performance and more about the gap between public identity and interior life. The mask is not a disguise. It is the honest acknowledgment that what gets presented in public is always a mediated version of the person underneath.

## Critical and Commercial Reception

The album debuted at number one, continuing Tyler's streak of commercial relevance. But the more telling metric was the critical response. Publications that had spent years trying to categorize him finally seemed to accept that he operates outside conventional genre boundaries. CHROMAKOPIA was reviewed not as a hip-hop album or a pop album but as an artistic statement, which is exactly what it is.

The first-week numbers were significant not just for their size but for their composition: high pure sales figures alongside strong streaming, a combination that indicated a fanbase willing to pay for the music rather than simply consuming it passively. Tyler has cultivated that kind of commitment through years of treating his audience as participants in something rather than consumers of a product.

Tyler the Creator at this stage of his career is one of the most consistently inventive artists working in any genre. CHROMAKOPIA did nothing to challenge that assessment and everything to reinforce it.

[download:/assets/images/artists/tyler-chromakopia-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: tyler-chromakopia-2024")
PYEOF


echo "=== All 15 T-slug posts updated ==="
