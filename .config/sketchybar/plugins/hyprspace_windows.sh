#!/bin/bash

set -u
set -o pipefail

HYPRSPACE_BIN="/opt/homebrew/bin/hyprspace"
workspace_order=(
    1 2 3 4 5 6 7 8 9 10
    11-q 12-w 13-e 14-r 15-t 16-y 17-u 18-i 19-o 20-p
    21-a 22-s 23-d 24-f 25-g
)
window_state="${TMPDIR:-/tmp}/sketchybar-hyprspace-windows-${UID}.state"
updates=()

is_known_workspace() {
    local requested="$1"
    local workspace

    for workspace in "${workspace_order[@]}"; do
        if [[ "$workspace" = "$requested" ]]; then
            return 0
        fi
    done
    return 1
}

if ! window_labels="$(
    "$HYPRSPACE_BIN" list-windows --all --format '%{workspace}|%{app-name}' 2>/dev/null |
        /usr/bin/jq -R -s -r '
            split("\n")
            | map(select(length > 0) | split("|") | {workspace: .[0], app: .[1]})
            | group_by(.workspace)[]
            | .[0].workspace as $workspace
            | [
                $workspace,
                (
                    group_by(.app)
                    | map(.[0].app + if length > 1 then " ×\(length)" else "" end)
                    | join(" · ")
                )
              ]
            | join("|")
        '
)"; then
    exit 0
fi

if [[ -f "$window_state" && "$(<"$window_state")" = "$window_labels" ]]; then
    exit 0
fi
printf '%s\n' "$window_labels" > "$window_state"

for workspace in "${workspace_order[@]}"; do
    updates+=(--set "space.$workspace" label="—")
done

while IFS='|' read -r workspace apps; do
    [[ -z "$workspace" || -z "$apps" ]] && continue
    if is_known_workspace "$workspace"; then
        updates+=(--set "space.$workspace" label="$apps")
    fi
done <<< "$window_labels"

if (( ${#updates[@]} > 0 )); then
    sketchybar "${updates[@]}"
fi
