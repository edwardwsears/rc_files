#!/bin/bash

workspace_groups="${1:-}"
focused_workspace="${FOCUSED_WORKSPACE:-}"
updates=()

if [[ -z "$workspace_groups" || -z "$focused_workspace" ]]; then
    exit 0
fi

IFS=';' read -r -a groups <<< "$workspace_groups"
for group in "${groups[@]}"; do
    case ",$group," in
        *,$focused_workspace,*) ;;
        *) continue ;;
    esac

    IFS=',' read -r -a workspaces <<< "$group"
    for workspace in "${workspaces[@]}"; do
        case "$workspace" in
            4-q|5-w|6-e) row_border_color=0xaa5e81ac ;;
            7-a|8-s|9-d) row_border_color=0xaaa3be8c ;;
            *) row_border_color=0x665a5a5a ;;
        esac

        if [[ "$workspace" = "$focused_workspace" ]]; then
            updates+=(
                --set "space.$workspace"
                icon.color=0xff181818
                label.color=0xff303030
                background.color=0xffff9500
                background.border_color=0xffffb340
            )
        else
            updates+=(
                --set "space.$workspace"
                icon.color=0xffe8e8e8
                label.color=0xffb8b8b8
                background.color=0x55353535
                background.border_color="$row_border_color"
            )
        fi
    done
    break
done

if (( ${#updates[@]} > 0 )); then
    sketchybar "${updates[@]}"
fi
