## NixOS配置

```
├── assets
│   ├── icons
│   │   └── mozc
│   │       └── mozc.png
│   ├── scripts
│   │   ├── battery-status.sh
│   │   ├── mic-status.sh
│   │   └── rclone-sync.sh
│   └── sounds
│       └── ringing.wav
├── envs
│   ├── base
│   │   ├── home.d
│   │   │   ├── home.nix
│   │   │   └── modules
│   │   │       ├── git.nix
│   │   │       ├── nvim.nix
│   │   │       ├── ssh.nix
│   │   │       └── zsh.nix
│   │   └── os.d
│   │       ├── modules
│   │       │   ├── boot.nix
│   │       │   ├── gpg-agent.nix
│   │       │   ├── network.nix
│   │       │   ├── packages.nix
│   │       │   ├── snapshot.nix
│   │       │   └── user.nix
│   │       └── os.nix
│   ├── desktop
│   │   ├── flake.lock
│   │   ├── flake.nix
│   │   ├── home.d
│   │   │   ├── home.nix
│   │   │   └── modules
│   │   │       ├── fcitx5.nix
│   │   │       ├── hyprland.nix
│   │   │       ├── kitty.nix
│   │   │       ├── mako.nix
│   │   │       ├── mpd.nix
│   │   │       ├── ncmpcpp.nix
│   │   │       ├── ollama.nix
│   │   │       ├── rclone.nix
│   │   │       ├── rofi.nix
│   │   │       ├── save-notes.nix
│   │   │       ├── waybar.nix
│   │   │       └── yazi.nix
│   │   └── os.d
│   │       ├── modules
│   │       │   ├── boot.nix
│   │       │   ├── fonts.nix
│   │       │   ├── hardware.nix
│   │       │   ├── i18n.nix
│   │       │   ├── keyd.nix
│   │       │   ├── packages.nix
│   │       │   ├── qt.nix
│   │       │   └── tlp.nix
│   │       └── os.nix
│   └── server
│       ├── flake.lock
│       ├── flake.nix
│       ├── home.d
│       │   └── home.nix
│       └── os.d
│           ├── modules
│           │   ├── boot.nix
│           │   ├── cloudflared.nix
│           │   ├── hardware.nix
│           │   ├── packages.nix
│           │   └── sshd.nix
│           └── os.nix
├── flake.lock
├── flake.nix
└── README.md
```

