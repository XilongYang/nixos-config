---@type vim.lsp.Config
return {
  cmd = function(root_dir)
    local project = (root_dir and vim.fn.fnamemodify(root_dir, ":t")) or "default"
    local ws_base = vim.fn.stdpath("cache") .. "/jdtls-workspace/"
    local ws = ws_base .. project
    return { "jdtls", "-data", ws }
  end,

  filetypes = { "java" },

  root_markers = {
    "pom.xml",
    "build.gradle",
    "settings.gradle",
    "mvnw",
    "gradlew",
    ".git",
  },
}
