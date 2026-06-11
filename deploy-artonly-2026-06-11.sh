#!/bin/bash
# artonly.io YouTube retrofit: art + culture posts
# Generated: 2026-06-11
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-11.sh

set -e
echo "=== artonly.io YouTube Retrofit 2026-06-11 ==="

python3 << 'PYEOF'
import json, os

BASE = '/home/dh_yadmw3/artonly.io/posts'

UPDATES = {
    "actress": "WgBZFWXvvEw",
    "ai-art-controversy-2023-2024": "nwxtEvljUZU",
    "ai-generated-art-museums-2026": "MlxsSWqrnZs",
    "amy-sherald-american-sublime": "KcKNiEIVx1A",
    "andrew-thomas-huang-visual-mythologist": "962Cx6nmnzg",
    "art-basel-2025-year-in-review": "cjeYiCeEQos",
    "art-basel-hong-kong-2025": "OWHEs9cxwN4",
    "art-basel-miami-2025": "6Ow8JNLKou4",
    "art-basel-paris-2025": "HPJKKOyI0vc",
    "art-basel-switzerland-2025": "jkwyTdwwo-g",
    "blood-orange-essex-honey": "KX2naTrEhnI",
    "cecily-brown-retrospective-2022": "wmPGBlxOUbo",
    "divide-and-dissolve": "Sfbbxuox-sI",
    "documenta-s-aftermath-exposed-fault-lines-the-art-world-cann": "A9uhf1iSvN8",
    "duchamp-moma-2026-the-retrospective-that-arrives-exactly-on-time": "PTnmJLysyLg",
    "emma-westenberg-visual-language": "4ZNFfYccXLM",
    "fake-banksy-shows": "-CJ3lyR-DOM",
    "frieze-london-2024-revealed-an-art-market-in-anxious-transit": "EE6Ru1hNjjY",
    "helen-frankenthaler-kunstmuseum-basel-2026": "pBKNifpTSFk",
    "henry-taylor-moca-2023": "ofN0NxmO-nA",
    "hernan-bas-florida-2024": "DoIQ27yCXLY",
    "immersive-van-gogh-shows-forced-a-question-nobody-wanted-to": "Dfk6Vo4L_ds",
    "james-turrell-s-light-keeps-traveling-and-we-keep-following": "kUtf7KkKRmM",
    "jenny-holzer-truisms-2024": "CQ9iK_yTWxs",
    "jenny-holzer-words-as-weapons-2026": "oaY8VmHmiB4",
    "julius-eastman-legacy-2022": "9HIGwUomb0A",
    "kara-walker": "MhByMffG9IA",
    "kara-walker-fort-2023": "tV_L3fceGNA",
    "kara-walker-silhouette-absence-history": "nrKIGL5ZWNk",
    "kara-walker-subtlety": "sRkP5rcXtys",
    "kerry-james-marshall-mastry": "K2bmHE7MRQU",
    "klara-hosnedlova-embrace-as-architecture": "hslNsz7e6D0",
    "korakrit-arunanondchai-2022": "8ySvb5Notuc",
    "lauren-halsey-pyramid-2023": "I4irGrO5ePc",
    "lynette-yiadom-boakye-2024": "cHbTD9DYrqk",
    "lynette-yiadom-boakye-fictional-portraits": "6ee5gGkW7nk",
    "moma-duchamp-retrospective-2026": "PTnmJLysyLg",
    "odutola-grief-house": "C8w4i3e953Q",
    "odutola-ile-oriaku": "TzKbkZSE4Sk",
    "pacita-abad-discovery-2023": "Qt7KArzxw4Y",
    "peter-doig-retrospective-2022": "Q23w1cBFHC0",
    "philadelphia-nation-of-artists-2026": "E9vRfqXAvR8",
    "rashid-johnson-anxiety-material": "lC2R7Ye-tYA",
    "refik-anadol-ai-visual-architect": "UxQDG6WQT5s",
    "rirkrit-tiravanija-cook-2023": "LQFJfAFIhyE",
    "simone-leigh-sovereign-2022": "MlrgDkwO_W4",
    "tau-lewis-stitched-monumental-2026": "ObU0EasffuA",
    "theaster-gates-black-archive-2023": "Byin7zoiiUU",
    "toyin-ojih-odutola": "C8w4i3e953Q",
    "toyin-ojih-odutola-mark-on-skin": "9N3XMDzfK0k",
    "tschabalala-self-body-as-monument": "6DBg8di0FCQ",
    "venice-biennale-2024": "9LLN1reIJQE",
    "weyes-blood": "fHZFAYlKMfU",
    "yayoi-kusama-infinity-rooms-2023-2024": "0-C69t22twQ",
    "yeule": "qObf97Tz40I",
    "zanele-muholi-2022": "-c02DXHz5bY",
    "zanele-muholi-somnyama": "s5WINxyy0I4",
    "a24-a-decade-2024": "24bZVz535_g",
    "a24-mother-mary-hathaway-coel": "ATGaqU6Srcc",
    "afrobeats-global-mainstream": "BEMl5nHbKLo",
    "arca-angels-exhibition-2023": "xLJs4e9sBSY",
    "ballroom-culture-2026": "zjfzvo-zRPo",
    "barbie-movie-2023": "qcGMKd8iego",
    "burial": "Et5B-zfAIIo",
    "cate-le-bon": "UeYlNPK3u14",
    "cautious-clay-the-hours": "1OepiFbXnB0",
    "charli-xcx": "LgBMFg7ZgJw",
    "charli-xcx-brat-summer-2024": "LgBMFg7ZgJw",
    "cities-nightlife-dying-2023": "xbGBjee3Yoo",
    "cliqua-directing-duo-2026": "5xD7T_XXrUE",
    "dakar-art-scene-2023": "5sTpErq03YI",
    "digital-detox-culture-2024": "_va8iHsFx_E",
    "fashion-week-new-faces-2024": "su9_DxEdV8A",
    "film-photography-revival-2023": "YotUW5WcOh8",
    "greta-gerwig-barbie-cultural-moment-2023": "PIlf1oDQBQY",
    "internet-celebrity-loneliness-2023": "utmnyCPiEuk",
    "jamila-woods": "zW8y7GXamm4",
    "jane-schoenbrun": "dXKidTVXV0A",
    "kelly-lee-owens": "77M_7aBmUdE",
    "kendrick-lamar-gnx-hip-hop-culture-2025": "6FUAevq5ces",
    "klein-thirteen-sense": "pKmWG484AH0",
    "lagos-art-capital-2026": "5_44tV6F2V4",
    "listening-bars-global-rise": "teTu7NQlZvU",
    "michaela-coel-i-may-destroy-you": "9AFe9CHhyno",
    "mick-jenkins": "2OR1SMIH774",
    "moma-ps1-warm-up-2024-proved-electronic-music-and-art-still": "uQNdEkOj9I4",
    "new-museum-oma": "N3enkkTIo8c",
    "nick-leon-tropical-entropy": "DVXBQMYBe9k",
    "pharrell-louis-vuitton-2023": "pDsjAIrmSKM",
    "rick-owens-paris-2023": "KsZOwn_PG24",
    "sofia-coppola-priscilla-2023": "DBWk6BohVXk",
    "south-korea-cultural-wave-2023": "Wk-WJkzWLV0",
    "special-interest": "B6ni2375n9A",
    "streaming-killed-the-album-or-did-it": "yWKzxM7pnpo",
    "sudan-archives": "LHy6iZFWOkI",
    "underground-club-culture-london-2022": "qxlY3kK9aog",
    "venice-architecture-biennale-2026": "eBVoWaBz2v0",
    "virgil-abloh-legacy-2022": "MOGdkouMhuI",
    "wong-kar-wai-criterion-2023": "6MKSC32vH8w",
}

updated = 0
already = 0
missing = 0
errors = 0

for slug, vid_id in UPDATES.items():
    path = f'{BASE}/{slug}.json'
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        body = data.get('body', '')
        if '[youtube:' in body:
            print(f'SKIP (already has embed): {slug}')
            already += 1
            continue
        data['body'] = f'[youtube:{vid_id}]\n{body}'
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
            f.write('\n')
        print(f'UPDATED: {slug} -> {vid_id}')
        updated += 1
    except FileNotFoundError:
        print(f'MISSING FILE: {slug}')
        missing += 1
    except Exception as e:
        print(f'ERROR {slug}: {e}')
        errors += 1

print(f'\nRESULT: {updated} updated, {already} already had embed, {missing} missing, {errors} errors')
PYEOF

echo "=== Done ==="
