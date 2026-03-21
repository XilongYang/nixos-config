{ config, pkgs, ... }:
{
  systemd.user.services."save-notes" = {
    Unit = {
      Description = "Save Notes";
    };
    
    Service = {
     Type = "oneshot";
     ExecStart = ''
        ${config.home.homeDirectory}/Notes/scripts/commit.sh
      '';
    };
  };

  systemd.user.timers."save-notes" = {
    Unit = {
      Description = "Timer for Save Notes Service";
    };
    
    Timer = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Persistent = true;
    };
    
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
