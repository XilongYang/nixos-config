{ config, pkgs, lib, ... }:
{
  home.homeDirectory = "/Users/xilong";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = let dir = ./modules;
    in builtins.map (name: dir + "/${name}") (builtins.attrNames (builtins.readDir dir));

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

