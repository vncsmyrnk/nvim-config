-- INFO: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs
vim.lsp.enable({ "lua_ls", "gopls", "intelephense" })

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
})
