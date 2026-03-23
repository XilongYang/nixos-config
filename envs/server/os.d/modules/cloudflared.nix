{config, pkgs, ... } :
{
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      EnvironmentFile = "-/etc/cloudflared-tunnel-token";

      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel run --token $CF_TOKEN";

      Restart = "on-failure";
      RestartSec = 10;
      StartLimitBurst = 5;
      StartLimitIntervalSec = 60;

      DynamicUser = true;
      StateDirectory = "cloudflared";

      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
    };

    wantedBy = [ "multi-user.target" ];
  };
}
