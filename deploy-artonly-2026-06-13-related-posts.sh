#!/bin/bash
# ArtOnly Related Posts — 2026-06-13
# Adds "related" field to today's 6 published articles.
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-13-related-posts.sh

set -e
echo "=== ArtOnly Internal Linking: 2026-06-13 ==="

python3 << 'PYEOF'
import json, os

BASE = '/home/dh_yadmw3/artonly.io/posts'

RELATED = {
    # Birthday tribute + indie/alt-rock cluster
    "rivers-cuomo-birthday-2026": [
        {"slug": "robyn-birthday-2026",       "title": "Happy Birthday Robyn: The Work That Matters",                                                        "author": "Allastair Voss", "image": "/assets/images/artists/robyn-birthday-2026.jpg"},
        {"slug": "boygenius-the-record-2023", "title": "boygenius and the Strange Power of Three People Deciding to Show Up Fully",                           "author": "Leelou Blanc",   "image": "/assets/images/artists/boygenius-the-record-2023.jpg"},
        {"slug": "angel-olsen",               "title": "Angel Olsen Recorded Big Time Three Weeks After Burying Her Mother, and Every Track Knows It",        "author": "Allastair Voss", "image": "/assets/images/artists/angel-olsen.jpg"},
    ],
    # Hip-hop breakout / female artists claiming the moment
    "doechii": [
        {"slug": "navy-blue-sir-render",      "title": "Sir Render Is Navy Blue at His Most Exposed and His Most Complete",                                   "author": "Allastair Voss", "image": "/assets/images/artists/navy-blue-sir-render.jpg"},
        {"slug": "chappell-roan-rise-2024",   "title": "Chappell Roan's Rise Was the Most Thrilling Story in Pop Music This Year",                           "author": "Allastair Voss", "image": "/assets/images/artists/chappell-roan.jpg"},
        {"slug": "charli-xcx-brat-summer-2024", "title": "Brat Summer Was the Defining Aesthetic Moment of 2024",                                            "author": "John Terrence",  "image": "/assets/images/artists/charli-xcx.jpg"},
    ],
    # Gen-Z pop: emotional, honest, multi-album careers
    "olivia-rodrigo": [
        {"slug": "ariana-grande",                    "title": "Ariana Grande Is Just Getting Started",                                                        "author": "Allastair Voss", "image": "/assets/images/artists/ariana-grande.jpg"},
        {"slug": "billie-eilish-hit-me-hard-soft-2024", "title": "Billie Eilish Made the Quietest Blockbuster Album of the Year",                            "author": "Allastair Voss", "image": "/assets/images/artists/billie-eilish.jpg"},
        {"slug": "chappell-roan-rise-2024",          "title": "Chappell Roan's Rise Was the Most Thrilling Story in Pop Music This Year",                    "author": "Allastair Voss", "image": "/assets/images/artists/chappell-roan.jpg"},
    ],
    # Pop career-arc stories, artists building since childhood/teens
    "sabrina-carpenter": [
        {"slug": "olivia-rodrigo",               "title": "Olivia Rodrigo Is Three Albums In and Still Setting the Terms",                                    "author": "Allastair Voss", "image": "/assets/images/artists/olivia-rodrigo.jpg"},
        {"slug": "ariana-grande",                "title": "Ariana Grande Is Just Getting Started",                                                            "author": "Allastair Voss", "image": "/assets/images/artists/ariana-grande.jpg"},
        {"slug": "charli-xcx-brat-summer-2024", "title": "Brat Summer Was the Defining Aesthetic Moment of 2024",                                            "author": "John Terrence",  "image": "/assets/images/artists/charli-xcx.jpg"},
    ],
    # Experimental hip-hop visionaries, unpredictable long-game careers
    "tyler-the-creator": [
        {"slug": "andre-3000-new-blue-sun-2023", "title": "Andre 3000 Released a Flute Album and It Was Exactly What We Needed",                             "author": "Leelou Blanc",   "image": "/assets/images/artists/andre-3000.jpg"},
        {"slug": "navy-blue-sir-render",         "title": "Sir Render Is Navy Blue at His Most Exposed and His Most Complete",                                "author": "Allastair Voss", "image": "/assets/images/artists/navy-blue-sir-render.jpg"},
        {"slug": "doechii",                      "title": "Doechii: The Swamp Princess Who Claimed the Throne",                                               "author": "Allastair Voss", "image": "/assets/images/artists/doechii.jpg"},
    ],
    # NYC/city rap — place-specific, dense, poetic
    "wiki-ancient-history": [
        {"slug": "navy-blue-sir-render",         "title": "Sir Render Is Navy Blue at His Most Exposed and His Most Complete",                                "author": "Allastair Voss", "image": "/assets/images/artists/navy-blue-sir-render.jpg"},
        {"slug": "tyler-the-creator",            "title": "Tyler, The Creator Is Eight Albums In and Still Impossible to Predict",                            "author": "Allastair Voss", "image": "/assets/images/artists/tyler-the-creator.jpg"},
        {"slug": "andre-3000-new-blue-sun-2023", "title": "Andre 3000 Released a Flute Album and It Was Exactly What We Needed",                             "author": "Leelou Blanc",   "image": "/assets/images/artists/andre-3000.jpg"},
    ],
}

updated = []
skipped = []

for slug, related in RELATED.items():
    path = os.path.join(BASE, f'{slug}.json')
    if not os.path.exists(path):
        print(f'  MISSING file: {path}')
        continue
    with open(path) as f:
        post = json.load(f)
    if post.get('related'):
        print(f'  SKIP {slug} (already has related)')
        skipped.append(slug)
        continue
    post['related'] = related
    with open(path, 'w') as f:
        json.dump(post, f, indent=2, ensure_ascii=False)
    print(f'  OK {slug} → {[r["slug"] for r in related]}')
    updated.append(slug)

print()
print(f'=== Done: {len(updated)} updated, {len(skipped)} skipped ===')
for slug in updated:
    print(f'  + {slug}')
PYEOF

echo "=== Related posts run complete ==="
