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
    bochs
    chez
    clang-tools
    cloc
    cmake
    coreutils
    fd
    fzf
    gcc
    gdb
    ghc
    git
    gnumake
    gnupg
    haskell-language-server
    jdt-language-server
    jq
    lua-language-server
    macism
    marksman
    neovim
    nodejs
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    ollama
    pandoc
    pinentry_mac
    pyright
    ripgrep
    sqls
    tmux
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
