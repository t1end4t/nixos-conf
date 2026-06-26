Use this guide when working under `home-manager/gui/hyprland/`. See `INDEX.md` for the navigation map.

## Purpose

Hyprland Home Manager configuration shared by laptop and workstation.

## Conventions

- Keep shared keyboard/input/keybinding behavior in `hyprland-lua.nix`.
- Keep host-specific monitor behavior in `local.hyprland.hostConfig` in each host file.
- Prefer the Lua helpers (`hl.monitor`, `hl.config`, `hl.bind`) over legacy Hyprland settings when editing Lua-backed config.

## Verification

- Format touched Nix files with `nix fmt <files>`.
- Verify host configs with `nix eval .#homeConfigurations.<host>.activationPackage.drvPath`.
