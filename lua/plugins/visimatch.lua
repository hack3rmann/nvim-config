return {
    "wurli/visimatch.nvim",
    event = "BufRead",
    opts = {
        chars_lower_limit = 2,
    },
    config = function(_, opts)
        require("visimatch").setup(opts)
    end,
}
