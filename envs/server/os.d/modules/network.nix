{config, pkgs, lib, ... } :
{
    networking.firewall.allowedTCPPorts = [ 8000 ];
}
