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
    enabled = false,
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
    },
  },

  {
    "olimorris/codecompanion.nvim",
    opts = {
      display = {
        chat = {
          window = {
            width = 0.3,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  { "AndreM222/copilot-lualine" },
}
