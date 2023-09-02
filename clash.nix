{ pkgs, config, lib, ... } :
with lib;
let
  cfg = config.services.clash;
in
{
  options.services.clash = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
    package = mkOption {
      type = types.package;
      default = pkgs.clash;
    };
  };
  config = mkIf cfg.enable {
    systemd.services.clash = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      description = "Clash Daemon";

      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe cfg.package} -d /var/clash";
        CapabilityBoundingSet = [
          "CAP_NET_RAW"
          "CAP_NET_ADMIN"
          "CAP_NET_BIND_SERVICE"
        ];
        AmbientCapabilities = [
          "CAP_NET_RAW"
          "CAP_NET_ADMIN"
          "CAP_NET_BIND_SERVICE"
        ];
        Restart = "on-failure";
      };
    };
  };
}

