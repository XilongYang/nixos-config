{ config, pkgs, ... }:
{
  systemd.user.services."ollama" = {
    Unit = {
      Description = "Ollama Service";
    };
    
    Service = {
     Type = "simple";
     ExecStart = ''
        ${pkgs.ollama}/bin/ollama serve
      '';
    };

    Install.WantedBy = [ "default.target" ];
  };
}
