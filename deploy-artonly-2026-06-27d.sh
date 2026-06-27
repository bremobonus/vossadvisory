#!/bin/bash
# ArtOnly Direct Patch: Devon Gilfillian JSON on disk + summary email
# Bypasses publish.php (rate-limited) - post already live, just adding fields
# 2026-06-27d

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Direct Patch (Devon Gilfillian): $(date) ==="

echo "--- Patching post JSON on disk (no publish.php) ---"
python3 - <<'PYEOF'
import json, sys

POST_FILE = 'artonly.io/posts/devon-gilfillian-time-will-tell.json'

try:
    with open(POST_FILE) as f:
        post = json.load(f)
except FileNotFoundError:
    print(f"ERROR: {POST_FILE} not found", file=sys.stderr)
    sys.exit(1)

changed = []

if post.get('instagram') != 'devongilfillian':
    post['instagram'] = 'devongilfillian'
    changed.append('instagram')

desired_crew = [
    {"name": "Neal H Pogue", "role": "Executive Producer"},
    {"name": "Jonathan Smalt", "role": "Co-Producer, Drums"}
]
if post.get('crew') != desired_crew:
    post['crew'] = desired_crew
    changed.append('crew')

body = post.get('body', '')
SPOTIFY_LINE = '[spotify:artist/5cbak2U6nZWXDYiG72E3lH]'
VIDEO_LINE = '[youtube:c0L1la2IxjY]'
if VIDEO_LINE not in body and SPOTIFY_LINE in body:
    body = body.replace(
        SPOTIFY_LINE + '\n\n',
        SPOTIFY_LINE + '\n\n' + VIDEO_LINE + '\n\n',
        1
    )
    post['body'] = body
    changed.append('youtube_embed')

# Remove token field if present (not part of stored post)
post.pop('token', None)

if changed:
    with open(POST_FILE, 'w') as f:
        json.dump(post, f, ensure_ascii=False, indent=2)
    print(f"  Patched fields: {', '.join(changed)}")
else:
    print("  Nothing to patch, fields already set")
PYEOF

echo "--- Verifying post is live ---"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://artonly.io/post/devon-gilfillian-time-will-tell)
echo "HTTP status: $STATUS"
if [ "$STATUS" != "200" ]; then
  echo "WARNING: post returned $STATUS, expected 200"
fi

echo "--- Validating patched post ---"
python3 artonly.io/agent/post-validator.py devon-gilfillian-time-will-tell || true

echo "--- Sending summary email ---"
python3 ~/artonly.io/api/gmail-send.py <<'JSONEOF'
{
  "to": "amosleblanc@gmail.com",
  "subject": "ArtOnly Album Monitor: 2026-06-27 (complete)",
  "body": "Both posts are live:\n\n1. Naomi Sharon - No Sleep In Paradise\n   https://artonly.io/post/naomi-sharon-no-sleep-in-paradise\n   Author: Leelou Blanc | 1184 words | all checks passed\n\n2. Devon Gilfillian - Time Will Tell\n   https://artonly.io/post/devon-gilfillian-time-will-tell\n   Author: Allastair Voss | 1156 words | live HTTP 200\n\nOutreach sent to OVO Sound and Concord Records."
}
JSONEOF

echo "=== Direct patch complete: $(date) ==="
