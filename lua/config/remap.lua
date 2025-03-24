-- Default NeoVim file tree
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex, { desc = "Open default filesystem" })

-- Disable search highlight
vim.keymap.set("n", "<leader>/", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
