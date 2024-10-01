return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    },
    config = function(_, opts)
        require("mason").setup()
    end,
}
