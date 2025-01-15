return {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    opts = {
        transparency_color = "#000000",
    },
    config = function(_, opts)
        require("tiny-glimmer").setup(opts)
    end,
}
