# Use the systemd-boot EFI boot loader.
{config, pkgs, ... } :
{
  boot = 
  {
    initrd.availableKernelModules = [];
    initrd.kernelModules = [];
    kernelParams = [];
    kernelModules = [];
    extraModulePackages = [];
    
    loader =
    {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
