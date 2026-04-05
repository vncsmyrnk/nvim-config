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
        toggle_repl = "<space>pt",
        restart_repl = "<space>pr",
        send_motion = "<space>pc",
        visual_send = "<A-enter>",
        send_file = "<A-enter>",
        send_line = "<A-;>",
        exit = "<space>pq",
        clear = "<space>pl",
      },
    },
  },
}
