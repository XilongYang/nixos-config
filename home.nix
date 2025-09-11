{config, pkgs, lib, ...}:
{
  home.username = "xilong";
  home.homeDirectory = "/home/xilong";
  home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE  = "24";
    };
  
  gtk = {
    enable = true;
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
    iconTheme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-icon-theme;
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    settings = {
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
    };
  };

  imports = [
    ./home.d/fuzzel.nix
    ./home.d/git.nix
    ./home.d/zsh.nix    
    ./home.d/waybar.nix
    ./home.d/hyprland.nix
  ];

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
