# macOS setup

The shared copy script detects macOS and includes the macOS-specific files
automatically.

1. Install the commands referenced by the shared configuration:

   ```sh
   brew install tmux cscope universal-ctags
   ```

2. Copy the shared and macOS rc files (including the AeroSpace and
   aerospace-swipe configs):

   ```sh
   ./copy_rc_files.sh
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
`.aerospace.toml` and `.config/aerospace-swipe/config.json` are
macOS-specific and are only managed by `copy_rc_files.sh` when running on
macOS.
