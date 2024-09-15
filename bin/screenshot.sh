#!/bin/bash

set -eo pipefail

SS_DIRECTORY="$HOME/Pictures/screenshot.sh"
FILENAME="$(date --iso-8601=ns)_screenshot.png"
FILE="$SS_DIRECTORY/$FILENAME"
mkdir -p "$SS_DIRECTORY"

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    IS_WAYLAND=true
else
    IS_WAYLAND=false
fi

take_screenshot_select() {
    if $IS_WAYLAND; then
        gnome-screenshot --area --file="$FILE"
    else
        scrot -s -F "$FILE"
    fi
}

take_screenshot_full() {
    if $IS_WAYLAND; then
      gnome-screenshot --file="$FILE"
    else
      scrot -F "$FILE"
    fi
}

take_screenshot_window() {
    if $IS_WAYLAND; then
        gnome-screenshot -w --file="$FILE"
    else
        scrot -u -F "$FILE"
    fi
}

if [[ "$1" == "select" ]]; then
    take_screenshot_select
elif [[ "$1" == "full" ]] || [[ "$1" == "" ]]; then
    take_screenshot_full
elif [[ "$1" == "window" ]]; then
    take_screenshot_window
else
    echo "Unknown parameter '$1'"
    echo ""
    echo "Usage:"
    echo "  $0 [full]"
    echo "  $0 select"
    echo "  $0 window"
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
