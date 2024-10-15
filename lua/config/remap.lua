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

-- Disable search highlight
vim.keymap.set("n", "<leader>/", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Open float diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics" })
