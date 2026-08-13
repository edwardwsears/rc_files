#!/bin/bash

display_count_state="${TMPDIR:-/tmp}/sketchybar-display-count-${UID}.state"
current_count="$(sketchybar --query displays | /usr/bin/jq -r 'length')"

if [[ -f "$display_count_state" ]]; then
    previous_count="$(<"$display_count_state")"
    if [[ "$current_count" = "$previous_count" ]]; then
        exit 0
    fi
fi

printf '%s\n' "$current_count" > "$display_count_state"

# Give macOS and Hyprspace time to settle their display/workspace mappings.
sleep 1
sketchybar --reload
