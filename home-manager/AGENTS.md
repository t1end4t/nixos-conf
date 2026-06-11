Use this guide when working under `home-manager/`.

## Start Here
- Home entrypoint: `default.nix`
- Shared user config: `home.nix`, `base.nix`, `environment.nix`
- Host entrypoints: `hosts/laptop.nix`, `hosts/workstation.nix`

## Read By Task
- GUI stack: `gui/default.nix`, then the specific file in `gui/`
- Hyprland: `gui/hyprland/common.nix`, `gui/hyprland/hyprland-lua.nix`, plus host file if display-specific.
- Waybar: `gui/waybar/waybar.nix`, `gui/waybar/settings.nix`
- Shells: `shell/default.nix`, then `shell/bash/bash.nix` or `shell/nushell/nushell.nix`
- Editors/LSP: `editors/default.nix`, `editors/lsp.nix`, `editors/helix/helix.nix`
- CLI tools: `tools/default.nix`, then the specific file in `tools/`
- Desktop apps: `desktop-apps/default.nix`, then app-specific files.
- Firefox: `desktop-apps/firefox/firefox.nix`, `betterfox.nix`, `extensions.nix`, `filter.nix`
- Local LLM/research: `research/default.nix`, `research/local-llm.nix`

## Constraints
- Keep host-specific user behavior in `hosts/` or host-specific Hyprland files.
- Prefer existing module grouping over creating new folders.
- Verify with `home-manager switch --flake .#tiendat@<host>` when changing user config.
