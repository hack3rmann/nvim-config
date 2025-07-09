return {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
        local logo_path = vim.fn.stdpath("config") .. "/lua/assets/logo.txt"
        local has_logo = vim.fn.filereadable(logo_path) == 1
        local logo_lines = has_logo and vim.fn.readfile(logo_path) or nil

        require("dashboard").setup({
            theme = "doom",
            preview = has_logo and {
                -- NOTE(hack3rmann): dashboard contains race conditions somehow
                command = [[print() { if command -v lolcrab > /dev/null; then lolcrab -g warm $1; sleep 0.5; else cat $1; fi }; print]],
                file_path = logo_path,
                file_width = string.len(logo_lines[1]),
                file_height = #logo_lines,
            } or nil,
            config = {
                vertical_center = true,
                disable_move = true,
                center = {
                    {
                        icon = " ",
                        desc = "Find Files",
                        key = "f",
                        action = function()
                            require("telescope.builtin").find_files()
                        end,
                    },
                    {
                        icon = " ",
                        desc = "Live Grep",
                        key = "g",
                        action = function()
                            require("telescope.builtin").live_grep()
                        end,
                    },
                    {
                        icon = "󰒲 ",
                        desc = "Plugin Manager",
                        key = "l",
                        action = "Lazy",
                    },
                    {
                        icon = "󰿅 ",
                        desc = "Quit Neovim",
                        key = "q",
                        action = "qa",
                    },
                },
                footer = {},
            },
        })
    end,
}
