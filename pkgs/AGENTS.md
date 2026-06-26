Use this guide when working under `pkgs/`. See `INDEX.md` for the navigation map.

## Constraints
- Add local packages here only when they are repo-owned or not suitable as simple package references.
- Keep derivations minimal; avoid repo-wide abstractions for one package.
- Verify by building the affected package or running `nix flake check`.
