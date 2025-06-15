local utils = require("config.utils")

local lsp = vim.lsp.buf
local set = vim.keymap.set

set("n", "gK", lsp.hover, { desc = "LSP: hover" })
set("n", "gd", lsp.definition, { desc = "LSP: go to definition" })
set("n", "gD", lsp.declaration, { desc = "LSP: go to declaraion" })
set("n", "gi", lsp.implementation, { desc = "LSP: go to implementation" })
set("n", "gO", vim.diagnostic.open_float, { desc = "LSP: open diagnostic" })
set("n", "go", lsp.type_definition, { desc = "LSP: go to type definition" })
set("n", "gr", lsp.references, { desc = "LSP: list references" })
set("n", "gs", lsp.signature_help, { desc = "LSP: signature help" })
set("n", "<F2>", lsp.rename, { desc = "LSP: rename" })
set("n", "<F4>", lsp.code_action, { desc = "LSP: list code actions available" })
set({ "n", "x" }, "<F3>", function()
  lsp.format({ async = true })
end, { desc = "LSP: format buffer" })

set("n", "gpd", utils.on_existing_rvsplit(lsp.definition), { desc = "LSP: definition in the right split" })
set("n", "gPd", utils.on_new_rvsplit(lsp.definition), { desc = "LSP: definition in a split" })

set("n", "<leader>cL", "<cmd>bufdo LspRestart<cr>", { desc = "LSP: Restart LSP on all open buffers" })
