local M = {}

local SESSION_FILE = "/tmp/session.vim"
local SHADA_FILE = "/tmp/session.shada"

---@param force boolean
local save_and_quit = function(force)
  vim.cmd("mks! " .. vim.fn.fnameescape(SESSION_FILE))
  vim.cmd("wshada! " .. vim.fn.fnameescape(SHADA_FILE))
  if force then
    vim.cmd("qa!")
    return
  end
  local ok, err = pcall(vim.cmd, "qa")
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

-- saves the session to be later recovery and exit neovim
function M.save_and_quit()
  save_and_quit(false)
end

-- saves the session to be later recovery and exit neovim forcedly
function M.save_and_force_quit()
  save_and_quit(true)
end

-- restores the last session
function M.load()
  if vim.fn.filereadable(SESSION_FILE) == 1 then
    vim.cmd("source " .. vim.fn.fnameescape(SESSION_FILE))
    vim.cmd("rshada! " .. vim.fn.fnameescape(SHADA_FILE))
  else
    vim.notify("No session found at " .. SESSION_FILE, vim.log.levels.WARN)
  end
end

return M
