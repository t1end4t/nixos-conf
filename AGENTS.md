Use this guide when working in this repository. See `INDEX.md` for the navigation map.

## Overview

NixOS flake configuration for two hosts: `laptop` and `workstation`.
Home Manager manages the user environment. `nixpkgs` is stable, with
`nixpkgs-unstable` exposed as `pkgs.unstable`.

## Constraints

- Keep host-only behavior in `nixos/<host>/` or `home-manager/hosts/`.
- Put shared behavior in `nixos/base/`, shared Home Manager files, or `modules/`
  only when multiple configs need it.
- Prefer `pkgs.unstable` for one-package freshness before adding overlay logic.
- Do not edit `hardware-configuration.nix` unless the task is hardware-specific.
- Do not add abstractions for one-off config.
- Do not touch ignored secret/config files unless explicitly requested.

## Verification

- Broad repo validation: `nix flake check`
- System config: `nh os test` or `sudo nixos-rebuild switch --flake .#<host>`
- Home Manager config: `home-manager switch --flake .#tiendat@<host>`
- Package changes: build the affected package, or run `nix flake check`.
