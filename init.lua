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
                "shfmt",

                -- Dap
                -- I do think debugpy is required
                -- You should have it installed in your virt env.
                -- You can install it via Mason, but mason will pull down
                -- virt env and install it inside.
                -- In that case you are using two virt envs, one where debugpy
                -- is installed and the other where you packages are located.
                "debugpy"
            }

            require("lsp.util").install_tools(tools)

            -- ensure_installed only installs lsps, not regular tools.
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
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",

            -- wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
            -- && cd ~/.local/share/fonts \
            -- && unzip JetBrainsMono.zip \
            -- && rm JetBrainsMono.zip \
            -- && fc-cache -fv
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("dap.dap").setup()
        end
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
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
