return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>gd",
            function()
                local has_telescope, telescope = pcall(require, "telescope.builtin")

                if has_telescope then
                    telescope.lsp_definitions()
                else
                    vim.lsp.buf.definition()
                end
            end,
            desc = "Go to definition",
        },
        {
            "<leader>gr",
            function(context, opts)
                local has_telescope, telescope = pcall(require, "telescope.builtin")

                if has_telescope then
                    telescope.lsp_references()
                else
                    vim.lsp.buf.references(context, opts)
                end
            end,
            desc = "Go to references",
        },
        {
            "<leader>gb",
            "<C-t>",
            desc = "Go back",
        },
        {
            "<leader>d",
            vim.diagnostic.open_float,
            desc = "Open diagnostics",
        },
    },
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "linrongbin16/lsp-progress.nvim",
    },
    opts = {
        inlay_hints = { enabled = false },
        capabilites = {},
        autoformat = false,
        servers = {
            clangd = {},
            lua_ls = {},
            rust_analyzer = {},
            tinymist = {},
        },
        diagnostics = {
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚",
                    [vim.diagnostic.severity.WARN] = "󰀪",
                    [vim.diagnostic.severity.HINT] = "󰌶",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
        },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(opts.servers),
            automatic_enable = true,
        })

        vim.lsp.config("slangd", {
            cmd = { "slangd" },
            filetypes = {
                "hlsl",
                "slang",
                "shaderslang",
            },
            single_file_support = true,
        })

        vim.lsp.config("tinymist", {
            cmd = { "tinymist" },
            filetypes = { "typst" },
            single_file_support = true,
            root_dir = lspconfig.util.root_pattern(".typ"),
            offset_encoding = "utf-8",
        })

        vim.lsp.config("clangd", {
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            root_dir = lspconfig.util.root_pattern(".clangd", ".clang-tidy", ".clang-format", "compile_commands.json"),
            single_file_support = true,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths here.
                            "${3rd}/luv/library",
                            -- "${3rd}/busted/library",
                        },
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        vim.lsp.config("jdtls", {})

        vim.lsp.config("ts_ls", {})
    end,
}
