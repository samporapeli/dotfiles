local ide_mode = require("samporapeli.config.ide_mode")

-- Load vimrc configuration
vim.cmd [[
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath = &runtimepath
	source ~/.vim/vimrc
]]

-- load plugins
require("samporapeli.config.lazy")

vim.g.vimtex_compiler_progname = "nvr"

-- on lua error handling: https://www.lua.org/pil/8.4.html
vim.opt.termguicolors = true
if pcall(function () require("colorizer") end) then
	require("colorizer").setup()
end
require("Comment").setup()

-- appearance
vim.cmd.colorscheme "catppuccin-mocha"

require("samporapeli.toggle_background")
require("samporapeli.trim_trailing_whitespace")

-- load ide-config if NVIM_IDE is set
if ide_mode.enabled then require("samporapeli.ide") end
