#!/bin/bash
# ArtOnly — Burna Boy FIX4: read validator/mail source, fix instagram field, send outreach
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-26-burna-boy-fix4.sh

echo "=== ArtOnly Fix4: Burna Boy 2026-06-26 ==="
echo "$(date)"

# ---- Step 1: Inspect validator instagram check ----
echo ""
echo "--- Step 1: Inspect validator instagram field name ---"
grep -n "instagram" /home/dh_yadmw3/artonly.io/agent/post-validator.py | head -20 || echo "grep failed"

# ---- Step 2: Inspect send-mail.php required fields ----
echo ""
echo "--- Step 2: Inspect send-mail.php ---"
grep -n "Missing\|required\|field\|to\|from\|subject\|body\|text\|html\|slug\|artist" /home/dh_yadmw3/artonly.io/api/send-mail.php | head -40 || echo "grep failed"

# ---- Step 3: Show current post JSON instagram field ----
echo ""
echo "--- Step 3: Current post instagram fields ---"
python3 - << 'PYEOF'
import json
post = json.load(open('/home/dh_yadmw3/artonly.io/posts/burna-boy-african-giant.json'))
for k, v in post.items():
    if 'insta' in k.lower() or 'gram' in k.lower():
        print(f'  {k}: {v}')
print('All keys:', list(post.keys()))
PYEOF

# ---- Step 4: Enable emails ----
echo ""
echo "--- Step 4: Enable emails ---"
python3 - << 'PYEOF'
import json, os
cfg_path = '/home/dh_yadmw3/artonly.io/data/publish-config.json'
cfg = json.load(open(cfg_path))
cfg['publishing_enabled'] = True
cfg['emails_enabled'] = True
with open(cfg_path, 'w') as f:
    json.dump(cfg, f, indent=2)
print('publishing_enabled and emails_enabled -> True')
PYEOF

echo ""
echo "=== Fix4 diagnostics complete ==="
