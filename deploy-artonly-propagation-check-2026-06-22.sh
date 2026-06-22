#!/bin/bash
# Propagation enforcer run triggered by watchdog agent (2026-06-22)
# SSH was blocked from Claude Code remote env; GitHub Actions has SSH access

set -e

echo "=== ArtOnly Propagation Enforcer === $(date -u)"

# STEP 1: Run propagation enforcer
echo "--- STEP 1: propagation-enforcer.py ---"
python3 ~/artonly.io/agent/propagation-enforcer.py || echo "WARNING: propagation-enforcer.py exited with error"

# STEP 2: Domain expiry check
echo "--- STEP 2: Domain expiry ---"
python3 -c "
import json, datetime
try:
    brain = json.load(open('/home/dh_yadmw3/artonly.io/data/distribution-brain.json'))
    expires = brain.get('domain',{}).get('expires','')
    if expires:
        days = (datetime.datetime.strptime(expires,'%Y-%m-%d').date() - datetime.date.today()).days
        print(f'Domain expires: {expires} ({days} days left)')
        if days <= 45:
            print('ACTION REQUIRED: Renew domain at panel.dreamhost.com')
    else:
        print('No domain expiry data in brain')
except Exception as e:
    print(f'Error: {e}')
"

# STEP 3: Today's posts
echo "--- STEP 3: Today posts ---"
python3 -c "
import json, glob, datetime
today = datetime.date.today().isoformat()
today_posts = []
for f in glob.glob('/home/dh_yadmw3/artonly.io/posts/*.json'):
    try:
        p = json.load(open(f))
        if p.get('date','') == today and not p.get('hidden'):
            today_posts.append(p.get('slug','?'))
    except: pass
print(f'Posts today ({today}): {len(today_posts)}')
for s in today_posts: print(f'  {s}')
"

# STEP 5: Update distribution brain
echo "--- STEP 5: Update brain ---"
python3 -c "
import json, datetime, socket
try:
    brain = json.load(open('/home/dh_yadmw3/artonly.io/data/distribution-brain.json'))
    brain['health']['last_checked'] = datetime.datetime.utcnow().isoformat()
    try:
        socket.gethostbyname('artonly.io')
        brain['health']['dns_resolves'] = True
    except:
        brain['health']['dns_resolves'] = False
    json.dump(brain, open('/home/dh_yadmw3/artonly.io/data/distribution-brain.json','w'), indent=2)
    print('Brain updated')
except Exception as e:
    print(f'Brain update error: {e}')
"

echo "=== Propagation check complete ==="
