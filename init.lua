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
            local dapui = require("dapui")
            local dap = require("dap")
            local dapPython = require("dap-python")

            dapui.setup()
            dapPython.setup(vim.fn.exepath("python"))

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
            vim.keymap.set('n', '<leader>dc', dap.continue, {})
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
