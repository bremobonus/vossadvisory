#!/bin/bash
set -e
PY=$(command -v python3)
mkdir -p ~/websiteempire ~/bremo.io/websiteempire
mv ~/websiteempire-upload/collect.py ~/websiteempire/collect.py
mv ~/websiteempire-upload/index.html ~/bremo.io/websiteempire/index.html
rmdir ~/websiteempire-upload
chmod 755 ~/websiteempire/collect.py
JOB="*/15 * * * * $PY \$HOME/websiteempire/collect.py >> \$HOME/websiteempire/collect.log 2>&1"
( crontab -l 2>/dev/null | grep -v 'websiteempire/collect.py' ; echo "$JOB" ) | crontab -
echo "--- crontab ---"; crontab -l | grep websiteempire
echo "--- first collection ---"
"$PY" ~/websiteempire/collect.py
"$PY" - <<'PY'
import json, os
d = json.load(open(os.path.expanduser("~/bremo.io/websiteempire/data.json")))
print("%-32s %-10s %8s %6s %s" % ("domain", "stack", "views7d", "up", "registered"))
for s in sorted(d["sites"], key=lambda s: -s["traffic"]["views_7d"]):
    print("%-32s %-10s %8d %6s %s" % (s["domain"], s["files"]["stack"], s["traffic"]["views_7d"], s["http"]["up"], s["registration"].get("registered")))
PY
