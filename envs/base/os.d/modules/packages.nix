{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Base
    appimage-run
    bochs
    clang-tools
    cloc
    cmake
    dev86
    findutils
    gcc
    gdb
    ghc
    git
    git-filter-repo
    gnumake
    gnupg
    jq
    linux-firmware
    mandoc
    nodejs
    ntfs3g
    openssh
    openssl
    p7zip
    pass
    pinentry-curses
    powertop
    python3
    pipx
    rclone
    sof-firmware
    tree
    unrar
    unzip
    vim
    wget
    zsh

    # User
    aria2
    chez
    cloudflared
    fastfetch
    gh
    kitty
    neovim
    rclone

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
