{config, pkgs, lib, ... } :
{
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Clash
  systemd.services.clash = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    description = "Clash Daemon";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.clash} -d /var/clash";
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
}
