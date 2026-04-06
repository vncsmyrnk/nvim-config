---@type integer
local bufnr = nil

--- Executes the cmd on the given range and outputs to a split buffer.
---@param opts UserCommandOpts
local run = function(opts)
  ---@type string
  local cmd = opts.args

  ---@type string
  local file = vim.fn.tempname()
  require("lib.redirect").file(cmd, file)

  if bufnr then
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
  end

  vim.cmd("belowright split " .. file)
  bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_win_set_height(
    vim.fn.bufwinid(bufnr),
    math.floor(vim.o.lines * 0.2)
  )
  vim.cmd("normal G")
end

local opts = { nargs = "+" }
vim.api.nvim_create_user_command("P", run, opts)
