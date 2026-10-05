return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ensure_installed = {
                "c",
                "cpp",
                "rust",
                "lua",
                "vim",
                "vimdoc",
                "nix",
                "query",
                "markdown",
                "markdown_inline",
            }

            require("nvim-treesitter").install(ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang then
                        return
                    end

                    -- On Neovim 0.12, get_parser returns nil instead of raising when missing.
                    local ok, parser = pcall(vim.treesitter.get_parser, ev.buf, lang)
                    if not ok or not parser then
                        return
                    end

                    pcall(vim.treesitter.start, ev.buf)

                    -- Keep previous behavior: treesitter indent everywhere except nix.
                    if ev.match ~= "nix" then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local objects = {
                ["af"] = { query = "@function.outer", desc = "function" },
                ["if"] = { query = "@function.inner", desc = "function" },
                ["ac"] = { query = "@class.outer", desc = "class" },
                ["ic"] = { query = "@class.inner", desc = "class" },
            }

            for keys, map in pairs(objects) do
                vim.keymap.set({ "x", "o" }, keys, function()
                    select.select_textobject(map.query, "textobjects")
                end, { desc = map.desc })
            end

            vim.keymap.set({ "x", "o" }, "as", function()
                select.select_textobject("@local.scope", "locals")
            end, { desc = "scope" })
        end,
    },
}
