# Use the systemd-boot EFI boot loader.
{config, pkgs, ... } :
{
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
}
