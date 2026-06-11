#!/usr/bin/env python3
"""
artonly.io image framing audit — local mode.
Works on posts/*.json in the working directory.
Applies all rules checkable without SSH; reports Rule 2/4 status
that require server-side image data as warnings.
"""

import json
import re
import os
import glob

POSTS_GLOB = "/home/user/vossadvisory/*.json"
ARTISTS_PATH_FRAGMENT = "/assets/images/artists/"

# Files that are not post files
NON_POST_FILES = {
    "wikipedia_brain", "reddit-log", "reddit-queue", "press-log",
    "newsletter-log", "outreach-log", "push_brain", "reddit-log-2026-06-05",
}

def is_post_file(path):
    name = os.path.basename(path).replace(".json", "")
    for skip in NON_POST_FILES:
        if name.startswith(skip) or name == skip:
            return False
    return True

def extract_img_tags(body):
    return re.findall(r'\[img:([^\]]+)\]', body)

def extract_download_tags(body):
    return re.findall(r'\[download:([^\]|]+)', body)

def remove_img_tag(body, filepath):
    escaped = re.escape(filepath)
    return re.sub(r'\[img:' + escaped + r'\]', '', body)

def is_allowed_image_path(img_path, slug):
    normalized = img_path.replace("\\", "/")
    if ARTISTS_PATH_FRAGMENT in normalized:
        return True
    if f"/assets/images/{slug}" in normalized:
        return True
    parts = normalized.split("/")
    if slug in parts:
        return True
    return False

def audit_posts():
    all_files = sorted(glob.glob(POSTS_GLOB))
    post_files = [f for f in all_files if is_post_file(f)]

    print(f"Scanning {len(post_files)} post files...\n")

    summary = {
        "posts_checked": 0,
        "posts_modified": [],
        "hero_in_body_removed": 0,
        "irrelevant_images_removed": 0,
        "posts_with_no_body_images": [],
        "image_position_warnings": [],
        "missing_image_warnings": [],
        "parse_errors": [],
    }

    for path in post_files:
        name = os.path.basename(path)
        slug = name.replace(".json", "")
        summary["posts_checked"] += 1
        modified = False
        changes = []

        try:
            with open(path, "r", encoding="utf-8") as f:
                post = json.load(f)
        except Exception as e:
            summary["parse_errors"].append(f"{name}: {e}")
            continue

        hero = post.get("image", "")
        body = post.get("body", "")
        image_position = post.get("image_position")

        # ----------------------------------------------------------------
        # RULE 1: hero must not appear as [img:] in body
        # ----------------------------------------------------------------
        if hero and body:
            img_tags = extract_img_tags(body)
            hero_basename = hero.rstrip("/").split("/")[-1]
            for tag_path in img_tags:
                tag_norm = tag_path.strip().rstrip("/")
                hero_norm = hero.strip().rstrip("/")
                tag_basename = tag_norm.split("/")[-1]
                if tag_norm == hero_norm or (hero_basename and tag_basename == hero_basename):
                    body = remove_img_tag(body, tag_path)
                    changes.append(f"Rule 1: removed hero image [{tag_path}] from body")
                    summary["hero_in_body_removed"] += 1
                    modified = True

        # ----------------------------------------------------------------
        # RULE 2: image_position — note if missing (can't check dims locally)
        # ----------------------------------------------------------------
        if not image_position:
            summary["image_position_warnings"].append(
                f"{slug}: image_position missing (needs server-side identify)"
            )

        # ----------------------------------------------------------------
        # RULE 3: no irrelevant [img:] in body
        # ----------------------------------------------------------------
        if body:
            img_tags = extract_img_tags(body)
            for tag_path in img_tags:
                if not is_allowed_image_path(tag_path, slug):
                    body = remove_img_tag(body, tag_path)
                    changes.append(f"Rule 3: removed irrelevant image [{tag_path}]")
                    summary["irrelevant_images_removed"] += 1
                    modified = True

        # ----------------------------------------------------------------
        # RULE 4: warn about hero image paths that look suspicious
        #         (can't confirm file existence without SSH)
        # ----------------------------------------------------------------
        if hero and not hero.startswith("/assets/"):
            summary["missing_image_warnings"].append(
                f"{slug}: hero path '{hero}' doesn't follow /assets/ convention"
            )

        # ----------------------------------------------------------------
        # RULE 5: body must have at least one [img:] tag
        # ----------------------------------------------------------------
        remaining_img = extract_img_tags(body)
        if len(remaining_img) == 0:
            summary["posts_with_no_body_images"].append(slug)

        # ----------------------------------------------------------------
        # Write back if changed
        # ----------------------------------------------------------------
        if modified:
            post["body"] = body
            with open(path, "w", encoding="utf-8") as f:
                json.dump(post, f, indent=2, ensure_ascii=False)
            summary["posts_modified"].append(slug)
            print(f"  FIXED {name}:")
            for c in changes:
                print(f"    - {c}")
        else:
            print(f"  OK    {name}")
            if changes:
                for c in changes:
                    print(f"    - {c}")

    # ----------------------------------------------------------------
    # Summary
    # ----------------------------------------------------------------
    print("\n" + "=" * 60)
    print("ARTONLY.IO IMAGE AUDIT SUMMARY")
    print("=" * 60)
    print(f"Posts checked:               {summary['posts_checked']}")
    print(f"Posts modified:              {len(summary['posts_modified'])}")
    print(f"  Rule 1 fixes (hero dupe):  {summary['hero_in_body_removed']}")
    print(f"  Rule 3 fixes (irrelevant): {summary['irrelevant_images_removed']}")

    if summary["posts_with_no_body_images"]:
        print(f"\nRule 5 — Posts with NO [img:] in body (logged, not auto-fixed):")
        for s in summary["posts_with_no_body_images"]:
            print(f"  - {s}")

    if summary["image_position_warnings"]:
        print(f"\nRule 2 — image_position missing (needs server-side verify):")
        for w in summary["image_position_warnings"]:
            print(f"  ! {w}")

    if summary["missing_image_warnings"]:
        print(f"\nRule 4 — suspicious hero paths:")
        for w in summary["missing_image_warnings"]:
            print(f"  ! {w}")

    if summary["parse_errors"]:
        print(f"\nParse errors:")
        for e in summary["parse_errors"]:
            print(f"  ! {e}")

    if summary["posts_modified"]:
        print(f"\nModified posts:")
        for s in summary["posts_modified"]:
            print(f"  - {s}")

    print("=" * 60)
    print("NOTE: Rule 2 (image_position orientation) and Rule 4 (file")
    print("existence) require SSH access to the server. Outbound SSH")
    print("(port 22) is blocked in this container environment. These")
    print("checks were skipped. Re-run from an environment with SSH")
    print("access to fully enforce all 5 rules.")
    print("=" * 60)

if __name__ == "__main__":
    audit_posts()
