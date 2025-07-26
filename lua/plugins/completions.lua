return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      enabled = function()
        return not vim.tbl_contains({ "copilot-chat", "markdown", "oil" }, vim.bo.filetype)
      end,
      keymap = {
        -- INFO: https://cmp.saghen.dev/configuration/keymap.html#presets
        preset = "default",
        ["<C-l>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      signature = { enabled = true },
      cmdline = {
        enabled = false,
      },
    },
  },
}
