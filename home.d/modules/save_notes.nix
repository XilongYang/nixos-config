{ config, pkgs, ... }:
{
  systemd.user.services."save-notes" = {
    Unit = {
      Description = "Save Notes";
    };
    
    Service = {
     Type = "oneshot";
     ExecStart = ''
        /home/xilong/Notes/scripts/commit.sh
      '';
    };
  };

  systemd.user.timers."save-notes" = {
    Unit = {
      Description = "Timer for Save Notes Service";
    };
    
    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Persistent = true;
    };
    
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
