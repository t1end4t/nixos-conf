Use this guide when working under `home-manager/hosts/`. See `INDEX.md` for the navigation map.

## Scope
- Host-specific Home Manager entrypoints.

## Constraints
- Keep laptop-only user config in `laptop.nix`.
- Keep workstation-only user config in `workstation.nix`.
- Move duplicated host behavior upward only when both hosts need it.
