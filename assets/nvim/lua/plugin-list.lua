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
add("plugins.common.nvim-tree")
add("plugins.common.tokyonight")
add("plugins.common.agentic")

if (vim.uv or vim.loop).os_uname().sysname == "Darwin" then
  add("plugins.mac.im-select")
else
  add("plugins.linux.fcitx")
end

return pluginList
