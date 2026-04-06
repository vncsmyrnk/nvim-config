---@class Redirect
local M = {}

--- Executes a cmd silently piping the current file as stdin and redirecting its output to a file
---@param cmd string
---@param filename string
function M.file(cmd, filename)
  ---@type string
  local target_cmd = string.format("silent %s", cmd)

  vim.cmd("redir! > " .. filename)
  vim.cmd(target_cmd)
  vim.cmd("redir END")
end

return M
