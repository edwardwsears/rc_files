#!/bin/bash

HYPRSPACE_BIN="/opt/homebrew/bin/hyprspace"
workspace_groups="${1:-}"
updates=()

if [[ -z "$workspace_groups" ]]; then
    exit 0
fi

for workspace in $(printf '%s' "$workspace_groups" | tr ',;' '  '); do
    updates+=(--set "space.$workspace" label="—")
done

while IFS='|' read -r workspace apps; do
    [[ -z "$workspace" || -z "$apps" ]] && continue
    updates+=(--set "space.$workspace" label="$apps")
done < <(
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
)

if (( ${#updates[@]} > 0 )); then
    sketchybar "${updates[@]}"
fi
