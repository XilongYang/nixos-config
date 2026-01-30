local pluginList = {}

local function add(mod)
  local ok, p = pcall(require, mod)
  if ok and p then
    vim.list_extend(pluginList, p)
  end
end

add("plugins.common.aerial")
add("plugins.common.blink")
add("plugins.common.bufferline")
add("plugins.common.colorizer")
add("plugins.common.copilot")
add("plugins.common.nvim-tree")
add("plugins.common.toggleterm")
add("plugins.common.tokyonight")

if vim.loop.os_uname().sysname == "Darwin" then
  add("plugins.mac.im-select")
else
  add("plugins.linux.fcitx")
end

return pluginList
