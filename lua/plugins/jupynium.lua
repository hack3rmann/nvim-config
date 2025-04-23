return {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    cmd = {
        "JupyniumAttachToServer",
        "JupyniumShortsightedDisable",
        "JupyniumShortsightedEnable",
        "JupyniumShortsightedToggle",
        "JupyniumStartAndAttachToServer",
        "JupyniumStartAndAttachToServerInTerminal",
    },
    keys = {
        {
            "<leader>x",
            ":JupyniumExecuteSelectedCells<CR>",
            desc = "Execute selected cell",
            silent = true,
        },
    },
    dependencies = {
        "rcarriga/nvim-notify",
        "stevearc/dressing.nvim",
    },
    opts = {
        firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
        firefox_profile_name = "default-release",
        notify = {
            ignore = {
                "download_ipynb",
            },
        },
    },
    setup = function(opts, _)
        require("jupynium").setup(opts)
    end,
}
