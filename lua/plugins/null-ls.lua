return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            on_init = function(new_client, _)
                new_client.offset_encoding = "utf-8"
            end,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            if require("config.switches").format_on_save then
                                vim.lsp.buf.format()
                            end
                        end,
                    })
                end
            end,
            sources = {
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.google_java_format,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.typstfmt,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.nixfmt,
                null_ls.builtins.formatting.yamlfmt,
            },
        })

        local ranged_format = function()
            vim.lsp.buf.format({
                async = true,
                range = {
                    ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                    ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
                },
            })
        end

        vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "Format buffer" })
        vim.keymap.set("v", "<leader>=", ranged_format, { desc = "Format buffer" })
    end,
}
