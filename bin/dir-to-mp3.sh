#!/usr/bin/env bash

# Converts every mp3, flac, wav and ogg file of a directory to an mp3
# Bitrate (kbps) can be given as the only argument

FILES=$(echo ./*.{mp3,flac,wav,ogg} | sed 's/\.\/\*\.flac \.\/\*\.wav \.\/\*\.ogg//')
BITRATE=${1:-192}
OUT_DIR="./converted-mp3"

mkdir -p $OUT_DIR
for f in $FILES; do
  ffmpeg -y -i "$f" -ac 2 -b:a "$BITRATE"k "$OUT_DIR"/"${f%.*}".mp3
done
