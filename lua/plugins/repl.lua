return {
  {
    "Vigemus/iron.nvim",
    cmd = "IronRepl",
    opts = {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
        },
        repl_open_cmd = "vertical botright 80 split",
      },
      keymaps = {
        toggle_repl = "<space>pr",
        restart_repl = "<space>pR",
        send_motion = "<space>pc",
        visual_send = "<space>pc",
        send_file = "<space>pf",
        send_line = "<space>pl",
        send_code_block = "<space>pb",
        exit = "<space>pq",
        clear = "<space>pL",
      },
    },
  },
}
