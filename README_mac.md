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

Workspaces use stable keyboard rows regardless of display arrangement:

- `Option+1` through `Option+0` select workspaces on the main display.
- `Option+Q` through `Option+P` select workspaces on the second display.
- `Option+A` through `Option+G` select workspaces on the third display.
- Add `Shift` to move the focused window to that workspace and follow it.

The number-row workspaces are named `1` through `10`, with `Option+0` selecting
workspace `10`. Letter-row workspaces use
sortable prefixes: `11-q` through `20-p` and `21-a` through `25-g`. Only `1`,
`2`, `3`, `11-q`, `12-w`, `13-e`, `21-a`, `22-s`, and `23-d` are persistent.
The remaining keys create on-demand workspaces which disappear after they
become empty and invisible. `Option+PageUp` and `Option+PageDown` use the
workspace manager's native per-monitor cycling order.
