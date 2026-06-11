#!/bin/bash
# Deploy all expanded artonly.io posts to DreamHost
# Run from your local machine:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-expand-all.sh

set -e
POSTS_DIR=~/artonly.io/posts
echo "=== Deploying expanded posts to artonly.io ==="

echo "Updating: rick-owens-paris-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/rick-owens-paris-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: rick-owens-paris-2023')
"

echo "Updating: rick-wade-detroit-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/rick-wade-detroit-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: rick-wade-detroit-2022')
"

echo "Updating: rirkrit-tiravanija-cook-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/rirkrit-tiravanija-cook-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: rirkrit-tiravanija-cook-2023')
"

echo "Updating: sadeyes-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sadeyes-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sadeyes-2024')
"

echo "Updating: sailorr-rawness-as-craft"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sailorr-rawness-as-craft.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sailorr-rawness-as-craft')
"

echo "Updating: salamanda-dreams-as-reality"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/salamanda-dreams-as-reality.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: salamanda-dreams-as-reality')
"

echo "Updating: samara-cyn-backroads-2025"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/samara-cyn-backroads-2025.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: samara-cyn-backroads-2025')
"

echo "Updating: samara-cyn-detour-as-destination"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/samara-cyn-detour-as-destination.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: samara-cyn-detour-as-destination')
"

echo "Updating: sampha-return-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sampha-return-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sampha-return-2023')
"

echo "Updating: sasha-keable-act-ii"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sasha-keable-act-ii.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sasha-keable-act-ii')
"

echo "Updating: sault-acts-of-faith-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sault-acts-of-faith-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sault-acts-of-faith-2022')
"

echo "Updating: sega-bodega-harold-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sega-bodega-harold-2022')
"

echo "Updating: sega-bodega-harold"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sega-bodega-harold.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sega-bodega-harold')
"

echo "Updating: serpentwithfeet-deacon-gospel"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/serpentwithfeet-deacon-gospel.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: serpentwithfeet-deacon-gospel')
"

echo "Updating: seun-kuti-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/seun-kuti-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: seun-kuti-2024')
"

echo "Updating: shygirl-nymph-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/shygirl-nymph-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: shygirl-nymph-2022')
"

echo "Updating: simone-leigh-sovereign-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/simone-leigh-sovereign-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: simone-leigh-sovereign-2022')
"

echo "Updating: slowthai-ugly-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/slowthai-ugly-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: slowthai-ugly-2023')
"

echo "Updating: smiff-pressure-core-bass"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/smiff-pressure-core-bass.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: smiff-pressure-core-bass')
"

echo "Updating: sofia-coppola-priscilla-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sofia-coppola-priscilla-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sofia-coppola-priscilla-2023')
"

echo "Updating: sofia-kourtesis-madres-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sofia-kourtesis-madres-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sofia-kourtesis-madres-2023')
"

echo "Updating: sophia-stel-a24-solitaire"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sophia-stel-a24-solitaire.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sophia-stel-a24-solitaire')
"

echo "Updating: sorisa-toronto-hyperpop"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sorisa-toronto-hyperpop.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sorisa-toronto-hyperpop')
"

echo "Updating: soul-wun-blue-light-emotional-electronic"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/soul-wun-blue-light-emotional-electronic.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: soul-wun-blue-light-emotional-electronic')
"

echo "Updating: south-korea-cultural-wave-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/south-korea-cultural-wave-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: south-korea-cultural-wave-2023')
"

echo "Updating: sprints-2025"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sprints-2025.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sprints-2025')
"

echo "Updating: streaming-killed-the-album-or-did-it"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/streaming-killed-the-album-or-did-it.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: streaming-killed-the-album-or-did-it')
"

echo "Updating: sudan-archives-natural-brown-prom-queen"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sudan-archives-natural-brown-prom-queen.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sudan-archives-natural-brown-prom-queen')
"

echo "Updating: sung-holly-simple"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sung-holly-simple.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sung-holly-simple')
"

echo "Updating: sza-sos-lana"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/sza-sos-lana.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: sza-sos-lana')
"

echo "Updating: tame-impala-deadbeat"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tame-impala-deadbeat.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tame-impala-deadbeat')
"

echo "Updating: teddy-swims-lose-control"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/teddy-swims-lose-control.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: teddy-swims-lose-control')
"

echo "Updating: tems-love-is-a-kingdom"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tems-love-is-a-kingdom.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tems-love-is-a-kingdom')
"

echo "Updating: the-death-of-soundcloud-rap-was-slow-ugly-and-overdue"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/the-death-of-soundcloud-rap-was-slow-ugly-and-overdue.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: the-death-of-soundcloud-rap-was-slow-ugly-and-overdue')
"

echo "Updating: the-eras-tour-rewrote-the-rules-of-live-music-forever"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/the-eras-tour-rewrote-the-rules-of-live-music-forever.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: the-eras-tour-rewrote-the-rules-of-live-music-forever')
"

echo "Updating: theaster-gates-black-archive-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/theaster-gates-black-archive-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: theaster-gates-black-archive-2023')
"

echo "Updating: thugli-sic-em"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/thugli-sic-em.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: thugli-sic-em')
"

echo "Updating: tirzah-minimal-as-heartbeat"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tirzah-minimal-as-heartbeat.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tirzah-minimal-as-heartbeat')
"

echo "Updating: tirzah-trip-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tirzah-trip-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tirzah-trip-2022')
"

echo "Updating: tiwayo-outsider"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tiwayo-outsider.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tiwayo-outsider')
"

echo "Updating: tokyo-underground-electronic-2026"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tokyo-underground-electronic-2026.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tokyo-underground-electronic-2026')
"

echo "Updating: toro-y-moi-hole-erth"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/toro-y-moi-hole-erth.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: toro-y-moi-hole-erth')
"

echo "Updating: tove-lo-criminally-underrated-heat-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tove-lo-criminally-underrated-heat-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tove-lo-criminally-underrated-heat-2024')
"

echo "Updating: turnstile-coachella-2026"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/turnstile-coachella-2026.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: turnstile-coachella-2026')
"

echo "Updating: tyler-chromakopia-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/tyler-chromakopia-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: tyler-chromakopia-2024')
"

echo "Updating: underground-club-culture-london-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/underground-club-culture-london-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: underground-club-culture-london-2022')
"

echo "Updating: urtrax-immersive-music-for-the-mind"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/urtrax-immersive-music-for-the-mind.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: urtrax-immersive-music-for-the-mind')
"

echo "Updating: vagabon-again-album"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/vagabon-again-album.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: vagabon-again-album')
"

echo "Updating: vegyn-the-producer-who-stayed"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/vegyn-the-producer-who-stayed.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: vegyn-the-producer-who-stayed')
"

echo "Updating: venice-biennale-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/venice-biennale-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: venice-biennale-2024')
"

echo "Updating: verraco-basic-maneuvers"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/verraco-basic-maneuvers.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: verraco-basic-maneuvers')
"

echo "Updating: vinyl-surpasses-cds-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/vinyl-surpasses-cds-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: vinyl-surpasses-cds-2024')
"

echo "Updating: virgil-abloh-legacy-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/virgil-abloh-legacy-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: virgil-abloh-legacy-2022')
"

echo "Updating: waxahatchee"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/waxahatchee.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: waxahatchee')
"

echo "Updating: wesley-joseph-forever-ends-someday"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/wesley-joseph-forever-ends-someday.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: wesley-joseph-forever-ends-someday')
"

echo "Updating: wet-leg"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/wet-leg.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: wet-leg')
"

echo "Updating: wishgxd-toronto-cinematic-rb"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/wishgxd-toronto-cinematic-rb.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: wishgxd-toronto-cinematic-rb')
"

echo "Updating: witch-prophet-words-are-spells"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/witch-prophet-words-are-spells.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: witch-prophet-words-are-spells')
"

echo "Updating: women-reshaping-rap-2026"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/women-reshaping-rap-2026.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: women-reshaping-rap-2026')
"

echo "Updating: wong-kar-wai-criterion-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/wong-kar-wai-criterion-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: wong-kar-wai-criterion-2023')
"

echo "Updating: wsabe-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/wsabe-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: wsabe-2024')
"

echo "Updating: yaeji-dancing-in-both-languages"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yaeji-dancing-in-both-languages.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yaeji-dancing-in-both-languages')
"

echo "Updating: yame-ebem-2025"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yame-ebem-2025.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yame-ebem-2025')
"

echo "Updating: yaya-bey-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yaya-bey-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yaya-bey-2023')
"

echo "Updating: yayoi-kusama-infinity-rooms-2023-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yayoi-kusama-infinity-rooms-2023-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yayoi-kusama-infinity-rooms-2023-2024')
"

echo "Updating: ye-sofi-bully-2026"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/ye-sofi-bully-2026.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: ye-sofi-bully-2026')
"

echo "Updating: yeule-softscars-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yeule-softscars-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yeule-softscars-2023')
"

echo "Updating: yu-su-2024"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yu-su-2024.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yu-su-2024')
"

echo "Updating: yussef-dayes-2023"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yussef-dayes-2023.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yussef-dayes-2023')
"

echo "Updating: yves-tumor-heaven-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/yves-tumor-heaven-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: yves-tumor-heaven-2022')
"

echo "Updating: zanele-muholi-2022"
python3 -c "
import json
path = '/home/dh_yadmw3/artonly.io/posts/zanele-muholi-2022.json'
with open(path) as f:
    d = json.load(f)
d['body'] = " + body + "
with open(path, 'w') as f:
    json.dump(d, f, indent=2, ensure_ascii=False)
print('Done: zanele-muholi-2022')
"
echo "=== All done ==="
