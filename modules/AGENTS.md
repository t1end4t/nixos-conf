Use this guide when working under `modules/`. See `INDEX.md` for the navigation map.

## Constraints
- Add reusable options here only when multiple configs need them.
- For one-off host or user settings, edit `../nixos/` or `../home-manager/` instead.
- Keep option names stable; these files define cross-repo contracts.
- Verify with `nix flake check`.
