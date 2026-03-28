local utils = require("config.utils")

---@type integer
local output_bufnr = nil

---@type string
local output_filename = vim.fn.tempname()

--- Executes the current SHELL on the given range and outputs to a split buffer.
---@param opts UserCommandOpts
local run = function(opts)
  local shell = os.getenv("SHELL") or ""
  if not shell then
    vim.notify("$SHELL is not set", vim.log.levels.ERROR)
    return
  end

  utils.pipe_file_to_cmd(shell, output_filename, { line1 = opts.line1, line2 = opts.line2 })
  if output_bufnr and #vim.fn.win_findbuf(output_bufnr) > 0 then
    return
  end
  utils.open_output_brhsplit(output_filename, { focus_current_buffer = true })
end

vim.api.nvim_create_user_command("CustomShellRun", run, { range = "%" })
