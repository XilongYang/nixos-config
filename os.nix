# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  # Use the Nix-Flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable the locate & updatedb
  services.locate.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users = {
    users.xilong = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker"]; 
      shell = pkgs.zsh;
    };
  };

  nix.settings.trusted-users = [ "xilong" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    zsh
    neovim 
    wget
    git
    ntfs3g
    openssh
    cloc
    gcc
    gdb
    cmake
    gnumake
    racket
    qgnomeplatform
    adwaita-qt
    appimage-run
    python3Full
    ghc
    unzip
    dev86
    bochs
    findutils
    clang-tools_16
    xorg.xhost
    docker-compose
    rclone
  ];

  environment.variables.EDITOR = "nvim";

  # Locales
  i18n.supportedLocales = [
  "en_US.UTF-8/UTF-8"
  "zh_CN.UTF-8/UTF-8"
  "ja_JP.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";

  # Input Method
  i18n.inputMethod = {
    type = "ibus";
    enable = true;
    ibus.engines = with pkgs.ibus-engines; [ rime ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    source-han-sans
    source-han-serif
    wqy_zenhei
    jetbrains-mono
  ];

  # HIP
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.hipcc}"
  ];

  # NixOS GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # QT
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

