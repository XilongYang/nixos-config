{config, pkgs, lib, ...}:
let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  home.username = "xilong";
  home.homeDirectory = "/home/xilong";
  xresources.properties = {
    "Xft.dpi" = 135;
  };

  programs.git = {
    enable = true;
    userName = "Xilong Yang";
    userEmail = "xilong.yang@foxmail.com";
  };

  home.packages = with pkgs; [
    neofetch
    firefox-esr
    obsidian
    telegram-desktop
  ];

  # Gnome Settings
  dconf.settings = {
    "org/gnome/desktop/interface" = { 
      color-scheme = "prefer-dark";
      text-scaling-factor = 1.3;
    };
    "org/gnome/desktop/input-sources" = { 
      sources = [ (mkTuple ["xkb" "us"]) (mkTuple ["ibus" "rime"]) ];
      per-window = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = { 
      home = [ "<Super>e" ];
      search = [ "<Super>r" ];
      control-center = [ "<Super>i" ];

      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "terminal";
    };
  };

  # QT
  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
