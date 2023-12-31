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

  programs.zsh = {
    enable = true;
    shellAliases = {
      xnix-history = "nix profile history --profile /nix/var/nix/profiles/system";
      xnix-clear = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 14d";
      xnix-gc = "sudo nix store gc --debug";
    };
    initExtra = ''
      PATH=$PATH:/home/xilong/.local/bin

      xproxy(){
        if [ $http_proxy ]
        then
          unset http_proxy
          unset https_proxy
          echo "proxy_off"
        else
          export http_proxy="http://127.0.0.1:7890"
          export https_proxy="http://127.0.0.1:7890"
          echo "proxy_on"
        fi
      }
    '';
    oh-my-zsh = {
      enable = true;
      theme = "kardan";
      plugins = ["git"];
    };
  };

  home.packages = with pkgs; [
    neofetch
    firefox-esr
    telegram-desktop
    flameshot
    gimp
    maestral-gui
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    vscode-fhs
    octaveFull
    obs-studio
    wpsoffice-cn
    godot_4
    aseprite
    thunderbird
    logseq
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
    "org/gnome/shell" = {
      enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com"];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
      show-screen-recording-ui = [];
      screenshot = [];
      show-screenshot-ui = [];
      screenshot-window = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = ["<Super>d"]; 
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
      switch-to-workspace-left = ["<Shift><Super>h"];
      switch-to-workspace-right = ["<Shift><Super>l"];
      minimize = ["<Shift><Super>j"];
      maximize = ["<Super>k"];
      unmaximize = ["<Super>j"];
      toggle-fullscreen = ["<Super>f"];
      switch-input-source = ["<Super>space"];
      switch-input-source-backward = ["<Shift><Super>space"];
    };
    "org/gnome/desktop/input-sources" = { 
      xkb-options = ["lv3:ralt_alt"];
    };
    "org/gnome/mutter/keybindings" = { 
      toggle-tiled-left = ["<Super>h"];
      toggle-tiled-right = ["<Super>l"];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = { 
      home = [ "<Super>e" ];
      search = [ "<Super>r" ];
      control-center = [ "<Super>i" ];
      screensaver = [ "<Control><Alt>l" ];

      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Shift><Super>s";
      command = "flameshot gui";
      name = "scrennshot";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "Print";
      command = "flameshot gui";
      name = "scrennshot";
    };
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
