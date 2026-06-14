#!/bin/bash
# ArtOnly Image Framing Audit — full server-side run
# Generated: 2026-06-14
# Rules enforced: 1 (no hero dupe), 2 (image_position), 3 (no irrelevant img),
#                 4 (file existence), 5 (min one body img, logged only)
# Touches no body text with em/en dashes.

set -e
echo "=== ArtOnly Image Audit: $(date) ==="

python3 << 'PYEOF'
import json, re, glob, os, subprocess

SITE     = '/home/dh_yadmw3/artonly.io'
POSTS    = SITE + '/posts'
ARTISTS  = '/assets/images/artists/'
PLACEHOLDER = '/assets/images/placeholder.jpg'

# ------------------------------------------------------------------ helpers

def disk(rel_path):
    """Absolute path for a site-relative path."""
    if rel_path.startswith('/assets/'):
        return SITE + rel_path
    return rel_path

def exists(rel_path):
    if not rel_path:
        return False
    return os.path.exists(disk(rel_path))

def img_dims(rel_path):
    """Returns (w, h) or None. Uses ImageMagick identify."""
    full = disk(rel_path)
    if not os.path.exists(full):
        return None
    try:
        env = os.environ.copy()
        env['OMP_NUM_THREADS'] = '1'
        r = subprocess.run(
            ['identify', '-format', '%w %h', full + '[0]'],
            capture_output=True, text=True, timeout=15, env=env
        )
        parts = r.stdout.strip().split()
        if len(parts) >= 2:
            return int(parts[0]), int(parts[1])
    except Exception:
        pass
    return None

def correct_position(w, h):
    return 'center top' if h > w else 'center 20%'

def body_imgs(body):
    return re.findall(r'\[img:([^\]]+)\]', body)

def remove_img(body, path):
    return re.sub(r'\n?\[img:' + re.escape(path) + r'\]\n?', '\n\n', body)

def strip_dashes(body):
    """Replace em dashes and en dashes with comma-space or plain space."""
    body = re.sub(r'\s*—\s*', ', ', body)   # em dash
    body = re.sub(r'\s*–\s*', ' ', body)     # en dash
    return body

def allowed_img(path, slug):
    norm = path.replace('\\', '/')
    if ARTISTS in norm:
        return True
    if f'/assets/images/{slug}' in norm:
        return True
    parts = norm.split('/')
    return slug in parts

# ------------------------------------------------------------------ scan

files = sorted(glob.glob(POSTS + '/*.json'))

counts = dict(checked=0, modified=0,
              rule1=0, rule2=0, rule3=0,
              rule4_hero=0, rule4_body=0)
no_body_imgs = []

for fpath in files:
    try:
        size = os.path.getsize(fpath)
    except OSError:
        continue
    if size < 10:
        continue

    try:
        post = json.load(open(fpath, encoding='utf-8'))
    except Exception as e:
        print(f'  PARSE ERROR {os.path.basename(fpath)}: {e}')
        continue

    if not isinstance(post, dict) or 'slug' not in post:
        continue

    counts['checked'] += 1
    slug    = post.get('slug', '')
    hero    = post.get('image', '')
    body    = post.get('body', '')
    ip      = post.get('image_position', '')
    changes = []
    modified = False

    # ---- Rule 1: hero must not appear in body as [img:] -----------------
    if hero and body:
        hero_base = hero.rstrip('/').split('/')[-1]
        for tag in body_imgs(body):
            tag_norm = tag.strip().rstrip('/')
            if tag_norm == hero.strip().rstrip('/') or tag_norm.split('/')[-1] == hero_base:
                body = remove_img(body, tag)
                changes.append(f'Rule1: removed hero duplicate [{tag}] from body')
                counts['rule1'] += 1
                modified = True

    # ---- Rule 4a: hero must exist on disk --------------------------------
    if hero and not exists(hero):
        changes.append(f'Rule4: hero NOT on disk: {hero}  ->  placeholder')
        post['image'] = PLACEHOLDER
        hero = PLACEHOLDER
        counts['rule4_hero'] += 1
        modified = True

    # ---- Rule 3: body [img:] must be in /artists/ or slug dir -----------
    if body:
        for tag in body_imgs(body):
            if not allowed_img(tag, slug):
                body = remove_img(body, tag)
                changes.append(f'Rule3: removed irrelevant image [{tag}]')
                counts['rule3'] += 1
                modified = True

    # ---- Rule 4b: body [img:] must exist on disk -------------------------
    if body:
        for tag in list(body_imgs(body)):
            if not exists(tag):
                body = remove_img(body, tag)
                changes.append(f'Rule4: removed missing body image [{tag}]')
                counts['rule4_body'] += 1
                modified = True

    # ---- Rule 2: image_position based on actual hero dimensions ----------
    check_hero = post.get('image', hero)
    if check_hero and check_hero != PLACEHOLDER:
        dims = img_dims(check_hero)
        if dims:
            w, h = dims
            want = correct_position(w, h)
            if not ip or ip != want:
                old = ip or '(none)'
                post['image_position'] = want
                changes.append(f'Rule2: image_position {old} -> {want}  ({w}x{h})')
                counts['rule2'] += 1
                modified = True

    # ---- Zero-dash enforcement on any body we touch ----------------------
    if modified and body:
        cleaned = strip_dashes(body)
        if cleaned != body:
            body = cleaned
            changes.append('Style: stripped em/en dashes from body')

    # ---- Rule 5: log posts with no body [img:] (do not auto-fix) --------
    # collapse whitespace before counting so removed tags leave nothing
    body = re.sub(r'\n{3,}', '\n\n', body)
    if not body_imgs(body):
        no_body_imgs.append(slug)

    # ---- Write back if changed -------------------------------------------
    if modified:
        post['body'] = body
        with open(fpath, 'w', encoding='utf-8') as f:
            json.dump(post, f, indent=2, ensure_ascii=False)
            f.write('\n')
        counts['modified'] += 1
        print(f'FIXED {os.path.basename(fpath)}:')
        for c in changes:
            print(f'  {c}')
    else:
        print(f'OK    {os.path.basename(fpath)}')

# ------------------------------------------------------------------ summary

print()
print('=' * 60)
print('ARTONLY.IO IMAGE AUDIT SUMMARY')
print('=' * 60)
print(f"Posts checked:               {counts['checked']}")
print(f"Posts modified:              {counts['modified']}")
print(f"  Rule1 (hero dupe):         {counts['rule1']}")
print(f"  Rule2 (image_position):    {counts['rule2']}")
print(f"  Rule3 (irrelevant img):    {counts['rule3']}")
print(f"  Rule4 (missing hero):      {counts['rule4_hero']}")
print(f"  Rule4 (missing body img):  {counts['rule4_body']}")
if no_body_imgs:
    print(f"\nRule5 (no body [img:]) - logged, not auto-fixed:")
    for s in no_body_imgs:
        print(f"  - {s}")
print('=' * 60)
PYEOF

echo "=== Audit complete ==="
