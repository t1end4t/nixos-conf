Use this guide when working in this repository. See `INDEX.md` for the navigation map.

## Overview

NixOS flake configuration for two hosts: `laptop` and `workstation`.
Home Manager manages the user environment. `nixpkgs` is stable, with
`nixpkgs-unstable` exposed as `pkgs.unstable`.

## Constraints

- Keep host-only behavior in `nixos/<host>/` or `home-manager/hosts/`.
- Put shared behavior in `nixos/base/`, shared Home Manager files, or `modules/`
  only when multiple configs need it.
- Prefer `pkgs.unstable` for one-package freshness before adding overlay logic.
- Do not edit `hardware-configuration.nix` unless the task is hardware-specific.
- Do not add abstractions for one-off config.
- Do not touch ignored secret/config files unless explicitly requested.

## Area-specific conventions

- Keep Home Manager app, editor, shell, and GUI settings in their existing
  matching files or folders; keep `default.nix` imports within their area.
- Keep shared language tooling in `home-manager/editors/lsp.nix` and
  research/local-LLM tools in `home-manager/research/`.
- Keep Firefox CSS in the existing CSS files and separate Betterfox prefs from
  extension wiring. Keep Helix, Zellij, Bash, and Nushell native config in
  their existing native files; keep Home Manager wiring in their Nix files.
- In `home-manager/gui/hyprland/`, keep shared input and keybindings in
  `hyprland-lua.nix`, host monitors in each host's `local.hyprland.hostConfig`,
  and prefer Lua helpers (`hl.monitor`, `hl.config`, `hl.bind`).
- Keep Waybar settings in `settings.nix`, styling in `style.css`, and wiring in
  `waybar.nix`. The fcitx5 profile's `force = true` intentionally overwrites
  an unmanaged profile; system daemon and package config belongs elsewhere.
- Treat `nixos/base/hosts/main-hosts` as generated; regenerate it with
  `update-main-hosts.sh` and put manual additions in `extra-hosts`.
- Keep host DNS lists as plain text and changes in the appropriate host folder.
- Keep shared module option names stable. Keep overlays narrow and documented
  by package name, and local package derivations minimal.
- Treat scripts as user-machine operations; avoid destructive behavior without
  explicit confirmation and preserve each script's shell portability style.

## Verification

- Broad repo validation: `nix flake check`
- System config: `nh os test` or `sudo nixos-rebuild switch --flake .#<host>`
- Home Manager config: `home-manager switch --flake .#tiendat@<host>`
- Package changes: build the affected package, or run `nix flake check`.
- Hyprland: format touched Nix files with `nix fmt <files>` and evaluate the
  affected Home Manager activation package.
- Scripts: run `shellcheck` if available; otherwise run the smallest safe path.
