return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = "rust",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
        -- Plugin configuration
        tools = {
            float_win_config = {
                border = "rounded",
            },
        },
        -- LSP configuration
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "K", function()
                    vim.cmd.RustLsp({ "hover", "actions" })
                end, { buffer = bufnr })

                vim.keymap.set("n", "<leader>a", function()
                    vim.cmd.RustLsp("codeAction")
                end, { buffer = bufnr, remap = true })
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ["rust-analyzer"] = {
                    diagnostics = { enable = true },
                    checkOnSave = true,
                    check = {
                        enable = true,
                        command = "clippy",
                        features = "all",
                    },
                    rustc = { source = "discover" },
                },
            },
        },
        -- DAP configuration
        dap = {},
    },
    config = function(_, opts)
        vim.g.rustaceanvim = opts
    end,
}
