local M = {
    setup = function()
        -- Make sure to setup `mapleader` and `maplocalleader` before
        -- loading lazy.nvim so that mappings are correct.
        -- This is also a good place to setup other settings (vim.opt)
        vim.g.mapleader = " "
        vim.g.maplocalleader = "\\"

        -- No mouse.
        vim.opt.mouse = ""

        -- Line numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        vim.opt.tabstop = 4 -- Number of spaces a <Tab> counts for
        vim.opt.shiftwidth = 4 -- Number of spaces for each level of indentation
        vim.opt.expandtab = true -- Use spaces instead of tabs

        vim.opt.list = true
        vim.opt.listchars = {
            tab = "» ",
            trail = "·",
            eol = "↴",
            extends = "›",
            precedes = "‹",
            space = " ", -- optional: shows dots for spaces too
        }

        -- Add command for Lua formatting.
        --    vim.api.nvim_create_user_command("FormatLua", function()
        --      vim.cmd("!lua-format" .. " -i " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
        --      vim.cmd("edit!") -- reload buffer
        --    end, { desc = "Format current Lua file." })

        --    vim.api.nvim_create_user_command("FormatC", function()
        --      vim.cmd("!clang-format" .. " -i " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
        --      vim.cmd("edit!") -- reload buffer
        --    end, { desc = "Format current C / C++ file." })
    end,
}

return M
