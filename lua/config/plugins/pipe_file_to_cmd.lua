local utils = require("config.utils")

---@type integer
local output_bufnr = nil

---@type string
local output_filename = vim.fn.tempname()

--- Executes the cmd on the given range and outputs to a split buffer.
---@param opts UserCommandOpts
local run = function(opts)
  utils.pipe_file_to_cmd(opts.args, output_filename, { line1 = opts.line1, line2 = opts.line2 })
  if output_bufnr and #vim.fn.win_findbuf(output_bufnr) > 0 then
    return
  end
  utils.open_output_brhsplit(output_filename, { inherit_filetype = true, focus_current_buffer = true, height = 0.3 })
end

local command_opts = { range = "%", nargs = "+" }
vim.api.nvim_create_user_command("CustomPipeFileToCmd", run, command_opts)
vim.api.nvim_create_user_command("CC", run, command_opts)
