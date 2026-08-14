#!/bin/sh

action="${1:-update}"

case "${SENDER:-}" in
    front_app_switched|space_change)
        sketchybar --set datetime popup.drawing=off
        exit 0
        ;;
esac

california_zone="$(TZ=America/Los_Angeles /bin/date '+%Z')"
eastern_zone="$(TZ=America/New_York /bin/date '+%Z')"
israel_zone="$(TZ=Asia/Jerusalem /bin/date '+%Z')"
india_zone="$(TZ=Asia/Kolkata /bin/date '+%Z')"

sketchybar \
    --set datetime label="$(/bin/date '+%Y-%m-%d %-I:%M %p')" \
    --set timezone.california \
        icon="Pacific ($california_zone)" \
        label="$(TZ=America/Los_Angeles /bin/date '+%Y-%m-%d %I:%M %p')" \
    --set timezone.eastern \
        icon="Eastern ($eastern_zone)" \
        label="$(TZ=America/New_York /bin/date '+%Y-%m-%d %I:%M %p')" \
    --set timezone.israel \
        icon="Israel ($israel_zone)" \
        label="$(TZ=Asia/Jerusalem /bin/date '+%Y-%m-%d %I:%M %p')" \
    --set timezone.india \
        icon="India ($india_zone)" \
        label="$(TZ=Asia/Kolkata /bin/date '+%Y-%m-%d %I:%M %p')"

if [ "$action" = "toggle" ]; then
    sketchybar --set datetime popup.drawing=toggle
fi
