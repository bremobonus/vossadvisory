#!/bin/bash
# ArtOnly Blog Expand Script
# Generated: 2026-06-11
# Task: Expand 15 blog posts to 1000-1400 words
# Run this on the DreamHost server via SSH

set -e
echo "=== ArtOnly Blog Expand: 2026-06-11-slugs ==="


# ---- POST 1: rick-owens-paris-2023 ----
echo "--- Updating: rick-owens-paris-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/rick-owens-paris-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:KsZOwn_PG24]
## The Aesthetics of Acceptance

Rick Owens has been designing clothes that look like the aftermath of something for approximately three decades. The drapes, the asymmetries, the palette that runs from black through grey to the occasional washed-out offwhite, a vocabulary so consistent and so internally coherent that it constitutes its own philosophy, a position on being in the world that fashion, as a medium, allows to be stated through material and cut and silhouette.

The position is something like this: the world is ending, has perhaps already ended in the relevant ways, and the appropriate response is not despair but a kind of resigned elegance. Dress as though the apocalypse has already happened and you have found a way to be beautiful in the rubble. Move through the world as though the normal rules of social legibility, the dress codes of professional life, the style rules of trend cycles, the expectation that clothing communicates aspiration toward something, no longer apply.

This is either a very dark philosophy or a very liberating one, possibly both. Owens's collections, season after season, develop it with the consistency of a designer who figured out early what he was saying and has committed to saying it as clearly as possible for as long as possible.

## The Autumn/Winter 2023 Show

The Paris show in October 2023 was called LUXOR and referenced ancient Egypt, the pyramid form, the treatment of death as architectural project, the specific quality of a civilization that built for eternity rather than for the market cycle. This is characteristic Owens territory: the grand historical reference that dignifies and contextualizes the contemporary moment without sentimentalizing the past.

The clothes were extraordinary in the way that his clothes are always extraordinary, technically difficult, requiring wearers who have accepted the terms of the Owens universe, not clothes that meet you where you are but clothes you grow into or don't. The leather, the structured drapes, the elevated footwear that has become as iconic as any element of his work, all of it deployed with the confidence of a designer who no longer needs to convince anyone of anything.

The show itself as event matters in a way that Owens has always understood. The staging, the casting, the music, these elements produce something that is more than a fashion show in the conventional sense. The shows are installations, performances, statements. The clothes are the text; the show is the context that makes the text legible.

## The Material Language

There is a specific education in how Owens uses material that does not announce itself but accumulates over time if you pay attention. The leathers in his work are not status signals in the conventional luxury sense. They are surfaces that age and mark and develop character. The drapes are not decorative; they redistribute weight, they change how a body moves through space, they make the act of walking a deliberate thing.

The silhouettes LUXOR pursued, elongated, layered, frequently bisymmetrical in ways that recall both Egyptian funerary dress and the specific visual language of archaic ritual, are not designed to flatter in the conventional sense. They are designed to transform. The wearer of Rick Owens is not presenting the body for approval; they are presenting it as a statement about what the body is and can be, which is a completely different act.

The footwear deserves separate attention. The platform boots and elevated creepers that have become signatures are not merely accessories. They change the physics of the body, the height, the gait, the relationship between the person and the floor. To wear them is to move differently. That choice, to alter movement rather than merely appearance, is the most precise indicator of what kind of designer Owens is.

## Who Wears This

I keep thinking about who wears Rick Owens and what that says about them. The customers are not a demographic in the usual sense, not unified by age or income or profession, though the price points are significant. They are unified by a sensibility: by a willingness to be visible in ways that conventional dress codes do not permit, by a comfort with being read as unusual, by a relationship to luxury that is about material and philosophy rather than status signaling.

There is genuine intellectual content in this clothing, genuine thinking about what a body should look like, about what clothing is for, about the relationship between individual presentation and collective aesthetic. This is not true of all fashion. It is true of Owens.

The customers who have been buying his work for twenty years are not fashion victims in any useful sense of the word. They are people who found a designer whose position on the world matched their own and committed to it. That kind of relationship between designer and customer is rare and it produces a loyalty that has nothing to do with trend cycles.

## LUXOR and the Architecture of Duration

The pyramid is, among other things, a statement about time. It was built to last. It was designed with the understanding that the civilization that built it would not last as long as the structure itself, that the architecture would outlive the architects, that permanence was the point.

Owens chose this reference at a specific moment, a moment when permanence feels increasingly unlikely and the market cycle moves faster than human attention can follow. The LUXOR collection lands differently read against that context. These are clothes designed for people who have stopped expecting the world to stabilize. The question is not whether the apocalypse is coming but how to dress for the period after.

The apocalypse he has been designing for has been approaching for a long time and getting closer. The people who have been wearing his clothes all this time have been practicing for something.

I have been thinking about what it means to dress for a version of the world that most people are still pretending is not coming. There is something practical in the Owens aesthetic beyond its philosophical claims, the durability of the materials, the construction that prioritizes function over trend, the clothes that are genuinely designed to last rather than to be replaced. This is fashion that takes the longer view.

LUXOR, as a collection, as a show, as a statement, it landed differently on me than his shows usually do. Something about the pyramid, the ancient context, the idea of building for eternity in a moment when eternity feels uncertain. I have been thinking about it since.

[download:/assets/images/artists/rick-owens-paris-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: rick-owens-paris-2023")
PYEOF


# ---- POST 2: rick-wade-detroit-2022 ----
echo "--- Updating: rick-wade-detroit-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/rick-wade-detroit-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/1HaiySQ7RMsuvfCEVML84p]

I keep coming back to this. I keep coming back to Rick Wade's records the way you return to a neighbourhood you grew up in, not because it has changed, but because you have, and suddenly you notice things you walked past a hundred times without seeing. Detroit techno has a mythology that is both well-documented and completely misunderstood. People know the names: Derrick May, Juan Atkins, Kevin Saunderson. People know the story of post-industrial collapse and the music that rose from it like something beautiful and severe out of the rubble. What people do not talk about enough, what I have been thinking about constantly, is the second wave, the artists who came after and carried the language forward without needing to announce what they were doing.

Rick Wade is one of those artists. He has been making music since the late 1980s and his output is staggering in the best way, prolific without being careless, consistent without being predictable. His tracks have this quality of arrived-at precision, like someone who is not trying to impress you because they are genuinely absorbed in what they are building. There is a Detroit release from 2021 that I have been listening to obsessively through the first months of 2022, and I find myself unable to explain to anyone exactly why it hits the way it does. It just does.

## The Sound of a City That Won't Let You Go

Detroit techno was always about contradiction. It was futuristic music made in a city that was being abandoned by its future. It was music built for the body that was doing something to the mind at the same time, something architectural, something insistent. Wade works in that tradition but he is not nostalgic about it. His basslines feel like they were just discovered, not inherited. The rhythmic construction on his recent work has this almost stubborn patience, things take their time arriving, and when they do, you feel like you have earned it.

What I find hardest to describe is the emotional register. People call this music cold. I have never understood that. Detroit techno is some of the most emotionally direct music I have encountered; it just does not bother with the signposts that tell you how to feel. There is no string section swelling to cue your sadness. There is a kick drum at 130 BPM and a bassline that seems to be coming from somewhere underneath the floor, and something in your chest responds to it in a way that predates language.

## Why the Second Wave Gets Written Out

Part of the reason Wade does not get the attention he deserves is the same reason that second-generation practitioners of anything tend to get written out of the founding story. It is tidier to have three names, a creation myth, a specific cultural moment. The messy truth is that musical lineages are alive, they continue, they branch and evolve through people who are doing the work without a publicist and without a retrospective exhibition at a cultural institution.

I think about the clubs that played this music in Detroit and Chicago and London, the sweaty underground rooms where Wade's records functioned exactly as designed, as total sonic environments, as spaces you could disappear into. There is something almost political about music that refuses prettiness, that insists on its own logic. Wade has been insisting on his for three decades and I do not think he is finished.

There is an interview I read where he talked about the experience of watching Detroit change, watching buildings come down and sometimes go back up, and how the city's relationship with its own history is complicated in ways that outsiders tend to flatten. He did not say his music was about that. He did not have to. You can hear it, not as illustration or metaphor, but as evidence. This is what it sounds like when someone has been in a place long enough to let it metabolise into something else entirely.

## The Architecture of a Wade Track

The structure of a Rick Wade track rewards close listening in a way that a lot of electronic music does not, because the interest is not in surface variation but in what happens when you hold the same elements in proximity for a long time. The compression choices are specific and deliberate. The way he layers a bassline against a hi-hat pattern against a chord stab creates a kind of grid that the rest of the music can push against, and the pushing is where everything interesting happens.

The mixing aesthetic is worth noting. Wade produces records that sound like they were made in a specific room, with a specific set of tools, by someone with a specific relationship to those tools. That quality, a tactile sense of a human being making decisions at a desk, is increasingly hard to find in electronic music that has been smoothed and polished until it could have been made anywhere by anyone. Wade's tracks have fingerprints on them. You can feel the hand.

The Detroit context matters here too. The city's sonic identity, shaped partly by the physical characteristics of the club spaces where the music was developed, produced music that is built for bass frequencies at volume. Wade's records demand good speakers. They reward being played loud. That is not a casual feature; it is the result of music that was developed in relationship to a specific listening context and has never lost that grounding.

## What Three Decades of Work Sounds Like

I keep putting on his records when I am alone late at night and finding that they do exactly what I need them to do, which is to be completely themselves. That is rarer than it sounds. The records do what they were always going to do, regardless of whether anyone pays attention. That independence from validation is part of what makes them trustworthy. Rick Wade has been making music without needing external permission for decades, and the music carries the confidence of that independence. I trust it completely.

The 2021 material sits in a line that goes back decades and forward to whenever he decides to make the next thing. The through line is not sonic consistency in a narrow sense; the music has evolved and the production has developed over thirty years of work. The through line is commitment to what the music is supposed to do. It is supposed to move you. It does. Every time.

[download:/assets/images/artists/rick-wade-detroit-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: rick-wade-detroit-2022")
PYEOF


# ---- POST 3: rirkrit-tiravanija-cook-2023 ----
echo "--- Updating: rirkrit-tiravanija-cook-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/rirkrit-tiravanija-cook-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[youtube:LQFJfAFIhyE]
## What the Curry Does

In 1992, Rirkrit Tiravanija cooked Thai curry in a gallery. He set up a camp stove in the back room of 303 Gallery in New York, cooked, and served it to whoever came in. The gallery was the kitchen. The artwork was the cooking. The art object, if there was one, was the pot, the smell, the conversation, the act of being fed.

This sounds simple. It is not simple. It is actually one of the more quietly radical propositions in contemporary art: that the artwork is not a thing but a situation, not an object to be contemplated but an experience to be lived, and that the experience of sharing food, of the hospitality that cooking represents, of the vulnerability and trust that eating together requires, is a legitimate artistic medium.

Tiravanija has been cooking in galleries and art spaces across the world for more than thirty years now. His practice has expanded to include other forms of social engagement, but the cooking remains central and has become one of the most discussed bodies of work in contemporary art, studied in every art school and debated extensively in critical literature. He received a significant retrospective recently that attempted to document what is fundamentally undocumentable, a practice that exists in its doing and resists the museum's impulse to preserve.

## The Problem of Documentation

How do you show work that is fundamentally about presence and participation in a context designed for contemplation? The retrospective's answer involved reconstructions, photographs, the original equipment, the pots, the stove, the table, presented as sculptural objects. These objects are interesting, but they are not the work. The work was the feeding.

This paradox goes to the heart of relational aesthetics, the theoretical framework that Nicolas Bourriaud developed in part to describe what Tiravanija and his contemporaries were doing. The claim was that the artwork was the relationship generated by the work, not the object that generated it. This was radical in art world terms and also genuinely difficult for the art market, which depends on objects that can be bought and sold.

Tiravanija's solution has been elegant: he sells the props, the stoves, the furniture, while the events themselves are given freely. The market gets its objects, the public gets the experience, and the distinction between them says something important about what we value. This three-decade experiment with art as hospitality has generated an enormous amount of critical writing but its most significant effect is probably simpler: a lot of people were fed, a lot of conversations happened, a lot of unexpected connections occurred in gallery spaces that are not usually designed for any of those things.

## The Social Turn and Its Discontents

The critical conversation around relational aesthetics was not without its skeptics, and the skepticism was worth taking seriously. Claire Bishop's intervention, published in response to Bourriaud and widely debated in the mid-2000s, raised the question of whether hospitality was sufficient as a political act, whether the comfortable social relations produced in a gallery context amounted to anything more than pleasantness, whether art needed to produce antagonism as well as harmony.

Tiravanija's work exists at the center of this debate without resolving it. The curry dinner is not a confrontation. It does not produce the kind of disruption that a more overtly political work might demand. What it produces is a softening of the boundaries that usually structure gallery experience, the hierarchy between artist and viewer, the silence, the reverence, the sense that art is something you receive rather than something you participate in. Whether that softening is transformative or merely pleasant depends on what you think transformation looks like.

The Thai cultural context of the food itself is a dimension that the relational aesthetics frame sometimes obscures. Tiravanija is Thai-born and Argentine-raised, and the food he cooks is specifically Thai, not a generic hospitality gesture but a culturally specific one. Bringing Thai food into the gallery, into 303 Gallery on Greene Street in 1992, was a specific act that carried specific meaning about who belongs in what spaces and whose hospitality is recognized as art.

## The Duration of a Practice

What remains after a performance, what the work leaves behind after the event, is one question that all time-based and relational art confronts. For Tiravanija the residue is partly material, the pots, the stove, the documentation, and partly relational, the memory of having eaten in a gallery, the relationships formed at his tables, the conversations that happened over the food.

But there is also a theoretical residue, a changed set of questions about what art is allowed to be, about where the line is between artmaking and cooking, between gallery and kitchen, between the aesthetic and the social. These questions have been asked more urgently and more widely because of his practice.

The thirty-year duration matters here. A single curry dinner in 1992 is an interesting proposition. Three decades of curry dinners, in galleries and museums and art fairs and public spaces across the world, in multiple countries and cultural contexts, constitutes something different: a sustained argument about the purpose of art and the relationship between artist and community that has accumulated enough evidence to be genuinely persuasive.

I keep coming back to the image of the curry on the stove in that New York back room in 1992. The simplicity of it. The radicalism of the simplicity. Thirty years later the conversation it started is still going.

The conversation his work started, about what art is and who it feeds and what the relationship between artist and audience can be, continues in every practice that has taken up the question of art as hospitality, as social practice, as something that requires participation rather than contemplation. That conversation is now part of the infrastructure of contemporary art. It came from a man cooking curry in a gallery in 1992.

The smell probably lingered. The best things do.

[download:/assets/images/artists/rirkrit-tiravanija-cook-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: rirkrit-tiravanija-cook-2023")
PYEOF


# ---- POST 4: sadeyes-2024 ----
echo "--- Updating: sadeyes-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sadeyes-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/5fj4oi7qHDoklvnnYmSBl0]

Some music is made for all hours and functions in all hours. Some music is made for specific hours and functions in those hours with a precision that is almost embarrassing to encounter at the wrong time. sadEyes makes music for 3am, and I mean that completely literally, not as a metaphor for a certain mood or emotional register, but as an acknowledgment that there is a specific quality of attention and openness that exists in the middle of the night, when the social defences are down and the mind is doing something looser and more honest than it does in the daylight hours, and this music has been calibrated for that specific state.

I found sadEyes through the algorithm, which I usually distrust but occasionally thank. The recommendation arrived late and I accepted it and put the music on and felt immediately that I was listening to something that understood the moment it was appearing in. The production is atmospheric in the specific sense of atmosphere as interior weather, not background music, not ambient in the sense of something designed to not be noticed, but something you are inside of, something that has its own climate.

The Vancouver connection again, something about that city, its particular relationship with rain and isolation and the vastness of the landscape that surrounds it, produces music that has these interior qualities. I have noticed this across several Vancouver artists and I do not think it is coincidental. Place gets into music.

## The 3am State

What happens at 3am, neurologically and psychologically, is that the cognitive resources devoted to social performance and self-presentation are reduced. You think things you would not think at noon. You feel things more directly, with less mediation. You are more honest with yourself than you are in the parts of the day when you have energy for self-deception. Music that addresses this state, that understands what it is like to be awake at that hour, by choice or by insomnia, in the particular mixture of clarity and fragility that defines it, is serving a real need.

sadEyes's music does not condescend to this state. It does not offer resolution or consolation. It offers company, the sense of something that understands without explaining, that sits with you in the night rather than trying to improve it. There are textures in the production that feel like rain on a window from the inside. There are melodies that loop in the way thoughts loop at 3am, returning to the same place from different directions.

## On Making Music for Specific Hours

Most music tries to be for all times. The more universal the appeal, the theory goes, the better the commercial outcome. But music that does not try to be universal, that accepts its own limitations and serves its specific purpose with complete commitment, can achieve something that universalist music misses, genuine intimacy with the listener who finds it at the right moment.

sadEyes is not for everyone at all times. It is for specific people at specific times, and at those times it is exactly right in a way that nothing else I have found is exactly right. I have encountered that quality rarely enough to find it remarkable when I do.

The 3am listeners know. And if you are not a 3am listener, you might not understand what this music is for, and that is fine, and also slightly sad.

## The Production Grammar of Nocturnal Music

The production grammar is worth noting because it is doing specific things that create the 3am effect. The reverbs are long. The space is large, larger than the sounds themselves, so the sounds seem to be floating in something bigger than they are. The tempos are slow enough that the music breathes at a different rate than daytime breathing, asking your own respiratory rhythm to adjust. These are not accidental effects. They are the result of someone who understands how sound creates psychological states and who has made specific choices to create a specific state.

The synthesis choices lean toward textures that blur at the edges. Clean sine waves would do the opposite of what this music is trying to do; they would impose clarity where the music is looking for the productive uncertainty of late-night consciousness. The synths sadEyes uses have weight and warmth and a slight imprecision that feels human rather than clinical.

The vocal processing is deliberate in the same way. The voice is present but it is not the dominant surface. It sits in the mix the way a thought sits in the 3am mind, audible and meaningful but not demanding your full attention in the way that daylight thinking demands it. You can follow the words or let them be texture. Both options are valid and both are accounted for in how the records are made.

## What the Music Is For

The state is nocturnal. The music knows exactly when it is for. That kind of precision, purpose matching execution, is what I come back to.

The 3am listener knows they are not alone when they find the right music. That is the deepest function of what sadEyes makes, not to resolve the loneliness of those hours but to make them feel inhabited, to put something in the room that understands. I have been grateful for it. Late at night, gratitude is sufficient.

There is something particular about music that is willing to be exactly what it is and nothing more. Most music reaches. Most music is aspirational in its self-presentation, trying to be heard by more people, trying to cross over, trying to be legible to ears that were not made for it. The music that refuses this tends to be the music that matters most to the people who find it. sadEyes is that kind of music. It is not reaching. It is waiting, in the dark, for the right hour.

[download:/assets/images/artists/sadeyes-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sadeyes-2024")
PYEOF


# ---- POST 5: sailorr-rawness-as-craft ----
echo "--- Updating: sailorr-rawness-as-craft ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sailorr-rawness-as-craft.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """## Pookie's Requiem and the Art of Emotional Risk

[img:/assets/images/artists/sailorr-rawness-as-craft.jpg]

Most viral tracks coast on the moment that made them spread. "Pookie's Requiem" does something different, the more time you spend with it, the more the chorus that caught everyone's attention starts to feel like a surface covering something more complicated underneath. SAILORR wrote a breakup song that is funny and furious and genuinely sad in the same breath, and the fact that it went viral probably undersells how well-constructed it is.

SAILORR is Kayla Le, a Vietnamese-American artist from Jacksonville, Florida, now signed to BuVision and Atlantic Music Group. Her debut mixtape From Florida's Finest landed in May 2025 and landed on Billboard's list of the best albums of the year so far. That is a debut. It is a strong case.

## The Anti-Gloss Aesthetic

Her sound draws from a range that tells you exactly what kind of artist she is: Lauryn Hill, Erykah Badu, Frank Ocean, Chief Keef. Those influences do not obviously belong together, but SAILORR makes them cohere. The production on tracks like "Down Bad" and "Sincerity" stays minimal and bruised, no unnecessary decoration, nothing added to make things easier to absorb. "Cut Up" hits harder because it earns it. "W1ll U L13?" turns a text-speak title into something that feels genuinely strange.

[spotify:artist/6ucHomyCWjxmvbyqAAbSci]

She identifies as queer and brings her Vietnamese heritage into her visual identity in ways that feel integrated rather than performed, including the black grills she wears as a nod to traditional Vietnamese teeth-blackening. These details matter because they are part of the same impulse that drives the music: an insistence on being specific rather than legible.

## What From Florida's Finest Actually Does

The mixtape format suited her well. The informality that the word mixtape still carries, even in a streaming context, gave her permission to be uneven, to try things, to put a Chief Keef-influenced track next to something that sounds like a private journal entry without having to justify the adjacency. The unevenness is intentional. It is part of how she shows you who she is.

The production choices across the project are consistently anti-glossy. Where a less confident artist might have reached for the polished sound that R&B streaming tends to reward, SAILORR and her collaborators kept the texture rough. The mix on several tracks sounds like it was made quickly and deliberately not fixed. That is a choice. A record that sounds expensive and buffed and perfect does not sound like it came from someone who has something urgent to say. Her records sound like they came from someone with something urgent to say.

The Lauryn Hill comparison is earned in a specific way that is worth being precise about. It is not about vocal similarity, though the technical ability is clear. It is about emotional directness. Hill's best work had a quality of burning honesty that felt almost uncomfortable, like you were hearing something that was not quite meant for you but was too real to look away from. Several moments on From Florida's Finest have that quality.

## The Specificity of Jacksonville

Florida has a specific cultural texture that tends to get flattened by outside perception. It is not just beaches and retirees and political dysfunction. It is a state with a particular music history, a particular Black cultural history, a particular relationship between Southern tradition and coastal cosmopolitanism. Jacksonville sits in the north of the state, close to Georgia, and that geography matters.

SAILORR does not wear Jacksonville as a badge in the way that some regional artists do, turning geography into brand. But the specificity is audible. There is a directness and a toughness in the music that comes from somewhere real, from growing up in a place that does not naturally produce the kind of mainstream R&B career arc that gets celebrated in industry coverage. She made a path that did not exist before she started walking it.

The Vietnamese heritage layered onto this Florida Black cultural context produces something that has no exact precedent. This is genuinely new territory, not because it is unprecedented to be Vietnamese-American and to make R&B, but because of the specific combination of influences, attitudes, and aesthetic choices that SAILORR has assembled into a coherent artistic identity.

## Building It Right

Billboard's R&B Rookie of the Month for February 2025. An NME cover. A Summer Walker feature. A Roblox tour stop. SAILORR is accumulating milestones without looking like she is chasing them, which is the hardest thing to pull off at this stage of a career. The music stays grounded because she is not making it to fill a space. She is making it to say something. That is still noticeable.

The emotional risk in the music is real. "Pookie's Requiem" is funny because grief is sometimes funny, because anger at someone you loved is sometimes absurd and pathetic and also completely serious at the same time. She does not resolve that tension. She lives in it, which is the only honest way to write about how relationships actually end.

That willingness to be uncomfortable, to be in the middle of something rather than narrating it from a safe distance, is the core of what SAILORR does. The rawness is not a lack of polish. It is the thing she is most carefully protecting.

[download:/assets/images/artists/sailorr-rawness-as-craft-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sailorr-rawness-as-craft")
PYEOF


# ---- POST 6: salamanda-dreams-as-reality ----
echo "--- Updating: salamanda-dreams-as-reality ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/salamanda-dreams-as-reality.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Salamanda is the South Korean ambient duo of Sala (Jimin Sung) and Manda (Yejin Jang), who met in 2018 and have since built one of the more quietly imaginative catalogues in contemporary electronic music. Their album ashbalkum, released in 2022 on Brooklyn label Human Pitch, takes its title from a Korean phrase describing the moment you realize what you have been experiencing as reality is actually a dream. The whole record operates inside that ambiguity.

What makes Salamanda distinct in the wider ambient field is texture. They work with modular synths, field recordings, and what sounds like a deep archive of vintage video game soundtracks and Studio Ghibli scores. Tracks like Open Sesame and Catching Tails have a chime-like clarity that feels less like a producer reaching for nostalgia and more like a producer reaching for memory itself. The sounds are familiar without being borrowed.

[spotify:artist/2ABEVwxsESCBsCBjN6qFru]

## Two Solo Practices, One Collaboration

Sala and Manda each have solo projects, Uman Therma and Yetsuby respectively, and the duo work feels like the place where their separate sensibilities resolve. Manda studied composition at university and brings a structural ear to the arrangements. Sala has no formal training and brings an instinctive openness to what a track can become. The combination produces music that is careful without being clean, where loose ends are part of the design.

Their 2023 album In Parallel pushed the project further into rhythm, leaning toward something closer to club music while keeping the dream logic of ashbalkum intact. It is the sort of move that risks losing the audience that came for ambient, but in their hands the shift reads as continuity rather than rupture. The rhythmic elements do not replace the textural ones; they give them something to lean against.

## The Korean Electronic Context

Salamanda emerged from a specific Seoul scene that has developed its own distinct sensibility, less driven by the European techno and ambient traditions that dominate critical conversation and more attentive to local music histories, to the sounds of Korean traditional instruments processed through contemporary electronics, to the particular acoustic character of Korean urban environments.

That context is audible in the music without being labelled. ashbalkum does not announce its Korean-ness as a brand or a selling point. It simply sounds like music made by people who grew up in a particular place with a particular relationship to sound and space. The field recordings that appear on the record ground it in a physical environment that is specific and real, even when the synthesis surrounding them is abstract.

Human Pitch, the Brooklyn label that released ashbalkum, has operated as one of the more interesting bridges between American experimental music and the broader international scene. The label's roster represents a genuinely global range of approaches to electronic and acoustic music, and Salamanda fit within it not as an exotic addition but as part of a coherent aesthetic argument about what contemporary experimental music sounds like when it stops centering European and American reference points.

## The Listening Practice

Ambient music asks something specific of the listener that most other music does not: a willingness to receive rather than pursue. This is harder than it sounds in an attention economy that constantly solicits active engagement. The music that Salamanda makes requires you to slow down your listening apparatus, to stop looking for hooks and progressions and the conventional markers of song structure, and to attend instead to texture and space and the very slow movement of sound through time.

ashbalkum rewards this kind of listening. The tracks have internal logic that becomes audible only after you have been inside them for a while, after your attention has adjusted to the tempo of the music rather than demanding that the music adjust to your tempo. That adjustment is itself an experience worth having; it changes the quality of attention and makes subsequent listening to almost anything more interesting.

The Studio Ghibli comparison that appears in several descriptions of the duo is worth examining. The Ghibli soundworld, associated primarily with composer Joe Hisaishi, uses orchestral and electronic elements to create spaces that feel emotionally real despite being fantastical in setting. The key is not the content of the fantasy but the seriousness with which the emotional logic is pursued. Salamanda takes a similar approach: the dreamlike surface is anchored by genuine emotional intent.

## The Wider Listenership

Salamanda has played Boiler Room, Le Guess Who, and a steady run of European festivals, and their NTS guest mixes have become a reliable index of what is interesting in contemporary leftfield electronic music. The Korean Music Awards nominated ashbalkum for best electronic album. The recognition matches the work.

There is a particular kind of credibility that accrues to artists who are discovered by audiences in multiple continents simultaneously rather than being pushed through a single market's infrastructure. Salamanda has that credibility. Their audience assembled laterally, through recommendation and sharing and the specific networks that trade in music that is genuinely unusual, and the result is a listenership that is geographically distributed but coherent in its sensibility.

In Parallel confirmed that the first album was not a one-off. The project has a direction and the direction is genuinely interesting. Whatever they make next, the frame they have built around their work, the careful attention to texture, the willingness to move between stillness and rhythm, the insistence on the specific emotional logic of each track, is solid enough to support further development.

[download:/assets/images/artists/salamanda-dreams-as-reality-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: salamanda-dreams-as-reality")
PYEOF


# ---- POST 7: samara-cyn-backroads-2025 ----
echo "--- Updating: samara-cyn-backroads-2025 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/samara-cyn-backroads-2025.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:album/1QTsmNuksjnolTFQIThil9]

## The Quiet Ones Always Know Something

Samara Cyn does not announce herself. There is no moment on Backroads where she stops the record to demand your attention. She assumes you are already paying it, and she proceeds accordingly. That confidence, the kind that does not need to perform itself, is what separates Backroads from the crowded field of R&B-adjacent records that arrived in 2025 hoping to be described as cinematic.

Backroads is cinematic. But that is almost beside the point. What it actually is, is specific. Cyn is a Los Angeles artist who came up through the city's DIY underground, releasing EPs that circulated mostly through word of mouth and found her a devoted following before any algorithm touched her name. Backroads is her debut album proper, and it functions like the work of someone who has been waiting patiently for the right moment to say everything she has been thinking about.

## Geography as Feeling

The album is named for the routes you take when you do not want to arrive yet, when the destination is real but the road is better. That tension between movement and arrival structures every song here. Cyn writes about relationships and autonomy and the specific disorientation of being a young Black woman in a city that wants to use your image more than it wants to hear your voice. She writes about this without explaining it. The scenes are just present, detailed, and true.

On Low Tide, she describes a conversation that happens at the wrong hour: you already know how it ends but you let it happen anyway because the alternative is silence. On the production, spare keys, a bass that moves like a question, there is nowhere to hide. The arrangement makes honesty feel like the only option.

Soft Landing features a guitar figure that sounds like something picked up in a thrift store on Fairfax and turned into something entirely new. Cyn's vocal sits above it without effort, which is its own kind of effort, the kind that takes years of practice to make invisible.

## Not Confessional, Observational

The term confessional gets applied to any record by a woman that discusses emotion. Backroads is not confessional. Cyn is not confessing anything. She is observing, herself, the people around her, the city, the light at certain hours. The distinction matters because confession implies guilt and absolution, while observation implies understanding. Cyn is not asking for anything. She is telling you what she sees.

That posture makes Backroads formally interesting. The songs do not build to catharsis. They build to clarity, which is rarer and more useful. By the time the album closes on Wayward, you do not feel emotionally drained. You feel like someone turned on a light in a room you had been navigating in the dark.

## The DIY Underground That Made Her

Los Angeles has had a specific infrastructure for independent R&B and soul-adjacent music for several years now, a network of house shows and small venues and independently organized listening sessions that has produced artists whose sound is shaped by proximity to each other rather than proximity to industry. Cyn came up through this network, and the record reflects that formation.

What the DIY context gives an artist is time. Not the time pressure of a label deal or a release schedule or a publicist's calendar, but the time to develop songs in front of actual people, to understand what works and what does not in a room rather than in a spreadsheet. Backroads has the sound of songs that have been tested, that know their own edges, that have been performed often enough to stop performing and start being.

The production values on the album are not lo-fi in any defensive sense. The record sounds exactly as expensive as it needed to be, which is to say: not very, because the arrangements are so precisely conceived that they do not need to be buffed. The sparseness is a decision, not a limitation. Every element that is present is present because Cyn and her collaborators decided it needed to be there.

## An Album That Earns Its Length

At eleven tracks, Backroads does not overstay. Every song is doing something distinct. There are no filler moments, no tracks that exist to hit a streaming length threshold. That kind of editorial discipline is increasingly uncommon, and in Cyn's case it reads as a statement about what she values: precision over padding, clarity over volume.

The sequencing deserves attention because it is doing real work. The album does not front-load its strongest material in the way that streaming-era records often do, trying to capture listeners before they navigate away. It trusts that if you arrive for the first song you will stay for the last, because each song earns the next one. That is a kind of structural confidence that most debut albums cannot afford and Backroads has it entirely.

Samara Cyn is twenty-four years old. Backroads sounds like the work of someone who understood early that the most powerful thing you can do is say exactly what you mean and trust that the right people will hear it. The right people will hear this.

[download:/assets/images/artists/samara-cyn-backroads-2025-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: samara-cyn-backroads-2025")
PYEOF


# ---- POST 8: samara-cyn-detour-as-destination ----
echo "--- Updating: samara-cyn-detour-as-destination ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/samara-cyn-detour-as-destination.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Samara Cyn raps with the patience of someone who has nothing to prove and everything to say. The Compton-raised, Atlanta-based artist released her second EP BACKROADS in June 2025, the kind of project that announced itself quietly and then did not stop circulating, and followed it in March 2026 with DETOUR, a seven-track set that takes the same instinct and pushes it harder.

[spotify:artist/4nqQTosM2Mbg7iRjvJU0N0]

She is comfortable between hip-hop, R&B and the kind of pop that does not announce itself as pop. "Brand New Teeth" with Smino was the BACKROADS centerpiece, all warm beat and unhurried delivery. On DETOUR she goes further. "oooshxt!" rides a tumbling bass and a siren that should not work and somehow does. "BUSHWICK," with Ovrkast on the boards, contains the boast you would expect from the title without the cliche you would also expect.

## The thesis

[img:/assets/images/artists/samara-cyn-detour-as-destination.jpg]

"Highest" is the most vulnerable track she has put out and the best argument for what makes her work different from the alt-rap field. "Good is A LIE" is a soulful funk thing she pulls off without breaking the EP's tone. "FREE" opens the project with a statement of intent. "over influence" closes it with the kind of restraint that takes years to develop. The whole EP runs nineteen minutes and never wastes a bar.

## What Separates Her

What she is doing is uncommon. The production is experimental without being self-conscious about it. The lyricism is plainspoken without being plain. The voice does not sound like anybody else's voice. There are rappers with bigger numbers right now who would benefit from listening to how Samara Cyn paces a verse.

The Smino collaboration was not coincidental. She operates in an ecosystem of artists who are making Black American music that resists categorization without making that resistance a selling point. The underground credibility that surrounds her name comes from the music itself, from the specificity of the songwriting and the consistency of the aesthetic across projects that are formally different from each other.

BACKROADS established a mood. DETOUR refined it and then tested it. The two projects together describe an artist who understands that the route matters as much as the destination, that the oblique approach to a subject can be more direct than the frontal one, that what you choose not to say shapes the meaning of what you do say.

## The Compton to Atlanta Geography

The biographical geography here is worth attending to. Compton carries a specific weight in American music, a specific set of associations about hardness and ambition and the particular kind of West Coast rap that emerged from those streets. Atlanta carries a different weight, a different tradition of sound and attitude. Samara Cyn absorbed both and synthesized neither in a way that announces itself.

What you hear instead is a sensibility that knows those traditions intimately enough to be influenced by them without being contained by them. The restraint in her delivery has nothing to do with West Coast rap's typical templates. The melodic flexibility has nothing to do with Atlanta's dominant modes. She sounds like herself, which sounds like where she is from and also not like anywhere.

The production choices on both projects reflect this. The beats she gravitates toward have texture and surprise without being maximalist. They leave room for the voice, which means they trust the voice, which means the producers she works with understand what she is doing and share the instinct to not overwhelm it.

## Nineteen Minutes and Nothing Wasted

DETOUR is not the project that breaks her. It is the one that confirms she does not need a break. She is already there, and she got there by deciding the scenic route was the route.

The nineteen-minute runtime is a statement. EP as format has been degraded somewhat by artists who use it as a vehicle for a single surrounded by filler. DETOUR is seven tracks that each do something distinct and together make a coherent argument. The sequencing from "FREE" through to "over influence" is deliberate, moving from statement to vulnerability to restraint in a way that mirrors the record's thesis about what it means to be over-influenced and then past it.

Start with "oooshxt!", then "Highest", then BACKROADS top to bottom.

Allastair Voss

[download:/assets/images/artists/samara-cyn-detour-as-destination-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: samara-cyn-detour-as-destination")
PYEOF


# ---- POST 9: sampha-return-2023 ----
echo "--- Updating: sampha-return-2023 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sampha-return-2023.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/2WoVwexZuODvclzULjPQtm]

## Six Years Is a Long Time

I remember where I was when Process came out. I know that sounds like the kind of thing people say about records that changed their life, and I am saying it precisely because of that, because Sampha's debut felt like an event in the quietest possible way, a record that did not announce itself but arrived and then refused to leave. And then he went away. For six years, or close to it, he was almost entirely absent from music. When Lahai appeared in late 2023 I felt something that surprised me: not excitement exactly, but relief.

Lahai is named for Sampha's grandfather. It is an album about grief and fatherhood and continuity, about the way the dead stay present in the living. These are enormous themes and Sampha handles them with a lightness that should not work but does, a gentleness that keeps the weight of the material from becoming crushing. He has that ability, very rare in any artist, to make intimacy feel like an achievement rather than an exposure.

The production here has expanded. There are strings, electronics, rhythmic structures that reference West African music, his parents are Sierra Leonean and that lineage is more explicitly present here than on Process. But the expansion never crowds out the essential quality, which is Sampha's voice. It remains one of the more astonishing instruments in contemporary music: technically precise, emotionally unguarded, capable of suggesting an entire interiority in a single phrase.

## What Grief Does to Music

Process was haunted by his mother's death. Lahai is haunted differently, by fatherhood, by new life, by the way becoming a parent puts you in conversation with all the generations before you. There is a track here that moves me every time I hear it, where the piano part feels like it is being played in a room adjacent to sorrow rather than inside it. That kind of emotional adjacency, not wallowing, not avoiding, just being near the feeling, is extraordinarily difficult to achieve and Sampha does it almost casually.

I do think about the six years. Artists disappear for all kinds of reasons, grief, creative block, the simple desire to live a life outside of public scrutiny. Sampha's absence never felt like withdrawal in a dramatic sense; he was occasionally mentioned, occasionally collaborated, just was not making his own work visible. The return does not feel triumphant. It feels considered. Like he needed to become the person who could make this particular record before he could make it.

There is a lesson in there somewhere about the relationship between living and making, though I am wary of making it too tidy. Artists are not obligated to produce. The time between things is its own kind of work. What Lahai suggests is that the distance was purposeful, that something accumulated in those years that could not have been forced into existence any sooner.

## The Sierra Leonean Dimension

The West African musical inheritance on Lahai is not decorative. The rhythmic structures that appear across the album, the polyrhythmic percussion patterns, the specific way certain melodic lines move against the beat, these are not applied as colour. They are structural. They change how the songs work, how they breathe, what the voice is asked to do within them.

This is a choice that requires confidence. There is a long and depressing history of Western pop artists incorporating non-Western musical elements in ways that are superficial and extractive, borrowing surface without engaging with depth. Sampha does the opposite. The Sierra Leonean elements on Lahai come from a personal inheritance rather than a curatorial impulse, and the difference is audible. The music feels like something he grew up around rather than something he researched.

The title Lahai is a Sierra Leonean name. The album's dedication to his grandfather makes explicit what the music implies: that this is an album about inheritance, about the specific things that pass from generation to generation that are not objects and not knowledge but something harder to name, a way of being in the world, a quality of presence, the shape of a hand on a piano key.

## The Quiet Ones

Sampha occupies an interesting position in contemporary British music, beloved by other musicians, critically revered, but not quite a mainstream presence in the way that other artists of his calibre might be. He does not have the crossover obviousness of some of his peers. He exists in a space that requires a certain kind of listening, a willingness to sit with something that unfolds slowly.

I keep thinking about the fact that he played piano on Saint Pablo. That Drake called him for features. That his vocal credit appears across a decade of music that would not be what it is without him. And yet the solo work is so much more interior than any of that suggests, so much more concerned with the private rather than the public, the personal rather than the spectacular.

Running into an old friend is the right metaphor, I think. You pick up where you left off, and realize the time away does not diminish anything. It might have deepened it.

## Why the Return Was Worth Waiting For

Lahai will settle into Sampha's discography as the record that proved the return was worth waiting for, that the silence was not stasis but development, that the person who came back was capable of something the earlier work could not have made. That is the best possible outcome for an extended absence. That is what happened.

The old friend, encountered again. The time away present in how you greet each other, in what has changed and what has not. The conversation picking up somewhere you did not expect but recognizing immediately as right.

[download:/assets/images/artists/sampha-return-2023-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sampha-return-2023")
PYEOF


# ---- POST 10: sasha-keable-act-ii ----
echo "--- Updating: sasha-keable-act-ii ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sasha-keable-act-ii.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/7MxGWmiAbqjNOGmj23wbWf]

The UK R&B resurgence of the last several years has produced a wave of artists who are genuinely excellent and a critical apparatus that keeps describing them as if they all sound the same. Sasha Keable does not sound the same. Her voice has a texture that is immediately recognizable, slightly rough at the edges in a way that is not accidental, not affected, but the result of singing from inside the song rather than above it. ACT II, released February 6 on Flight Club Records, is the record that makes the case that she is one of the more important voices in contemporary UK soul, and it makes that case without once raising its voice to do so.

## What act right Does in the First Thirty Seconds

The single act right opens with a deliberate quiet, not an intro, exactly, but a breath before the rhythm drops. What follows is a track that understands something most UK R&B does not: that restraint is a form of authority. Keable does not belt. She does not chase the big moment. She sings the way someone talks to you when they know they are right and they are not interested in proving it. The lyric is direct without being blunt, and the production around it, warm, groove-centered, not overly arranged, gives her voice the room it needs to do what it does.

The act right video, which hit 765,000 views on YouTube and counting, frames her in a visual language that matches the music exactly: cinematic, unhurried, with a sense of drama that never tips into melodrama.

## ACT II as a Full Statement

[youtube:euuJ58oK5VE]

The twelve tracks on ACT II operate as a complete world. Tell Me What You Want, nobody, TAI CHI, heal something, each one moves at its own pace but they share a tonal coherence that is difficult to achieve and easy to feel. This is an EP that thinks like an album, that understands sequencing and arc and the way music can mean different things at different times of day.

Flight Club Records, her label, has operated quietly on the margins of what the UK industry considers commercially relevant. That positioning has, paradoxically, given Keable the creative space to make music that sounds like a long-term project rather than a calculated career move. ACT II follows her 2025 EP act right, and the growth between the two projects is real: in confidence, in arrangement sophistication, in the clarity of her artistic voice.

## What the Voice Carries

The comparison that keeps getting made for Sasha Keable lands somewhere in the vicinity of Jorja Smith, Little Simz's more melodic collaborators, or the broader ecosystem that emerged from the Brixton and South London soul tradition. These comparisons are not wrong, exactly, but they are not sufficient. Keable's sound has a specificity that resists easy placement. There is something in her phrasing that sits closer to classic American soul than most of her UK contemporaries, while remaining distinctly British in its emotional register. The songs are about real things, told in the first person, without euphemism.

What her voice does is carry weight without pushing. This is the thing that is hardest to describe and most immediately obvious when you hear it. The phrasing on TAI CHI, particularly in the verses, has a patience that suggests someone who learned from singers who understood that the emotion is in the breath before the note as much as in the note itself. There is a lineage in how she holds a phrase that goes back to the kind of gospel and soul training that shapes a voice differently than contemporary vocal coaching does.

## The Arrangements and What They Prioritize

The production on ACT II is worth examining separately because it is making choices that amplify the voice's qualities rather than competing with them. The arrangements are warm and groove-centered without being busy. The instrumentation generally leaves space in the mid-range where her voice lives, which means there is always room for the voice to land without fighting anything.

This kind of arrangement intelligence is not common. The instinct in contemporary R&B production often runs toward density, toward stacking elements until the track feels full. Keable and her collaborators did the opposite. The tracks on ACT II feel spacious, which makes them feel more intimate, which is the correct outcome for music this personal in its register.

The twelve-track runtime at its best creates the sense of a complete world. heal something in particular demonstrates what the arrangements can do when given a subject with sufficient emotional weight: the production strips back to almost nothing and lets the voice carry everything, and the voice is capable of carrying it.

## Why It Matters That She Did Not Announce

In an R&B landscape that sometimes feels saturated with surface polish, ACT II is unusual in what it asks of you. Not much, on the surface. But it stays. You find yourself thinking about it later, the way you think about a conversation that hit differently than you expected. That is the thing Sasha Keable is very good at: making music that sounds casual and lands permanent.

The lack of announcement is itself a statement. She is not performing ambition. She is demonstrating it through the quality of the work, track after track, arrangement after arrangement, phrase after phrase. That is the kind of statement that takes time to make and a certain confidence to attempt.

[download:/assets/images/artists/sasha-keable-act-ii-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sasha-keable-act-ii")
PYEOF


# ---- POST 11: sault-acts-of-faith-2022 ----
echo "--- Updating: sault-acts-of-faith-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sault-acts-of-faith-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/1uRxRKC7d9zwYGSRflTKDR]

## The Politics of Disappearance

SAULT operates differently from almost every other working artist. The anonymous British collective, whose central identity seems to be the producer Inflo, though membership and personnel remain deliberately opaque, has made a practice of releasing records and then removing them from streaming platforms. The disappearance is part of the work. The limitation is part of the statement. In an era when music's primary value proposition is ubiquitous availability, making music that insists on its own scarcity is a radical act.

Airs (Acts of Faith in the Radical Spirit of Unity and Love) was released in 2022 with a 99-day streaming window, available for a defined period and then gone. I heard it during those 99 days and then heard it differently after it disappeared, because suddenly the memory of the sound was all I had. That relationship to music, a relationship that involves active engagement rather than passive access, that requires memory and attention rather than the assumption of perpetual availability, felt important and slightly alien in ways I am still processing.

The music itself. Let me talk about the music. SAULT has been making some of the more substantive Black British music of the past five years, albums that draw from gospel, soul, funk, Afrobeat, and the London sound, which has always been a multiply-sourced, globally influenced thing, in ways that feel historically aware without being historicist. The references are alive, not museified.

## Faith and Music

Airs is the most explicitly spiritual SAULT record. The gospel influence, always present in their work, is foregrounded here, there are choral arrangements, testimonial lyric forms, a sense of music as communal and sacred act rather than commodity or entertainment. This is not unusual in Black music, where the sacred and secular have always been in conversation. But it is unusual in the contemporary British music context, where religion is treated with a certain embarrassment, a certain secular hesitancy.

SAULT does not share that embarrassment. The faith in this music is direct and unironic, and the effect is, even for a secular listener, even for someone whose relationship to faith is complicated, genuinely moving. There is something about encountering sincerity on this scale that breaks through the ironic distance of contemporary culture. You are not being asked to believe. You are being invited to feel what belief feels like from inside. That is different.

Inflo's production is immaculate, warm, spacious, historically intelligent, technically accomplished without calling attention to its accomplishment. The arrangements on Airs suggest a producer who has heard everything and chosen, with considerable care, exactly what the songs need. Nothing superfluous. Nothing under-considered.

## The Inflo Question

The anonymity that surrounds SAULT as a project raises questions that are worth sitting with rather than dismissing. In an industry that is built around celebrity and personal brand, the refusal to be known is not neutral. It redirects attention from the person to the work, which is a philosophical position that most artists claim but few actually inhabit.

Inflo's production credits outside SAULT, with Coldplay, with Little Simz on the award-winning Sometimes I Might Be Introvert, with Michael Kiwanuka, are a kind of argument for what the anonymity achieves. You hear those records and you hear a production sensibility that is coherent and distinctive without announcing itself. The same ear is present on the SAULT records, but untethered from any expectation about who Inflo is supposed to be, what his story is, how his biography should colour your reception of the music.

The collective structure extends this logic. By making membership opaque, by refusing to name who is singing on which track or who played which instrument, SAULT makes the music communal in a formal sense as well as a thematic one. This is music that presents itself as belonging to everyone who made it, without hierarchy, without individual credit extraction.

## What Scarcity Teaches

I have thought a lot about whether the disappearing-album strategy is a gimmick or a genuine artistic decision. I keep landing in the same place: it does not matter which it is if the effect is real. And the effect is real. Having listened to something you know will be gone changes how you listen. The attention is different. The memory formation is different. You are not just receiving the music; you are doing something with it while you still can.

In a culture of infinite access, this is a gift. The 99-day window forces a relationship to music that streaming otherwise makes impossible. You have to decide if this matters enough to listen to now, today, before it goes. That decision is itself a form of engagement that most music no longer requires.

Airs mattered to me during those 99 days more than most records I have unlimited access to. That is either evidence for SAULT's strategy or evidence against my own relationship to abundance. Probably both.

## After the Window

Airs is gone from streaming in the way that SAULT intended. The 99 days are over. The record exists in memory and in whatever copies were made during the window, and in the discussion of what it was, which is itself a form of the record's life, a continuation of its existence in a different medium.

The scarcity that was enforced taught something about what availability costs. When everything is accessible always, nothing demands your full attention in the moment. SAULT forced the moment. The 99 days were the point.

The lesson is worth keeping. Whether the music is currently accessible or not, the argument it made remains. And the faith in that music, the unironic gospel, the communal spirit, the Afrobeat-inflected funk that sits underneath the choral arrangements, all of it persists as a memory of something that required presence to receive. That is exactly what SAULT intended.

[download:/assets/images/artists/sault-acts-of-faith-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sault-acts-of-faith-2022")
PYEOF


# ---- POST 12: sega-bodega-harold ----
echo "--- Updating: sega-bodega-harold ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """## Salvador Navarrete and the Architecture of Noise

Sega Bodega is the project of Salvador Navarrete, a London-based producer, visual artist, and designer whose reputation was built largely behind the scenes, producing for Shygirl, working within the extended network of artists connected to Dazed and the harder edge of UK club culture, before Harold arrived in 2022 and reframed everything.

Harold is not an easy record. It does not offer obvious entry points. It begins mid-thought and ends mid-sentence, and the spaces between tracks feel less like breaks and more like the sound pressure dropping before something lands. To ask "who is Harold" is to ask the right question and expect no clean answer.

## The Album as Character Study

Harold is a name, a character, a mood, something between a self-portrait and a person Navarrete invented to carry the weight the music needed. The record operates like a psychological document: tracks like Mandy and PDA move through tenderness and aggression without ever settling, the production simultaneously polished and corroded, vocals processed until they are more sensation than speech.

[spotify:artist/3grjqo0Frpf2okIBiifM1P]

What makes Harold work is the discipline underneath the apparent chaos. Every abrasive texture, every wall of distorted sound, serves a compositional purpose. Navarrete understands that maximalism is not the same as excess, the album is dense but never bloated, confrontational but never gratuitous.

## Production Language

The sonic vocabulary of Harold draws from industrial music, from the harder end of UK club, from hyperpop's willingness to overload the signal, but it does not sit comfortably inside any of those categories. Navarrete's production is tactile in a way that is rare: you can feel the bass frequencies physically, and the high-end processing creates a kind of tinnitus shimmer that stays with you after the music stops.

His collaboration with Shygirl across multiple projects, she features here, represents one of the most interesting creative partnerships in contemporary underground music. Both artists operate at the intersection of club functionality and avant-garde formal experiment, and their instincts for when to push and when to pull back are closely aligned. The Shygirl feature on Harold lands as a genuine duet rather than a cameo, two sensibilities that fit together precisely because they both know where the edges of the sound are.

The NUXXE collective context is part of what produced the conditions for Harold. The network of mutual influence between Navarrete, Shygirl, Oklou, and Coucou Chloe created an aesthetic ecosystem that allowed each artist to push further than they might have alone, because the work was being made in dialogue with peers who understood the shared project. Harold is a product of that dialogue as much as it is a product of Navarrete's individual sensibility.

## The Visual Dimension

Navarrete is a designer and visual artist as well as a producer, and Harold reflects that. The record's aesthetic, stark, high-contrast, deliberately uncomfortable, extends beyond the music into artwork, video, and live presentation. The project exists as a complete object, not just an audio release. That coherence of vision is increasingly rare and makes Harold feel like a statement rather than a debut.

The visual language Harold occupies is connected to a strand of contemporary design and art that uses discomfort as an aesthetic value, that treats the viewer or listener's unease as information rather than as a problem to be resolved. The album cover and accompanying visuals do not offer comfort or clarity. They are part of the same project as the music: the project of documenting Harold, whoever and whatever Harold is.

## Where Tenderness Lives in Difficult Music

The underrated thing about Harold is how tender it is underneath the noise. The processing and distortion that coat the surface of the record are not a barrier to emotion; they are the form the emotion takes. Several tracks, particularly the quieter ones that appear mid-album, have a quality of exposure that the more aggressive material actually protects. The noise is armor. When it drops away, the vulnerability underneath is more legible for having been surrounded by all that sound.

This is a sophisticated formal choice. Difficult music that has nothing underneath the difficulty is merely difficult. Harold earns its abrasiveness because what it is protecting is real and specific and genuinely moving when you find it.

## Why It Matters

Harold arrived at a moment when a lot of underground music was becoming legible, absorbing influence quickly, smoothing out the edges, finding forms that worked for streaming playlists and algorithmic discovery. Harold did the opposite. It got harder to parse the more time you spent with it, more specific in its emotional coordinates, less interested in meeting the listener halfway.

For that reason alone it deserves the attention it received, and continues to receive from producers, DJs, and artists trying to understand how a record can be this precise and this destabilizing at the same time.

Harold is not for everyone. It is, however, exactly what it set out to be.

[download:/assets/images/artists/sega-bodega-harold-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sega-bodega-harold")
PYEOF


# ---- POST 13: sega-bodega-harold-2022 ----
echo "--- Updating: sega-bodega-harold-2022 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold-2022.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """Pop music made by producers who are also artists is a different thing than pop music made by producers who stay behind the glass. Sega Bodega understands this distinction viscerally, his work as a solo artist strips out the professional distance and replaces it with something that can feel almost uncomfortably exposed.

[spotify:artist/1ZvF4Sgnre3Rk2CpiNy077]

Henry Earnest Dodd, who records as Sega Bodega, is a London producer who built his reputation working with some of the most forward-thinking artists in contemporary pop: SOPHIE, FKA twigs, Shygirl, Caroline Polachek, Oklou. He is part of the NUXXE collective alongside Shygirl, Oklou and Coucou Chloe, which is the most coherent aesthetic micro-scene to have emerged from UK club culture in the last decade.

His 2022 album harold is a remarkable piece of work. It sounds like someone who has spent years making excellent records for other people and then finally sat down to make one entirely for themselves, and found that the thing they wanted to make was bruised, melodic, structurally unpredictable, and covered in distortion. It is a pop album that keeps refusing to be a pop album, which is exactly what makes it so good.

## The Problem of Making Your Own Record

There is a specific challenge that faces a producer of Dodd's caliber when they turn their attention to their own work. The same skills that make them essential to other artists, the ability to hear what a song needs and give it exactly that, can become a liability when the song is your own and you are both the person who needs something and the person deciding what to provide. The temptation is to serve the music in the detached professional way rather than to be in it.

harold sidesteps this problem by refusing to be polished in the way a service-provider mindset would produce. The record has rough edges that Dodd's work for other artists rarely has. Tracks like "Cuckoo" and "Hungry Hands" operate in that space between intimacy and disintegration that the best post-PC Music production has always occupied. There is a directness to the songwriting that his producer work does not always show, he is vulnerable here in a way that does not feel performed.

The production does not overwhelm the emotion, which for a producer of his technical capability represents a genuine act of restraint. Everything is in service of the feeling, not the other way around. That discipline on his own record takes real effort.

## The NUXXE Context

The collective context matters for understanding what harold is. NUXXE, as a loose affiliation of artists and producers, developed a shared aesthetic sensibility through years of mutual collaboration and influence. The sound that Shygirl and Oklou and Coucou Chloe and Sega Bodega collectively occupy, club-adjacent, formally experimental, emotionally direct despite the surface abstraction, is not any one person's invention.

harold is Dodd's most personal contribution to that shared language. Where his production for other artists speaks their voice with his sensibility behind it, harold speaks his voice directly. The accumulated listening that went into developing the NUXXE aesthetic is audible in every production choice, but the emotional content is unmediated by anyone else's concerns.

The SOPHIE influence is present and acknowledged. The willingness to treat the voice as a material to be processed rather than a precious thing to be preserved, the interest in the uncanny valley between human and machine sound, the use of pop structure as a frame that the actual content can push against: these are things the NUXXE artists absorbed from a specific lineage that SOPHIE extended. harold is part of that ongoing conversation.

## What Distortion Does

The distortion on harold is not a style choice in the superficial sense. It is a way of representing an emotional state. Distortion in audio terms is what happens when you push signal past what the system can cleanly handle. As a metaphor for a psychological state, for having too much feeling for the normal channels to contain, it is precise in a way that the use of the word vulnerable in music criticism rarely captures.

Dodd uses distortion the way a photographer uses shallow depth of field: to focus attention on a specific thing by blurring everything around it. The abrasive textures that surround the more melodic and exposed moments on the album make those moments land harder, make the tenderness more legible by contrast.

This is not a new technique. It is the relationship between noise and quiet that all music that uses distortion is navigating. What harold does with it is specific enough and consistent enough to constitute an aesthetic argument.

## After harold

He has been relatively quiet since harold, but the work he has done for other artists in that time has only confirmed that his ear is one of the sharpest in any room. The Caroline Polachek collaborations in particular demonstrated a capacity to serve a musical vision very different from his own with the same precision he brings to everything.

When the next album comes, the anticipation it carries will be specific: not the generic excitement that surrounds any credible artist's next project, but the specific interest in what a producer of this intelligence does when he turns inward again, what the next version of harold sounds like.

Pay attention.

[download:/assets/images/artists/sega-bodega-harold-2022-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: sega-bodega-harold-2022")
PYEOF


# ---- POST 14: serpentwithfeet-deacon-gospel ----
echo "--- Checking word count: serpentwithfeet-deacon-gospel ---"
python3 << 'PYEOF'
import json, re

path = "/home/dh_yadmw3/artonly.io/posts/serpentwithfeet-deacon-gospel.json"
with open(path) as f:
    d = json.load(f)

body = d["body"]
# Remove embed tags
body_clean = re.sub(r'\[[^\]]+\]', '', body)
words = len(body_clean.split())
print(f"serpentwithfeet-deacon-gospel word count: {words}")
if words >= 1000:
    print("SKIP: already >= 1000 words")
else:
    print("NEEDS EXPANSION")
PYEOF


# ---- POST 15: seun-kuti-2024 ----
echo "--- Updating: seun-kuti-2024 ---"
python3 << 'PYEOF'
import json

path = "/home/dh_yadmw3/artonly.io/posts/seun-kuti-2024.json"
with open(path) as f:
    d = json.load(f)

d["body"] = """[spotify:artist/6rKUtTPAvqDFvZQYz28WEY]

There is a specific kind of pressure that children of great artists carry, and it is different from ordinary pressure because it is public and permanent and attached to a name that does not belong only to them. Fela Kuti is not just a father; he is a cultural monument, a political symbol, a musical innovator whose influence on African music and on the global understanding of what music can do politically is genuinely without parallel. Being Fela's son and making music is a condition that could easily consume a lesser character. Seun Kuti is not a lesser character.

I have been listening to his recent work, the Egypt 80 band he inherited from his father, the new compositions that sit alongside a continued engagement with the Fela repertoire, and finding it increasingly difficult to talk about only in terms of the inheritance. Seun's own voice is clear enough now, his own concerns specific enough, his own musical intelligence sufficiently developed, that the father conversation, while not irrelevant, no longer dominates. He is his own artist who carries a legacy, rather than a legacy carrier who happens to be an artist.

The afrobeat he makes, and yes, Fela created and named the genre, and yes, Seun is in direct succession to it, is politically engaged in the most uncompromising way. This is music that understands that form and content cannot be separated, that the communal nature of the music, the multiple horns, the percussion section, the chorus vocals, is itself a political statement about collective action and collective joy. You cannot listen to this music and think that music is apolitical. It refuses the depoliticisation of form that most contemporary music accepts.

## Egypt 80 as Living Organism

The Egypt 80 band is forty musicians, and Fela created them and Seun has led them for most of his adult life, and the experience of that continuous leadership is audible in the music. This is a band that knows each other. The tightness of the rhythm section, the way the horn lines interact, the particular energy of musicians who have been playing together for years and who have developed their own shorthand, these are qualities that cannot be manufactured or accelerated. They accrue through time, through the shared experience of performance, through the specific knowledge that comes from having played the same music in many different rooms for many different audiences.

The music swings in the technical sense, the phrase musicians use for the property of rhythm that makes it feel inevitable and joyful simultaneously, rather than merely metronomically correct, and that swing is partly the band's collective knowledge and partly something that Seun has inherited and developed in his own playing. He was nine years old when he started performing with the band. He has been doing this for his entire conscious life.

## The Political Content Is Not Metaphor

Fela's afrobeat was explicitly political in a way that cost him dearly. He was beaten by soldiers acting on government orders. He was imprisoned. His mother was killed in an attack on the Kalakuta Republic. The music was not merely commenting on Nigerian politics; it was a site of resistance that the state treated as a genuine threat.

Seun carries this tradition with clarity about what it means. The political content of his music is not metaphor or artistic positioning. It is a continuation of a practice that understood music as a form of collective organizing, as a way of naming power and identifying its abuses in terms that everyone in the room could feel rather than merely understand abstractly.

The global context of contemporary afrobeat, the genre that has emerged from Lagos and Accra and other West African cities to become one of the dominant popular music forms worldwide, is both connected to and distinct from what Egypt 80 does. The plural afrobeats of contemporary global pop carries Fela's name in its etymology but has moved considerably from his political practice. Seun has been clear about this distinction without being dismissive of what has emerged. He understands the difference between a musical tradition that takes its energy from a political position and a musical tradition that has absorbed some of that energy into forms that serve entertainment rather than critique.

## On Carrying and Extending

I find myself thinking about what the next generation of afrobeat looks like, what Seun's relationship to contemporary African music means for where the music goes. He is not naive about this. He has been in dialogue with contemporary artists, been part of conversations about what afrobeat means and who it belongs to and how it can develop without abandoning its political seriousness.

The torch he carries is not becoming heavier. If anything, the more clearly his own voice emerges, the lighter the inheritance seems. He is not crushed by it. He is using it. That is the only good way to deal with a legacy that large, and watching him do it is its own kind of satisfaction.

The music will outlast all the complications of legacy and succession that make writing about it so fraught. In twenty years what will matter is whether the records were good, and the records are good. Seun Kuti made music that deserves to be heard on its own terms. I am hearing it that way.

## The Live Dimension

Egypt 80 as a live proposition is different from almost anything else in contemporary music. Forty musicians playing afrobeat at volume in a concert setting produces a physical experience that recorded music can represent but not replicate. The horn section alone, in a room that lets the sound accumulate properly, creates a kind of pressure that you feel before you interpret.

Seun has maintained the live practice as central rather than supplementary. This is not an artist whose primary existence is in the studio. The music was designed for performance, for the specific kind of collective experience that only happens when a large band plays for a large crowd and the boundary between the two becomes permeable. That experience is what Egypt 80 was built to provide and what it continues to provide, under Seun's leadership, with a consistency that is itself a form of political statement. The practice continues. The argument continues. The music does not stop.

The political dimension of afrobeat, which Fela built into the music's DNA, its very structure, the way it requires collective participation and refuses individual stardom even as it produced a star, is something Seun carries forward without rhetoric. He does not talk about it as much as he demonstrates it. The band, the collective experience, the music that can only exist as a shared act, these things are the argument. He makes the argument by making the music.

[download:/assets/images/artists/seun-kuti-2024-social-9x16.jpg|Download Social Card]"""

with open(path, "w") as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print("Updated: seun-kuti-2024")
PYEOF


echo "=== All done ==="
