# NixOS Configuration

This repository contains my personal Nix-based configuration for two active targets:

- `server`: a NixOS host configuration
- `mac`: a standalone Home Manager profile for macOS

The repository is split into per-environment flakes under `envs/`, with shared defaults in `envs/base`.

## Design

The layout follows a composition model:

- `envs/base`: shared Home Manager defaults
- `envs/server`: server-specific NixOS + Home Manager modules
- `envs/mac`: macOS-specific Home Manager modules
- `assets/nvim`: Neovim runtime config consumed by Home Manager modules

The root [`flake.nix`](flake.nix) acts as a router that re-exports outputs from environment flakes.

## Repository Layout

```text
.
├── assets/
│   └── nvim/
├── envs/
│   ├── base/
│   │   └── home.d/
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

Within `home.d/modules` and `os.d/modules`, module files are imported dynamically from the directory to keep entry files small and composable.

## What Is Included

This repository currently manages:

- core NixOS settings for the server target
- user shell, Git, SSH, Neovim, and tmux via Home Manager
- server-specific packages and services
- a shared Neovim configuration under `assets/nvim`

## Usage

Run all commands from the repository root.

### Server (NixOS)

Build and switch the server system:

```bash
sudo nixos-rebuild switch --flake .#server
```

### macOS (Home Manager)

Apply the Home Manager profile:

```bash
home-manager switch --flake .#mac
```

## Customization

To adapt this repository to your own machines, the main places to change are:

- host-specific system settings in `envs/server/os.d/modules`
- user programs in `envs/<target>/home.d/modules`
- shared defaults in `envs/base`
- user name, home directory, and hardware-specific values

This repo is intentionally opinionated and personal. Expect to replace identity, package selection, and service settings before using it directly.

## Notes

- Both targets currently track `nixpkgs` from `nixos-unstable`.
- Home Manager is integrated into the `server` NixOS flake.
- The `mac` target is user-scoped only and does not manage the full operating system.
