{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Base
    appimage-run
    bochs
    brightnessctl
    clang-tools
    cloc
    cmake
    dev86
    docker-compose
    findutils
    gcc
    gdb
    ghc
    git
    git-filter-repo
    gnumake
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    libnotify
    mako
    mandoc
    nodejs
    ntfs3g
    openssh
    p7zip
    powertop
    python3
    pipx
    rclone
    tree
    where-is-my-sddm-theme
    unrar
    unzip
    vim
    wget
    wl-clipboard
    xorg.xhost
    zsh

    # User
    aria2
    adwaita-icon-theme
    chez
    fastfetch
    gh
    gimp3
    goldendict-ng
    google-chrome
    foliate
    kitty
    mpc
    mpd
    mpv
    musescore
    ncmpcpp
    neovim
    nsxiv
    obs-studio
    qogir-theme
    qogir-icon-theme
    rclone
    rofi
    sioyek
    telegram-desktop
    thunderbird
    typora
    waybar
    onlyoffice-desktopeditors
    overskride
    protonvpn-gui
    qbittorrent
    valent
    yazi

    #LSPs
    clang-tools
    jdt-language-server
    pyright
    nodePackages.bash-language-server
    sqls
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    haskell-language-server
    lua-language-server
    marksman
  ];
}
