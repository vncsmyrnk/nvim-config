local set = vim.keymap.set

set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Opens a new tab" })
set("n", "<leader>tt", "<cmd>tab term<cr>", { desc = "Opens a new tab in terminal mode" })
set("n", "<leader>th", "<cmd>tabmove -1<cr>", { desc = "Moves tab to the right" })
set("n", "<leader>tl", "<cmd>tabmove +1<cr>", { desc = "Moves tab to the left" })
set("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Closes current tab" })
