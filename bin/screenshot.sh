#!/bin/bash

set -eo pipefail

SS_DIRECTORY="$HOME/Pictures/screenshot.sh"
FILENAME="$(date --iso-8601=ns)_screenshot.png"
FILE="$SS_DIRECTORY/$FILENAME"
mkdir -p "$SS_DIRECTORY"

IS_WAYLAND=$([[ "$XDG_SESSION_TYPE" = "wayland" ]])

if [[ "$1" == "select" ]]; then
    $IS_WAYLAND && gnome-screenshot --area --file="$FILE" || scrot -s -F "$FILE"
elif [[ "$1" == "full" ]] || [[ "$1" == "" ]]; then
    $IS_WAYLAND && gnome-screenshot --file="$FILE" || scrot -F "$FILE"
else
    echo "Unknown parameter '$1'"
    echo ""
    echo "Usage:"
    echo "  $0 [full]"
    echo "  $0 select"
    exit 1
fi

if $IS_WAYLAND; then
    wl-copy < "$FILE"
else
    xclip -selection clipboard -t image/png -i "$FILE"
fi

NOTIFICATION_RESULT=$(
    notify-send \
        -a 'screenshot.sh' \
        "Image \"$FILE\" copied to clipboard" \
        --action=KEEP="Keep and close" \
        --action=DELETE="Delete the file" \
)

if [[ "$NOTIFICATION_RESULT" = "DELETE" ]]; then
    rm "$FILE"
fi
