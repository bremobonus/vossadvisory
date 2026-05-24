#!/usr/bin/env python3
"""artonly.io image framing agent - audits and fixes image problems in all posts."""

import json
import re
import paramiko
import os
import sys

HOST = "pdx1-shared-a2-06.dreamhost.com"
USER = "dh_yadmw3"
PASS = "Neverending48!"
POSTS_DIR = "/home/dh_yadmw3/artonly.io/posts"
IMAGES_DIR = "/home/dh_yadmw3/artonly.io/assets/images"
ARTISTS_DIR = "/home/dh_yadmw3/artonly.io/assets/images/artists"


def ssh_run(client, cmd):
    stdin, stdout, stderr = client.exec_command(cmd)
    out = stdout.read().decode("utf-8", errors="replace").strip()
    err = stderr.read().decode("utf-8", errors="replace").strip()
    return out, err


def get_image_dimensions(client, path):
    """Returns (width, height) or None if file doesn't exist or can't be read."""
    out, err = ssh_run(client, f"OMP_NUM_THREADS=1 identify '{path}' 2>/dev/null | awk '{{print $3}}' | head -1")
    if not out:
        return None
    m = re.match(r"(\d+)x(\d+)", out)
    if m:
        return int(m.group(1)), int(m.group(2))
    return None


def file_exists(client, path):
    out, _ = ssh_run(client, f"test -f '{path}' && echo yes || echo no")
    return out.strip() == "yes"


def resolve_image_path(image_ref):
    """Convert an image reference (starting with /assets/images/...) to full server path."""
    if image_ref.startswith("/"):
        return f"/home/dh_yadmw3/artonly.io{image_ref}"
    return f"/home/dh_yadmw3/artonly.io/assets/images/{image_ref}"


def is_allowed_body_image(image_ref):
    """Check if image ref is in /assets/images/artists/ or a subdirectory."""
    norm = image_ref.lstrip("/")
    return "assets/images/artists" in norm


def main():
    print("Connecting to server...")
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(HOST, username=USER, password=PASS, look_for_keys=False, allow_agent=False)
    print("Connected.\n")

    # Get all post files
    out, err = ssh_run(client, f"ls {POSTS_DIR}/*.json 2>/dev/null")
    if not out:
        print("No post files found.")
        client.close()
        return

    post_files = out.splitlines()
    print(f"Found {len(post_files)} posts to audit.\n")

    stats = {
        "posts_checked": 0,
        "repeated_image_fixed": 0,
        "image_position_fixed": 0,
        "irrelevant_image_removed": 0,
        "missing_image_removed": 0,
        "no_body_images": 0,
    }

    violation_log = []

    for pf in post_files:
        pf = pf.strip()
        if not pf:
            continue

        slug = os.path.basename(pf).replace(".json", "")
        stats["posts_checked"] += 1

        # Read the post file
        out, err = ssh_run(client, f"cat '{pf}'")
        if not out:
            print(f"  [WARN] Could not read {pf}")
            continue

        try:
            post = json.loads(out)
        except json.JSONDecodeError as e:
            print(f"  [WARN] JSON parse error in {pf}: {e}")
            continue

        original_post = json.dumps(post, ensure_ascii=False, indent=2)
        modified = False
        post_violations = []

        hero = post.get("image", "")
        body = post.get("body", "")

        # ── RULE 1: No repeated images ──────────────────────────────────────
        if hero and body:
            # Find all [img:...] tags in body
            img_tags = re.findall(r'\[img:[^\]]+\]', body)
            for tag in img_tags:
                # Extract the path from [img:path] or [img:path|caption]
                m = re.match(r'\[img:([^\]|]+)', tag)
                if not m:
                    continue
                img_path = m.group(1).strip()
                # Normalize both for comparison
                hero_norm = hero.strip().lstrip("/")
                img_norm = img_path.strip().lstrip("/")
                if hero_norm == img_norm or os.path.basename(hero_norm) == os.path.basename(img_norm):
                    body = body.replace(tag, "").strip()
                    body = re.sub(r'\n{3,}', '\n\n', body)
                    post["body"] = body
                    modified = True
                    stats["repeated_image_fixed"] += 1
                    post_violations.append(f"RULE1: removed repeated hero image [{img_path}] from body")

        # ── RULE 2: Image position ──────────────────────────────────────────
        if hero:
            hero_full = resolve_image_path(hero)
            dims = get_image_dimensions(client, hero_full)
            if dims:
                w, h = dims
                if h > w:
                    correct_pos = "center top"
                else:
                    correct_pos = "center 20%"

                current_pos = post.get("image_position", None)
                if current_pos != correct_pos:
                    post["image_position"] = correct_pos
                    modified = True
                    stats["image_position_fixed"] += 1
                    post_violations.append(
                        f"RULE2: set image_position to '{correct_pos}' (was '{current_pos}', dims {w}x{h})"
                    )

        # ── RULE 3: No irrelevant images ────────────────────────────────────
        if body:
            img_tags = re.findall(r'\[img:[^\]]+\]', body)
            for tag in img_tags:
                m = re.match(r'\[img:([^\]|]+)', tag)
                if not m:
                    continue
                img_path = m.group(1).strip()
                # Check if in artists dir or slug subdir
                norm = img_path.lstrip("/")
                in_artists = "assets/images/artists" in norm
                in_slug_dir = f"assets/images/{slug}" in norm
                if not in_artists and not in_slug_dir:
                    body = body.replace(tag, "").strip()
                    body = re.sub(r'\n{3,}', '\n\n', body)
                    post["body"] = body
                    modified = True
                    stats["irrelevant_image_removed"] += 1
                    post_violations.append(f"RULE3: removed irrelevant image [{img_path}] from body")

        # ── RULE 4: Image exists check ──────────────────────────────────────
        if body:
            img_tags = re.findall(r'\[img:[^\]]+\]', body)
            for tag in img_tags:
                m = re.match(r'\[img:([^\]|]+)', tag)
                if not m:
                    continue
                img_path = m.group(1).strip()
                full_path = resolve_image_path(img_path)
                if not file_exists(client, full_path):
                    body = body.replace(tag, "").strip()
                    body = re.sub(r'\n{3,}', '\n\n', body)
                    post["body"] = body
                    modified = True
                    stats["missing_image_removed"] += 1
                    post_violations.append(f"RULE4: removed missing image [{img_path}] from body")

        # Check hero exists
        if hero:
            hero_full = resolve_image_path(hero)
            if not file_exists(client, hero_full):
                post_violations.append(f"RULE4: hero image [{hero}] does not exist on disk (flagged, no auto-replace)")

        # ── RULE 5: Minimum images ──────────────────────────────────────────
        if body:
            remaining_imgs = re.findall(r'\[img:[^\]]+\]', post.get("body", body))
            if not remaining_imgs:
                stats["no_body_images"] += 1
                post_violations.append("RULE5: post has zero body [img:] tags (logged only)")

        # ── Write back if modified ──────────────────────────────────────────
        if modified:
            new_content = json.dumps(post, ensure_ascii=False, indent=2)
            # Escape for shell heredoc
            escaped = new_content.replace("'", "'\\''")
            write_cmd = f"printf '%s' '{escaped}' > '{pf}'"
            _, werr = ssh_run(client, write_cmd)
            if werr:
                print(f"  [ERROR] writing {pf}: {werr}")
            else:
                print(f"  [FIXED] {slug}: {'; '.join(post_violations)}")
        elif post_violations:
            print(f"  [INFO]  {slug}: {'; '.join(post_violations)}")

        if post_violations:
            violation_log.append((slug, post_violations))

    client.close()

    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    print(f"Posts checked:              {stats['posts_checked']}")
    print(f"Repeated hero in body fixed: {stats['repeated_image_fixed']}")
    print(f"Image position fixed:        {stats['image_position_fixed']}")
    print(f"Irrelevant images removed:   {stats['irrelevant_image_removed']}")
    print(f"Missing images removed:      {stats['missing_image_removed']}")
    print(f"Posts with no body images:   {stats['no_body_images']} (logged only)")
    total_fixes = (stats['repeated_image_fixed'] + stats['image_position_fixed'] +
                   stats['irrelevant_image_removed'] + stats['missing_image_removed'])
    print(f"Total fixes applied:         {total_fixes}")
    print("=" * 60)

    if not violation_log:
        print("All posts are clean.")


if __name__ == "__main__":
    main()
