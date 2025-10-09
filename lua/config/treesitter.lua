local ts = require("nvim-treesitter")

-- tracks the parsers which do not match the filetype
local aliases = { mysql = "sql", gitrebase = "git_rebase", sh = "bash" }

-- registers parsers wich do not match the filetype
for k, v in pairs(aliases) do
  vim.treesitter.language.register(v, { k })
end

-- applies TS config
local setup_treesitter = function()
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.opt.foldmethod = "expr"
end

-- applies TS config for the current buffer and auto installs
-- the parser if necessary
local on_any_file_type = function()
  local ft = vim.bo.filetype
  pcall(vim.treesitter.start)

  local parsers_available = ts.get_available()
  if not vim.tbl_contains(parsers_available, ft) and aliases[ft] == nil then
    return
  end

  if aliases[ft] ~= nil then
    ts.install({ aliases[ft] }):await(setup_treesitter)
    return
  end

  local parsers_installed = ts.get_installed()
  if not vim.tbl_contains(parsers_installed, ft) then
    ts.install({ ft }):await(setup_treesitter)
    return
  end

  setup_treesitter()
end

local ts_start_group = vim.api.nvim_create_augroup("MyTreesitterStart", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ts_start_group,
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
