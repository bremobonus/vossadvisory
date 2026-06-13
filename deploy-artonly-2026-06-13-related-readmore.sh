#!/bin/bash
# ArtOnly Related Posts — Read More fallback — 2026-06-13
# post.php does not render the "related" JSON key in HTML, so we also
# append [related:SLUG|TITLE] shortcodes to the body/content field so
# the template can pick them up as inline markup.
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-13-related-readmore.sh

set -e
echo "=== ArtOnly Read More Fallback: 2026-06-13 ==="

python3 << 'PYEOF'
import json, os

BASE = '/home/dh_yadmw3/artonly.io/posts'

# Related data already written to the JSON files; re-declare for the shortcodes.
RELATED = {
    "rivers-cuomo-birthday-2026": [
        ("robyn-birthday-2026",          "Happy Birthday Robyn: The Work That Matters"),
        ("boygenius-the-record-2023",    "boygenius and the Strange Power of Three People Deciding to Show Up Fully"),
        ("angel-olsen",                  "Angel Olsen Recorded Big Time Three Weeks After Burying Her Mother, and Every Track Knows It"),
    ],
    "doechii": [
        ("navy-blue-sir-render",         "Sir Render Is Navy Blue at His Most Exposed and His Most Complete"),
        ("chappell-roan-rise-2024",      "Chappell Roan's Rise Was the Most Thrilling Story in Pop Music This Year"),
        ("charli-xcx-brat-summer-2024",  "Brat Summer Was the Defining Aesthetic Moment of 2024"),
    ],
    "olivia-rodrigo": [
        ("ariana-grande",                    "Ariana Grande Is Just Getting Started"),
        ("billie-eilish-hit-me-hard-soft-2024", "Billie Eilish Made the Quietest Blockbuster Album of the Year"),
        ("chappell-roan-rise-2024",          "Chappell Roan's Rise Was the Most Thrilling Story in Pop Music This Year"),
    ],
    "sabrina-carpenter": [
        ("olivia-rodrigo",               "Olivia Rodrigo Is Three Albums In and Still Setting the Terms"),
        ("ariana-grande",                "Ariana Grande Is Just Getting Started"),
        ("charli-xcx-brat-summer-2024",  "Brat Summer Was the Defining Aesthetic Moment of 2024"),
    ],
    "tyler-the-creator": [
        ("andre-3000-new-blue-sun-2023", "Andre 3000 Released a Flute Album and It Was Exactly What We Needed"),
        ("navy-blue-sir-render",         "Sir Render Is Navy Blue at His Most Exposed and His Most Complete"),
        ("doechii",                      "Doechii: The Swamp Princess Who Claimed the Throne"),
    ],
    "wiki-ancient-history": [
        ("navy-blue-sir-render",         "Sir Render Is Navy Blue at His Most Exposed and His Most Complete"),
        ("tyler-the-creator",            "Tyler, The Creator Is Eight Albums In and Still Impossible to Predict"),
        ("andre-3000-new-blue-sun-2023", "Andre 3000 Released a Flute Album and It Was Exactly What We Needed"),
    ],
}

MARKER = '\n\n## Read More\n\n'

updated = []
skipped = []

for slug, links in RELATED.items():
    path = os.path.join(BASE, f'{slug}.json')
    if not os.path.exists(path):
        print(f'  MISSING file: {path}')
        continue

    with open(path) as f:
        post = json.load(f)

    # Determine content field
    if 'body' in post:
        field = 'body'
    elif 'content' in post:
        field = 'content'
    else:
        # Stub post with no text field — create a body field
        field = 'body'
        post[field] = ''

    text = post[field]

    # Skip if already has the Read More block
    if '## Read More' in text:
        print(f'  SKIP {slug} (already has Read More block)')
        skipped.append(slug)
        continue

    shortcodes = '\n'.join(f'[related:{s}|{t}]' for s, t in links)
    post[field] = text.rstrip() + MARKER + shortcodes + '\n'

    with open(path, 'w') as f:
        json.dump(post, f, indent=2, ensure_ascii=False)

    print(f'  OK {slug} ({field}) → {[s for s,_ in links]}')
    updated.append(slug)

print()
print(f'=== Done: {len(updated)} updated, {len(skipped)} skipped ===')
for slug in updated:
    print(f'  + {slug}')
PYEOF

echo "=== Read More fallback complete ==="
