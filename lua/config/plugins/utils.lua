---@class Utils
local M = {}

---@class RunWithRedirectOpts
---@field line1? integer
---@field line2? integer

--- Executes a cmd silently redirecting its output to a file
---@param cmd string
---@param filename string
---@param opts RunWithRedirectOpts
function M.run_with_redirect(cmd, filename, opts)
  local target_cmd = string.format("silent :w !%s", cmd)
  if opts.line1 and opts.line2 then
    target_cmd = string.format("silent :%d,%dw !%s", opts.line1, opts.line2, cmd)
  end
  vim.cmd("redir! > " .. filename)
  vim.cmd(target_cmd)
  vim.cmd("redir END")
end

---@class OpenOutputOpts
---@field inherit_filetype? boolean
---@field focus_current_buffer? boolean
---@field height? number

---@type OpenOutputOpts
local open_output_brhsplit_default_opts = {
  inherit_filetype = false,
  focus_current_buffer = true,
  height = 0.2,
}

--- Opens the file on a horizontal belowright split
---@param filename string
---@param opts OpenOutputOpts
function M.open_output_brhsplit(filename, opts)
  opts = vim.tbl_deep_extend("force", open_output_brhsplit_default_opts, opts)

  local current_bufnr = vim.api.nvim_get_current_buf()

  vim.cmd("belowright split " .. filename)
  local output_bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_win_set_height(vim.fn.bufwinid(output_bufnr), math.floor(vim.o.lines * opts.height))

  if opts.inherit_filetype then
    vim.bo[output_bufnr].filetype = vim.bo[current_bufnr].filetype
  end

  if opts.focus_current_buffer then
    vim.api.nvim_set_current_win(vim.fn.bufwinid(current_bufnr))
  end
end

return M
