return {
  {
    "stevearc/conform.nvim",
    event = "BufEnter",
    opts = {
      -- INFO: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "jq" },
        zsh = { "shfmt" },
        sh = { "shfmt" },
        rust = { "rustfmt" },
        nix = { "nixfmt" },
      },
      format_on_save = function(bufnr)
        -- INFO: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
        local ignore_filetypes = { "php" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
    },
  },
}
