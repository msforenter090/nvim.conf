require("config.base")
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
            -- Make sure tools are installed.
            local tools = {
                "stylua", "yamlfmt",
                "shellcheck",
                "shfmt"
            }

            require("lsp.util").install_tools(tools)
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Bash
                    "bashls",

                    -- Python
                    "pylsp",

                    -- Lua
                    "lua_ls"
                }
            })
            -- Lua:
            -- luals Key binding and suggestions do not work because thay are not added.
            -- Client is not attached.

            -- Bash:
            -- Shell checking shows double Warrnings, Errors and everything else.
            require("lsp.util").load_config({ "bashls", "pyls", "luals" })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sharkdp/fd",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("telescope").setup()
        end
    }
})

require("config.keymaps").setup()
require("config.keymaps.telescope.keymap").setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    float = { border = "rounded" },
})
