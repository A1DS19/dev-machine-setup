lvim.colorscheme = "dracula"
lvim.transparent_window = false
lvim.builtin["terminal"].active = false
vim.opt.cmdheight = 2         -- more space in the neovim command line for displaying messages
vim.opt.guifont = "hack:h17"  -- the font used in graphical neovim applications
vim.opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2           -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines
vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#44475a", bold = true })
vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#6272a4", bold = true })
vim.api.nvim_set_hl(0, "vCursor", { fg = "#000000", bg = "#555555", bold = true })
vim.api.nvim_set_hl(0, "rCursor", { fg = "#000000", bg = "#888888", bold = true })
