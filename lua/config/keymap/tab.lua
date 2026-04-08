local set = vim.keymap.set

set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Opens a new tab" })
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

set(
  "n",
  "<A-]>",
  "<cmd>silent! tabnext +1<cr>",
  { desc = "Opens the next tab" }
)
set(
  "n",
  "<A-[>",
  "<cmd>silent! tabnext -1<cr>",
  { desc = "Opens the previous tab" }
)

set(
  { "n", "t" },
  "<A-0>",
  [[<C-\><C-n><cmd>silent! tabnext 1<cr>]],
  { desc = "Opens first tab" }
)
set(
  { "n", "t" },
  "<A-9>",
  [[<C-\><C-n><cmd>silent! tabnext $<cr>]],
  { desc = "Opens last tab" }
)

-- Maps <A-{N}> to open tabs
for i = 1, 8 do
  set("n", string.format("<A-%s>", i), string.format("%sgt", i), {
    noremap = true,
    desc = "Go to tab " .. i,
  })
  set("t", string.format("<A-%s>", i), string.format([[<C-\><C-N>%sgt]], i), {
    noremap = true,
    desc = "Go to tab " .. i,
  })
end
