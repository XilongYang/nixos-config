return {
  -- 1) 底层 Copilot，负责鉴权和会话
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  -- 2) CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "zbirenbaum/copilot.lua" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4.1",
      temperature = 0.1,
      auto_insert_mode = true,
      window = {
        layout = "vertical",
        width = 0.42,
      },

      prompts = {
        DocsEnglish = {
          prompt = table.concat({
            "Generate concise English documentation comments for the selected code.",
            "Requirements:",
            "- Do not invent behavior that is not present in the code.",
            "- Focus on purpose, inputs, outputs, constraints, side effects, and edge cases.",
            "- Keep it practical and suitable for production code.",
          }, "\n"),
          description = "Generate English doc comments",
        },
      },
    },

    keys = {
      -- 聊天窗口
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "AI Chat Toggle" },
      { "<leader>ax", "<cmd>CopilotChatReset<cr>",  desc = "AI Chat Reset" },
      { "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "AI Select Model" },
      { "<leader>ap", "<cmd>CopilotChatPrompts<cr>", desc = "AI Select Prompt" },

      -- 选中代码后直接干活
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "AI Explain", mode = "x" },
      { "<leader>ac", "<cmd>CopilotChatDocsEnglish<cr>", desc = "AI English Comments", mode = "x" },

      -- 不选中时，也能快速提问
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "AI Quick Chat",
      },
    },

    config = function(_, opts)
      require("CopilotChat").setup(opts)

      -- 聊天 buffer 里别搞行号，清爽一点
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.conceallevel = 0
        end,
      })
    end,
  },
}
