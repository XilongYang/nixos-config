# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.variables.EDITOR = "nvim";

  # Use the Nix-Flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # NixOS GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable SDDM Display Manager
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    extraPackages = with pkgs.kdePackages; [
      qt5compat
      qtdeclarative
      qtwayland
      qtsvg
      qtmultimedia
    ];
    settings = {
      General = {
        DisplayCommand = "${pkgs.writeShellScript "sddm-display-setup" ''
          ${pkgs.xorg.xrandr}/bin/xrandr \
            --output eDP-1 --primary --mode 2880x1800 --pos 0x0 \
            --output DP-1 --off
        ''}";
      };
    };
  };

  # Enable the Hyprland.
  programs.hyprland.enable = true;

  # Enable the locate & updatedb
  services.locate.enable = true;

  # Suspend Configure
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    IdleAction = "ignore";
  };

  # HIP
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.hipcc}"
  ];

  # Docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  imports = let dir = ./modules;
    in builtins.map (name: dir + "/${name}") (builtins.attrNames (builtins.readDir dir));

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

