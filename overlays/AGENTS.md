Use this guide when working under `overlays/`.

## Start Here
- Overlay definitions: `default.nix`
- Overlay application: `../flake.nix`

## Constraints
- Keep package overrides narrow and documented by package name.
- Prefer `pkgs.unstable` in config files for single-package freshness before adding overlay logic.
- Verify with `nix flake check` or build the affected package directly.
