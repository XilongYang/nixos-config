{ config, pkgs, lib, ... }:
{
  home.homeDirectory = "/Users/xilong";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = let dir = ./modules;
    in builtins.map (name: dir + "/${name}") (builtins.attrNames (builtins.readDir dir));

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    git
    neovim
    tmux
    ripgrep
    fd
    jq
    fzf
    gnupg
    pinentry_mac
    coreutils
    nodejs
    ollama
    macism
 ];

  services.ollama.enable = true;

  # macOS 上 GPG agent 走 pinentry-mac
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry_mac;
    defaultCacheTtl = 86400;
    maxCacheTtl = 604800;
  };
}

