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
    clang-tools_16
    cloc
    cmake
    dev86
    docker-compose
    findutils
    gcc
    gdb
    ghc
    git
    gnumake
    hyprlock
    hyprpaper
    hyprshot
    kdePackages.qtwayland
    libsForQt5.qt5.qtwayland
    mako
    mandoc
    nodejs
    ntfs3g
    openssh
    p7zip
    powertop
    python3
    where-is-my-sddm-theme
    unrar
    unzip
    vim
    wget
    wl-clipboard
    xorg.xhost
    zsh

    # User
    adwaita-icon-theme
    chez
    eudic
    fastfetch
    gh
    gimp
    google-chrome
    foliate
    kitty
    mpv
    neovim
    qogir-theme
    qogir-icon-theme
    libsForQt5.qt5ct
    qt6ct
    rclone
    sioyek
    waybar
    overskride
    xarchiver
    xfce.xfce4-appfinder
    xfce.ristretto
    xfce.thunar
    xfce.tumbler

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

  # Fonts
  fonts.packages = with pkgs; [
    source-han-sans
    source-han-serif
    wqy_zenhei
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];

}
