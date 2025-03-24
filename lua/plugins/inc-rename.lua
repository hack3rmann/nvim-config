return {
    "smjonas/inc-rename.nvim",
    keys = {
        {
            "<leader>r",
            ":IncRename ",
            desc = "Rename",
        },
    },
    config = function(_, opts)
        require("inc_rename").setup(opts)
    end,
}
