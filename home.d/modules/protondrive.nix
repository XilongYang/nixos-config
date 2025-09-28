{ config, pkgs, ... }:
{
  systemd.user.services."proton-drive" = {
    Unit = {
      Description = "Rclone mount for Proton Drive";
      After = ["network.target"];
      Wants = ["network.target"];
    };
    
    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
     Type = "simple";
     Environment = "RCLONE_CONFIG=%h/.config/rclone/rclone.conf";
     ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount proton:/ %h/Documents/ProtonDrive \
          --vfs-cache-mode full \
          --vfs-cache-max-size 10G \
          --cache-dir %h/.cache/rclone \
          --dir-cache-time 72h \
          --poll-interval 30s \
          --umask 022
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u %h/Documents/ProtonDrive";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
