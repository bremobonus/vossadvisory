#!/usr/bin/env python3
"""Website Empire collector: catalogs every domain in this DreamHost account and writes data.json."""
import concurrent.futures as cf
import datetime as dt
import glob
import gzip
import json
import os
import re
import socket
import ssl
import sys
import time
import urllib.request

HOME = os.path.expanduser("~")
OUT_DIR = os.path.join(HOME, "bremo.io", "websiteempire")
STATE_DIR = os.path.join(HOME, "websiteempire")
CACHE = os.path.join(STATE_DIR, "cache.json")
LOCK = os.path.join(STATE_DIR, "collect.lock")
DAYS = 14
UA = "WebsiteEmpireMonitor/1.0"

DOMAIN_RE = re.compile(r"^(?=.{4,253}$)([a-z0-9-]+\.)+[a-z]{2,24}$")
SKIP_DIRS = {"logs", "Maildir", "tmp", "websiteempire"}
BOT_RE = re.compile(r"bot|crawl|spider|slurp|curl|wget|python|scrapy|httpclient|monitor|headless|preview|facebookexternalhit|semrush|ahrefs|bytespider|gptbot|claude|axios|go-http|java/", re.I)
ASSET_RE = re.compile(r"\.(css|js|png|jpe?g|gif|webp|svg|ico|woff2?|ttf|map|xml|txt|json|mp4|webm|mp3|pdf|zip)(\?|$)", re.I)
LOG_RE = re.compile(r'^(\S+) \S+ \S+ \[([^\]]+)\] "(\S+) (\S+)[^"]*" (\d{3}) (\S+) "([^"]*)" "([^"]*)"')


def load_cache():
    try:
        with open(CACHE) as f:
            return json.load(f)
    except Exception:
        return {}


def discover():
    found = set()
    for name in os.listdir(HOME):
        p = os.path.join(HOME, name)
        if name in SKIP_DIRS or name.startswith(".") or not os.path.isdir(p):
            continue
        if DOMAIN_RE.match(name.lower()):
            found.add(name.lower())
    logs = os.path.join(HOME, "logs")
    if os.path.isdir(logs):
        for name in os.listdir(logs):
            if DOMAIN_RE.match(name.lower()):
                found.add(name.lower())
    return sorted(found)


def dir_stats(domain):
    root = os.path.join(HOME, domain)
    out = {"bytes": 0, "files": 0, "last_modified": None, "stack": "none"}
    if not os.path.isdir(root):
        return out
    latest = 0
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in (".git", "node_modules", "cache")]
        for fn in filenames:
            try:
                st = os.lstat(os.path.join(dirpath, fn))
            except OSError:
                continue
            out["files"] += 1
            out["bytes"] += st.st_size
            if st.st_mtime > latest:
                latest = st.st_mtime
    if latest:
        out["last_modified"] = dt.datetime.utcfromtimestamp(latest).isoformat() + "Z"
    if os.path.exists(os.path.join(root, "wp-config.php")):
        out["stack"] = "WordPress"
    elif glob.glob(os.path.join(root, "index.php")):
        out["stack"] = "PHP"
    elif glob.glob(os.path.join(root, "index.htm*")):
        out["stack"] = "Static"
    elif out["files"]:
        out["stack"] = "Other"
    return out


def iter_log_lines(domain, since_ts):
    for proto in ("https", "http"):
        for path in glob.glob(os.path.join(HOME, "logs", domain, proto, "access.log*")):
            try:
                if os.path.getmtime(path) < since_ts:
                    continue
                opener = gzip.open if path.endswith(".gz") else open
                with opener(path, "rt", errors="ignore") as f:
                    for line in f:
                        yield line
            except OSError:
                continue


def traffic(domain, now):
    since = now - dt.timedelta(days=DAYS)
    daily_views = {}
    daily_visitors = {}
    pages = {}
    refs = {}
    status = {"2xx": 0, "3xx": 0, "4xx": 0, "5xx": 0}
    bots = 0
    bytes_out = 0
    for line in iter_log_lines(domain, since.timestamp() - 86400):
        m = LOG_RE.match(line)
        if not m:
            continue
        ip, ts, method, path, code, size, ref, ua = m.groups()
        try:
            when = dt.datetime.strptime(ts, "%d/%b/%Y:%H:%M:%S %z").astimezone(dt.timezone.utc).replace(tzinfo=None)
        except ValueError:
            continue
        if when < since:
            continue
        status[code[0] + "xx"] = status.get(code[0] + "xx", 0) + 1
        if size.isdigit():
            bytes_out += int(size)
        if BOT_RE.search(ua):
            bots += 1
            continue
        if method != "GET" or not code.startswith("2") or ASSET_RE.search(path):
            continue
        day = when.strftime("%Y-%m-%d")
        daily_views[day] = daily_views.get(day, 0) + 1
        daily_visitors.setdefault(day, set()).add(ip + "|" + ua)
        clean = path.split("?")[0]
        pages[clean] = pages.get(clean, 0) + 1
        if ref and ref != "-" and domain not in ref:
            host = re.sub(r"^https?://(www\.)?", "", ref).split("/")[0]
            refs[host] = refs.get(host, 0) + 1
    days = [(now - dt.timedelta(days=i)).strftime("%Y-%m-%d") for i in range(DAYS - 1, -1, -1)]
    series = [daily_views.get(d, 0) for d in days]
    visitors = [len(daily_visitors.get(d, ())) for d in days]
    return {
        "days": days,
        "views": series,
        "visitors": visitors,
        "views_24h": series[-1],
        "views_7d": sum(series[-7:]),
        "views_prev_7d": sum(series[-14:-7]),
        "visitors_7d": sum(visitors[-7:]),
        "bot_hits": bots,
        "bandwidth_bytes": bytes_out,
        "status": status,
        "top_pages": sorted(pages.items(), key=lambda kv: -kv[1])[:8],
        "top_referrers": sorted(refs.items(), key=lambda kv: -kv[1])[:6],
    }


def http_check(domain):
    out = {"up": False, "code": None, "ms": None, "final_url": None, "title": None, "error": None}
    t0 = time.time()
    try:
        req = urllib.request.Request("https://" + domain + "/", headers={"User-Agent": UA})
        with urllib.request.urlopen(req, timeout=12) as r:
            body = r.read(200000).decode("utf-8", errors="ignore")
            out["code"] = r.status
            out["final_url"] = r.geturl()
            mt = re.search(r"<title[^>]*>(.*?)</title>", body, re.I | re.S)
            if mt:
                out["title"] = re.sub(r"\s+", " ", mt.group(1)).strip()[:120]
            out["up"] = 200 <= r.status < 400
    except urllib.error.HTTPError as e:
        out["code"] = e.code
        out["error"] = "HTTP %d" % e.code
    except Exception as e:
        out["error"] = type(e).__name__ + ": " + str(e)[:120]
    out["ms"] = int((time.time() - t0) * 1000)
    return out


def ssl_check(domain):
    try:
        ctx = ssl.create_default_context()
        with socket.create_connection((domain, 443), timeout=8) as s:
            with ctx.wrap_socket(s, server_hostname=domain) as ss:
                cert = ss.getpeercert()
        exp = dt.datetime.strptime(cert["notAfter"], "%b %d %H:%M:%S %Y %Z")
        issuer = dict(x[0] for x in cert.get("issuer", ()))
        return {"valid": True, "expires": exp.isoformat() + "Z", "issuer": issuer.get("organizationName")}
    except Exception as e:
        return {"valid": False, "error": type(e).__name__ + ": " + str(e)[:120]}


def rdap(domain, cache, now):
    hit = cache.get("rdap", {}).get(domain)
    if hit and now.timestamp() - hit.get("checked", 0) < 86400:
        return hit
    res = {"checked": now.timestamp(), "registered": None, "expires": None, "registrar": None}
    try:
        req = urllib.request.Request("https://rdap.org/domain/" + domain, headers={"User-Agent": UA, "Accept": "application/rdap+json"})
        with urllib.request.urlopen(req, timeout=15) as r:
            data = json.load(r)
        res["registered"] = True
        for ev in data.get("events", []):
            if ev.get("eventAction") == "expiration":
                res["expires"] = ev.get("eventDate")
        for ent in data.get("entities", []):
            if "registrar" in ent.get("roles", []):
                for item in ent.get("vcardArray", [None, []])[1]:
                    if item[0] == "fn":
                        res["registrar"] = item[3]
    except urllib.error.HTTPError as e:
        if e.code == 404:
            res["registered"] = False
    except Exception:
        pass
    if res["registered"] is not None:
        cache.setdefault("rdap", {})[domain] = res
    return res


def collect_one(domain, cache, now):
    return {
        "domain": domain,
        "files": dir_stats(domain),
        "traffic": traffic(domain, now),
        "http": http_check(domain),
        "ssl": ssl_check(domain),
        "registration": rdap(domain, cache, now),
    }


def main():
    os.makedirs(STATE_DIR, exist_ok=True)
    os.makedirs(OUT_DIR, exist_ok=True)
    try:
        fd = os.open(LOCK, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
        os.write(fd, str(os.getpid()).encode())
        os.close(fd)
    except FileExistsError:
        if time.time() - os.path.getmtime(LOCK) < 1800:
            print("collector already running")
            return
        os.remove(LOCK)
        return main()
    try:
        started = time.time()
        now = dt.datetime.utcnow()
        cache = load_cache()
        domains = discover()
        with cf.ThreadPoolExecutor(max_workers=8) as pool:
            sites = list(pool.map(lambda d: collect_one(d, cache, now), domains))
        prev = cache.get("history", [])
        snapshot = {
            "t": now.isoformat() + "Z",
            "views_24h": sum(s["traffic"]["views_24h"] for s in sites),
            "up": sum(1 for s in sites if s["http"]["up"]),
        }
        cache["history"] = (prev + [snapshot])[-672:]
        data = {
            "generated": now.isoformat() + "Z",
            "duration_s": round(time.time() - started, 1),
            "host": socket.gethostname(),
            "sites": sites,
            "history": cache["history"],
        }
        tmp = os.path.join(OUT_DIR, "data.json.tmp")
        with open(tmp, "w") as f:
            json.dump(data, f, separators=(",", ":"))
        os.replace(tmp, os.path.join(OUT_DIR, "data.json"))
        with open(CACHE, "w") as f:
            json.dump(cache, f)
        print("collected %d sites in %.1fs" % (len(sites), time.time() - started))
    finally:
        try:
            os.remove(LOCK)
        except OSError:
            pass


if __name__ == "__main__":
    sys.exit(main())
