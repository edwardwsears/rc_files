#!/bin/bash

set -euo pipefail

profile="${1:-}"
config_path="$HOME/.config/hyprspace/config.toml"
start_marker="# BEGIN managed monitor layout profile"
end_marker="# END managed monitor layout profile"

if [[ "$profile" == "toggle" ]]; then
    current_profile="$(awk '/^# Active profile: [12] / { print $4; exit }' "$config_path")"
    case "$current_profile" in
        1) profile=2 ;;
        2) profile=1 ;;
        *)
            echo "Unable to determine the active monitor layout profile." >&2
            exit 1
            ;;
    esac
fi

case "$profile" in
    1)
        profile_name="three across"
        assignments=$(cat <<'EOF'
# Active profile: 1 (three across; columns map to monitors)
[workspace-to-monitor-force-assignment]
'1' = [1, 'main']
'4-q' = [1, 'main']
'7-a' = [1, 'main']

'2' = [2, 'main']
'5-w' = [2, 'main']
'8-s' = [2, 'main']

'3' = [3, 'main']
'6-e' = [3, 'main']
'9-d' = [3, 'main']
EOF
        )
        ;;
    2)
        profile_name="three stacked"
        assignments=$(cat <<'EOF'
# Active profile: 2 (three stacked; rows map to monitors)
[workspace-to-monitor-force-assignment]
'1' = [1, 'main']
'2' = [1, 'main']
'3' = [1, 'main']

'4-q' = [2, 'main']
'5-w' = [2, 'main']
'6-e' = [2, 'main']

'7-a' = [3, 'main']
'8-s' = [3, 'main']
'9-d' = [3, 'main']
EOF
        )
        ;;
    *)
        echo "Usage: $0 {1|2|toggle}" >&2
        exit 2
        ;;
esac

if [[ ! -f "$config_path" ]]; then
    echo "Hyprspace config not found: $config_path" >&2
    exit 1
fi

if ! grep -qxF "$start_marker" "$config_path" || ! grep -qxF "$end_marker" "$config_path"; then
    echo "Managed monitor layout markers are missing from $config_path" >&2
    exit 1
fi

temporary_config="$(mktemp "${TMPDIR:-/tmp}/hyprspace-layout.XXXXXX")"
backup_config="$(mktemp "${TMPDIR:-/tmp}/hyprspace-layout-backup.XXXXXX")"
replacement_config="$(mktemp "${TMPDIR:-/tmp}/hyprspace-layout-replacement.XXXXXX")"
trap 'rm -f "$temporary_config" "$backup_config" "$replacement_config"' EXIT
cp "$config_path" "$backup_config"
printf '%s\n' "$assignments" > "$replacement_config"

awk -v start="$start_marker" -v end="$end_marker" -v replacement_file="$replacement_config" '
    $0 == start {
        print
        while ((getline replacement_line < replacement_file) > 0)
            print replacement_line
        close(replacement_file)
        inside = 1
        found_start = 1
        next
    }
    $0 == end {
        if (!inside) exit 2
        inside = 0
        found_end = 1
        print
        next
    }
    !inside { print }
    END {
        if (!found_start || !found_end || inside) exit 3
    }
' "$config_path" > "$temporary_config"

chmod "$(stat -f '%Lp' "$config_path")" "$temporary_config"
mv "$temporary_config" "$config_path"

if ! hyprspace reload-config --dry-run --no-gui --warnings-as-errors; then
    cp "$backup_config" "$config_path"
    echo "Profile $profile failed validation; restored the previous config." >&2
    exit 1
fi

if ! hyprspace reload-config; then
    cp "$backup_config" "$config_path"
    hyprspace reload-config || true
    echo "Profile $profile failed to load; restored the previous config." >&2
    exit 1
fi

if [[ -x /opt/homebrew/bin/sketchybar ]]; then
    /opt/homebrew/bin/sketchybar --reload || true
fi

echo "Hyprspace monitor layout $profile enabled: $profile_name"
