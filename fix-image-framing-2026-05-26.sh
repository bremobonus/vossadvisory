#!/bin/bash
# ArtOnly Image Framing Agent - 2026-05-26
# Audits and fixes all posts: hero duplication, image_position, irrelevant/missing images
set -e
echo "=== ArtOnly Image Framing Fix: 2026-05-26 ==="

python3 << 'PYEOF'
import json, os, glob, subprocess, re, sys

POSTS_DIR  = "/home/dh_yadmw3/artonly.io/posts"
SITE_ROOT  = "/home/dh_yadmw3/artonly.io"
VALID_BASE = "/assets/images/artists"

def identify_dims(path):
    env = {**os.environ, "OMP_NUM_THREADS": "1"}
    try:
        r = subprocess.run(["identify", path], capture_output=True, text=True, env=env)
        m = re.search(r" (\d+)x(\d+) ", r.stdout)
        if m:
            return int(m.group(1)), int(m.group(2))
    except Exception:
        pass
    return None, None

def correct_position(w, h):
    if w is None or h is None:
        return None
    return "center top" if h > w else "center 20%"

def body_img_paths(body):
    return re.findall(r'\[img:([^\]]+)\]', body)

stats = dict(checked=0, rule1=0, rule2=0, rule3=0, rule4=0, rule5_log=0)
posts = sorted(glob.glob(os.path.join(POSTS_DIR, "*.json")))
print(f"Posts found: {len(posts)}\n")

for path in posts:
    with open(path) as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError as e:
            print(f"PARSE ERROR {path}: {e}")
            continue

    stats["checked"] += 1
    slug   = data.get("slug", os.path.basename(path).replace(".json", ""))
    hero   = data.get("image", "")
    body   = data.get("body", "")
    ipos   = data.get("image_position", "")
    dirty  = False

    print(f"[{slug}]")

    # ---- Rule 1: hero must not appear as [img:] in body ----
    if hero:
        tag = f"[img:{hero}]"
        if tag in body:
            body = body.replace(tag, "")
            dirty = True
            stats["rule1"] += 1
            print(f"  RULE1 FIX: removed repeated hero tag from body")

    # ---- Resolve hero disk path ----
    hero_disk = os.path.join(SITE_ROOT, hero.lstrip("/")) if hero else None

    # ---- Rule 4: hero file missing? ----
    if hero_disk and not os.path.exists(hero_disk):
        stats["rule4"] += 1
        print(f"  RULE4 FLAG: hero image missing on disk: {hero_disk}")
        # Leave hero field; flag only (no automatic placeholder replacement without manual review)

    # ---- Rule 2: image_position ----
    if hero_disk and os.path.exists(hero_disk):
        w, h = identify_dims(hero_disk)
        if w and h:
            orientation = "portrait" if h > w else "landscape"
            want = correct_position(w, h)
            print(f"  Dimensions: {w}x{h} ({orientation}) -> want image_position={want!r}")
            if ipos != want:
                data["image_position"] = want
                dirty = True
                stats["rule2"] += 1
                print(f"  RULE2 FIX: {ipos!r} -> {want!r}")
        else:
            print(f"  RULE2 WARN: could not read dimensions for {hero_disk}")
    elif not hero:
        if not ipos:
            print(f"  RULE2 WARN: no hero image and no image_position set")

    # ---- Check body [img:] tags ----
    img_tags = body_img_paths(body)

    # Rule 5: no body images
    if not img_tags:
        stats["rule5_log"] += 1
        print(f"  RULE5 LOG: zero [img:] tags in body (not auto-fixed)")

    # Rules 3 & 4 on body images
    for img_path in list(img_tags):
        valid_prefixes = (
            f"{VALID_BASE}/",
            f"{VALID_BASE}/{slug}/",
        )
        # Rule 3: irrelevant path
        if not any(img_path.startswith(p) for p in valid_prefixes):
            body = body.replace(f"[img:{img_path}]", "")
            dirty = True
            stats["rule3"] += 1
            print(f"  RULE3 FIX: removed irrelevant [img:{img_path}]")
            continue
        # Rule 4: file exists?
        img_disk = os.path.join(SITE_ROOT, img_path.lstrip("/"))
        if not os.path.exists(img_disk):
            body = body.replace(f"[img:{img_path}]", "")
            dirty = True
            stats["rule4"] += 1
            print(f"  RULE4 FIX: removed missing [img:{img_path}]")

    if dirty:
        data["body"] = body
        with open(path, "w") as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        print(f"  SAVED")
    else:
        print(f"  OK (no changes)")

print()
print("=== SUMMARY ===")
print(f"Posts checked          : {stats['checked']}")
print(f"Rule 1 fixes (dup hero): {stats['rule1']}")
print(f"Rule 2 fixes (position): {stats['rule2']}")
print(f"Rule 3 fixes (irrelevant img): {stats['rule3']}")
print(f"Rule 4 fixes (missing img): {stats['rule4']}")
print(f"Rule 5 logged (no body imgs): {stats['rule5_log']}")
PYEOF

echo "=== Fix complete ==="
