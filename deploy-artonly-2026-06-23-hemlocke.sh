#!/bin/bash
# ArtOnly Fix: hemlocke springs outreach + brain.json
# Post published 2026-06-22 but outreach and brain.json update were missed
# Generated: 2026-06-23
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-23-hemlocke.sh

set -e
cd /home/dh_yadmw3
echo "=== ArtOnly Fix: hemlocke springs: $(date) ==="

# =====================================================================
# Validate
# =====================================================================
echo "--- Validating hemlocke-springs post ---"
python3 artonly.io/agent/post-validator.py hemlocke-springs

# =====================================================================
# IndexNow
# =====================================================================
echo "--- IndexNow submission ---"
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/hemlocke-springs&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

# =====================================================================
# Outreach
# =====================================================================
echo "--- Sending outreach to AWAL press ---"
curl -s -X POST https://artonly.io/api/send-mail.php \
  --data-urlencode "to=cami.opere@awal.com" \
  --data-urlencode "subject=ArtOnly just covered hemlocke springs" \
  --data-urlencode "body=https://artonly.io/post/hemlocke-springs

ArtOnly covered hemlocke springs and the apple tree under the sea today. The album completes its concept in a way that most debut records do not: it arrives at a genuinely different place than it started, and the sequence of the ten tracks carries that emotional logic without needing to explain itself. A social card is available at the bottom of the page, feel free to share. If hemlocke springs or anyone on the team wants to do a Q and A, just reply to this email. Allastair Voss, ArtOnly (artonly.io)" \
  --data-urlencode "reply_to=allastairvoss@gmail.com"
echo ""

# =====================================================================
# Update brain.json
# =====================================================================
echo "--- Updating brain.json ---"
python3 << 'PYEOF'
import json

brain_path = 'artonly.io/agent/brain.json'
with open(brain_path, 'r') as f:
    b = json.load(f)

written = b.get('artists_written', [])
queue = b.get('queue', [])

if 'Hemlocke Springs' not in written:
    written.append('Hemlocke Springs')
    b['artists_written'] = written
    print(f'Added Hemlocke Springs to artists_written (now {len(written)} total)', flush=True)
else:
    print('Hemlocke Springs already in artists_written', flush=True)

if 'Hemlocke Springs' in queue:
    queue.remove('Hemlocke Springs')
    b['queue'] = queue
    print('Removed Hemlocke Springs from queue', flush=True)
else:
    print('Hemlocke Springs not in queue (already removed)', flush=True)

with open(brain_path, 'w') as f:
    json.dump(b, f, indent=2)
print('brain.json saved', flush=True)
PYEOF

echo ""
echo "=== hemlocke springs fix complete: $(date) ==="
echo "Live at: https://artonly.io/post/hemlocke-springs"
