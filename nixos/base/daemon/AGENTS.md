Use this guide when working under `nixos/base/daemon/`. See `INDEX.md` for the navigation map.

## Scope
- Shared system daemons imported by all hosts.

## Constraints
- Keep host-specific daemon config in the host folder.
- Put only daemon imports in `default.nix`.
