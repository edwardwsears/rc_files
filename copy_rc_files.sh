#!/bin/bash
if [[ "$1" == "-r" ]]; then
    # copy rc files back to this directory
    echo "Copying rc files back to this directory"
    cp ~/.sqliterc .
    cp ~/.tmux.conf .
    cp ~/.vimrc .
    cp ~/.zshrc_common .
else
    # Copy rc files to home directory (~/)
    echo "Copying rc files to home directory"
    cp .sqliterc ~/
    cp .tmux.conf ~/
    cp .vimrc ~/
    cp .zshrc_common ~/
fi
