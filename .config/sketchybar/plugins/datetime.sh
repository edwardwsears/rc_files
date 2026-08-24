#!/bin/sh

action="${1:-update}"

case "${SENDER:-}" in
    front_app_switched|space_change)
        sketchybar --set datetime popup.drawing=off
        exit 0
        ;;
esac

if [ "$action" != "toggle" ]; then
    sketchybar --set datetime label="$(/bin/date '+%Y-%m-%d %-I:%M %p')"
    exit 0
fi

popup_drawing="$(sketchybar --query datetime | /usr/bin/jq -r '.popup.drawing')"
if [ "$popup_drawing" = "on" ]; then
    sketchybar --set datetime popup.drawing=off
    exit 0
fi

california="$(TZ=America/Los_Angeles /bin/date '+%Z|%Y-%m-%d %I:%M %p')"
eastern="$(TZ=America/New_York /bin/date '+%Z|%Y-%m-%d %I:%M %p')"
israel="$(TZ=Asia/Jerusalem /bin/date '+%Z|%Y-%m-%d %I:%M %p')"
india="$(TZ=Asia/Kolkata /bin/date '+%Z|%Y-%m-%d %I:%M %p')"

sketchybar \
    --set timezone.california \
        icon="Pacific (${california%%|*})" \
        label="${california#*|}" \
    --set timezone.eastern \
        icon="Eastern (${eastern%%|*})" \
        label="${eastern#*|}" \
    --set timezone.israel \
        icon="Israel (${israel%%|*})" \
        label="${israel#*|}" \
    --set timezone.india \
        icon="India (${india%%|*})" \
        label="${india#*|}" \
    --set datetime popup.drawing=on
