return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    opts = {
        highlight = {
            pattern = [[.*(<(KEYWORDS)[^:]*):]],
        },
    },
    config = function(_, opts)
        require("todo-comments").setup(opts)
    end
}
