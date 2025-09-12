{ config, ... }:
{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    terminal=kitty
    dpi-aware=yes

    [colors]
    background=1a1b26ee
    text=a9b1d6ff
    match=f7768eff
    selection-match=f7768eff
    selection=1a1b26ff
    selection-text=7aa2f7ff
    border=a9b1d6ff
  '';
}
