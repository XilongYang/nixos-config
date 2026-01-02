{ config, pkgs, ... }:
let
  syncProton = pkgs.writeShellScript "sync-protondrive" ''
    set -euo pipefail

    export RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"

    ${pkgs.rclone}/bin/rclone sync proton:/Archive "$HOME/Documents/ProtonDrive/Archive" \
      --fast-list --delete-after --checkers=16 --transfers=8

    ${pkgs.rclone}/bin/rclone sync proton:/Ebooks "$HOME/Documents/ProtonDrive/Ebooks" \
      --fast-list --delete-after --checkers=16 --transfers=8
  '';
in {
  systemd.user.services."proton-drive" = {
    Unit = {
      Description = "Rclone sync for Proton Drive";
    };
    
    Service = {
     Type = "oneshot";
     ExecStart = syncProton; 
    };
  };

  systemd.user.timers."proton-drive" = {
    Unit = {
      Description = "Timer for Proton Drive sync";
    };
    
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
      Persistent = true;
    };
    
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
