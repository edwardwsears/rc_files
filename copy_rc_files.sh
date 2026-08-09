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
    )
fi

if [[ "${1:-}" == "-r" ]]; then
    echo "Copying rc files back to this directory"
    for file in "${files[@]}"; do
        cp "$HOME/$file" "$script_dir/$file"
    done
else
    echo "Copying rc files to home directory"
    for file in "${files[@]}"; do
        cp "$script_dir/$file" "$HOME/$file"
    done
fi
