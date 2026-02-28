local session = require("config.session")
local set = vim.keymap.set

set("v", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
set("n", "<leader>Y", '"+Y', { desc = "Copy the rest of the line to system clipboard" })
set("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Last buffer" })
set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Clear highlight" })
set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Close buffer" })
set("n", "<leader>qp", "<cmd>b#|bd#<cr>", { desc = "Close current buffer and go to previous" })
set("n", "<leader>qb", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })
set("n", "<leader>qa", session.save_and_quit, { desc = "Close session" })
set("n", "<leader>qA", session.save_and_force_quit, { desc = "Close session without saving" })
set("n", "<leader>qR", session.load, { desc = "Restore last session" })

-- Moving lines around
-- <cmd> does not preserve the visual selection or range. Silent avoids the cmdline of being focused
set("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move lines down" })
set("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move lines up" })

-- Copy file name
set("n", "<leader>eyp", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Copy current buffer absolute path" })
set("n", "<leader>eyf", '<cmd>let @+ = expand("%:f")<cr>', { desc = "Copy current buffer relative path" })
set("n", "<leader>eyt", '<cmd>let @+ = expand("%:f")<cr>', { desc = "Copy current buffer file name" })

-- Resizing
set("n", "<A-K>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
set("n", "<A-J>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
set("n", "<A-H>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
set("n", "<A-L>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Window
set("t", "<A-h>", [[<C-\><C-N><C-w>h]], { desc = "Go to window on the left" })
set("t", "<A-j>", [[<C-\><C-N><C-w>j]], { desc = "Go to window below" })
set("t", "<A-k>", [[<C-\><C-N><C-w>k]], { desc = "Go to window above" })
set("t", "<A-l>", [[<C-\><C-N><C-w>l]], { desc = "Go to window on the right" })
set("t", "<A-t>", [[<C-\><C-N><C-w>t]], { desc = "Go to window on the top left" })
set("t", "<A-b>", [[<C-\><C-N><C-w>b]], { desc = "Go to window on the right bottom" })
set("n", "<A-h>", "<C-w>h", { desc = "Go to window on the left" })
set("n", "<A-j>", "<C-w>j", { desc = "Go to window below" })
set("n", "<A-k>", "<C-w>k", { desc = "Go to window above" })
set("n", "<A-l>", "<C-w>l", { desc = "Go to window on the right" })
set("n", "<A-t>", "<C-w>t", { desc = "Go to window on the top left" })
set("n", "<A-b>", "<C-w>b", { desc = "Go to window on the right bottom" })
set("n", "<A-o>", "<C-w>o", { desc = "Makes the current window the only one visible" })
set("n", "<A-q>", "<C-w>q", { desc = "Closes current window" })
