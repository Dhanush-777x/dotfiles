return {
    -- Mason for managing LSP servers, linters, and formatters
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "bashls",
                "lua_ls",
                "cssls",
                "html",
                "tailwindcss",
                "ts_ls",
                "clangd"
            },
            auto_install = true,
        },
    },
    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            -- Configure individual LSP servers
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })
        lspconfig.tailwindcss.setup({
            cmd = { "/usr/bin/tailwindcss-language-server", "--stdio" },
            filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            ".git"
        ),
    })
           lspconfig.ts_ls.setup({
                capabilities = capabilities,
                root_dir = lspconfig.util.root_pattern(".git"),
                single_file_support = false,
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "literal",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })
            -- Setup clangd
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd" },
                root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json"),
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                single_file_support = true,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        completion = {
                            workspaceWord = true,
                            callSnippet = "Both",
                        },
                        diagnostics = {
                            disable = { "incomplete-signature-doc", "trailing-space" },
                            unusedLocalExclude = { "_*" },
                        },
                        format = {
                            enable = false,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "2",
                            },
                        },
                    },
                },
            })

            -- Keybindings for LSP actions
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definitions" })
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format your code" })
        end,
    },
    -- Autocompletion
    {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
        -- Ensure `opts.sources` is defined and is a table
        opts.sources = opts.sources or {}
        -- Add the emoji source
        table.insert(opts.sources, { name = "emoji" })
    end,
},
}

