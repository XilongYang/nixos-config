{config, pkgs, lib, ... } :
{
  services.cloudflared = {
    enable = true;

    tunnels."c7c3f517-874c-47db-8dbe-b507d44070fc" = {
      credentialsFile = "/var/lib/cloudflared/c7c3f517-874c-47db-8dbe-b507d44070fc.json";

      ingress = {
        "ssh.xilong.site" = "ssh://localhost:22";
      };

      default = "http_status:404";
    };
  };
}
