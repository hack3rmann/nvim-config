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
        local blink_cmp = require("blink.cmp")

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        local lsp_attach = function(_, bufnr)
            -- K.LspKeymaps(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
        end

        local capabilities = blink_cmp.get_lsp_capabilities(opts.capabilities or {})

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(opts.servers),
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = lsp_attach,
                    settings = opts.servers[server_name],
                })
            end,
        })

        lspconfig.tinymist.setup({
            cmd = { "tinymist" },
            filetypes = { "typst" },
            single_file_support = true,
            root_dir = lspconfig.util.root_pattern(".typ"),
            offset_encoding = "utf-8",
        })

        lspconfig.clangd.setup({
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            root_dir = lspconfig.util.root_pattern(".clangd", ".clang-tidy", ".clang-format", "compile_commands.json"),
            single_file_support = true,
        })

        lspconfig.lua_ls.setup({
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        },
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })

        lspconfig.jdtls.setup({})
    end,
}
