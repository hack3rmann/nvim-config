return {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    opts = {
        server = {
            on_attach = function(_, bufnr)
                local rt = require("rust-tools")

                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, remap = true })
            end,
            settings = {
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
            cmd = { "rust-analyzer" },
        },
        debug = {
            adapter = {
                command = "codelldb",
            },
        },
    },
    config = function(_, opts)
        require("rust-tools").setup(opts)
    end,
}
