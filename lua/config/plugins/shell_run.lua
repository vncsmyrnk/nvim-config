---@type integer
local output_bufnr = nil

---@type string
local output_filename = vim.fn.tempname()

---@class opts
---@field line1 integer The starting line of the command range
---@field line2 integer The final line of the command range
---@field range integer The number of items in the command range: 0, 1, or 2

--- Executes the current SHELL on the given range and outputs to a split buffer.
---@param opts opts
local run = function(opts)
  local shell = os.getenv("SHELL")
  vim.cmd("redir! > " .. output_filename)
  vim.cmd(string.format("silent :%d,%dw !%s", opts.line1, opts.line2, shell))
  vim.cmd("redir END")

  if output_bufnr and #vim.fn.win_findbuf(output_bufnr) > 0 then
    return
  end

  local current_bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("belowright split " .. output_filename)
  output_bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_current_win(vim.fn.bufwinid(current_bufnr))
end

vim.api.nvim_create_user_command("CustomShellRun", run, { range = "%" })
