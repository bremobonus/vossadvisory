#!/usr/bin/env python3
"""Append-only, hash-chained log of calls/contacts from Rates Insurance / Aviva.

Each entry stores the SHA-256 of the previous entry, so any later edit,
deletion or re-ordering is detectable with `verify`. Entries are never edited;
corrections are made by adding a new entry that references the old id.

  python3 log_call.py add --occurred "2026-11-21 10:05" --caller "Name" \
      --org "Rates Insurance" --number "416-..." --direction in \
      --duration "3 min" --topic "..." --solicitation unknown --recorded yes \
      --source "phone screenshot" --notes "..."
  python3 log_call.py verify
  python3 log_call.py export      # writes call-log.md
"""
import argparse, hashlib, json, sys, datetime as dt
from pathlib import Path
from zoneinfo import ZoneInfo

LOG = Path(__file__).with_name("call-log.jsonl")
FIELDS = ["occurred", "kind", "caller", "org", "number", "direction", "duration",
          "topic", "solicitation", "recorded", "voicemail", "source", "notes"]

def read():
    if not LOG.exists():
        return []
    return [json.loads(l) for l in LOG.read_text().splitlines() if l.strip()]

def digest(entry):
    body = {k: v for k, v in entry.items() if k != "hash"}
    return hashlib.sha256(json.dumps(body, sort_keys=True, ensure_ascii=False).encode()).hexdigest()

def add(a):
    rows = read()
    e = {"id": f"CL-{len(rows)+1:03d}",
         "logged_at": dt.datetime.now(ZoneInfo("America/Toronto")).isoformat(timespec="seconds"),
         "prev_hash": rows[-1]["hash"] if rows else "GENESIS"}
    for f in FIELDS:
        e[f] = getattr(a, f, None) or ""
    e["hash"] = digest(e)
    with LOG.open("a") as fh:
        fh.write(json.dumps(e, ensure_ascii=False) + "\n")
    print("logged", e["id"])

def verify():
    prev = "GENESIS"
    for r in read():
        if r["prev_hash"] != prev or r["hash"] != digest(r):
            print("TAMPER DETECTED at", r["id"]); sys.exit(1)
        prev = r["hash"]
    print("OK:", len(read()), "entries, chain intact")

def export():
    rows = read()
    out = ["# Contact log: Rates Insurance Brokers / Aviva", "",
           "| ID | Occurred | Kind | Who | Number | Dir | Dur | Topic | Sales pitch? | Recorded | Source |",
           "|---|---|---|---|---|---|---|---|---|---|---|"]
    for r in rows:
        who = f'{r["caller"]} ({r["org"]})'
        out.append("| " + " | ".join(str(x).replace("|", "/") for x in [
            r["id"], r["occurred"], r["kind"], who, r["number"], r["direction"], r["duration"],
            r["topic"], r["solicitation"], r["recorded"], r["source"]]) + " |")
    out += ["", "## Notes", ""] + [f'- **{r["id"]}**: {r["notes"]}' for r in rows if r["notes"]]
    Path(__file__).with_name("call-log.md").write_text("\n".join(out) + "\n")
    print("wrote call-log.md")

if __name__ == "__main__":
    p = argparse.ArgumentParser(); s = p.add_subparsers(dest="cmd", required=True)
    ap = s.add_parser("add")
    for f in FIELDS:
        ap.add_argument("--" + f)
    s.add_parser("verify"); s.add_parser("export")
    a = p.parse_args()
    {"add": lambda: add(a), "verify": verify, "export": export}[a.cmd]()
