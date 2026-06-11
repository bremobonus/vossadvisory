#!/bin/bash
# ArtOnly Album Monitor Deploy Script
# Generated: 2026-05-24
# Posts: jpegmafia-experimental-rap, bleachers-everyone-for-ten-minutes
# Run on DreamHost server:
# sshpass -p 'Neverending48!' ssh -o PreferredAuthentications=password -o StrictHostKeyChecking=no dh_yadmw3@pdx1-shared-a2-06.dreamhost.com 'bash -s' < deploy-artonly-2026-05-24.sh

set -e
echo '=== ArtOnly Deploy: 2026-05-24 ==='

# ---- POST 1: JPEGMAFIA ----
echo '--- Deploying: jpegmafia-experimental-rap ---'
curl -L -o ~/artonly.io/assets/images/artists/jpegmafia-experimental-rap.jpg \
  'https://commons.wikimedia.org/wiki/Special:FilePath/JPEGMAFIA_-_Primavera_Sound_2023_(cropped).jpg'
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert jpegmafia-experimental-rap.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 jpegmafia-experimental-rap-up.jpg && mv jpegmafia-experimental-rap-up.jpg jpegmafia-experimental-rap.jpg
cd ~/artonly.io/agent
python3 make-social-card.py jpegmafia-experimental-rap 'JPEGMAFIA Names the Thing Nobody Would and Means Every Word of It' music
cp /tmp/jpegmafia-experimental-rap.json ~/artonly.io/posts/jpegmafia-experimental-rap.json
echo 'jpegmafia-experimental-rap deployed'

# ---- POST 2: BLEACHERS ----
echo '--- Deploying: bleachers-everyone-for-ten-minutes ---'
curl -L -o ~/artonly.io/assets/images/artists/bleachers-everyone-for-ten-minutes.jpg \
  'https://commons.wikimedia.org/wiki/Special:FilePath/Jack_Antonoff_-_Bleachers_-_Day-In_Day-Out_Festival_Seattle_July_2024.jpg'
cd ~/artonly.io/assets/images/artists/
OMP_NUM_THREADS=1 convert bleachers-everyone-for-ten-minutes.jpg -resize 150% -unsharp 0x0.75+0.75+0.008 -quality 92 bleachers-everyone-for-ten-minutes-up.jpg && mv bleachers-everyone-for-ten-minutes-up.jpg bleachers-everyone-for-ten-minutes.jpg
cd ~/artonly.io/agent
python3 make-social-card.py bleachers-everyone-for-ten-minutes 'Jack Antonoff Made Everyone Elses Records. Then He Came Home.' music
cp /tmp/bleachers-everyone-for-ten-minutes.json ~/artonly.io/posts/bleachers-everyone-for-ten-minutes.json
echo 'bleachers-everyone-for-ten-minutes deployed'

# ---- Verify + IndexNow ----
JPEG_CODE=$(curl -s -o /dev/null -w '%{http_code}' 'https://artonly.io/post/jpegmafia-experimental-rap')
echo "jpegmafia-experimental-rap: HTTP $JPEG_CODE"
BLEACH_CODE=$(curl -s -o /dev/null -w '%{http_code}' 'https://artonly.io/post/bleachers-everyone-for-ten-minutes')
echo "bleachers-everyone-for-ten-minutes: HTTP $BLEACH_CODE"
curl -s 'https://api.indexnow.org/indexnow?url=https://artonly.io/post/jpegmafia-experimental-rap&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b'
curl -s 'https://api.indexnow.org/indexnow?url=https://artonly.io/post/bleachers-everyone-for-ten-minutes&key=5a4a5c1b5f124ccc9e6c4e5c5a4a5c1b'

# ---- Outreach ----
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d 'to=press@awal.com' \
  -d 'subject=Your artist is on ArtOnly' \
  -d 'body=Hi, we published a piece on JPEGMAFIA and EXPERIMENTAL RAP at artonly.io/post/jpegmafia-experimental-rap. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly' \
  -d 'bcc=amosleblanc@gmail.com'
curl -s -X POST https://artonly.io/api/send-mail.php \
  -d 'to=press@dirtyhit.com' \
  -d 'subject=Your artist is on ArtOnly' \
  -d 'body=Hi, we published a piece on Bleachers and everyone for ten minutes at artonly.io/post/bleachers-everyone-for-ten-minutes. No ask, just thought you should see it. Best, Allastair Voss, ArtOnly' \
  -d 'bcc=amosleblanc@gmail.com'

# ---- Summary email ----
python3 ~/artonly.io/api/gmail-send.py 'amosleblanc@gmail.com' \
  'ArtOnly Album Monitor: 2026-05-24' \
  'Published today:\n\nhttps://artonly.io/post/jpegmafia-experimental-rap\nhttps://artonly.io/post/bleachers-everyone-for-ten-minutes\n\nOutreach: press@awal.com (JPEGMAFIA), press@dirtyhit.com (Bleachers)'
echo '=== Done ==='
