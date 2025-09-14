{config, pkgs, lib, ...}:
{
  home.username = "xilong";
  home.homeDirectory = "/home/xilong";
  home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE  = "24";
      GTK_IM_MODULE = "";
      GTK_SCALE = "2";
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

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Qogir-dark
  '';

  imports = let dir = ./home.d;
    in builtins.map (name: dir + "/${name}") (builtins.attrNames (builtins.readDir dir));

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
