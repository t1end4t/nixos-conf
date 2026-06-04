Use this guide when working under `home-manager/gui/hyprland/`.

## Purpose

Hyprland Home Manager configuration shared by laptop and workstation.

## Start Here

- `common.nix` — shared Hyprland enablement and generated Lua config wiring.
- `hyprland-lua.nix` — shared Lua config, input behavior, and keybindings.
- `laptop.nix` and `workstation.nix` — host-specific monitor/layout Lua snippets.

## Conventions

- Keep shared keyboard/input/keybinding behavior in `hyprland-lua.nix`.
- Keep host-specific monitor behavior in `local.hyprland.hostConfig` in each host file.
- Prefer the Lua helpers (`hl.monitor`, `hl.config`, `hl.bind`) over legacy Hyprland settings when editing Lua-backed config.

## Verification

- Format touched Nix files with `nix fmt <files>`.
- Verify host configs with `nix eval .#homeConfigurations.<host>.activationPackage.drvPath`.
