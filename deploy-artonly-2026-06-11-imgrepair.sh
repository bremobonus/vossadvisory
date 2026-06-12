#!/bin/bash
# artonly.io body image repair: download 36 missing press photos across 7 posts
# Generated: 2026-06-11
# Run via GitHub Actions (deploy-artonly.yml) or:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-06-11-imgrepair.sh

echo "=== artonly.io Image Repair 2026-06-11 ==="

ARTISTS_DIR="/home/dh_yadmw3/artonly.io/assets/images/artists"
OK=0
FAIL=0
SKIP=0

download_image() {
    local filename="$1"
    local url="$2"
    local dest="$ARTISTS_DIR/$filename"

    if [ -f "$dest" ]; then
        local existing
        existing=$(wc -c < "$dest" 2>/dev/null || echo 0)
        if [ "$existing" -gt 5000 ]; then
            echo "SKIP (exists, ${existing}B): $filename"
            SKIP=$((SKIP+1))
            return
        fi
    fi

    curl -s -L -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0" \
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

# ---------------------------------------------------------------
# Nick León (5 body images)
# ---------------------------------------------------------------
download_image "nick-leon-arquitectronica.jpg" \
    "https://djmag.com/sites/default/files/styles/djm_23_961x540_jpg/public/2025-05/IMG_1272.JPG.jpg?itok=xLkwotBk"

download_image "nick-leon-miami-score.jpg" \
    "https://www.miaminewtimes.com/wp-content/uploads/sites/4/ww-media/mediaserver/mia/2017-46/feature14-1-591c579ba25fa75e.webp"

download_image "nick-leon-rosalia-era.jpg" \
    "https://djmag.com/sites/default/files/styles/djm_23_961x540_jpg/public/2022-06/Nick%20Leo%CC%81n%20Bitter%20Babe%20.jpg?itok=ZheINt8o"

download_image "nick-leon-collaborators.jpg" \
    "https://files.pi.fyi/cdn-cgi/image/quality=70,format=webp/users/clo3dv6su000bur3ptk0zgk82/images/ztl3evokly7bte7zyv09yqh6/original.jpg"

download_image "nick-leon-against-categories.jpg" \
    "https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6699f36d-969f-4a10-b8d9-22b3198b4a7c_3312x4416.jpeg"

# ---------------------------------------------------------------
# Grouper / Liz Harris (5 body images)
# ---------------------------------------------------------------
download_image "grouper-heavywater.jpg" \
    "https://groundcontroltouring.com/storage/2977/conversions/01KP911H9A5XJXTGZWMT8XKRGY-large.jpg"

download_image "grouper-shade.jpg" \
    "https://groundcontroltouring.com/storage/2978/GRP1.jpg"

download_image "grouper-raum.jpg" \
    "https://www.digitalinberlin.de/wordpress/wp-content/2020/09/LizHarris_AliciaJRoseBZ-2.jpg"

download_image "grouper-slowwalkers.jpg" \
    "https://lastfm.freetls.fastly.net/i/u/770x0/94e986d2cea2ff4e9863e7a5b1a37410.jpg"

download_image "grouper-live.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/4/4b/Liz_Harris_Grouper.png"

# ---------------------------------------------------------------
# Angel Olsen (6 body images)
# ---------------------------------------------------------------
download_image "angel-olsen-countryroots.jpg" \
    "https://images.squarespace-cdn.com/content/v1/679012fda46f71605008f8b0/84f8eebc-8b3f-466a-be7d-14ce4a9eb5c2/AngelOlsen_PhotoCredit_MagdalenaWosinska.jpg"

download_image "angel-olsen-topanga.jpg" \
    "https://images.squarespace-cdn.com/content/v1/679012fda46f71605008f8b0/1737618573153-HN2LSXZB018RPRQFY0LH/AngelOlsen_PhotoCredit_MaximLudwig.jpg"

download_image "angel-olsen-beforeloss.jpg" \
    "https://angelolsen.com/wp-content/uploads/2023/03/ao-24.jpg-cropped.jpg"

download_image "angel-olsen-voice.jpg" \
    "https://angelolsen.com/wp-content/uploads/2022/03/AR_ANGELOLSEN_BIGTIME_RETOUCH_11.jpg"

download_image "angel-olsen-collabs.jpg" \
    "https://angelolsen.com/wp-content/uploads/2022/03/AR_ANGELOLSEN_BIGTIME_RETOUCH_1.jpg"

download_image "angel-olsen-cosmic.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/6/6b/Angel_Olsen_Rockefeller_2020_222104.jpg"

# ---------------------------------------------------------------
# Aldous Harding (5 body images)
# ---------------------------------------------------------------
download_image "aldous-harding-withholding.jpg" \
    "https://www.aldousharding.net/wp/wp-content/uploads/2023/07/2019_aldousharding_clareshilland_01.jpg"

download_image "aldous-harding-parish.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/4/47/Aldous_Harding_at_the_Barbican_%2852854523971%29-edit.jpg"

download_image "aldous-harding-scroll.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/4/4d/Aldous_Harding_%2830901885381%29-edit.jpg"

download_image "aldous-harding-catalog.jpg" \
    "https://upload.wikimedia.org/wikipedia/commons/8/89/Aldous_Harding_%2823212350536%29-edit.jpg"

download_image "aldous-harding-present.jpg" \
    "https://www.nme.com/wp-content/uploads/2026/01/live-aldous-harding-696x442.jpg"

# ---------------------------------------------------------------
# Lankum (5 body images)
# ---------------------------------------------------------------
download_image "lankum-dublin.jpg" \
    "https://s3.eu-west-1.amazonaws.com/cf-cdn.beggars.com/roughtrade/wp-content/uploads/2021/07/04110955/Lankum_Press-Photo-10-Credit-Sorcha-Frances-Ryder.jpg"

download_image "lankum-studio.jpg" \
    "https://s3.eu-west-1.amazonaws.com/cf-cdn.beggars.com/roughtrade/wp-content/uploads/2025/10/30113810/Lankum_GhostTown_4000px-scaled.jpg"

download_image "lankum-falselankum.jpg" \
    "https://s3.eu-west-1.amazonaws.com/cf-cdn.beggars.com/roughtrade/wp-content/uploads/2025/01/05165908/455414-1.jpg"

download_image "lankum-harmonies.jpg" \
    "https://www.nme.com/wp-content/uploads/2024/04/lankum_live_2000_1-696x442.jpg"

download_image "lankum-vicarstreet.jpg" \
    "https://s3.eu-west-1.amazonaws.com/cf-cdn.beggars.com/roughtrade/wp-content/uploads/2025/02/05170512/340247-1.jpg"

# ---------------------------------------------------------------
# Florist / Emily Sprague (5 body images)
# ---------------------------------------------------------------
download_image "florist-quiet.jpg" \
    "https://www.philthymag.com/wp-content/uploads/2025/04/Florist-by-V-Haddad-5-1920x1080.jpg"

download_image "florist-subject.jpg" \
    "https://res.cloudinary.com/dhh19fozh/q_auto:good,f_auto,dpr_1.0/jb7production-uploads/2025/01/florist-press-january-2025-1200x632.jpg"

download_image "florist-production.jpg" \
    "https://images.squarespace-cdn.com/content/v1/5edf06dcd417cb4da8ba2163/b2696625-1d81-4132-90df-fbd23e0b0052/Florist+by+V+Haddad+-+3.jpg"

download_image "florist-tracks.jpg" \
    "https://images.squarespace-cdn.com/content/v1/5edf06dcd417cb4da8ba2163/dd2ffe48-0cc8-4ac3-a3f2-bb4215702fec/Florist+by+V+Haddad+-+2.jpg"

download_image "florist-context.jpg" \
    "https://images.squarespace-cdn.com/content/v1/5edf06dcd417cb4da8ba2163/5b22cd3c-f73b-4388-90f5-f4c596a868dd/Florist+by+V+Haddad+-+1.jpg"

# ---------------------------------------------------------------
# Perfume Genius / Mike Hadreas (5 body images)
# ---------------------------------------------------------------
download_image "perfume-genius-portrait.jpg" \
    "https://matadorrecords.com/cdn/shop/articles/PG_-_credit_Cody_Critcheloe.jpg?v=1772170674&width=4200"

download_image "perfume-genius-live.jpg" \
    "https://matadorrecords.com/cdn/shop/articles/Clean_Heart_-_Perfume_Genius_Glory_Promo-62_-_credit_Cody_Critcheloe_834ac9ed-4689-4871-8808-4f303008e00f.jpg?v=1743113316&width=2000"

download_image "perfume-genius-studio.jpg" \
    "https://cdn.sanity.io/images/al3bmbfh/production/98aa7eaa0abe68f319fa79a1b3e8d93ade941c9f-1280x1707.jpg?auto=format"

download_image "perfume-genius-visual.jpg" \
    "https://images-prod.anothermag.com/1600/azure/another-prod/450/9/459952.jpeg"

download_image "perfume-genius-stage.jpg" \
    "https://images.squarespace-cdn.com/content/v1/62a8d040753efb6690fa2c54/2ecff989-d515-47fd-addc-993dcced441d/Tour+Admat+-+Perfume+Genius%2C+Glory+Promo-04+-+credit+Cody+Critcheloe.jpeg"

# ---------------------------------------------------------------
echo ""
echo "=== RESULT: $OK downloaded, $SKIP skipped, $FAIL failed ==="
echo "=== Done ==="
