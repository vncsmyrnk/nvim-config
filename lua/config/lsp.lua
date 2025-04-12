-- INFO: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs
vim.lsp.enable({ "lua_ls", "gopls", "intelephense" })

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})
