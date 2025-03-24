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
    dependencies = {
        "rcarriga/nvim-notify",
        "stevearc/dressing.nvim",
    },
    opts = {
        firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
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
