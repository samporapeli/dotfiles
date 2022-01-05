#!/bin/bash

SS_DIRECTORY="$HOME/Pictures/screenshot.sh"
FILENAME="$(date --iso-8601=ns)_screenshot.png"
FILE="$SS_DIRECTORY/$FILENAME"
mkdir -p "$SS_DIRECTORY"

if [[ "$1" == "select" ]]; then
    scrot -s -F "$FILE"
elif [[ "$1" == "full" ]] || [[ "$1" == "" ]]; then
    scrot -F "$FILE"
else
    echo "Unknown parameter '$1'"
    echo ""
    echo "Usage:"
    echo "  $0 [full]"
    echo "  $0 select"
    exit 1
fi

xclip -selection clipboard -t image/png -i "$FILE" &&
    notify-send "Image \"$FILE\" copied to clipboard"
