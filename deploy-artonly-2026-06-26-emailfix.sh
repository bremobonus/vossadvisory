#!/bin/bash
# Fix: send summary email for 2026-06-26 monitor run
# gmail-send.py reads JSON from stdin, not positional args

echo "=== Sending summary email for 2026-06-26 ==="

python3 << 'PYEOF'
import subprocess, json, sys

payload = json.dumps({
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Album Monitor: 2026-06-26",
    "body": "Published today:\n\n1. Chloe & Timbaland - Resurrection\n   https://artonly.io/post/chloe-timbaland-resurrection\n   Author: Allastair Voss\n   Spotify ID: 1FtBEIWAwvw5ymBen5GICR\n   Released: June 19, 2026 (Parkwood/Columbia Records)\n   12-track mixtape, production-driven R&B revival\n\nNote: Myles Smith (My Mess, My Heart, My Life) was already published on 2026-06-25 by yesterday's monitor run.\n\nOutreach emails: artonly.io outbound email is currently frozen for QC (only system digest permitted).\n\nIndexNow pinged for: chloe-timbaland-resurrection"
})

result = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py'],
    input=payload,
    capture_output=True,
    text=True
)
print("STDOUT:", result.stdout)
print("STDERR:", result.stderr)
print("Return code:", result.returncode)
if result.returncode != 0:
    sys.exit(1)
print("Summary email sent successfully.")
PYEOF

echo "=== Email fix complete ==="
