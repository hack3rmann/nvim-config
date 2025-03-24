return {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function(_, opts)
        require("dashboard").setup(opts)
    end,
}
