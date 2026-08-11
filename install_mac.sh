#!/bin/bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
swipe_dir="$HOME/.local/share/aerospace-swipe"
swipe_service="gui/$(id -u)/com.acsandmann.swipe"

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

echo "Installing rc files"
"$script_dir/copy_rc_files.sh"
"$script_dir/zsh_initial_setup_mac.sh"

echo "Starting AeroSpace"
open -g -a AeroSpace

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

echo "Installing aerospace-swipe"
if [[ -d "$swipe_dir/.git" ]]; then
    git -C "$swipe_dir" pull --ff-only
elif [[ -e "$swipe_dir" ]]; then
    echo "$swipe_dir exists but is not an aerospace-swipe Git checkout." >&2
    exit 1
else
    mkdir -p "$(dirname "$swipe_dir")"
    git clone https://github.com/acsandmann/aerospace-swipe.git "$swipe_dir"
fi

if launchctl print "$swipe_service" >/dev/null 2>&1; then
    make -C "$swipe_dir" all bundle install_plist
    launchctl kickstart -k "$swipe_service"
else
    make -C "$swipe_dir" install
fi

echo
echo "macOS setup complete. Grant Accessibility access to AeroSpace and AerospaceSwipe if prompted."
