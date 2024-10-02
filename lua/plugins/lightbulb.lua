return {
    "kosayoda/nvim-lightbulb",
    enabled = false,
    opts = {
        autocmd = { enabled = true },
    },
    config = function(_, opts)
        require("nvim-lightbulb").setup(opts)
    end,
}
