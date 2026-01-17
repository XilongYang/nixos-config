{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Base
    alsa-utils
    android-tools
    brightnessctl
    hypridle
    hyprlock
    hyprpaper
    hyprpolkitagent
    hyprshot
    libnotify
    mako
    pandoc
    where-is-my-sddm-theme
    wl-clipboard
    xorg.xhost

    # User
    adwaita-icon-theme
    gimp3
    goldendict-ng
    google-chrome
    graphviz
    foliate
    mpc
    mpd
    mpv
    musescore
    ncmpcpp
    nsxiv
    obs-studio
    qogir-theme
    qogir-icon-theme
    rofi
    sioyek
    telegram-desktop
    thunderbird
    typora
    waybar
    ollama
    overskride
    protonvpn-gui
    qbittorrent
    qrencode
    valent
    yazi
    zbar
  ];
}
