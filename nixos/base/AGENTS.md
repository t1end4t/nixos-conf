Use this guide when working under `nixos/base/`. See `INDEX.md` for the navigation map.

## Scope
- Shared NixOS config imported by all hosts.

## Constraints
- Keep host-specific system config in the host folder.
- Put only shared imports in `default.nix`.
- Prefer `pkgs.unstable` for single-package freshness before adding overlay logic.
