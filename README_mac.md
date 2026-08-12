# macOS setup

The macOS installer requires [Homebrew](https://brew.sh). It installs the
shared shell tools, AeroSpace, JankyBorders, and Mos; copies the shared and
macOS-specific rc files; and initializes zsh.

1. Run the installer:

   ```sh
   ./install_mac.sh
   ```

2. Grant Accessibility access to AeroSpace and Mos if macOS asks.

3. If this is the first Vim setup, use the existing shared script:

   ```sh
   ./vim_initial_setup.sh
   ```

4. Start a new shell:

   ```sh
   exec zsh
   ```

`hotkeys.ahk` is Windows-specific and is not loaded on macOS.
`.aerospace.toml` is macOS-specific and is only managed by
`copy_rc_files.sh` when running on macOS.

In AeroSpace service mode (`Option+Shift+;`), press `1` for the normal
three-monitor horizontal profile or `2` for the work profile with the Dell
display above the built-in display. The selected profile remains statically
assigned until another profile is selected.
