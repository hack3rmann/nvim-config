return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
    },
    config = function(spec, opts)
        require("nvim-autopairs").setup(opts)
    end,
}
