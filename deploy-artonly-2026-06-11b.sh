#!/bin/bash
# ArtOnly Deploy Fix: 2026-06-11b
# Sends summary email only (posts already deployed in 2026-06-11)

echo "=== ArtOnly Deploy Fix: 2026-06-11b ==="

# Posts already deployed - skip image/JSON/verify steps
# Send summary via send-mail API (gmail-send.py interface has changed)
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d "to=amosleblanc@gmail.com" \
  -d "subject=ArtOnly Album Monitor: 2026-06-11" \
  -d "body=Published today:

1. Bedouine - Neon Summer Skin
   https://artonly.io/post/bedouine-neon-summer-skin
   Author: Leelou Blanc
   Spotify: 6IiZemRMna678qNhiRkYI5
   Released: June 5, 2026 (Thirty Tigers)
   11 tracks, 41 minutes, fourth album
   Themes: displacement, family history, Armenian-Syrian heritage, memory
   Image: Downloaded from Aquarium Drunkard (333KB)

2. Navy Blue - Sir Render
   https://artonly.io/post/navy-blue-sir-render
   Author: Allastair Voss
   Spotify: 5qRbfEf4Ooo19aRXKQzvUV
   Released: June 5, 2026 (Freedom Sounds)
   15 tracks, 45 minutes, trilogy closer
   Features: Armand Hammer, Earl Sweatshirt, Ka (posthumous)
   Image: Downloaded from Underground Hip Hop Blog (199KB)

Outreach:
- Bedouine: sent to press@thirtytigers.com (success)
- Navy Blue: sent to navybluethetruest@gmail.com (success)

Both posts live and verified HTTP 200.
Both IndexNow pings sent."
echo "Summary email sent via send-mail API"

echo "=== Fix complete: 2026-06-11b ==="
