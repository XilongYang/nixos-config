{ config, pkgs, lib, ... }:
{
  xdg.configFile."scripts/rclone-sync.sh" = {
    executable = true;
    source = ../../assets/scripts/rclone-sync.sh;
  };

  systemd.user.services."rclone" = {
    Unit = {
      Description = "Rclone sync for Proton Drive & Dropbox";
    };
    
    Service = {
     Type = "oneshot";
     ExecStart = "/home/xilong/.config/scripts/rclone-sync.sh"; 
     Environment = [
       "PATH=${lib.makeBinPath [ pkgs.rclone pkgs.gnupg pkgs.coreutils pkgs.findutils pkgs.bash ]}"
     ];
    };

  };

  systemd.user.timers."rclone" = {
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
