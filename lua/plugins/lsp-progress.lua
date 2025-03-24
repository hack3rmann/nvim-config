return {
    "linrongbin16/lsp-progress.nvim",
    opts = {},
    lazy = true,
    setup = function(_, opts)
        require("lsp-progress").setup(opts)
    end,
}
