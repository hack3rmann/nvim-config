return {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    opts = {
        -- NOTE: should match terminal bg color
        transparency_color = "#14121A",
    },
    config = function(_, opts)
        require("tiny-glimmer").setup(opts)
    end,
}
