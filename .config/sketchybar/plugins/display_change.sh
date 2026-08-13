#!/bin/bash

cooldown_file="${TMPDIR:-/tmp}/sketchybar-display-change-${UID}.cooldown"
now="$(date +%s)"

if [[ -f "$cooldown_file" ]]; then
    last_reload="$(stat -f '%m' "$cooldown_file")"
    if (( now - last_reload < 5 )); then
        exit 0
    fi
fi

touch "$cooldown_file"

# Give macOS and Hyprspace time to settle their display/workspace mappings.
sleep 1
touch "$cooldown_file"
sketchybar --reload
