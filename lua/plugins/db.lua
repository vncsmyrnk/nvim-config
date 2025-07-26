return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_save_location = "~/misc/sql"
    end,
    keys = {
      { "<leader>st", "<cmd>DBUIToggle<cr>", desc = "DBUI: toggles UI" },
      { "<leader>sf", "<cmd>DBUIFindBuffer<cr>", desc = "DBUI: opens current buffer as DBUI buffer" },
      { "<leader>sl", "<cmd>DBUILastQueryInfo<cr>", desc = "DBUI: last query info" },
      { "<leader>sr", "<cmd>DBUIRenameBuffer<cr>", desc = "DBUI: renames current buffer" },
    },
  },
}
