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
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = builtins.map (name: dir + "/${name}") sorted;
}
