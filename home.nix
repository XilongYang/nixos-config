{config, pkgs, ...}:
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
