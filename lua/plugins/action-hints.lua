return {
    "roobert/action-hints.nvim",
    opts = {
        template = {
            definition = { text = " 󱞫D", color = "#565254" },
            references = { text = " 󱞫R", color = "#565254" },
        },
        use_virtual_text = true,
    },
    config = function(_, opts)
        require("action-hints").setup(opts)
    end,
}
