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
  home.username = "xilong";
  
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  imports = builtins.map (name: dir + "/${name}") sorted;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
