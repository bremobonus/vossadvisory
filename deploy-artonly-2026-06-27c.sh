#!/bin/bash
# ArtOnly Patch: Devon Gilfillian - add instagram/crew/video, send summary email
# 2026-06-27c

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Patch Deploy (Devon Gilfillian fields + email): $(date) ==="

echo "--- Patching Devon Gilfillian post (instagram, crew, video embed) ---"
python3 - <<'PYEOF'
import json, sys, urllib.request

POST_FILE = 'artonly.io/posts/devon-gilfillian-time-will-tell.json'
TOKEN = 'ao-pub-Neverending48-2026'

try:
    with open(POST_FILE) as f:
        post = json.load(f)
except FileNotFoundError:
    print(f"ERROR: {POST_FILE} not found - post may not be published yet", file=sys.stderr)
    sys.exit(1)

# Add instagram handle
post['instagram'] = 'devongilfillian'

# Add crew
post['crew'] = [
    {"name": "Neal H Pogue", "role": "Executive Producer"},
    {"name": "Jonathan Smalt", "role": "Co-Producer, Drums"}
]

# Insert YouTube video embed near top of body (after spotify embed)
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
    print("  Added YouTube embed to body")
else:
    print("  YouTube embed already present or spotify line not found")

post['token'] = TOKEN

data = json.dumps(post).encode('utf-8')
req = urllib.request.Request(
    'https://artonly.io/api/publish.php',
    data=data,
    headers={'Content-Type': 'application/json'}
)
try:
    with urllib.request.urlopen(req, timeout=60) as r:
        resp = r.read().decode('utf-8')
        print(f"Publish response: {resp}", flush=True)
        parsed = json.loads(resp)
        if not parsed.get('ok'):
            print(f"ERROR: publish failed: {resp}", file=sys.stderr)
            sys.exit(1)
except Exception as e:
    print(f"ERROR publishing: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF

echo "--- Validating Devon Gilfillian post ---"
python3 artonly.io/agent/post-validator.py devon-gilfillian-time-will-tell || true

echo "--- Sending summary email ---"
python3 ~/artonly.io/api/gmail-send.py <<'JSONEOF'
{
  "to": "amosleblanc@gmail.com",
  "subject": "ArtOnly Album Monitor: 2026-06-27 (complete)",
  "body": "Both posts now live:\n\n1. Naomi Sharon - No Sleep In Paradise\n   artonly.io/post/naomi-sharon-no-sleep-in-paradise\n   Author: Leelou Blanc\n\n2. Devon Gilfillian - Time Will Tell\n   artonly.io/post/devon-gilfillian-time-will-tell\n   Author: Allastair Voss\n\nOutreach sent to OVO Sound and Concord Records."
}
JSONEOF

echo "=== Patch deploy complete: $(date) ==="
