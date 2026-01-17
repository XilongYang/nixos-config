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
  imports = builtins.map (name: dir + "/${name}") sorted;
}

