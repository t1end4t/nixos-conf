Use this guide when working under `modules/`.

## Start Here
- NixOS modules: `nixos/default.nix`
- Home Manager modules: `home-manager/default.nix`
- Flake export/import wiring: `../flake.nix`

## Constraints
- Add reusable options here only when multiple configs need them.
- For one-off host or user settings, edit `../nixos/` or `../home-manager/` instead.
- Keep option names stable; these files define cross-repo contracts.
- Verify with `nix flake check`.
