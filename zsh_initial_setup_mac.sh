#!/bin/bash

zshrc="$HOME/.zshrc"
source_line='source ~/.zshrc_common_mac'

if [[ ! -f "$HOME/.zshrc_common_mac" ]]; then
    echo "Missing ~/.zshrc_common_mac; run ./copy_rc_files_mac.sh first" >&2
    exit 1
fi

# Append only when absent so an existing .zshrc is never replaced.
if [[ -f "$zshrc" ]] && grep -Fqx "$source_line" "$zshrc"; then
    echo "macOS common settings are already sourced by $zshrc"
    exit 0
fi

{
    echo
    echo "#"
    echo "# Source common macOS settings"
    echo "#"
    echo "$source_line"
    echo
    echo "#"
    echo "# Machine-specific settings"
    echo "#"
} >> "$zshrc"

echo "Added macOS common settings to $zshrc"
