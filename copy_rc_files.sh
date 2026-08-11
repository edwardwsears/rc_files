#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

files=(
    .sqliterc
    .tmux.conf
    .vimrc
    .zshrc_common
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    files+=(
        .zshrc_common_mac
        .aerospace.toml
        .config/aerospace-swipe/config.json
    )
fi

if [[ "${1:-}" == "-r" ]]; then
    echo "Copying rc files back to this directory"
    for file in "${files[@]}"; do
        destination="$script_dir/$file"
        mkdir -p "$(dirname "$destination")"
        cp "$HOME/$file" "$destination"
    done
else
    echo "Copying rc files to home directory"
    for file in "${files[@]}"; do
        destination="$HOME/$file"
        mkdir -p "$(dirname "$destination")"
        cp "$script_dir/$file" "$destination"
    done
fi
