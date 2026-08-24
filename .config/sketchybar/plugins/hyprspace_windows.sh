#!/bin/bash

set -u
set -o pipefail

HYPRSPACE_BIN="/opt/homebrew/bin/hyprspace"
workspace_groups="${1:-}"
window_state="${TMPDIR:-/tmp}/sketchybar-hyprspace-windows-${UID}.state"
updates=()

if [[ -z "$workspace_groups" ]]; then
    exit 0
fi

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

IFS=';' read -r -a groups <<< "$workspace_groups"
for group in "${groups[@]}"; do
    IFS=',' read -r -a workspaces <<< "$group"
    for workspace in "${workspaces[@]}"; do
        updates+=(--set "space.$workspace" label="—")
    done
done

while IFS='|' read -r workspace apps; do
    [[ -z "$workspace" || -z "$apps" ]] && continue
    updates+=(--set "space.$workspace" label="$apps")
done <<< "$window_labels"

if (( ${#updates[@]} > 0 )); then
    sketchybar "${updates[@]}"
fi
