return {
  {"keaising/im-select.nvim",
    config = function()
      require("im_select").setup({
        default_command = "macism",
        default_im_select = "com.apple.keylayout.ABC",
      })
    end,
  },
}
