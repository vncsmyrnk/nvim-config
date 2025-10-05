return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
  },

  -- TODO: Use nvim-treesitter/nvim-treesitter-textobjects
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

  {
    "nvim-mini/mini.pairs",
    event = "BufEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  {
    "nvim-mini/mini.surround",
    event = "BufEnter",
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    opts = {},
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>md", "<cmd>RenderMarkdown disable<cr>", desc = "markdown: disable" },
      { "<leader>me", "<cmd>RenderMarkdown enable<cr>", desc = "markdown: enable" },
    },
  },
}
