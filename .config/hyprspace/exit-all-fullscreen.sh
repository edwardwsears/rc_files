#!/bin/bash

set -u

hyprspace_bin="${HYPRSPACE_BIN:-/opt/homebrew/bin/hyprspace}"

if [[ ! -x "$hyprspace_bin" ]]; then
    exit 1
fi

while IFS='|' read -r window_id is_fullscreen; do
    if [[ -n "$window_id" && "$is_fullscreen" = true ]]; then
        "$hyprspace_bin" fullscreen off --window-id "$window_id" || true
    fi
done < <(
    "$hyprspace_bin" list-windows --all \
        --format '%{window-id}|%{window-is-fullscreen}' 2>/dev/null
)
