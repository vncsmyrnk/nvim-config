local ts = require("nvim-treesitter")

-- applies TS config
local setup_treesitter = function()
  vim.treesitter.start()
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.opt.foldmethod = "expr"
end

-- applies TS config for the current buffer and auto installs
-- the parser if necessary
local on_any_file_type = function()
  local ft = vim.bo.filetype

  local parsers_available = ts.get_available()
  if not vim.tbl_contains(parsers_available, ft) then
    return
  end

  local parsers_installed = ts.get_installed()
  if not vim.tbl_contains(parsers_installed, ft) then
    ts.install({ ft }):await(setup_treesitter)
    return
  end

  setup_treesitter()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = on_any_file_type,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    -- necessary for vim-go GoCoverage highlighting
    -- h vim.treesitter.start()
    vim.bo.syntax = "on"
  end,
})
