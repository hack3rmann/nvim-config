-- Default NeoVim file tree
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex, { desc = "Open default filesystem" })

-- LSP code actions
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", function(context, opts)
    local has_telescope, telescope = pcall(require, "telescope.builtin")

    if has_telescope then
        telescope.lsp_references()
    else
        vim.lsp.buf.references(context, opts)
    end
end, { desc = "Go to references" })
vim.keymap.set("n", "<leader>gb", "<C-t>", { desc = "Go back" });

-- Disable search highlight
vim.keymap.set("n", "<leader>/", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Open float diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics" })

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
