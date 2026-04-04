local utils = require("lib.utils")

--- Executes the current file in a term split.
local run = function()
  utils.execute_in_term_brhsplit({ ignore_term_ftplugin = true }, {})
end

vim.api.nvim_create_user_command("CustomTermRunFile", run, {})
