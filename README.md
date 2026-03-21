# NixOS Configuration

This repository contains my personal Nix-based system configuration for three targets:

- `desktop`: a full NixOS workstation setup
- `server`: a leaner NixOS server profile
- `mac`: a standalone Home Manager setup for macOS

The repo is organized as a small flake router at the top level and per-environment flakes under `envs/`. Shared configuration lives in `envs/base`, while each target adds its own operating system and user-level modules.

## Design

The layout follows a simple composition model:

- `envs/base`: shared NixOS and Home Manager defaults
- `envs/desktop`: desktop-specific system and user modules
- `envs/server`: server-specific system and user modules
- `envs/mac`: macOS-only Home Manager configuration
- `assets`: helper scripts, icons, and small runtime assets

The root [`flake.nix`](flake.nix) does not define systems itself. It re-exports outputs from the environment flakes so commands can be run from the repository root.

## Repository Layout

```text
.
├── assets/
│   ├── icons/
│   ├── scripts/
│   └── sounds/
├── envs/
│   ├── base/
│   │   ├── home.d/
│   │   └── os.d/
│   ├── desktop/
│   │   ├── home.d/
│   │   ├── os.d/
│   │   └── flake.nix
│   ├── mac/
│   │   ├── home.d/
│   │   └── flake.nix
│   └── server/
│       ├── home.d/
│       ├── os.d/
│       └── flake.nix
├── flake.nix
└── README.md
```

Within both `home.d/modules` and `os.d/modules`, modules are imported dynamically from the directory, which keeps the top-level entry files small and makes it easy to split configuration by concern.

## What Is Included

Depending on the target, this repository manages things such as:

- core NixOS settings and garbage collection
- user shell, Git, SSH, and Neovim configuration through Home Manager
- Hyprland-based desktop configuration
- terminal and launcher tooling such as Kitty, Rofi, Waybar, and Yazi
- desktop input, fonts, audio, power, and hardware-related options
- server packages and services

## Usage

Run all commands from the repository root.

### Desktop

Build and switch the desktop system:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

### Server

Build and switch the server system:

```bash
sudo nixos-rebuild switch --flake .#server
```

### macOS

Apply the Home Manager profile:

```bash
home-manager switch --flake .#mac
```

## Customization

If you want to adapt this repository for your own machines, the main places to change are:

- host-specific system settings in `envs/<target>/os.d/modules`
- user programs in `envs/<target>/home.d/modules`
- shared defaults in `envs/base`
- user name, home directory, and machine-specific hardware settings

This repo is opinionated and personal by design. Expect to replace hardware definitions, user identity, themes, package selections, and service settings before using it as your own daily setup.

## Notes

- Linux targets use `nixpkgs` from `nixos-unstable`.
- Home Manager is integrated into the NixOS configurations for `desktop` and `server`.
- The `mac` target is user-scoped only and does not manage the full operating system.
