#!/usr/bin/env python3
"""
artonly.io image framing agent
Runs on the DreamHost server. Audits and fixes all posts in ~/artonly.io/posts/
"""

import json
import re
import os
import glob
import subprocess

POSTS_DIR = os.path.expanduser("~/artonly.io/posts")
IMAGES_BASE = os.path.expanduser("~/artonly.io/assets/images")
ARTISTS_DIR = os.path.expanduser("~/artonly.io/assets/images/artists")
SITE_ROOT = os.path.expanduser("~/artonly.io")


def get_image_dimensions(path):
    try:
        result = subprocess.run(
            ["identify", path],
            capture_output=True, text=True,
            env={**os.environ, "OMP_NUM_THREADS": "1"}
        )
        m = re.search(r"(\d+)x(\d+)", result.stdout)
        if m:
            return int(m.group(1)), int(m.group(2))
    except Exception:
        pass
    return None


def resolve_server_path(image_ref):
    ref = image_ref.strip().lstrip("/")
    return os.path.join(SITE_ROOT, ref)


def is_allowed_body_image(image_ref, slug):
    norm = image_ref.strip().lstrip("/")
    return ("assets/images/artists" in norm) or (f"assets/images/{slug}" in norm)


def main():
    post_files = sorted(glob.glob(os.path.join(POSTS_DIR, "*.json")))
    print(f"Found {len(post_files)} posts to audit.\n")

    stats = {
        "posts_checked": 0,
        "repeated_image_fixed": 0,
        "image_position_fixed": 0,
        "irrelevant_image_removed": 0,
        "missing_image_removed": 0,
        "no_body_images": 0,
    }

    for pf in post_files:
        slug = os.path.basename(pf).replace(".json", "")
        stats["posts_checked"] += 1

        try:
            with open(pf, "r", encoding="utf-8") as f:
                post = json.load(f)
        except Exception as e:
            print(f"  [WARN] Could not parse {pf}: {e}")
            continue

        modified = False
        violations = []

        hero = post.get("image", "")
        body = post.get("body", "")

        # Rule 1: no repeated hero in body
        if hero and body:
            hero_basename = os.path.basename(hero.strip())
            for tag in re.findall(r'\[img:[^\]]+\]', body):
                m = re.match(r'\[img:([^\]|]+)', tag)
                if not m:
                    continue
                img_path = m.group(1).strip()
                if (img_path.strip("/") == hero.strip("/") or
                        os.path.basename(img_path) == hero_basename):
                    body = body.replace(tag, "")
                    body = re.sub(r'\n{3,}', '\n\n', body).strip()
                    post["body"] = body
                    modified = True
                    stats["repeated_image_fixed"] += 1
                    violations.append(f"RULE1 fixed: removed repeated hero [{img_path}]")

        # Rule 2: image_position based on actual dimensions
        if hero:
            hero_path = resolve_server_path(hero)
            dims = get_image_dimensions(hero_path)
            if dims:
                w, h = dims
                correct_pos = "center top" if h > w else "center 20%"
                current_pos = post.get("image_position")
                if current_pos != correct_pos:
                    post["image_position"] = correct_pos
                    modified = True
                    stats["image_position_fixed"] += 1
                    violations.append(
                        f"RULE2 fixed: image_position '{current_pos}' -> '{correct_pos}' ({w}x{h})"
                    )
            elif not os.path.exists(hero_path):
                violations.append(f"RULE4 flag: hero image missing on disk [{hero}]")

        # Rule 3: no irrelevant body images
        body = post.get("body", "")
        for tag in re.findall(r'\[img:[^\]]+\]', body):
            m = re.match(r'\[img:([^\]|]+)', tag)
            if not m:
                continue
            img_path = m.group(1).strip()
            if not is_allowed_body_image(img_path, slug):
                body = body.replace(tag, "")
                body = re.sub(r'\n{3,}', '\n\n', body).strip()
                post["body"] = body
                modified = True
                stats["irrelevant_image_removed"] += 1
                violations.append(f"RULE3 fixed: removed irrelevant image [{img_path}]")

        # Rule 4: body images must exist on disk
        body = post.get("body", "")
        for tag in re.findall(r'\[img:[^\]]+\]', body):
            m = re.match(r'\[img:([^\]|]+)', tag)
            if not m:
                continue
            img_path = m.group(1).strip()
            full_path = resolve_server_path(img_path)
            if not os.path.exists(full_path):
                body = body.replace(tag, "")
                body = re.sub(r'\n{3,}', '\n\n', body).strip()
                post["body"] = body
                modified = True
                stats["missing_image_removed"] += 1
                violations.append(f"RULE4 fixed: removed missing image [{img_path}]")

        # Rule 5: minimum one [img:] in body (log only)
        body = post.get("body", "")
        remaining = re.findall(r'\[img:[^\]]+\]', body)
        if not remaining:
            stats["no_body_images"] += 1
            violations.append("RULE5 log: zero [img:] tags in body")

        if modified:
            with open(pf, "w", encoding="utf-8") as f:
                json.dump(post, f, ensure_ascii=False, indent=2)
            print(f"  [FIXED]  {slug}")
            for v in violations:
                print(f"           {v}")
        elif violations:
            print(f"  [INFO]   {slug}")
            for v in violations:
                print(f"           {v}")
        else:
            print(f"  [OK]     {slug}")

    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    print(f"Posts checked:               {stats['posts_checked']}")
    print(f"Repeated hero in body fixed: {stats['repeated_image_fixed']}")
    print(f"Image position fixed:        {stats['image_position_fixed']}")
    print(f"Irrelevant images removed:   {stats['irrelevant_image_removed']}")
    print(f"Missing images removed:      {stats['missing_image_removed']}")
    print(f"Posts with no body images:   {stats['no_body_images']} (logged only)")
    total = (stats['repeated_image_fixed'] + stats['image_position_fixed'] +
             stats['irrelevant_image_removed'] + stats['missing_image_removed'])
    print(f"Total fixes applied:         {total}")
    print("=" * 60)


if __name__ == "__main__":
    main()
