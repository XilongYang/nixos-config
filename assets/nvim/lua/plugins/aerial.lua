return {
  {'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
          -- Workaround for Neovim 0.12 + treesitter markdown capture shape.
          -- Avoid treesitter backend for markdown to prevent runtime errors.
          backends = {
            ["_"] = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
            markdown = { "markdown" },
          },
          -- optionally use on_attach to set keymaps when aerial has attached to a buffer
          on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
        })
    end,
  },
}
