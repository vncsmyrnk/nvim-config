local utils = require("lib.utils")

vim.keymap.set(
  "n",
  "<leader>gl",
  utils.on_a_new_tab("lazygit"),
  { desc = "TUI: Opens lazygit" }
)
vim.keymap.set(
  "n",
  "<leader>ag",
  utils.on_a_new_tab("gemini"),
  { desc = "TUI: Opens gemini" }
)
