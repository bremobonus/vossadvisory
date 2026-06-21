#!/bin/bash
# ArtOnly Fix3: Summary email only
# Both posts already live (41/41 validation):
#   Tierra Whack WHACK'S MUSEUM - validated in fix.sh
#   Micah Thomas Lucid          - validated in fix2.sh
# Just need to send the summary email via send-mail.php
# Generated: 2026-06-21
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-21-fix3.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Fix3: Summary email: $(date) ==="

python3 << 'PYEOF'
import subprocess, urllib.request, urllib.parse, json, sys

subject = "ArtOnly Album Monitor: 2026-06-21"
body = """Published today:

1. Tierra Whack, WHACK'S MUSEUM
   https://artonly.io/post/tierra-whack-whacks-museum
   By Leelou Blanc | Released June 19, 2026 (Interscope)
   Crew: Conductor Williams (Producer)
   Validator: 41/41 passed

2. Micah Thomas, Lucid
   https://artonly.io/post/micah-thomas-lucid
   By Allastair Voss | Released June 19, 2026 (self-released)
   Crew: Immanuel Wilkins, Kalia Vandever
   Validator: 41/41 passed

Outreach sent:
- Tierra Whack: press@interscope.com
- Micah Thomas: taylor@fullyaltered.com"""

# Try gmail-send.py first (with positional args)
result = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py',
     'amosleblanc@gmail.com', subject, body],
    capture_output=True, text=True
)
if result.returncode == 0:
    print("Summary email sent via gmail-send.py")
    print(result.stdout)
else:
    print(f"gmail-send.py failed (rc={result.returncode}): {result.stderr[:200]}")
    print("Falling back to send-mail.php...")
    data = urllib.parse.urlencode({
        'to': 'amosleblanc@gmail.com',
        'subject': subject,
        'body': body
    }).encode()
    req = urllib.request.Request('https://artonly.io/api/send-mail.php', data=data)
    resp = urllib.request.urlopen(req, timeout=30)
    result_body = resp.read().decode()
    print(f"Fallback mail result: {result_body}")
    parsed = json.loads(result_body)
    if not parsed.get('success'):
        print(f"ERROR: send-mail.php failed: {result_body}", file=sys.stderr)
        sys.exit(1)
    print("Summary email sent via send-mail.php fallback")
PYEOF

echo ""
echo "=== Fix3 complete: $(date) ==="
echo "Posts live:"
echo "  https://artonly.io/post/tierra-whack-whacks-museum"
echo "  https://artonly.io/post/micah-thomas-lucid"
