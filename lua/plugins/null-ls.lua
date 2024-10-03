return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        local switches = require("config.switches")

        null_ls.setup({
            on_attach = function(client, bufnr)
                if switches.format_on_save and client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = vim.lsp.buf.format,
                    })
                end
            end,
            sources = {
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.stylua,
            },
        })
    end,
}
