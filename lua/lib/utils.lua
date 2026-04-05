---@class Utils
local M = {}

local tui_term_close_group =
  vim.api.nvim_create_augroup("TermCloseGroup", { clear = true })
local api = vim.api

--- tracks the current tab index before a TUI is open
--- useful to switch back to the last accesed tab when
--- the TUI is closed.
---@type integer
TAB_INDEX_BEFORE_TUI = 0

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
      TAB_INDEX_BEFORE_TUI = vim.api.nvim_get_current_tabpage()
      vim.cmd(string.format("$tab term %s", callback))
      vim.cmd("startinsert")
    end
  end

  return function()
    callback_fn()
    vim.api.nvim_create_autocmd("TermClose", {
      group = tui_term_close_group,
      buffer = 0,
      callback = function()
        vim.api.nvim_buf_delete(0, { force = true })
        -- Goes back to previously accessed tab
        vim.cmd("tabnext " .. TAB_INDEX_BEFORE_TUI)
        vim.cmd("startinsert")
      end,
    })
  end
end

--- checks if a plugin is loaded in the current plugin management system
--- @param plugin_name string
--- @return boolean
function M.plugin_loaded(plugin_name)
  local plugins = require("lazy.core.config").plugins
  return plugins[plugin_name]._.loaded ~= nil
end

---@class RunWithRedirectOpts
---@field line1? integer
---@field line2? integer
---@field shell? boolean

---@type RunWithRedirectOpts
local run_with_redirect_default_opts = {
  shell = true,
}

--- Executes a cmd silently piping the current file as stdin and redirecting its output to a file
---@param cmd string
---@param filename string
---@param opts RunWithRedirectOpts
function M.pipe_file_to_cmd(cmd, filename, opts)
  opts = vim.tbl_deep_extend("force", run_with_redirect_default_opts, opts)
  ---@type string
  local target_cmd
  if opts.shell then
    target_cmd = string.format("silent :w !%s", cmd)
    if opts.line1 and opts.line2 then
      target_cmd =
        string.format("silent :%d,%dw !%s", opts.line1, opts.line2, cmd)
    end
  else
    target_cmd = string.format("silent %s", cmd)
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
  vim.api.nvim_win_set_height(
    vim.fn.bufwinid(output_bufnr),
    math.floor(vim.o.lines * opts.height)
  )

  if opts.inherit_filetype then
    vim.bo[output_bufnr].filetype = vim.bo[current_bufnr].filetype
  end

  if opts.focus_current_buffer then
    vim.api.nvim_set_current_win(vim.fn.bufwinid(current_bufnr))
  end
end

---@class ExecuteInTermOpts
---@field focus_current_buffer? boolean
---@field height? number
---@field cmd? string
---@field ignore_term_ftplugin? boolean

---@type ExecuteInTermOpts
local execute_in_term_brhsplit_default_opts = {
  focus_current_buffer = true,
  height = 0.3,
  cmd = "term",
  ignore_term_ftplugin = false,
}

---@class ExecuteInTermTermOpts
---@field number? boolean
---@field relativenumber? boolean
---@field signcolumn? string

---@type ExecuteInTermTermOpts
local execute_in_term_brhsplit_term_default_opts = {
  number = true,
  relativenumber = true,
  signcolumn = "yes:1",
}

--- Executes the current file in a term split
---@param opts ExecuteInTermOpts
---@param term_opts? ExecuteInTermTermOpts
function M.execute_in_term_brhsplit(opts, term_opts)
  opts =
    vim.tbl_deep_extend("force", execute_in_term_brhsplit_default_opts, opts)
  local optional_term_opts = term_opts
    or vim.tbl_deep_extend(
      "force",
      execute_in_term_brhsplit_term_default_opts,
      term_opts
    )
  local current_bufnr = vim.api.nvim_get_current_buf()

  local old_ignore = vim.o.eventignore
  if opts.ignore_term_ftplugin then
    vim.opt.eventignore:append("FileType")
  end

  local cmd = string.format("belowright %s %%", opts.cmd)
  vim.cmd(cmd)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_win_set_height(
    vim.fn.bufwinid(bufnr),
    math.floor(vim.o.lines * opts.height)
  )

  vim.o.eventignore = old_ignore
  vim.opt_local.number = optional_term_opts.number
  vim.opt_local.relativenumber = optional_term_opts.relativenumber
  vim.opt_local.signcolumn = optional_term_opts.signcolumn

  if opts.focus_current_buffer then
    vim.api.nvim_set_current_win(vim.fn.bufwinid(current_bufnr))
  end
end

return M
