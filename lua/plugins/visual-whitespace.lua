return {
    "mcauley-penney/visual-whitespace.nvim",
    keys = { "v", "V", "<C-v>" },
    config = function(_, opts)
        require("visual-whitespace").setup(opts)
        vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5D5F71", bg = "#2D3F76" })
    end,
}
