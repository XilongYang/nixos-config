{ config, pkgs, ... }:
{
    fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      source-han-sans
      source-han-serif
      wqy_zenhei
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel.rgba = "none";
      subpixel.lcdfilter = "default";
      defaultFonts = {
        serif     = [ "Source Han Serif" "Noto Serif" ];
        sansSerif = [ "Source Han Sans" "Noto Sans" ];
        monospace = [ "Noto Sans Mono" "JetBrainsMono Nerd Font" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };
}
