{ config, pkgs, ... }:
{
  systemd.user.services."proton-drive" = {
    Unit = {
      Description = "Rclone sync for Proton Drive";
    };
    
    Service = {
     Type = "oneshot";
     Environment = "RCLONE_CONFIG=%h/.config/rclone/rclone.conf";
     ExecStart = ''
        ${pkgs.rclone}/bin/rclone sync proton:/ %h/Documents/ProtonDrive \
          --fast-list \
          --delete-after \
          --checkers=16 \
          --transfers=8
      '';
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
