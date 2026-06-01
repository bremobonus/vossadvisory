#!/usr/bin/env python3
"""artonly.io SEO audit - run weekly Monday 6am UTC"""

import json
import os
import re
import glob

BASE_DIR = "/home/user/vossadvisory"
ARTONLY_ROOT = os.path.expanduser("~/artonly.io")

# Counters
total_checked = 0
descriptions_added = []
alts_added = []
dashes_fixed = []
long_titles = []
missing_images = []
dash_detail = []


def strip_media_tags(text):
    """Remove [img:...], [download:...|...], [spotify:...] tags."""
    text = re.sub(r'\[img:[^\]]*\]', '', text)
    text = re.sub(r'\[download:[^\]]*\]', '', text)
    text = re.sub(r'\[spotify:[^\]]*\]', '', text)
    return text.strip()


def make_description(body):
    """Generate a 155-char description from post body."""
    clean = strip_media_tags(body)
    # Remove markdown headings
    clean = re.sub(r'^#+\s+', '', clean, flags=re.MULTILINE)
    # Collapse whitespace
    clean = re.sub(r'\s+', ' ', clean).strip()
    if len(clean) > 155:
        # Trim at last word boundary before 152 chars
        trimmed = clean[:152]
        last_space = trimmed.rfind(' ')
        if last_space > 100:
            trimmed = trimmed[:last_space]
        clean = trimmed + '...'
    return clean


def fix_em_dash(text):
    """Replace em dashes with comma or period based on context."""
    count = 0
    def replace_em(m):
        nonlocal count
        before = m.string[:m.start()].rstrip()
        after = m.string[m.end():].lstrip()
        # If followed by capital letter or start of new clause -> period
        if after and after[0].isupper():
            count += 1
            return '. '
        else:
            count += 1
            return ', '
    result = re.sub(r'\s*—\s*', replace_em, text)
    return result, count


def fix_en_dash(text):
    """Replace en dashes with 'to' (numeric ranges) or comma."""
    count = 0
    def replace_en(m):
        nonlocal count
        before = m.string[:m.start()]
        after = m.string[m.end():]
        # If surrounded by digits/years -> 'to'
        before_char = before[-1] if before else ''
        after_char = after[0] if after else ''
        if before_char.isdigit() and after_char.isdigit():
            count += 1
            return ' to '
        else:
            count += 1
            return ', '
    result = re.sub(r'\s*–\s*', replace_en, text)
    return result, count


# Find all post files
all_json = sorted(glob.glob(os.path.join(BASE_DIR, "*.json")))
post_files = []
for path in all_json:
    try:
        d = json.load(open(path))
        if 'slug' in d and 'body' in d and 'title' in d:
            post_files.append(path)
    except Exception:
        pass

print(f"Found {len(post_files)} post files.\n")

for path in post_files:
    fname = os.path.basename(path)
    changed = False

    with open(path, 'r') as f:
        post = json.load(f)

    total_checked += 1
    slug = post.get('slug', fname)
    title = post.get('title', '')
    body = post.get('body', '')

    # 1. DESCRIPTION
    desc = post.get('description', '').strip()
    if not desc:
        new_desc = make_description(body)
        post['description'] = new_desc
        descriptions_added.append(slug)
        changed = True
        print(f"[DESC ADDED] {slug}")
        print(f"  -> {new_desc[:80]}...")

    # 2. IMAGE ALT
    if 'image_alt' not in post or not post.get('image_alt', '').strip():
        post['image_alt'] = title
        alts_added.append(slug)
        changed = True
        print(f"[ALT ADDED]  {slug}")

    # 3. DASHES
    em_count = body.count('—')
    en_count = body.count('–')
    if em_count > 0 or en_count > 0:
        new_body = body
        if em_count > 0:
            new_body, fixed_em = fix_em_dash(new_body)
        else:
            fixed_em = 0
        if en_count > 0:
            new_body, fixed_en = fix_en_dash(new_body)
        else:
            fixed_en = 0
        total_fixed = fixed_em + fixed_en
        if total_fixed > 0:
            post['body'] = new_body
            dashes_fixed.append(slug)
            detail = f"{slug}: {fixed_em} em-dash(es), {fixed_en} en-dash(es)"
            dash_detail.append(detail)
            changed = True
            print(f"[DASHES]     {detail}")

    # 4. TITLE LENGTH
    if len(title) > 70:
        long_titles.append({'slug': slug, 'length': len(title), 'title': title})
        print(f"[LONG TITLE] {slug} ({len(title)} chars): {title[:60]}...")

    # 5. MISSING HERO IMAGE
    img_path = post.get('image', '')
    if img_path:
        full_img_path = ARTONLY_ROOT + img_path
        if not os.path.exists(full_img_path):
            missing_images.append({'slug': slug, 'path': full_img_path})
            print(f"[MISSING IMG] {slug} -> {full_img_path}")

    # 6. SAVE if changed
    if changed:
        with open(path, 'w') as f:
            json.dump(post, f, indent=2, ensure_ascii=False)
            f.write('\n')
        print(f"  [SAVED] {fname}")

    print()

# Print summary
print("\n" + "="*60)
print("SEO AUDIT SUMMARY")
print("="*60)
print(f"Total posts checked:    {total_checked}")
print(f"Descriptions added:     {len(descriptions_added)}")
print(f"Image alts added:       {len(alts_added)}")
print(f"Dashes fixed (posts):   {len(dashes_fixed)}")
print(f"Long titles (>70 chars):{len(long_titles)}")
print(f"Missing hero images:    {len(missing_images)}")

if long_titles:
    print("\nLong titles:")
    for lt in long_titles:
        print(f"  {lt['slug']} ({lt['length']} chars): {lt['title']}")

if missing_images:
    print("\nMissing images:")
    for mi in missing_images:
        print(f"  {mi['slug']}: {mi['path']}")

if dash_detail:
    print("\nDash fixes:")
    for d in dash_detail:
        print(f"  {d}")

# Store results for email
RESULTS = {
    'total_checked': total_checked,
    'descriptions_added': descriptions_added,
    'alts_added': alts_added,
    'dashes_fixed': dashes_fixed,
    'dash_detail': dash_detail,
    'long_titles': long_titles,
    'missing_images': missing_images,
}

import pickle
with open('/tmp/seo_audit_results.pkl', 'wb') as f:
    pickle.dump(RESULTS, f)
print("\nResults saved to /tmp/seo_audit_results.pkl")
