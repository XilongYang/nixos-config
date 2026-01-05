## NixOS配置

```
├── flake.nix : 主配置文件
├── home.d ： 用户级配置
│   ├── home.nix
│   └── modules
│       ├── fcitx5.nix
│       ├── git.nix
│       ├── hyprland.nix
│       ├── kitty.nix
│       ├── mako.nix
│       ├── mpd.nix
│       ├── ncmpcpp.nix
│       ├── ollama.nix
│       ├── rclone.nix
│       ├── rofi.nix
│       ├── save_notes.nix
│       ├── waybar.nix
│       ├── yazi.nix
│       └── zsh.nix
├── os.d ： 系统级配置
│   ├── modules
│   │   ├── boot.nix
│   │   ├── fonts.nix
│   │   ├── gpg-agent.nix
│   │   ├── hardware.nix
│   │   ├── i18n.nix
│   │   ├── network.nix
│   │   ├── packages.nix
│   │   ├── qt.nix
│   │   ├── snapshot.nix
│   │   ├── tlp.nix
│   │   └── user.nix
│   └── os.nix
└── README.md
```

