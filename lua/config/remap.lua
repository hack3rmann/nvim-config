vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open default filesystem" })
vim.keymap.set("n", "<leader>a", vim.lsp.handlers["textDocument/codeAction"], { desc = "Open code actions" })
vim.keymap.set("n", "<leader>gd", vim.lsp.handlers["textDocument/definition"], { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.handlers["textDocument/references"], { desc = "Go to references" })
