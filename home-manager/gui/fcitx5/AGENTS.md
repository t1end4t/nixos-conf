Use this guide when working under `home-manager/gui/fcitx5/`.

## Purpose
- Home Manager-managed fcitx5 user profile.

## Files
- `fcitx5.nix` wires `xdg.configFile."fcitx5/profile"`.
- `profile` is the fcitx5 input-method profile content.

## Gotchas
- Keep system fcitx5 daemon/package config outside this directory.
- `force = true` intentionally overwrites an existing unmanaged profile file.
