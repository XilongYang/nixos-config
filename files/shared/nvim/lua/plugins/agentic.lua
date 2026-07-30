return {
  {
    "carlos-algms/agentic.nvim",
    opts = {
      provider = "claude-agent-acp",
      acp_providers = {
        ["claude-agent-acp"] = {
          command = "claude-agent-acp",
        },
      },
    },
    keys = {
      { "<leader>at", function() require("agentic").toggle() end, desc = "Agentic Toggle" },
      { "<leader>an", function() require("agentic").new_session() end, desc = "Agentic New Session" },
      { "<leader>af", function() require("agentic").add_file() end, desc = "Agentic Add File" },
      { "<leader>as", function() require("agentic").add_selection() end, mode = "v", desc = "Agentic Add Selection" },
    },
  },
}
