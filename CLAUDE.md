# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A NixOS flake-based configuration for two hosts (`laptop` and `workstation`) using Home Manager for user environment management. Built on nixpkgs 25.11 (stable) with nixpkgs-unstable available as `pkgs.unstable`.

## Common Commands

### Rebuild System (NixOS)
```bash
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#workstation
```

### Rebuild Home Manager
```bash
home-manager switch --flake .#tiendat@laptop
home-manager switch --flake .#tiendat@workstation
```

### Using `nh` (nix helper — NH_FLAKE is pre-configured)
```bash
nh os switch          # rebuild NixOS
nh home switch        # rebuild home-manager
nh os test            # test without activating
```

### Update Flake Inputs
```bash
nix flake update
# With GitHub token to avoid rate limits:
env NIX_CONFIG="access-tokens = github.com=<token>" nix flake update
```

### Check Flake
```bash
nix flake check
```

## Architecture

### Host Definitions
Hosts are declared in `flake.nix`. Each host has:
- `nixos/<host>/configuration.nix` — system configuration
- `nixos/<host>/hardware-configuration.nix` — auto-generated hardware config
- `home-manager/hosts/<host>.nix` — user home configuration

### Configuration Layers
1. **`nixos/base/`** — shared NixOS modules imported by all hosts:
   - `preset.nix` — nix settings, boot, networking, timezone (Asia/Ho_Chi_Minh), locale
   - `environment.nix` — system packages
   - `apps/` — Docker, Flatpak, Bluetooth, GL, Thunar
   - `daemon/` — SSH, PAM, Fcitx5, PipeWire, Bluetooth, XDG, nix-ld

2. **`nixos/<host>/configuration.nix`** — host-specific overrides:
   - `laptop`: TLP power management (40-80% battery thresholds), brightness, dual-monitor
   - `workstation`: NVIDIA GPU support

3. **`home-manager/`** — user environment, structured by concern:
   - `gui/` — Hyprland, Waybar, Rofi, Alacritty, Mako, GTK/Qt theming
   - `shell/` — Bash, Nushell
   - `editors/` — Helix (primary), VSCode
   - `tools/` — git, direnv, yazi, CLI utilities
   - `desktop-apps/` — Firefox (Betterfox optimized), Thunderbird, LibreOffice
   - `ai-tools/` — Node.js, Bun, Python 3.13, uv, AI coding tools
   - `research/` — local LLM (ollama with CUDA)

### Key Flake Inputs
- `nixpkgs` — 25.11 stable
- `nixpkgs-unstable` — unstable channel, accessible as `pkgs.unstable`
- `home-manager` — follows nixpkgs
- `catppuccin` — theming applied system-wide (GTK, Qt, Helix, system)
- `betterfox` — Firefox user.js optimization

### Secrets / Ignored Files
The following are gitignored and managed outside this repo:
```
.aider*
aider.conf.yml
claude-code-router-config.json
aichat-config.yaml
```

### Overlays
Custom package modifications live in `overlays/`. Applied in `flake.nix` and available throughout all configurations.

### Environment Variable
`NH_FLAKE=/home/tiendat/nix-dev/nixos-conf` is set so `nh` commands work from any directory.

## GitHub Token Setup

To avoid GitHub API rate limits during flake updates, add to `~/.config/nix/nix.conf`:
```
access-tokens = github.com=<your_token>
```
Token generation: https://github.com/settings/tokens
