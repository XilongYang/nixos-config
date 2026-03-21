{ config, pkgs, lib, ... }:
let
  dir = ./modules;
  entries = if builtins.pathExists dir then builtins.readDir dir else {};
  names = builtins.filter (name:
    entries.${name} == "regular" && lib.hasSuffix ".nix" name
  ) (builtins.attrNames entries);
  sorted = lib.sort (a: b: a < b) names;
in
{
  home.homeDirectory = "/Users/${config.home.username}";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = builtins.map (name: dir + "/${name}") sorted;

  home.packages = with pkgs; [
    clang-tools
    cloc
    coreutils
    ghc
    git
    macism
    neovim
    nodejs
    ollama
    pinentry_mac
    pyright
    ripgrep
 ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

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
