local function enable_all_lsps()
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
  local servers = {}

  local handle = vim.loop.fs_scandir(lsp_dir)
  if not handle then
    return
  end

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    if type == "file" and name:sub(-4) == ".lua" then
      local server = name:sub(1, -5) -- strip .lua
      table.insert(servers, server)
    end
  end

  if #servers > 0 then
    vim.lsp.enable(servers)
  end
end

enable_all_lsps()
