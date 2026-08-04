# macOS setup

The macOS files wrap and reuse the existing shared/Linux configuration. The
original files remain unchanged.

1. Install the commands referenced by the shared configuration:

   ```sh
   brew install tmux cscope universal-ctags
   ```

2. Copy the shared and macOS rc files:

   ```sh
   ./copy_rc_files_mac.sh
   ```

3. Initialize zsh:

   ```sh
   ./zsh_initial_setup_mac.sh
   ```

4. If this is the first Vim setup, use the existing shared script:

   ```sh
   ./vim_initial_setup.sh
   ```

5. Start a new shell:

   ```sh
   exec zsh
   ```

`hotkeys.ahk` is Windows-specific and is not loaded on macOS.
