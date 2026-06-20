#!/bin/bash
# ArtOnly Album Monitor - Summary email fix
# Generated: 2026-06-20b
# Purpose: Send summary email for the 2026-06-20 album monitor run
# (posts already deployed in 2026-06-20 run; this only sends the email)

set -e
echo "=== ArtOnly Summary Email: 2026-06-20 ==="

python3 << 'PYEOF'
import json, subprocess, sys

data = {
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Album Monitor: 2026-06-20",
    "body": """Published today:

1. Sha Ray & DJ Haram - Critical Thot
   https://artonly.io/post/sha-ray-dj-haram-critical-thot
   Author: Allastair Voss
   Spotify artist: 5Y4Skucz2y4H8UhB0RpTaQ (DJ Haram)
   Released: June 19, 2026 (Backwoodz Studioz / Rhymesayers)
   9 tracks, debut album for Sha Ray
   Themes: unapologetic feminine authority, reclamation, experimental hip-hop
   Image: downloaded from Stereogum

2. Alex Zhang Hungtai - Orion/Mother
   https://artonly.io/post/alex-zhang-hungtai-orion-mother
   Author: Leelou Blanc
   Spotify artist: 0U4w3nZTdH0QyefP5b1q0P
   Released: June 19, 2026 (American Dreams Records)
   Double album, jazz improv and ambient, trumpet-led
   Themes: personal transition, NYC winter sessions, improvisation
   Image: downloaded from FLOOD Magazine

Outreach:
- Sha Ray / DJ Haram: email sent to hello@backwoodzstudioz.com (success)
- Alex Zhang Hungtai: email sent to info@american-dreams.zone (success)

Both posts confirmed live at HTTP 200.
IndexNow pinged for both slugs."""
}

result = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py'],
    input=json.dumps(data),
    text=True,
    capture_output=True
)
print('STDOUT:', result.stdout)
if result.stderr:
    print('STDERR:', result.stderr)
if result.returncode != 0:
    print(f'gmail-send.py exited with {result.returncode}')
    sys.exit(result.returncode)
print('Summary email sent to amosleblanc@gmail.com')
PYEOF

echo "=== Done ==="
