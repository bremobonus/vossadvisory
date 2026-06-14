#!/bin/bash
# Radar cache refresh - June 14, 2026
set -e

python3 - << 'PYEOF'
import json

artists = [
    {
        "name": "Drake",
        "genre": "Music",
        "why": "ICEMAN held No. 1 on the Billboard 200 for a third straight week dated June 13, 2026, earning 171,000 equivalent album units in its third tracking week. It is his first album to spend three weeks at the top since Certified Lover Boy in 2021.",
        "signal": "Billboard 200"
    },
    {
        "name": "Ella Langley",
        "genre": "Music",
        "why": "Be Her remained at No. 1 on Billboard Country Airplay for a second week on June 13, 2026. She became the first female artist ever to have three songs simultaneously inside the top 10 of the chart, and she now surpasses 30 million monthly Spotify listeners.",
        "signal": "Billboard Country Airplay"
    },
    {
        "name": "Myles Smith",
        "genre": "Music",
        "why": "Debut album My Mess, My Heart, My Life releases June 19, 2026, following his breakout single Stargazing which peaked at No. 19 on the Billboard Hot 100 in 2025. A UK and Ireland arena tour follows, culminating at The O2 London on November 20.",
        "signal": "New album release"
    },
    {
        "name": "Lola Young",
        "genre": "Music",
        "why": "Featured on the April 2026 Rolling Stone cover as a Future of Music headliner and performed at the Rolling Stone SXSW showcase in Austin in March 2026, establishing her as one of the most anticipated UK pop voices of the year.",
        "signal": "Rolling Stone Future of Music"
    },
    {
        "name": "BigXthaPlug",
        "genre": "Music",
        "why": "Headlined the Rolling Stone Future of Music SXSW 2026 showcase and was profiled in the April 2026 Rolling Stone issue as a Texas rapper with Texas-size ambition and growing national crossover momentum.",
        "signal": "Rolling Stone Future of Music"
    },
    {
        "name": "Fuerza Regida",
        "genre": "Music",
        "why": "Headlined the Rolling Stone Future of Music SXSW 2026 showcase and were described by Rolling Stone as an act that built an empire to last, cementing their position as an arena-level draw in musica mexicana.",
        "signal": "Rolling Stone Future of Music"
    },
    {
        "name": "Tyla",
        "genre": "Music",
        "why": "Performed South Africa's national anthem at the FIFA World Cup 2026 opening ceremony, released the official FIFA anthem Game Time with Future, and announced her second album A*POP for July 24, 2026.",
        "signal": "FIFA World Cup 2026 opening"
    },
    {
        "name": "Harry Styles",
        "genre": "Music",
        "why": "New studio album received a full review in the April 2026 Rolling Stone Future of Music issue, maintaining his global commercial presence following multiple sold-out world tours.",
        "signal": "Rolling Stone album review"
    },
    {
        "name": "Maisie Peters",
        "genre": "Music",
        "why": "Third album Florescence released May 15, 2026, her first record on her own independent imprint after departing Ed Sheeran's Gingerbread Man Records, marking a bold step in her career as a UK pop songwriter.",
        "signal": "New album release"
    },
    {
        "name": "Diambe",
        "genre": "Art",
        "why": "Solo exhibition Bees beings beans at Kunsthalle Basel ran January to April 2026, the Brazilian artist's largest institutional show to date, presenting new film and bronze sculptures exploring colonial memory and ecological fragility.",
        "signal": "Kunsthalle Basel solo show"
    },
    {
        "name": "KAWS",
        "genre": "Art",
        "why": "KAWS: FAMILY at SFMOMA ran through May 2026 as the artist's first major museum exhibition on the US West Coast, bringing three decades of character-driven sculpture and painting to a new institutional audience.",
        "signal": "SFMOMA retrospective"
    },
    {
        "name": "Ming Wong",
        "genre": "Art",
        "why": "Served as the National Gallery London's 2025 Artist in Residence and presented the film installation Dance of the Sun on the Water from January to April 2026, becoming the first Southeast Asian artist ever to hold the residency.",
        "signal": "National Gallery London residency"
    },
    {
        "name": "Anne Hathaway",
        "genre": "Culture",
        "why": "2026 is shaping up to be the busiest and most visible acting year of her career, with a release calendar spanning multiple genres and major studio productions across film and television.",
        "signal": "Multiple major studio releases"
    },
    {
        "name": "Pedro Pascal",
        "genre": "Culture",
        "why": "Named the most in-demand TV and film actor of 2026, appearing across prestige dramas and blockbuster productions while maintaining a constant presence across entertainment media globally.",
        "signal": "Most in-demand actor 2026"
    },
    {
        "name": "Sydney Sweeney",
        "genre": "Culture",
        "why": "A constant presence in 2026 through hit drama series and high-profile film roles, remaining one of the most talked-about performers across streaming and theatrical release schedules.",
        "signal": "TV and film prominence 2026"
    }
]

path = '/home/dh_yadmw3/artonly.io/data/radar-cache.json'
with open(path, 'w') as f:
    json.dump(artists, f, indent=2)

print(f'Wrote {len(artists)} artists to radar-cache.json')
PYEOF

# Verify
python3 -c "import json; d=json.load(open('/home/dh_yadmw3/artonly.io/data/radar-cache.json')); print(len(d), 'artists in radar cache')"
