local M = {}

local tui_term_close_group = vim.api.nvim_create_augroup("TermCloseGroup", { clear = true })
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

--- executes a cmd in a new tab
---@param callback string|function
---@return function
function M.on_a_new_tab(callback)
  local callback_fn = callback
  if type(callback) == "string" then
    callback_fn = function()
      vim.cmd(string.format("$tab term %s", callback))
    end
  end

  return function()
    callback_fn()
    vim.api.nvim_create_autocmd("TermClose", {
      group = tui_term_close_group,
      buffer = 0,
      callback = function()
        vim.api.nvim_buf_delete(0, { force = true })
      end,
    })
  end
end

return M
