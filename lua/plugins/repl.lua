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
        toggle_repl = "<space>pt",
        restart_repl = "<space>pr",
        send_motion = "<space>pc",
        visual_send = "<A-enter>",
        send_file = "<A-enter>",
        send_line = "<A-;>",
        clear = "<space>pl",
      },
    },
    keys = {
      { "<leader>po", "<cmd>IronRepl<cr>", desc = "Repl: open UI" },
      { "<leader>pq", "<cmd>IronHide<cr>", desc = "Repl: hide UI" },
    },
  },
}
