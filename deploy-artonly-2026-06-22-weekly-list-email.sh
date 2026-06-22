#!/bin/bash
# Resend summary email for weekly list: Seven Artists Worth Your Time This Week
# The original deploy succeeded (post live, social card done, IndexNow pinged)
# but gmail-send.py was called incorrectly. This script fixes that.

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Weekly List Email Fix: $(date) ==="

python3 << 'PYEOF'
import json, subprocess, os

body = """Published today: https://artonly.io/post/the-week-in-music-june-22-2026

Seven Artists Worth Your Time This Week

A curated list of seven artists with work worth your attention this week on ArtOnly:

1. Tierra Whack - WHACK'S MUSEUM
   https://artonly.io/post/tierra-whack-whacks-museum

2. Olivia Rodrigo - you seem pretty sad...
   https://artonly.io/post/olivia-rodrigo-you-seem-pretty-sad

3. Micah Thomas - Lucid
   https://artonly.io/post/micah-thomas-lucid

4. Future - We Don't Trust You + Mixtape Pluto
   https://artonly.io/post/future

5. Hayley Kiyoko - girls like girls the album
   https://artonly.io/post/hayley-kiyoko-girls-like-girls-the-album

6. Ruel - Kicking My Feet and Screaming
   https://artonly.io/post/ruel-kicking-my-feet-screaming

7. Leon Thomas III - Mutt
   https://artonly.io/post/leon-thomas

Author: Allastair Voss | Category: culture | Date: 2026-06-22"""

payload = json.dumps({
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Weekly List: Seven Artists Worth Your Time This Week",
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

echo "Summary email sent to amosleblanc@gmail.com"
echo "=== Weekly list email fix complete: $(date) ==="
