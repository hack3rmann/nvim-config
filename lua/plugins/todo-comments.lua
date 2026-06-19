return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    opts = {
        keywords = {
            TODO = { alt = { "todo" } },
        },
        highlight = {
            comments_only = false,
            keyword = "bg",
            pattern = {
                [[.*(<(KEYWORDS)[^:]*):]],
                [[\c.*(\c<(KEYWORDS)!\(.*\))]],
            },
        },
    },
    config = function(_, opts)
        require("todo-comments").setup(opts)
    end
}
