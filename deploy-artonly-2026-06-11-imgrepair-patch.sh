#!/bin/bash
# artonly.io image repair patch: fix 2 Aldous Harding images that failed (Wikipedia rate-blocked)
# Generated: 2026-06-11

echo "=== artonly.io Image Repair Patch ==="

ARTISTS_DIR="/home/dh_yadmw3/artonly.io/assets/images/artists"
OK=0
FAIL=0

download_image() {
    local filename="$1"
    local url="$2"
    local dest="$ARTISTS_DIR/$filename"

    curl -s -L -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
        -m 60 --retry 2 -o "$dest" "$url" 2>/dev/null
    local size
    size=$(wc -c < "$dest" 2>/dev/null || echo 0)
    if [ "$size" -gt 5000 ]; then
        echo "OK (${size}B): $filename"
        OK=$((OK+1))
    else
        echo "FAIL (${size}B): $filename  <-- $url"
        rm -f "$dest"
        FAIL=$((FAIL+1))
    fi
}

# aldous-harding-scroll.jpg: 4AD official artist photo
download_image "aldous-harding-scroll.jpg" \
    "https://shopusa.4ad.com/cdn/shop/files/aldous-harding_1.jpg?v=1736360880"

# aldous-harding-catalog.jpg: Barbican 2026 press photo (credit: Emma Wallbanks)
download_image "aldous-harding-catalog.jpg" \
    "https://www.barbican.org.uk/sites/default/files/styles/hero_constrained_small/public/images/2025-12/Aldous%202026%20%28credit%20-%20Emma%20Wallbanks%29.jpg?h=1a14766c&itok=lqHO_es8"

echo ""
echo "=== RESULT: $OK downloaded, $FAIL failed ==="
echo "=== Done ==="
