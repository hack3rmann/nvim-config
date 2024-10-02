return {
    "numToStr/Comment.nvim",
    opts = {
        ignore = "^$",
        toggler = {
            line = "<leader>cc",
            block = "<leader>bc",
        },
        opleader = {
            line = "<leader>c",
            block = "<leader>b",
        },
    },
    config = function(_, opts)
        require("Comment").setup(opts)
    end,
}
