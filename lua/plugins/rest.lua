return {
  -- INFO: https://neovim.getkulala.net/
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      kulala_keymaps = {
        -- INFO: disabling default ui keymaps breaks the help sction
        ["Show headers"] = false,
        ["Show body"] = false,
        ["Show headers and body"] = false,
        ["Show verbose"] = false,
        ["Show script output"] = false,
        ["Show report"] = false,

        ["Next tab"] = {
          ")",
          function()
            require("config.kulala").next_winbar_tab()
          end,
        },
        ["Previous tab"] = {
          "(",
          function()
            require("config.kulala").previous_winbar_tab()
          end,
        },
      },
      global_keymaps = true,
      global_keymaps_prefix = "<leader>r",
      kulala_keymaps_prefix = "",
      ui = {
        max_response_size = 1000 * 1000, -- 1MB
      },
    },
  },
}
