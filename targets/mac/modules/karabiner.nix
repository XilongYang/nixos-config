{ lib, ... }:
{
  # Karabiner-Elements rewrites karabiner.json at runtime (GUI edits, profile
  # changes). A read-only nix-store symlink would make those saves fail, so the
  # config is copied into place as a writable file on activation instead of
  # symlinked. Edit files/mac/karabiner/karabiner.json to re-apply on
  # switch; local GUI edits survive until the next switch overwrites them.
  home.activation.karabinerConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.config/karabiner"
    run cp -f ${../../../files/mac/karabiner/karabiner.json} "$HOME/.config/karabiner/karabiner.json"
    run chmod u+w "$HOME/.config/karabiner/karabiner.json"
  '';
}
