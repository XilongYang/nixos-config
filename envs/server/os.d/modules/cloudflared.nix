{ config, pkgs, ... }:
{
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      # 从文件加载 token
      EnvironmentFile = "/etc/cloudflared-tunnel-token";

      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel run --token $CF_TOKEN";

      Restart = "always";
      RestartSec = 5;

      # 安全一点（可选）
      DynamicUser = true;
      NoNewPrivileges = true;
    };

    wantedBy = [ "multi-user.target" ];
  };
}
