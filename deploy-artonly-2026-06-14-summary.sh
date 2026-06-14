#!/bin/bash
set -e
echo "=== ArtOnly Summary Email: 2026-06-14 ==="

python3 << 'PYEOF'
import json, subprocess, os

body = """Published today:

1. Kelsey Lu - So Help Me God
   https://artonly.io/post/kelsey-lu-so-help-me-god
   Author: Leelou Blanc
   Spotify: 0fEfMW5bypHZ0A8eLnhwj5
   Released: June 12, 2026 (Dirty Hit)
   Second album, 7-year gap since Blood (2019). Features Sampha, Kamasi Washington, Kim Gordon.
   Themes: grief, spiritual questioning, self-possession, rebuilding after loss.

2. Wiki - Ancient History
   https://artonly.io/post/wiki-ancient-history
   Author: Allastair Voss
   Spotify: 78X7quh8fqAGZ42OpLmUW0
   Released: June 12, 2026 (Wikset Enterprise, self-released)
   First solo LP in 7 years since Oofie (2019). Produced by Alchemist, Navy Blue, MIKE (dj blackpower), Nick Hakim (Dom Maker).
   Features: Your Old Droog, duendita. NYC parks as conceptual anchor.

Outreach:
- Kelsey Lu: email sent to press@dirtyhit.com (Dirty Hit label)
- Wiki: email sent to wiksetnyc@gmail.com (best available contact, self-released)

Both releases from June 12, 2026, not previously covered on ArtOnly."""

payload = json.dumps({
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Album Monitor: 2026-06-14",
    "body": body
})

result = subprocess.run(
    ["python3", os.path.expanduser("~/artonly.io/api/gmail-send.py")],
    input=payload, text=True, capture_output=True
)
print(result.stdout)
if result.returncode != 0:
    print("gmail-send error:", result.stderr)
    raise SystemExit(1)
PYEOF

echo "Summary email sent."
echo "=== Done ==="
