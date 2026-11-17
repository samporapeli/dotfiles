local ide_mode = require("samporapeli.config.ide_mode")

-- load vimrc configuration
vim.cmd("source ~/.vim/vimrc")

-- load plugins
require("samporapeli.config.lazy")
-- load custom scripts/commands
require("samporapeli.scripts")

-- appearance
vim.cmd.colorscheme "catppuccin-mocha"

-- load "ide" config if NVIM_IDE is set
if ide_mode.enabled then require("samporapeli.ide") end
