local set = vim.keymap.set

set("n", "<leader>ko", "<cmd>copen<cr>", { desc = "Quickfix: open last list" })
set("n", "<leader>kq", "<cmd>cclose<cr>", { desc = "Quickfix: close list" })
set("n", "<leader>kn", "<cmd>cnewer<cr>", { desc = "Quickfix: next list" })
set("n", "<leader>kp", "<cmd>colder<cr>", { desc = "Quickfix: previous list" })
