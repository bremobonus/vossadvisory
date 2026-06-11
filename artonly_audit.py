#!/usr/bin/env python3
"""
artonly.io image framing audit agent.
Enforces 5 rules on every post JSON, fixes in-place, prints summary.
"""

import json
import re
import sys
import os
import io
import paramiko

HOST = "pdx1-shared-a2-06.dreamhost.com"
USER = "dh_yadmw3"
PASS = "Neverending48!"
POSTS_DIR = "/home/dh_yadmw3/artonly.io/posts"
IMAGES_DIR = "/home/dh_yadmw3/artonly.io/assets/images"
ARTISTS_DIR = "/home/dh_yadmw3/artonly.io/assets/images/artists"

def ssh_connect():
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(HOST, username=USER, password=PASS,
                   allow_agent=False, look_for_keys=False)
    return client

def run(client, cmd):
    _, stdout, stderr = client.exec_command(cmd)
    out = stdout.read().decode("utf-8", errors="replace").strip()
    err = stderr.read().decode("utf-8", errors="replace").strip()
    return out, err

def sftp_read_json(sftp, path):
    with sftp.file(path, "r") as f:
        return json.loads(f.read().decode("utf-8"))

def sftp_write_json(sftp, path, data):
    content = json.dumps(data, indent=2, ensure_ascii=False)
    with sftp.file(path, "w") as f:
        f.write(content)

def file_exists(client, path):
    out, _ = run(client, f'test -f "{path}" && echo yes || echo no')
    return out.strip() == "yes"

def get_image_dimensions(client, path):
    """Returns (width, height) or None if not determinable."""
    out, err = run(client, f'OMP_NUM_THREADS=1 identify "{path}" 2>/dev/null | awk \'{{print $3}}\' | head -1')
    if out:
        m = re.match(r'(\d+)x(\d+)', out.strip())
        if m:
            return int(m.group(1)), int(m.group(2))
    return None

def determine_image_position(dims):
    if dims is None:
        return None
    w, h = dims
    if h > w:
        return "center top"
    else:
        return "center 20%"

def extract_img_tags(body):
    """Return list of (full_match, filepath) for [img:...] tags."""
    return re.findall(r'\[img:([^\]]+)\]', body)

def remove_img_tag(body, filepath):
    """Remove [img:filepath] from body (exact match)."""
    escaped = re.escape(filepath)
    body = re.sub(r'\[img:' + escaped + r'\]', '', body)
    return body

def is_allowed_image_path(img_path, slug):
    """
    Allowed if path is under /assets/images/artists/
    or under /assets/images/<slug>/ (or exact slug match).
    img_path is the value inside [img:...], typically a URL path or relative path.
    """
    normalized = img_path.replace("\\", "/")
    if "/assets/images/artists/" in normalized:
        return True
    if f"/assets/images/{slug}" in normalized:
        return True
    # Also allow if the basename directory name matches slug
    parts = normalized.split("/")
    if slug in parts:
        return True
    return False

def resolve_image_disk_path(img_path):
    """
    Convert an [img:] path (which may be a URL path like /assets/images/...)
    to the full disk path on the server.
    """
    normalized = img_path.replace("\\", "/")
    # Strip query strings
    normalized = normalized.split("?")[0]
    if normalized.startswith("/assets/"):
        return f"/home/dh_yadmw3/artonly.io{normalized}"
    if normalized.startswith("assets/"):
        return f"/home/dh_yadmw3/artonly.io/{normalized}"
    # Already absolute
    if normalized.startswith("/home/"):
        return normalized
    return None

def main():
    print("Connecting to server...")
    client = ssh_connect()
    sftp = client.open_sftp()
    print("Connected.\n")

    # List all post JSON files
    out, _ = run(client, f'ls "{POSTS_DIR}"/*.json 2>/dev/null')
    if not out:
        print("No post JSON files found.")
        client.close()
        return

    post_files = out.splitlines()
    print(f"Found {len(post_files)} post(s).\n")

    summary = {
        "posts_checked": 0,
        "hero_in_body_removed": 0,
        "image_position_set": 0,
        "image_position_corrected": 0,
        "irrelevant_images_removed": 0,
        "missing_images_removed": 0,
        "posts_with_no_body_images": [],
        "posts_modified": [],
        "errors": [],
    }

    for post_path in post_files:
        post_path = post_path.strip()
        if not post_path:
            continue
        filename = os.path.basename(post_path)
        slug = filename.replace(".json", "")
        summary["posts_checked"] += 1
        modified = False
        changes = []

        try:
            post = sftp_read_json(sftp, post_path)
        except Exception as e:
            summary["errors"].append(f"{filename}: failed to parse JSON: {e}")
            continue

        hero = post.get("image", "")
        body = post.get("body", "")

        # ----------------------------------------------------------------
        # RULE 1: Hero image must not appear in body as [img:]
        # ----------------------------------------------------------------
        if hero and body:
            # Match by the path value
            img_tags_in_body = extract_img_tags(body)
            for tag_path in img_tags_in_body:
                # Compare by normalizing
                tag_norm = tag_path.strip().rstrip("/")
                hero_norm = hero.strip().rstrip("/")
                # Match if the tag path ends with the same filename as hero
                # or if full path matches
                hero_basename = hero_norm.split("/")[-1]
                tag_basename = tag_norm.split("/")[-1]
                if tag_norm == hero_norm or (hero_basename and tag_basename == hero_basename and hero_basename != ""):
                    body = remove_img_tag(body, tag_path)
                    changes.append(f"Rule 1: removed hero image [{tag_path}] from body")
                    summary["hero_in_body_removed"] += 1
                    modified = True

        # ----------------------------------------------------------------
        # RULE 2: image_position must be correct based on hero dimensions
        # ----------------------------------------------------------------
        if hero:
            hero_disk = resolve_image_disk_path(hero)
            if hero_disk:
                dims = get_image_dimensions(client, hero_disk)
                expected_pos = determine_image_position(dims)
                current_pos = post.get("image_position", None)
                if expected_pos:
                    if current_pos is None:
                        post["image_position"] = expected_pos
                        changes.append(f"Rule 2: set image_position='{expected_pos}' (dims={dims})")
                        summary["image_position_set"] += 1
                        modified = True
                    elif current_pos != expected_pos:
                        post["image_position"] = expected_pos
                        changes.append(f"Rule 2: corrected image_position '{current_pos}'->'{expected_pos}' (dims={dims})")
                        summary["image_position_corrected"] += 1
                        modified = True

        # ----------------------------------------------------------------
        # RULE 3: No irrelevant [img:] tags in body
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
        # RULE 4: [img:] tags and hero must point to existing files
        # ----------------------------------------------------------------
        # Check hero
        if hero:
            hero_disk = resolve_image_disk_path(hero)
            if hero_disk and not file_exists(client, hero_disk):
                changes.append(f"Rule 4 (hero): file not found [{hero}] — replacing with placeholder")
                post["image"] = "/assets/images/placeholder.jpg"
                modified = True

        # Check body img tags
        if body:
            img_tags = extract_img_tags(body)
            for tag_path in img_tags:
                disk_path = resolve_image_disk_path(tag_path)
                if disk_path:
                    if not file_exists(client, disk_path):
                        body = remove_img_tag(body, tag_path)
                        changes.append(f"Rule 4: removed missing file [{tag_path}]")
                        summary["missing_images_removed"] += 1
                        modified = True
                else:
                    # Can't resolve path — flag but don't remove
                    changes.append(f"Rule 4 (warn): could not resolve path [{tag_path}]")

        # ----------------------------------------------------------------
        # RULE 5: Body should have at least one [img:] tag
        # ----------------------------------------------------------------
        # Re-check body img tags after all removals
        remaining_img_tags = extract_img_tags(body)
        # Also check [download:] tags are not counted
        if len(remaining_img_tags) == 0:
            summary["posts_with_no_body_images"].append(slug)

        # ----------------------------------------------------------------
        # Write back if modified
        # ----------------------------------------------------------------
        if modified:
            post["body"] = body
            try:
                sftp_write_json(sftp, post_path, post)
                summary["posts_modified"].append(slug)
                print(f"  FIXED {filename}:")
                for c in changes:
                    print(f"    - {c}")
            except Exception as e:
                summary["errors"].append(f"{filename}: failed to write: {e}")
        else:
            if changes:
                print(f"  INFO {filename}:")
                for c in changes:
                    print(f"    - {c}")

    sftp.close()
    client.close()

    # ----------------------------------------------------------------
    # Print summary
    # ----------------------------------------------------------------
    print("\n" + "=" * 60)
    print("AUDIT SUMMARY")
    print("=" * 60)
    print(f"Posts checked:                {summary['posts_checked']}")
    print(f"Posts modified:               {len(summary['posts_modified'])}")
    print(f"  Hero-in-body removed:       {summary['hero_in_body_removed']}")
    print(f"  image_position set (new):   {summary['image_position_set']}")
    print(f"  image_position corrected:   {summary['image_position_corrected']}")
    print(f"  Irrelevant imgs removed:    {summary['irrelevant_images_removed']}")
    print(f"  Missing file imgs removed:  {summary['missing_images_removed']}")

    if summary["posts_with_no_body_images"]:
        print(f"\nPosts with NO body images (logged, not auto-fixed):")
        for s in summary["posts_with_no_body_images"]:
            print(f"  - {s}")

    if summary["posts_modified"]:
        print(f"\nModified posts:")
        for s in summary["posts_modified"]:
            print(f"  - {s}")

    if summary["errors"]:
        print(f"\nErrors:")
        for e in summary["errors"]:
            print(f"  ! {e}")

    print("=" * 60)
    print("Done.")

if __name__ == "__main__":
    main()
