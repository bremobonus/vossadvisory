#!/bin/bash
# deploy-artonly-2026-06-25-social-cards.sh
# Social card audit run via deploy workflow - 2026-06-25
# Audits all posts, generates missing social cards, fixes download tags.

set -e
echo "=== ArtOnly Social Card Audit (via deploy workflow) ==="
echo "$(date)"
echo ""

OMP_NUM_THREADS=1
export OMP_NUM_THREADS

python3 << 'PYEOF'
import json, os, glob, re, shutil, subprocess

POSTS_DIR = os.path.expanduser('~/artonly.io/posts')
IMAGES_DIR = os.path.expanduser('~/artonly.io/assets/images/artists')
AGENT_DIR = os.path.expanduser('~/artonly.io/agent')

generated = []
skipped_no_image = []
failed = []
already_ok = []
fixed_r5 = []
fixed_dl_format = []

for p in sorted(glob.glob(f'{POSTS_DIR}/*.json')):
    with open(p) as f:
        try:
            d = json.load(f)
        except Exception as e:
            print(f'SKIP (parse error): {p}: {e}')
            continue

    slug = str(d.get('slug') or os.path.basename(p).replace('.json', ''))
    title = str(d.get('title') or '')
    category = str(d.get('category') or '')
    hero = str(d.get('image') or '')
    body = str(d.get('body') or '')
    changed = False

    print(f'--- {slug} ---')

    # Rule 5: hero image must not be first [img:] in body
    img_tags = re.findall(r'\[img:([^\]]+)\]', body)
    if img_tags and img_tags[0].strip() == hero.strip():
        hero_basename = os.path.basename(hero)
        alternatives = sorted([
            f for f in os.listdir(IMAGES_DIR)
            if f.startswith(slug) and f.endswith('.jpg')
            and f != hero_basename
            and 'social' not in f
        ])
        old_tag = f'[img:{img_tags[0]}]'
        if alternatives:
            replacement_path = f'/assets/images/artists/{alternatives[0]}'
            new_tag = f'[img:{replacement_path}]'
            body = body.replace(old_tag, new_tag, 1)
            print(f'  Rule5: replaced {old_tag} -> {new_tag}')
        else:
            body = re.sub(r'\n+\[img:' + re.escape(img_tags[0]) + r'\]\n+', '\n\n', body)
            print(f'  Rule5: removed repeating hero img tag')
        fixed_r5.append(slug)
        d['body'] = body
        changed = True

    # Rule 4: check/fix download tag
    expected_dl = f'[download:/assets/images/artists/{slug}-social-9x16.jpg|Download Social Card]'
    has_correct_dl = expected_dl in body

    bad_dl = re.findall(r'\[download:(?!/assets/images/artists/)([^\]|]*' + re.escape(slug) + r'[^\]]*)\]', body)
    if bad_dl:
        for bad in bad_dl:
            bad_full = f'[download:{bad}]'
            body = body.replace(bad_full, expected_dl)
            print(f'  Download tag format fixed: {bad_full} -> {expected_dl}')
        fixed_dl_format.append(slug)
        d['body'] = body
        changed = True
        has_correct_dl = True

    if has_correct_dl:
        card_path = f'{IMAGES_DIR}/{slug}-social-9x16.jpg'
        if os.path.exists(card_path):
            if not changed:
                already_ok.append(slug)
                print(f'  OK (card exists, download tag present)')
            else:
                print(f'  Fixed (card exists, download tag present)')
        else:
            print(f'  Card file missing; regenerating...')
            hero_path = f'{IMAGES_DIR}/{slug}.jpg'
            if not os.path.exists(hero_path):
                src_path = os.path.expanduser('~/artonly.io' + hero) if hero else ''
                if src_path and os.path.exists(src_path):
                    shutil.copy(src_path, hero_path)
                    print(f'  Copied hero: {src_path}')
                else:
                    print(f'  SKIP: no hero image at {hero_path}')
                    skipped_no_image.append(slug)
                    continue
            env = os.environ.copy()
            env['OMP_NUM_THREADS'] = '1'
            result = subprocess.run(
                ['python3', f'{AGENT_DIR}/make-social-card.py', slug, title, category],
                capture_output=True, text=True, env=env, cwd=AGENT_DIR
            )
            if result.returncode != 0 or not os.path.exists(f'{IMAGES_DIR}/{slug}-social-9x16.jpg'):
                print(f'  FAIL: make-social-card.py failed')
                if result.stderr:
                    print(result.stderr[-300:])
                failed.append(slug)
                continue
            generated.append(slug)
            print(f'  Card regenerated')
    else:
        hero_path = f'{IMAGES_DIR}/{slug}.jpg'
        if not os.path.exists(hero_path):
            src_path = os.path.expanduser('~/artonly.io' + hero) if hero else ''
            if src_path and os.path.exists(src_path):
                shutil.copy(src_path, hero_path)
                print(f'  Copied hero: {src_path}')
            else:
                print(f'  SKIP: no hero image for {slug}')
                skipped_no_image.append(slug)
                continue

        env = os.environ.copy()
        env['OMP_NUM_THREADS'] = '1'
        print(f'  Running make-social-card.py...')
        result = subprocess.run(
            ['python3', f'{AGENT_DIR}/make-social-card.py', slug, title, category],
            capture_output=True, text=True, env=env, cwd=AGENT_DIR
        )
        if result.returncode != 0 or not os.path.exists(f'{IMAGES_DIR}/{slug}-social-9x16.jpg'):
            print(f'  FAIL: make-social-card.py failed')
            if result.stderr:
                print(result.stderr[-300:])
            failed.append(slug)
            continue

        d['body'] = body.rstrip() + f'\n\n{expected_dl}'
        changed = True
        generated.append(slug)
        print(f'  Card generated, download tag appended')

    if changed:
        with open(p, 'w') as f:
            json.dump(d, f, indent=2, ensure_ascii=False)
        print(f'  Saved: {p}')

print()
print('=== REPORT ===')
print(f'Cards generated/fixed: {len(generated)}: {generated}')
print(f'Rule5 fixed:           {len(fixed_r5)}: {fixed_r5}')
print(f'Download format fixed: {len(fixed_dl_format)}: {fixed_dl_format}')
print(f'Already OK:            {len(already_ok)}: {already_ok}')
print(f'Skipped (no image):    {len(skipped_no_image)}: {skipped_no_image}')
print(f'Failed:                {len(failed)}: {failed}')
PYEOF

echo "=== Social Card Audit Complete ==="
