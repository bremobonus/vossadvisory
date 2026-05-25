#!/usr/bin/env python3
"""artonly.io SEO audit — runs on DreamHost server, called via SSH from GitHub Actions."""
import json, re, os, glob, smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

SITE_ROOT  = os.path.expanduser("~/artonly.io")
POSTS_DIR  = os.path.join(SITE_ROOT, "posts")
EMAIL_TO   = "amosleblanc@gmail.com"
EMAIL_FROM = "noreply@artonly.io"

os.environ.setdefault("OMP_NUM_THREADS", "1")


def strip_media_tags(text):
    text = re.sub(r'\[img:[^\]]*\]', '', text)
    text = re.sub(r'\[download:[^\]]*\]', '', text)
    text = re.sub(r'!\[.*?\]\(.*?\)', '', text)
    text = re.sub(r'\[.*?\]\(.*?\)', '', text)
    return text.strip()


def fix_em_dashes(text):
    """Replace em-dashes (—) with comma or period."""
    count = [0]
    def _replace(m):
        count[0] += 1
        before = text[:m.start()].rstrip()
        after_char = text[m.end():m.end() + 1]
        if after_char and after_char.isupper():
            return '. '
        return ', '
    new_text = re.sub(r'\s*—\s*', _replace, text)
    return new_text, count[0]


def fix_en_dashes(text):
    """Replace en-dashes (–) with 'to' (between numbers) or comma."""
    count = [0]
    def _replace(m):
        count[0] += 1
        before = text[:m.start()]
        after  = text[m.end():]
        if re.search(r'\d\s*$', before) and re.search(r'^\s*\d', after):
            return ' to '
        return ', '
    new_text = re.sub(r'\s*–\s*', _replace, text)
    return new_text, count[0]


def run_audit():
    json_files = sorted(glob.glob(os.path.join(POSTS_DIR, "*.json")))
    print(f"Found {len(json_files)} post(s) in {POSTS_DIR}")

    stats = {
        "total":          0,
        "desc_added":     0,
        "alt_added":      0,
        "dashes_fixed":   0,
        "long_titles":    [],
        "missing_images": [],
        "errors":         [],
        "saved":          [],
    }

    for filepath in json_files:
        fname = os.path.basename(filepath)
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                post = json.load(f)
        except Exception as e:
            stats["errors"].append(f"{fname}: {e}")
            continue

        stats["total"] += 1
        changed = False

        # 1. DESCRIPTION
        if not post.get("description"):
            body = post.get("body") or post.get("content") or ""
            if body:
                clean = strip_media_tags(body).strip()
                desc  = clean[:155].rsplit(" ", 1)[0] if len(clean) > 155 else clean
                post["description"] = desc
                stats["desc_added"] += 1
                changed = True
                print(f"  [DESC]  {fname}")

        # 2. IMAGE ALT
        if not post.get("image_alt"):
            title = post.get("title", "")
            if title:
                post["image_alt"] = title
                stats["alt_added"] += 1
                changed = True
                print(f"  [ALT]   {fname}")

        # 3. DASHES in body / content fields
        total_dashes = 0
        for field in ("body", "content"):
            text = post.get(field)
            if not text:
                continue
            text, em  = fix_em_dashes(text)
            text, en  = fix_en_dashes(text)
            if em + en > 0:
                post[field]   = text
                total_dashes += em + en
                changed        = True
        if total_dashes:
            stats["dashes_fixed"] += total_dashes
            print(f"  [DASH]  {fname}: {total_dashes} fixed")

        # 4. TITLE LENGTH (log only)
        title = post.get("title", "")
        if len(title) > 70:
            stats["long_titles"].append(f"{fname}: {len(title)} chars — {title[:80]}")
            print(f"  [TITLE] {fname}: {len(title)} chars (>70)")

        # 5. MISSING HERO IMAGE
        img = post.get("image", "")
        if img:
            img_path = img.lstrip("/")
            full_path = os.path.join(SITE_ROOT, img_path)
            if not os.path.exists(full_path):
                stats["missing_images"].append(f"{fname}: {img}")
                print(f"  [IMG]   {fname}: missing {img}")

        # 6. SAVE
        if changed:
            try:
                with open(filepath, "w", encoding="utf-8") as f:
                    json.dump(post, f, indent=2, ensure_ascii=False)
                stats["saved"].append(fname)
                print(f"  [SAVE]  {fname}")
            except Exception as e:
                stats["errors"].append(f"Save {fname}: {e}")

    return stats


def build_report(stats):
    lines = [
        "artonly.io SEO Audit Report",
        "=" * 40,
        "",
        f"Posts checked:            {stats['total']}",
        f"Descriptions added:       {stats['desc_added']}",
        f"Image alts added:         {stats['alt_added']}",
        f"Dashes fixed:             {stats['dashes_fixed']}",
        f"Files saved:              {len(stats['saved'])}",
        f"Long titles (>70 chars):  {len(stats['long_titles'])}",
        f"Missing hero images:      {len(stats['missing_images'])}",
        f"Errors:                   {len(stats['errors'])}",
        "",
    ]
    if stats["long_titles"]:
        lines += ["LONG TITLES:"] + [f"  - {t}" for t in stats["long_titles"]] + [""]
    if stats["missing_images"]:
        lines += ["MISSING HERO IMAGES:"] + [f"  - {m}" for m in stats["missing_images"]] + [""]
    if stats["errors"]:
        lines += ["ERRORS:"] + [f"  - {e}" for e in stats["errors"]] + [""]
    lines.append("Audit complete.")
    return "\n".join(lines)


def send_email(subject, body):
    msg = MIMEMultipart()
    msg["From"]    = EMAIL_FROM
    msg["To"]      = EMAIL_TO
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain"))
    try:
        with smtplib.SMTP("localhost") as s:
            s.sendmail(EMAIL_FROM, [EMAIL_TO], msg.as_string())
        print(f"[EMAIL] Sent to {EMAIL_TO}")
    except Exception as e:
        print(f"[EMAIL] Failed: {e}")


if __name__ == "__main__":
    from datetime import date
    print("=== artonly.io SEO Audit ===")
    stats   = run_audit()
    report  = build_report(stats)
    subject = f"artonly.io SEO Audit — {date.today()}"
    print("\n" + report)
    send_email(subject, report)
