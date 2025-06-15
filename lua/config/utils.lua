local M = {}

local api = vim.api

--- executes a function in a new right vsplit
---@param callback function
---@return function
function M.on_new_rvsplit(callback)
  return function()
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    callback()
  end
end

--- executes a function in an existing right vsplit
---@param callback function
---@return function
function M.on_existing_rvsplit(callback)
  return function()
    local cur_win = api.nvim_get_current_win()
    local cur_buf = api.nvim_get_current_buf()
    local cur_pos = api.nvim_win_get_cursor(cur_win)
    vim.cmd("wincmd l")
    local win = vim.api.nvim_get_current_win()
    api.nvim_set_current_buf(cur_buf)
    api.nvim_win_set_cursor(win, cur_pos)
    callback()
  end
end

return M
