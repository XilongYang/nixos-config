{ config, pkgs, ... }:
{
  # Locales
  i18n.supportedLocales = [
  "en_US.UTF-8/UTF-8"
  "zh_CN.UTF-8/UTF-8"
  "ja_JP.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";

  # Input Method
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-configtool
    ];
  };

}
