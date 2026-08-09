#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Reuse the shared copy operation, then add the macOS-only files.
(
    cd "$script_dir" || exit 1
    ./copy_rc_files.sh "$@"
) || exit 1

if [[ "${1:-}" == "-r" ]]; then
    echo "Copying macOS rc files back to this directory"
    cp ~/.zshrc_common_mac "$script_dir"/
    cp ~/.aerospace.toml "$script_dir"/
else
    echo "Copying macOS rc files to home directory"
    cp "$script_dir"/.zshrc_common_mac ~/
    cp "$script_dir"/.aerospace.toml ~/
fi
