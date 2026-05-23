Use this guide when working under `nixos/`.

## Start Here
- Host wiring: `../flake.nix`
- Shared NixOS imports: `base/default.nix`
- Host entrypoints: `laptop/configuration.nix`, `workstation/configuration.nix`

## Read By Task
- Shared system defaults: `base/preset.nix`, `base/environment.nix`, `base/fonts.nix`
- Shared apps: `base/apps/default.nix`, then the specific file in `base/apps/`
- Shared daemons/services: `base/daemon/default.nix`, then the specific file in `base/daemon/`
- Laptop-specific config: `laptop/configuration.nix`, `laptop/laptop.nix`, `laptop/systemd.nix`
- Workstation-specific config: `workstation/configuration.nix`, `workstation/nvidia.nix`, `workstation/systemd.nix`
- DNS: `<host>/dns/dns.nix`, `<host>/dns/nameservers.nix`
- Hardware/swap: read only when changing host hardware, disks, boot, or generated hardware settings.

## Constraints
- Do not edit `hardware-configuration.nix` unless the task is hardware-specific.
- Keep host-only behavior in `nixos/<host>/`; keep shared behavior in `nixos/base/`.
- Verify with `nix flake check` for broad changes, or `nh os test` for local system changes.
