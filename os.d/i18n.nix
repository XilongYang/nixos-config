{ config, pkgs, ... }:
{
  environment.variables.WAYLAND_IM_MODULE = "fcitx";
  environment.variables.QT_IM_MODULE = "fcitx";
  environment.variables.XMODIFIERS = "@im=fcitx";
  environment.variables.SDL_IM_MODULE = "fcitx";
  environment.variables.GLFW_IM_MODULE = "fcitx";

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
      fcitx5-configtool
      fcitx5-rime
      libsForQt5.fcitx5-qt
      fcitx5-gtk
    ];
  };

}
