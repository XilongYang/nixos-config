{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Base
    git
    git-filter-repo
    gnupg
    jq
    kitty
    mandoc
    nodejs
    openssh
    openssl
    p7zip
    pass
    pinentry-curses
    python3
    ripgrep
    tree
    tmux
    unzip
    wget
    zsh

    # User
    cloudflared
    fastfetch
    neovim
    codex
    codex-acp

    #LSPs
    bash-language-server
  ];
}
