Use this guide when working under `nixos/`. See `INDEX.md` for the navigation map.

## Constraints
- Do not edit `hardware-configuration.nix` unless the task is hardware-specific.
- Keep host-only behavior in `nixos/<host>/`; keep shared behavior in `nixos/base/`.
- Verify with `nix flake check` for broad changes, or `nh os test` for local system changes.
