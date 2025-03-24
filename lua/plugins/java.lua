return {
    "nvim-java/nvim-java",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "java" },
    config = function(_, opts)
        require("java").setup(opts)
    end,
}
