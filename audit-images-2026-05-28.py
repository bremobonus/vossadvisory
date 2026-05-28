#!/usr/bin/env python3
"""
artonly.io image framing audit and fix script.
Run on the DreamHost server:
  python3 audit-images-2026-05-28.py

Rules enforced:
  1. No repeated images: hero must not appear as [img:] in body.
  2. image_position: portrait (h>w) => "center top", landscape (w>h) => "center 20%".
  3. No irrelevant images: [img:] path must be under /assets/images/artists/ or slug subdir.
  4. Image exists: [img:] and hero paths must exist on disk.
  5. Minimum images: log if body has zero [img:] tags (no auto-fix).
"""

import json
import os
import re
import subprocess
import sys

POSTS_DIR = "/home/dh_yadmw3/artonly.io/posts"
IMAGES_BASE = "/home/dh_yadmw3/artonly.io"
VALID_IMG_PREFIXES = ["/assets/images/artists/"]

FIXES = {
    "rule1_repeated": 0,
    "rule2_position": 0,
    "rule3_irrelevant": 0,
    "rule4_missing": 0,
}
LOGGED_NO_BODY_IMG = []
POSTS_CHECKED = 0


def get_image_dims(abs_path):
    """Return (width, height) or None if identify fails."""
    env = os.environ.copy()
    env["OMP_NUM_THREADS"] = "1"
    try:
        result = subprocess.run(
            ["identify", "-format", "%wx%h", abs_path],
            capture_output=True,
            text=True,
            env=env,
            timeout=15,
        )
        if result.returncode == 0:
            parts = result.stdout.strip().split("x")
            if len(parts) == 2:
                return int(parts[0]), int(parts[1])
    except Exception as e:
        print(f"    identify failed for {abs_path}: {e}")
    return None


def correct_position(abs_path, current_pos, slug):
    dims = get_image_dims(abs_path)
    if dims is None:
        print(f"    [WARN] Cannot check dimensions for {abs_path}, skipping position fix.")
        return current_pos
    w, h = dims
    if h > w:
        correct = "center top"
    else:
        correct = "center 20%"
    if current_pos != correct:
        print(f"    [RULE2] {slug}: image_position '{current_pos}' => '{correct}' ({w}x{h})")
        return correct
    return current_pos


def is_valid_img_path(path, slug):
    for prefix in VALID_IMG_PREFIXES:
        if path.startswith(prefix):
            return True
    slug_dir = f"/assets/images/artists/{slug}/"
    if path.startswith(slug_dir):
        return True
    return False


def image_exists_on_disk(path):
    abs_path = IMAGES_BASE + path
    return os.path.isfile(abs_path)


def remove_dash_punctuation(text):
    """Replace em-dash and en-dash punctuation with a comma or space (no dashes as punctuation)."""
    text = re.sub(r"—", ", ", text)
    text = re.sub(r"–", " ", text)
    return text


def audit_fix_post(filepath):
    global POSTS_CHECKED
    POSTS_CHECKED += 1

    with open(filepath, "r", encoding="utf-8") as f:
        post = json.load(f)

    slug = post.get("slug", os.path.basename(filepath).replace(".json", ""))
    hero = post.get("image", "")
    body = post.get("body", "")
    image_pos = post.get("image_position", "")
    modified = False

    print(f"\n[{slug}]")

    # Rule 4: Check hero image exists
    if hero:
        abs_hero = IMAGES_BASE + hero
        if not os.path.isfile(abs_hero):
            print(f"  [RULE4] Hero image missing on disk: {hero}")
            FIXES["rule4_missing"] += 1
        else:
            print(f"  hero: {hero} (exists)")
    else:
        print(f"  [WARN] No hero image set")

    # Parse [img:] tags from body
    img_tag_pattern = re.compile(r"\[img:([^\]]+)\]")
    img_tags = img_tag_pattern.findall(body)

    # Rule 1: Remove hero image from body if it appears as [img:]
    if hero and hero in img_tags:
        count_before = body.count(f"[img:{hero}]")
        body = re.sub(re.escape(f"[img:{hero}]"), "", body)
        FIXES["rule1_repeated"] += count_before
        modified = True
        print(f"  [RULE1] Removed {count_before} repeated hero [img:] from body")

    # Re-parse after rule1 fix
    img_tags = img_tag_pattern.findall(body)

    # Rule 3 and Rule 4: Check each remaining [img:] tag
    tags_to_remove = []
    for tag_path in img_tags:
        tag_path = tag_path.strip()
        # Rule 3: path must be under /assets/images/artists/
        if not is_valid_img_path(tag_path, slug):
            print(f"  [RULE3] Irrelevant [img:] path: {tag_path}")
            tags_to_remove.append(tag_path)
            FIXES["rule3_irrelevant"] += 1
            continue
        # Rule 4: image must exist on disk
        if not image_exists_on_disk(tag_path):
            print(f"  [RULE4] Missing file for [img:]: {tag_path}")
            tags_to_remove.append(tag_path)
            FIXES["rule4_missing"] += 1

    for tp in tags_to_remove:
        body = re.sub(re.escape(f"[img:{tp}]"), "", body)
        modified = True

    # Re-parse final [img:] list
    img_tags_final = img_tag_pattern.findall(body)

    # Rule 5: Log if no body [img:] tags remain
    if not img_tags_final:
        LOGGED_NO_BODY_IMG.append(slug)
        print(f"  [RULE5] No body [img:] tags (logged only)")

    # Rule 2: Check image_position
    if hero:
        abs_hero = IMAGES_BASE + hero
        if os.path.isfile(abs_hero):
            valid_positions = {"center top", "center 20%"}
            if image_pos not in valid_positions:
                new_pos = correct_position(abs_hero, image_pos, slug)
                if new_pos != image_pos:
                    post["image_position"] = new_pos
                    modified = True
                    FIXES["rule2_position"] += 1
            else:
                corrected = correct_position(abs_hero, image_pos, slug)
                if corrected != image_pos:
                    post["image_position"] = corrected
                    modified = True
                    FIXES["rule2_position"] += 1
                else:
                    print(f"  image_position: '{image_pos}' (correct)")

    # Apply dash-as-punctuation cleanup if body was touched
    if modified:
        body = remove_dash_punctuation(body)
        post["body"] = body
        with open(filepath, "w", encoding="utf-8") as f:
            json.dump(post, f, ensure_ascii=False, indent=2)
        print(f"  => Saved fixes to {filepath}")
    else:
        print(f"  => No changes needed")


def main():
    if not os.path.isdir(POSTS_DIR):
        print(f"Posts directory not found: {POSTS_DIR}")
        sys.exit(1)

    post_files = sorted(
        [
            os.path.join(POSTS_DIR, f)
            for f in os.listdir(POSTS_DIR)
            if f.endswith(".json")
        ]
    )

    if not post_files:
        print(f"No .json files found in {POSTS_DIR}")
        sys.exit(0)

    print(f"=== artonly.io image audit: {len(post_files)} posts ===\n")

    for pf in post_files:
        audit_fix_post(pf)

    print("\n=== SUMMARY ===")
    print(f"Posts checked:          {POSTS_CHECKED}")
    print(f"Rule1 fixes (repeated): {FIXES['rule1_repeated']}")
    print(f"Rule2 fixes (position): {FIXES['rule2_position']}")
    print(f"Rule3 fixes (irrelevant): {FIXES['rule3_irrelevant']}")
    print(f"Rule4 fixes (missing):  {FIXES['rule4_missing']}")
    print(
        f"Rule5 logged (no body imgs): {len(LOGGED_NO_BODY_IMG)} => "
        + ", ".join(LOGGED_NO_BODY_IMG)
    )


if __name__ == "__main__":
    main()
