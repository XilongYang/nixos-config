# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  # Use the Nix-Flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.xilong = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager"]; 
    };
  };

  nix.settings.trusted-users = [ "xilong" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    clash
    ntfs3g
    openssh
    cloc
    gcc
    gdb
    ghc
    racket
  ];

  environment.variables.EDITOR = "vim";

  # Locales
  i18n.supportedLocales = [
  "en_US.UTF-8/UTF-8"
  "zh_CN.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";

  # Input Method
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ rime ];
  };

  # Systemd config
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  # NixOS GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

