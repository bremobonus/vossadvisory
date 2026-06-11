#!/bin/bash
# ArtOnly Social Card Audit + Generation
# Finds all posts missing [download:] tags, generates cards, updates JSON.
# Run via GitHub Actions workflow (deploy-artonly.yml) with this script name.

echo "=== ArtOnly Social Card Audit: $(date) ==="

python3 << 'PYEOF'
import json, os, glob, subprocess, shutil, re

POSTS_DIR  = "/home/dh_yadmw3/artonly.io/posts"
IMAGES_DIR = "/home/dh_yadmw3/artonly.io/assets/images/artists"
AGENT_DIR  = "/home/dh_yadmw3/artonly.io/agent"
SITE_ROOT  = "/home/dh_yadmw3/artonly.io"

generated   = []
skipped     = []
failed      = []
fixed_paths = []

# ── Load all posts ──────────────────────────────────────────────────────────
all_posts = []
for p in sorted(glob.glob(f"{POSTS_DIR}/*.json")):
    with open(p) as f:
        try:
            d = json.load(f)
        except Exception as e:
            print(f"PARSE ERROR: {p}: {e}")
            continue
    all_posts.append((p, d))

print(f"Total posts found: {len(all_posts)}")

# ── Step 1: Fix posts where [download:] path is missing /assets/images/artists/ prefix
BAD_DL = re.compile(r'\[download:(?!/assets/images/artists/)([^|\]]+)\|([^\]]+)\]')

for p, d in all_posts:
    body = d.get("body", "")
    def _fix(m):
        filename = os.path.basename(m.group(1).strip())
        label    = m.group(2)
        return f"[download:/assets/images/artists/{filename}|{label}]"
    new_body = BAD_DL.sub(_fix, body)
    if new_body != body:
        slug = d.get("slug", os.path.basename(p).replace(".json", ""))
        d["body"] = new_body
        with open(p, "w") as f:
            json.dump(d, f, indent=2, ensure_ascii=False)
        print(f"FIXED path: {slug}")
        fixed_paths.append(slug)

# ── Step 2: Find posts still missing [download:] ────────────────────────────
missing = [(p, d) for p, d in all_posts if "[download:" not in d.get("body", "")]
print(f"Posts missing social card download tag: {len(missing)}")

# ── Step 3: Generate social cards ───────────────────────────────────────────
for p, d in missing:
    slug     = d.get("slug", os.path.basename(p).replace(".json", ""))
    title    = d.get("title", slug)
    category = d.get("category", "music")
    image_field = d.get("image", "")

    print(f"\n--- {slug} ---")

    # Ensure hero image exists at IMAGES_DIR/{slug}.jpg
    hero_dest = f"{IMAGES_DIR}/{slug}.jpg"
    if not os.path.exists(hero_dest):
        if image_field:
            src = f"{SITE_ROOT}{image_field}"
            if os.path.exists(src):
                shutil.copy2(src, hero_dest)
                print(f"  Copied hero: {image_field} -> {hero_dest}")
            else:
                print(f"  SKIP: hero not found at {src}")
                skipped.append(slug)
                continue
        else:
            print(f"  SKIP: no image field in post")
            skipped.append(slug)
            continue

    # Run make-social-card.py
    env = os.environ.copy()
    env["OMP_NUM_THREADS"] = "1"
    cmd = ["python3", f"{AGENT_DIR}/make-social-card.py", slug, title, category]
    print(f"  Running: {' '.join(cmd[:3])} {slug!r} ...")
    try:
        result = subprocess.run(
            cmd, capture_output=True, text=True,
            env=env, cwd=AGENT_DIR, timeout=180
        )
        if result.returncode != 0:
            print(f"  FAILED (exit {result.returncode}): {result.stderr[:400]}")
            failed.append(slug)
            continue
        out = (result.stdout + result.stderr).strip()
        if out:
            print(f"  Script output: {out[:300]}")
    except subprocess.TimeoutExpired:
        print(f"  FAILED: timeout after 180s")
        failed.append(slug)
        continue
    except Exception as e:
        print(f"  FAILED: {e}")
        failed.append(slug)
        continue

    # Verify card file was created
    card_path = f"{IMAGES_DIR}/{slug}-social-9x16.jpg"
    if not os.path.exists(card_path):
        print(f"  FAILED: card not found at {card_path}")
        failed.append(slug)
        continue

    # Check rule #5: if first [img:] in body matches post["image"], swap it out
    body = d.get("body", "")
    img_pattern = re.compile(r'\[img:([^\]]+)\]')
    img_matches = img_pattern.findall(body)
    if img_matches and img_matches[0].split('|')[0].strip() == image_field:
        # Find the next unused image in the artist's folder
        slug_prefix = slug
        all_imgs = sorted(glob.glob(f"{IMAGES_DIR}/{slug_prefix}*.jpg"))
        # Exclude the hero and the social card
        exclude = {hero_dest, card_path}
        alts = [i for i in all_imgs if i not in exclude and not i.endswith("-social-9x16.jpg")]
        if alts:
            alt_rel = "/assets/images/artists/" + os.path.basename(alts[0])
            # Replace only the first [img:] occurrence
            old_tag = img_matches[0]
            new_tag = alt_rel
            body = body.replace(f"[img:{old_tag}]", f"[img:{new_tag}]", 1)
            print(f"  Swapped repeated hero img to: {alt_rel}")

    # Append download tag
    download_tag = f"[download:/assets/images/artists/{slug}-social-9x16.jpg|Download Social Card]"
    body = body.rstrip() + "\n\n" + download_tag
    d["body"] = body

    with open(p, "w") as f:
        json.dump(d, f, indent=2, ensure_ascii=False)

    print(f"  DONE")
    generated.append(slug)

# ── Summary ──────────────────────────────────────────────────────────────────
print(f"\n{'='*50}")
print(f"SUMMARY")
print(f"{'='*50}")
print(f"Generated:        {len(generated)}")
for s in generated:    print(f"  + {s}")
print(f"Fixed bad paths:  {len(fixed_paths)}")
for s in fixed_paths:  print(f"  ~ {s}")
print(f"Skipped (no img): {len(skipped)}")
for s in skipped:      print(f"  - {s}")
print(f"Failed:           {len(failed)}")
for s in failed:       print(f"  ! {s}")
print(f"{'='*50}")
PYEOF

echo "=== Audit complete ==="
