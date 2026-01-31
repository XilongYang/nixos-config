{ config, ... }:
{
  xdg.configFile."nvim/lua".source = ../../../../assets/nvim/lua;
  xdg.configFile."nvim/lsp".source = ../../../../assets/nvim/lsp;
  xdg.configFile."nvim/init.lua".source = ../../../../assets/nvim/init.lua;
}
