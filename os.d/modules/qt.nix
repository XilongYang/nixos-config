{ config, pkgs, ... }:
{
  environment.variables = {
    QT_STYLE_OVERRIDE    = "kvantum";
    KVANTUM_THEME = "QogirDark";
    QT_QUICK_CONTROLS_STYLE = "Fusion";
  };

  environment.pathsToLink = [ "/share/Kvantum" ];

  environment.systemPackages = (with pkgs.kdePackages; [
    qtwayland
    qt5compat
    qtdeclarative
    qtwayland
    qtsvg
    qtmultimedia
    qtstyleplugin-kvantum
  ]) ++ (with pkgs.libsForQt5; [
    qt5.qtwayland
    qtstyleplugin-kvantum
  ]) ++ (with pkgs; [
    qogir-kde
  ]);
}
