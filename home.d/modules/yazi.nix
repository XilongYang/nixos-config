{ config, ... }:
{
  xdg.configFile."yazi/plugins/smart-enter.yazi/main.lua".text = ''
  --- @sync entry
  return {
  entry = function()
    local h = cx.active.current.hovered
    if not h then return end
    if h.cha.is_dir then
      ya.emit("enter", {})
    else
      ya.emit("open", {})
    end
  end,
  }
  '';

  xdg.configFile."yazi/keymap.toml".text = ''
  [[mgr.prepend_keymap]]
  on   = "<Enter>"
  run  = "plugin smart-enter"
  desc = "Open file or enter directory"
  '';
}
