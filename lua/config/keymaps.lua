vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Buffer
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy text" })
vim.keymap.set("n", "<leader><tab>", "<cmd>b#<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save file" })
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>", { desc = "Clear highlight" })
vim.keymap.set("n", "<leader>n", "<C-w><C-w>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>qp", "<cmd>b#|bd#<CR>", { desc = "Close current buffer and go to previous" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Close session" })
vim.keymap.set("n", "<leader>qA", "<cmd>qa!<CR>", { desc = "Close session without saving" })

-- Copy file name
vim.keymap.set("n", "<leader>eyp", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Copy current buffer absolute path" })
vim.keymap.set("n", "<leader>eyf", '<cmd>let @+ = expand("%:f")<cr>', { desc = "Copy current buffer relative path" })
vim.keymap.set("n", "<leader>eyt", '<cmd>let @+ = expand("%:f")<cr>', { desc = "Copy current buffer file name" })

-- Resizing
vim.keymap.set("n", "<A-K>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-J>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<A-H>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<A-L>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Window
vim.keymap.set("t", "<A-h>", [[<C-\><C-N><C-w>h]], { desc = "Go to window on the left" })
vim.keymap.set("t", "<A-j>", [[<C-\><C-N><C-w>j]], { desc = "Go to window below" })
vim.keymap.set("t", "<A-k>", [[<C-\><C-N><C-w>k]], { desc = "Go to window above" })
vim.keymap.set("t", "<A-l>", [[<C-\><C-N><C-w>l]], { desc = "Go to window on the right" })
vim.keymap.set("t", "<A-t>", [[<C-\><C-N><C-w>t]], { desc = "Go to window on the top left" })
vim.keymap.set("t", "<A-b>", [[<C-\><C-N><C-w>b]], { desc = "Go to window on the right bottom" })
vim.keymap.set("n", "<A-o>", [[<C-w>o]], { desc = "Makes the current window the only one visible" })
vim.keymap.set("n", "<A-h>", [[<C-w>h]], { desc = "Go to window on the left" })
vim.keymap.set("n", "<A-j>", [[<C-w>j]], { desc = "Go to window below" })
vim.keymap.set("n", "<A-k>", [[<C-w>k]], { desc = "Go to window above" })
vim.keymap.set("n", "<A-l>", [[<C-w>l]], { desc = "Go to window on the right" })
vim.keymap.set("n", "<A-t>", [[<C-w>t]], { desc = "Go to window on the top left" })
vim.keymap.set("n", "<A-b>", [[<C-w>b]], { desc = "Go to window on the right bottom" })

-- Splitting terminal windows
vim.keymap.set("n", "<A-v>", [[<cmd>vert term<CR>]], { desc = "Open split terminal on the right" })
vim.keymap.set("n", "<A-r>", [[<cmd>rightb term<CR>]], { desc = "Open split terminal on the bottom right" })
vim.keymap.set("n", "<A-a>", [[<cmd>lefta term<CR>]], { desc = "Open split terminal on the top left" })

-- Terminal mode
vim.keymap.set("t", "<A-q>", [[<C-\><C-N>]], { desc = "Exit terminal mode" })

-- Tabs
vim.keymap.set("n", "<leader>tn", [[<cmd>tabnew<CR>]], { desc = "Opens a new tab" })
vim.keymap.set("n", "<leader>tt", [[<cmd>tab term<CR>]], { desc = "Opens a new tab in terminal mode" })
vim.keymap.set("n", "<leader>th", [[<cmd>tabmove -1<CR>]], { desc = "Moves tab to the right" })
vim.keymap.set("n", "<leader>tl", [[<cmd>tabmove +1<CR>]], { desc = "Moves tab to the left" })
vim.keymap.set("n", "<leader>tq", [[<cmd>tabclose<CR>]], { desc = "Closes current tab" })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Language Specific

-- PHP
vim.keymap.set("n", "<leader>ipe", "oerror_log(print_r($obj, true));", { desc = "Insert error_log debug stmt" })
