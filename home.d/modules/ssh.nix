{ config, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "kaka" = {
        hostname = "ssh.xilong.site";
        user = "xilong";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };
    };
  };
}
