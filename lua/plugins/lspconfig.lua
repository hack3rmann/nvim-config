return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-java",
    },
    opts = {
        inlay_hints = { enabled = false },
        capabilites = {},
        autoformat = false,
        servers = {
            clangd = {},
            rust_analyzer = {},
            lua_ls = {},
        },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        require("java").setup()

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        local lsp_attach = function(_, bufnr)
            -- K.LspKeymaps(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
        end

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities() or {},
            opts.capabilities or {}
        )

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

        lspconfig.rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = true,
                    check = {
                        enable = true,
                        command = "clippy",
                        features = "all",
                    },
                    rustc = { source = "discover" },
                },
            },
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
