-- Leader.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- No mouse.
vim.opt.mouse = ""

-- Line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces, not tabs.
vim.opt.tabstop = 4 -- Number of spaces a <Tab> counts for
vim.opt.shiftwidth = 4 -- Number of spaces for each level of indentation
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Show spaces and tabs.
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    eol = "↴",
    extends = "›",
    precedes = "‹",
    space = " ", -- optional: shows dots for spaces too
}
