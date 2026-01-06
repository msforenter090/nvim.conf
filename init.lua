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
        -- Usefull as a dependency to other libraries.
        "nvim-lua/plenary.nvim",
        opts = {},
        config = function()
        end
    },
    {
       "mason-org/mason.nvim",
        opts = {},
        setup = function()
            require("mason").setup()
        end
    },
    {
        "gutsavgupta/nvim-gemini-companion",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("gemini").setup({
                cmds = { "gemini-cli" },
                 win = {
                    preset = "bottom-fixed",  -- Options: "right-fixed", "left-fixed", "bottom-fixed", "floating"
                    -- width = 0.8,
                    -- height = 0.8,
                }
            })
            vim.api.nvim_command("GeminiToggle")
        end,
        keys = {
            { "<leader>gg", "<cmd>GeminiToggle<cr>", desc = "Toggle Gemini sidebar" },
            { "<leader>gc", "<cmd>GeminiSwitchToCli<cr>", desc = "Spawn or switch to AI session" },
            { '<leader>gS', '<cmd>GeminiSend<cr>', mode = { 'x' }, desc = 'Send selection to Gemini' },
        }
    },
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = {
                enabled = true,
                replace_netrw = true,
                trash = false
            },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            terminal = { enabled = true }
        },
        keys = {
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            { "<leader>tt", function() Snacks.terminal.toggle() end, desc = "Terminal Toggle" },
            { "<leader>not",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup()
        end
    }
})

require("config.keymaps").setup()

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Open explorer.
        Snacks.explorer()

        -- I planned to open Gemini here, but command is not available here (not sure why)
    end,
})
