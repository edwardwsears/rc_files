#!/bin/bash

set -u
set -o pipefail

HYPRSPACE_BIN="/opt/homebrew/bin/hyprspace"
workspace_order=(
    1 2 3 4 5 6 7 8 9 10
    11-q 12-w 13-e 14-r 15-t 16-y 17-u 18-i 19-o 20-p
    21-a 22-s 23-d 24-f 25-g
)
updates=()

if ! workspace_state="$(
    "$HYPRSPACE_BIN" list-workspaces --all \
        --format '%{workspace}|%{monitor-id}|%{workspace-is-visible}' 2>/dev/null
)"; then
    exit 0
fi

sketchybar_displays=()
while IFS= read -r display_id; do
    sketchybar_displays+=("$display_id")
done < <(sketchybar --query displays | /usr/bin/jq -r 'sort_by([.frame.x, .frame.y])[] | .["arrangement-id"]')

for workspace in "${workspace_order[@]}"; do
    updates+=(--set "space.$workspace" drawing=off)
done

while IFS='|' read -r workspace monitor_id is_visible; do
    [[ -n "$workspace" ]] || continue

    case "$workspace" in
        1[1-9]-*|20-*) row_border_color=0xaa5e81ac ;;
        2[1-5]-*) row_border_color=0xaaa3be8c ;;
        1|2|3|4|5|6|7|8|9|10) row_border_color=0x665a5a5a ;;
        *) continue ;;
    esac

    display_index=$((monitor_id - 1))
    sketchybar_display="${sketchybar_displays[$display_index]:-$monitor_id}"

    if [[ "$is_visible" = true ]]; then
        updates+=(
            --set "space.$workspace"
            drawing=on
            display="$sketchybar_display"
            icon.color=0xff181818
            label.color=0xff303030
            background.color=0xffff9500
            background.border_color=0xffffb340
        )
    else
        updates+=(
            --set "space.$workspace"
            drawing=on
            display="$sketchybar_display"
            icon.color=0xffe8e8e8
            label.color=0xffb8b8b8
            background.color=0x55353535
            background.border_color="$row_border_color"
        )
    fi
done <<< "$workspace_state"

if (( ${#updates[@]} > 0 )); then
    sketchybar "${updates[@]}"
fi
