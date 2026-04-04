local set = vim.keymap.set

set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Opens a new tab" })
set("n", "<leader>t$", "<cmd>tabnext $<cr>", { desc = "Opens the last tab" })
set("n", "<leader>t0", "<cmd>tabnext 1<cr>", { desc = "Opens the first tab" })
set(
  "n",
  "<leader>t<tab>",
  "<cmd>tabnext #<cr>",
  { desc = "Opens the last accessed tab" }
)
set(
  "n",
  "<leader>tt",
  "<cmd>tab term<cr>",
  { desc = "Opens a new tab in terminal mode" }
)
set(
  "n",
  "<leader>th",
  "<cmd>tabmove -1<cr>",
  { desc = "Moves tab to the right" }
)
set(
  "n",
  "<leader>tl",
  "<cmd>tabmove +1<cr>",
  { desc = "Moves tab to the left" }
)
set("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Closes current tab" })

-- Maps <A-{N}> to open tabs
for i = 1, 9 do
  set("n", string.format("<A-%s>", i), string.format("%sgt", i), {
    noremap = true,
    desc = "Go to tab " .. i,
  })
end
