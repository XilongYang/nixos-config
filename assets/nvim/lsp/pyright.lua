---@type vim.lsp.Config
return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },

  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },

  settings = {
    pyright = {
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
