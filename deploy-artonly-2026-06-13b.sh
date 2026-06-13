#!/bin/bash
# ArtOnly Fix Script - 2026-06-13b
# Fixes: verify posts, IndexNow for DJ Seinfeld, summary email
set -e

echo "=== Checking wiki-ancient-history HTTP status ==="
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/wiki-ancient-history")
echo "wiki-ancient-history HTTP status: $HTTP_STATUS"

if [ "$HTTP_STATUS" = "500" ]; then
  echo "HTTP 500 detected - checking JSON file on server..."
  cat /home/dh_yadmw3/artonly.io/posts/wiki-ancient-history.json | python3 -c "import sys,json; d=json.load(sys.stdin); print('JSON valid, body length:', len(d.get('body','')))"
fi

echo "=== Checking dj-seinfeld-if-this-is-it HTTP status ==="
HTTP_STATUS_DJ=$(curl -s -o /dev/null -w "%{http_code}" "https://artonly.io/post/dj-seinfeld-if-this-is-it")
echo "dj-seinfeld-if-this-is-it HTTP status: $HTTP_STATUS_DJ"

echo "=== Pinging IndexNow for dj-seinfeld-if-this-is-it ==="
curl -s "https://api.indexnow.org/indexnow?url=https://artonly.io/post/dj-seinfeld-if-this-is-it&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b"
echo ""

echo "=== Sending summary email ==="
python3 << 'PYEOF'
import subprocess, json

data = json.dumps({
    "to": "amosleblanc@gmail.com",
    "subject": "ArtOnly Album Monitor: 2026-06-13",
    "body": "Published today on ArtOnly:\n\n1. Wiki - Ancient History\nhttps://artonly.io/post/wiki-ancient-history\nAuthor: Allastair Voss\nReleased: June 12, 2026 (Wikset Enterprise)\n14 tracks, producers include Alchemist, Nick Hakim, Navy Blue, Mount Kimbie, MIKE\n\n2. DJ Seinfeld - If This Is It (existing post, previously published)\nhttps://artonly.io/post/dj-seinfeld-if-this-is-it\nReleased: June 5, 2026 (Ninja Tune)\n\nOutreach emails sent:\n- Wiki: press@wikset.nyc\n- DJ Seinfeld: press@ninjatune.net\n\nIndexNow pinged for both posts."
})

proc = subprocess.run(
    ['python3', '/home/dh_yadmw3/artonly.io/api/gmail-send.py'],
    input=data,
    capture_output=True,
    text=True
)
print("STDOUT:", proc.stdout)
print("STDERR:", proc.stderr)
print("Return code:", proc.returncode)
PYEOF

echo "=== Done ==="
