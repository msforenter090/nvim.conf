require("config.base")
count = 1
require("config.lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require("mason").setup()
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {},
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Lua & Yaml
                    "stylua",
                    "yamlfmt",

                    -- Bash
                    "bash-language-server",
                    "shellcheck",
                    "shfmt",

                    -- Python
                    "python-lsp-server",
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    yaml = { "yamlfmt" },
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig" },
        },
        config = function()
            require("mason-lspconfig").setup()
            enableConfig = function(tool)
                require("lsp." .. tool .. ".config").config()
            end
            enableConfig("bashls")
            enableConfig("pyls")
        end,
    },
})

require("config.keymaps").setup()
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    float = { border = "rounded" },
})
