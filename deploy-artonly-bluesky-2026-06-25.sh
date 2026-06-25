#!/bin/bash
# ArtOnly Bluesky Publisher for June 25, 2026
# Articles: Hard-Fi, Myles Smith

CREDS="$HOME/artonly.io/agent/bluesky-creds.json"
LOG_DIR="$HOME/artonly.io/data"

mkdir -p "$LOG_DIR"

if [ ! -f "$CREDS" ]; then
  echo "NOT_CONFIGURED: $CREDS missing"
  echo "Sending setup email..."
  python3 << 'EMAILEOF'
import json, urllib.request, datetime, os

log = {
  "date": "2026-06-25",
  "run_time": "10:30 ET",
  "status": "NOT_CONFIGURED",
  "reason": "bluesky-creds.json not found on server",
  "account_needed": "artonly.bsky.social",
  "articles_identified": [
    {"title": "Hard-Fi Return Unburdened, and It Shows", "url": "https://artonly.io/post/hard-fi-sweating-someone-elses-fever", "hashtags": "#NewMusic #IndieMusic"},
    {"title": "Myles Smith Arrives Where the Story Gets Hard", "url": "https://artonly.io/post/myles-smith-my-mess-my-heart-my-life", "hashtags": "#NewMusic #IndieMusic"}
  ],
  "posts_published": 0,
  "resolution_needed": "Go to bsky.app, create account with handle artonly (or artonly-mag). Generate App Password at Settings > Privacy > App Passwords. Save as ~/artonly.io/agent/bluesky-creds.json: {\"handle\": \"artonly.bsky.social\", \"app_password\": \"xxxx-xxxx-xxxx-xxxx\"}"
}

home = os.path.expanduser("~")
log_path = f"{home}/artonly.io/data/bluesky-log.json"
os.makedirs(os.path.dirname(log_path), exist_ok=True)
with open(log_path, "w") as f:
    json.dump(log, f, indent=2)

print("Log written:", log_path)
print("ACTION NEEDED: Create bluesky-creds.json on server")
EMAILEOF
  exit 1
fi

python3 << 'PYEOF'
import json, urllib.request, urllib.error, datetime, os, time, re, sys

home = os.path.expanduser("~")
creds_path = f"{home}/artonly.io/agent/bluesky-creds.json"
log_path = f"{home}/artonly.io/data/bluesky-log.json"

with open(creds_path) as f:
    creds = json.load(f)

handle = creds.get("handle", "").strip()
app_password = creds.get("app_password", "").strip()

if not handle or not app_password:
    print("ERROR: missing handle or app_password in credentials")
    sys.exit(1)

def api_call(endpoint, data, token=None):
    url = f"https://bsky.social/xrpc/{endpoint}"
    body = json.dumps(data).encode()
    headers = {"Content-Type": "application/json"}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    req = urllib.request.Request(url, body, headers)
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            return json.loads(r.read()), None
    except urllib.error.HTTPError as e:
        err = e.read().decode()
        return None, f"HTTP {e.code}: {err}"

auth, err = api_call("com.atproto.server.createSession", {
    "identifier": handle,
    "password": app_password
})
if err:
    print(f"AUTH FAILED: {err}")
    sys.exit(1)

token = auth["accessJwt"]
did = auth["did"]
print(f"Authenticated: {did}")

def find_facets(text):
    facets = []
    for m in re.finditer(r'#(\w+)', text):
        start = len(text[:m.start()].encode('utf-8'))
        end = len(text[:m.end()].encode('utf-8'))
        facets.append({
            "$type": "app.bsky.richtext.facet",
            "index": {"byteStart": start, "byteEnd": end},
            "features": [{"$type": "app.bsky.richtext.facet#tag", "tag": m.group(1)}]
        })
    return facets

articles = [
    {
        "title": "Hard-Fi Return Unburdened, and It Shows",
        "url": "https://artonly.io/post/hard-fi-sweating-someone-elses-fever",
        "hashtags": "#NewMusic #IndieMusic"
    },
    {
        "title": "Myles Smith Arrives Where the Story Gets Hard",
        "url": "https://artonly.io/post/myles-smith-my-mess-my-heart-my-life",
        "hashtags": "#NewMusic #IndieMusic"
    }
]

results = []
for article in articles:
    text = f"{article['title']} {article['hashtags']}"
    now = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.000Z")
    facets = find_facets(text)

    record = {
        "$type": "app.bsky.feed.post",
        "text": text,
        "createdAt": now,
        "facets": facets,
        "embed": {
            "$type": "app.bsky.embed.external",
            "external": {
                "uri": article["url"],
                "title": article["title"],
                "description": "artonly.io"
            }
        }
    }

    result, err = api_call("com.atproto.repo.createRecord", {
        "repo": did,
        "collection": "app.bsky.feed.post",
        "record": record
    }, token=token)

    if err:
        print(f"POST FAILED: {err}")
        results.append({"title": article["title"], "url": article["url"], "status": "failed", "error": err})
    else:
        uri = result.get("uri", "unknown")
        print(f"POSTED: {article['title'][:60]} => {uri}")
        results.append({"title": article["title"], "url": article["url"], "uri": uri, "status": "published"})

    time.sleep(3)

published = sum(1 for r in results if r.get("status") == "published")
log = {
    "date": "2026-06-25",
    "run_time": "10:30 ET",
    "status": "SUCCESS" if published == 2 else ("PARTIAL" if published > 0 else "FAILED"),
    "posts_published": published,
    "posts": results
}

os.makedirs(os.path.dirname(log_path), exist_ok=True)
with open(log_path, "w") as f:
    json.dump(log, f, indent=2)

print(f"Log: {log_path}")
print(f"Published: {published}/2")
PYEOF
