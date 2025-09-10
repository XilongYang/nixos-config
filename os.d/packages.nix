{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Base
    adwaita-qt
    appimage-run
    bochs
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
    mandoc
    nodejs
    ntfs3g
    openssh
    powertop
    python3Full
    qgnomeplatform
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
    fuzzel
    gh
    google-chrome
    hyprpaper
    foliate
    kitty
    libsForQt5.qtstyleplugin-kvantum
    mpv
    neovim
    qogir-theme
    qogir-icon-theme
    qogir-kde
    libsForQt5.qt5ct
    qt6ct
    rclone
    sioyek
    xfce.thunar
    waybar

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
