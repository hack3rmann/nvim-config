return {
    "simrat39/rust-tools.nvim",
    opts = {
        server = {
            on_attach = function(_, bufnr)
                local rt = require("rust-tools")

                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, remap = true })
            end,
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