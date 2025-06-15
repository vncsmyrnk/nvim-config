local set = vim.keymap.set

set("t", "<A-d>", [[<C-\><C-N>]], { desc = "Exit terminal mode" })

set("n", "<A-v>", "<cmd>vert term<cr>", { desc = "Open split terminal on the left" })
set("n", "<A-r>", "<cmd>rightb term<cr>", { desc = "Open split terminal on the bottom right" })
set("n", "<A-a>", "<cmd>lefta term<cr>", { desc = "Open split terminal on the top left" })
