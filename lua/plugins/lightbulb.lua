return {
    "kosayoda/nvim-lightbulb",
    enabled = false,
    opts = {
        autocmd = { enabled = true },
    },
    config = function(spec, opts)
        require("nvim-lightbulb").setup(opts)
    end,
}
