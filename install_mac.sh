#!/bin/bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This installer only supports macOS." >&2
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required. Install it from https://brew.sh and rerun this script." >&2
    exit 1
fi

echo "Installing Homebrew dependencies"
brew install tmux cscope universal-ctags
brew install felixkratz/formulae/borders
brew install --cask nikitabobko/tap/aerospace
brew install --cask mos
brew install --cask shortcat

echo "Installing rc files"
"$script_dir/copy_rc_files.sh"
"$script_dir/zsh_initial_setup_mac.sh"

echo "Starting AeroSpace"
open -g -a AeroSpace

echo "Starting Mos"
open -g -a Mos

echo "Starting Shortcat"
open -g -a Shortcat

aerospace_ready=false
for ((attempt = 1; attempt <= 15; attempt++)); do
    if aerospace list-workspaces --all >/dev/null 2>&1; then
        aerospace_ready=true
        break
    fi
    sleep 1
done

if [[ "$aerospace_ready" != true ]]; then
    echo "AeroSpace did not become ready. Complete any macOS permission prompts and rerun this script." >&2
    exit 1
fi

echo
echo "macOS setup complete. Grant Accessibility access to AeroSpace, Mos, and Shortcat if prompted."
