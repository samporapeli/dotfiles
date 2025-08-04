local ide_mode = require("samporapeli.config.ide_mode")

-- Load vimrc configuration
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd("source ~/.vim/vimrc")
-- vimscript ftplugins are loaded as a lazy.nvim "plugin"

-- load plugins
require("samporapeli.config.lazy")

-- appearance
vim.cmd.colorscheme "catppuccin-mocha"

-- load custom scripts/commands
require("samporapeli.toggle_background")
require("samporapeli.trim_trailing_whitespace")

-- load "ide" config if NVIM_IDE is set
if ide_mode.enabled then require("samporapeli.ide") end
