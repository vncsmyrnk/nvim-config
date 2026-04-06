return {
  {
    "Vigemus/iron.nvim",
    cmd = { "IronRepl", "IronWatch" },
    opts = {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          lua = {
            command = { "lua" },
          },
        },
        repl_open_cmd = "vertical botright 80 split",
      },
      keymaps = {
        clear = "<space>pl",
      },
    },
    keys = {
      { "<leader>po", "<cmd>IronRepl<cr>", desc = "Repl: open UI" },
      { "<leader>pq", "<cmd>IronHide<cr>", desc = "Repl: hide UI" },
      {
        "<leader>pr",
        function()
          require("iron.core").repl_restart()
        end,
        desc = "Repl: restart",
      },
      {
        "<A-enter>",
        mode = { "n", "v" },
        function()
          local iron = require("iron.core")
          if vim.api.nvim_get_mode().mode == "V" then
            iron.mark_visual()
            iron.send_mark()
            return
          end
          iron.send_file()
        end,
        desc = "Repl: send",
      },
    },
  },
}
