#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Reuse the shared copy operation, then add the macOS compatibility file.
(
    cd "$script_dir" || exit 1
    ./copy_rc_files.sh "$@"
) || exit 1

if [[ "${1:-}" == "-r" ]]; then
    echo "Copying macOS rc file back to this directory"
    cp ~/.zshrc_common_mac "$script_dir"/
else
    echo "Copying macOS rc file to home directory"
    cp "$script_dir"/.zshrc_common_mac ~/
fi
