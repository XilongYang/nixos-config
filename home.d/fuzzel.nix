{ config, ... }:
{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    terminal=kitty
    dpi-aware=yes

    [colors]
    background=161616ff
    text=ffffffff
    match=ee5396ff
    selection-match=ee5396ff
    selection=262626ff
    selection-text=33b1ffff
    border=525252ff
  '';
}
