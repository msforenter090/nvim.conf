require("config.base").setup()
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
            require("mason").setup({})
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {},
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Formatters
                    "stylua", "shfmt", "yamlfmt"
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
                    sh = { "shfmt" },
                    bash = { "shfmt" },
                    yaml = { "yamlfmt" }
                },

                formatters = {
                    shfmt = {
                        prepend_args = {
                            "-i",
                            "4",
                            "-bn",
                            "-ci",
                            "-sr",
                        },
                    },
                },
            })
        end,
    },
})
require("config.keymaps").setup()
