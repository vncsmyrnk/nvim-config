return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    build = "make tiktoken",
    lazy = false,
    opts = {
      debug = false,
      window = {
        width = 0.3,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CopilotChat<cr>", desc = "CopilotChat open" },
      { "<leader>aq", "<cmd>CopilotChatClose<cr>", desc = "CopilotChat close" },
      {
        "<leader>ah",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat help actions",
      },
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat prompt actions",
      },
    },
  },

  { "AndreM222/copilot-lualine" },
}
