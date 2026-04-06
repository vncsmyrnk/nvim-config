local M = {}

---@type integer
local bufnr = nil

---@class Opts
---@field height? number

---@type Opts
local default_opts = {
  height = 0.2,
}

--- Puts the output of `:messages` into a temporary
--- buffer and displays it on a split
---@param opts Opts
function M.open(opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts)

  local file = vim.fn.tempname()
  vim.cmd("redir! > " .. file)
  vim.cmd("messages")
  vim.cmd("redir END")

  if bufnr then
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
  end

  vim.cmd("belowright split " .. file)
  bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_win_set_height(
    vim.fn.bufwinid(bufnr),
    math.floor(vim.o.lines * opts.height)
  )
  vim.cmd("normal G")
end

return M
