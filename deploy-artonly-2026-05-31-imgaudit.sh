#!/bin/bash
# ArtOnly Daily Image Audit
# Generated: 2026-05-31
# Enforces all 5 image rules across every post on the server.

set -e
export OMP_NUM_THREADS=1

echo "=== ArtOnly Image Audit: 2026-05-31 ==="
echo "$(date)"
echo ""

python3 << 'PYEOF'
import json, os, glob, re, subprocess

POSTS_DIR  = os.path.expanduser('~/artonly.io/posts')
IMAGES_DIR = os.path.expanduser('~/artonly.io/assets/images/artists')
SITE_ROOT  = os.path.expanduser('~/artonly.io')

stats = {
    'checked':    0,
    'r1_fixed':   [],
    'r2_fixed':   [],
    'r2_skipped': [],
    'r3_fixed':   [],
    'r4_body_fixed': [],
    'r4_hero_missing': [],
    'r5_logged':  [],
}


def image_dims(disk_path):
    try:
        raw = subprocess.check_output(
            ['identify', disk_path],
            env={**os.environ, 'OMP_NUM_THREADS': '1'},
            stderr=subprocess.DEVNULL,
            timeout=30,
        ).decode()
        m = re.search(r' (\d+)x(\d+) ', raw)
        if m:
            return int(m.group(1)), int(m.group(2))
    except Exception:
        pass
    return None, None


def ref_to_disk(img_ref):
    return SITE_ROOT + img_ref


def correct_pos(disk_path):
    w, h = image_dims(disk_path)
    if w is None:
        return None
    return 'center top' if h > w else 'center 20%'


def valid_location(img_ref, slug):
    base = '/assets/images/artists/'
    if not img_ref.startswith(base):
        return False
    remainder = img_ref[len(base):]
    if '/' not in remainder:
        return True
    return remainder.split('/')[0] == slug


posts = sorted(glob.glob(f'{POSTS_DIR}/*.json'))
print(f'Found {len(posts)} posts.\n')

for post_path in posts:
    try:
        with open(post_path) as f:
            d = json.load(f)
    except Exception as e:
        print(f'SKIP (parse error): {post_path}: {e}')
        continue

    stats['checked'] += 1
    slug    = d.get('slug', os.path.basename(post_path).replace('.json', ''))
    hero    = d.get('image', '')
    body    = d.get('body', '')
    cur_pos = d.get('image_position', '')
    changed = False
    issues  = []

    print(f'--- {slug} ---')

    img_tags = re.findall(r'\[img:([^\]]+)\]', body)

    # Rule 1: hero must not repeat in body as [img:]
    if hero:
        repeated = [t for t in img_tags if t.strip() == hero.strip()]
        if repeated:
            for ref in repeated:
                body = re.sub(
                    r'\n*\[img:' + re.escape(ref) + r'\]\n*',
                    '\n\n', body
                ).strip()
            d['body'] = body
            img_tags  = re.findall(r'\[img:([^\]]+)\]', body)
            issues.append(f'R1: removed {len(repeated)} hero-duplicate [img:] tag(s)')
            stats['r1_fixed'].append(slug)
            changed = True

    # Rule 2: image_position must match hero orientation
    hero_disk = ref_to_disk(hero) if hero else ''
    if hero and os.path.exists(hero_disk):
        exp = correct_pos(hero_disk)
        if exp is None:
            issues.append(f'R2: identify failed on {hero_disk}')
            stats['r2_skipped'].append(slug)
        elif cur_pos != exp:
            d['image_position'] = exp
            issues.append(f'R2: image_position {cur_pos!r} => {exp!r}')
            stats['r2_fixed'].append(slug)
            changed = True
    elif hero and not os.path.exists(hero_disk):
        issues.append(f'R2: hero not on disk, skipping orientation check')
        stats['r2_skipped'].append(slug)

    # Rule 3: body [img:] must live under /assets/images/artists/
    bad = [t for t in img_tags if not valid_location(t.strip(), slug)]
    if bad:
        for ref in bad:
            body = re.sub(
                r'\n*\[img:' + re.escape(ref) + r'\]\n*',
                '\n\n', body
            ).strip()
        d['body']  = body
        img_tags   = re.findall(r'\[img:([^\]]+)\]', body)
        issues.append(f'R3: removed {len(bad)} irrelevant [img:] tag(s): {bad}')
        stats['r3_fixed'].append(slug)
        changed = True

    # Rule 4a: hero image must exist on disk
    if hero and not os.path.exists(hero_disk):
        issues.append(f'R4: hero missing on disk ({hero}), flagged only')
        stats['r4_hero_missing'].append(slug)

    # Rule 4b: body [img:] refs must exist on disk
    missing = [t for t in img_tags if not os.path.exists(ref_to_disk(t.strip()))]
    if missing:
        for ref in missing:
            body = re.sub(
                r'\n*\[img:' + re.escape(ref) + r'\]\n*',
                '\n\n', body
            ).strip()
        d['body']  = body
        img_tags   = re.findall(r'\[img:([^\]]+)\]', body)
        issues.append(f'R4: removed {len(missing)} missing [img:] tag(s): {missing}')
        stats['r4_body_fixed'].append(slug)
        changed = True

    # Rule 5: at least one [img:] in body (log only, no auto-fix)
    if not img_tags:
        issues.append('R5: no body [img:] tags (logged, not auto-fixed)')
        stats['r5_logged'].append(slug)

    if issues:
        for msg in issues:
            print(f'  {msg}')
    else:
        print('  OK')

    if changed:
        with open(post_path, 'w') as f:
            json.dump(d, f, indent=2, ensure_ascii=False)
        print('  Saved.')

print()
print('=' * 54)
print('SUMMARY')
print('=' * 54)
print(f"Posts checked:               {stats['checked']}")
print(f"R1 fixed (hero dup removed): {len(stats['r1_fixed'])}  {stats['r1_fixed']}")
print(f"R2 fixed (image_position):   {len(stats['r2_fixed'])}  {stats['r2_fixed']}")
print(f"R2 skipped (dims unknown):   {len(stats['r2_skipped'])}  {stats['r2_skipped']}")
print(f"R3 fixed (irrelevant imgs):  {len(stats['r3_fixed'])}  {stats['r3_fixed']}")
print(f"R4 body fixed (img missing): {len(stats['r4_body_fixed'])}  {stats['r4_body_fixed']}")
print(f"R4 hero missing (flag only): {len(stats['r4_hero_missing'])}  {stats['r4_hero_missing']}")
print(f"R5 logged (no [img:] body):  {len(stats['r5_logged'])}  {stats['r5_logged']}")
PYEOF
