local tui_term_close_group = vim.api.nvim_create_augroup("TermCloseGroup", { clear = true })

local function set_tui_keymap(mode, lhs, cmd, opts)
  vim.keymap.set(mode, lhs, function()
    vim.cmd(string.format("$tab term %s", cmd))
    vim.api.nvim_create_autocmd("TermClose", {
      group = tui_term_close_group,
      buffer = 0,
      callback = function()
        vim.api.nvim_buf_delete(0, { force = true })
      end,
    })
  end, opts)
end

set_tui_keymap("n", "<leader>gl", "lazygit", { desc = "TUI: Opens lazygit" })
