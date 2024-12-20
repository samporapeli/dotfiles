local ide_mode = os.getenv("NVIM_IDE")

vim.cmd [[
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath = &runtimepath
	source ~/.vim/vimrc
]]

vim.g.vimtex_compiler_progname = "nvr"

-- Copilot
vim.g.copilot_enabled = false -- require `:Copilot enable` to start
vim.g.copilot_filetypes = {
	markdown = true,
	yaml = true,
	json = true,
	toml = true,
	gitcommit = true,
}
--Enable/disable with leader + co{e,d}
vim.api.nvim_set_keymap("n", "<Leader>coe", ":Copilot enable<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>cod", ":Copilot disable<CR>", { noremap = true })

-- setup packer and load plugins
local packer = require("packer")
packer.startup(function (use)
	use "norcalli/nvim-colorizer.lua"
	use "numToStr/Comment.nvim"
	use "catppuccin/nvim"
	use "vim-airline/vim-airline"
	use "vim-airline/vim-airline-themes"
	if ide_mode then
		require("samporapeli.ide.plugins")(use)
	end
end)

-- configure plugins
-- on lua error handling: https://www.lua.org/pil/8.4.html
vim.opt.termguicolors = true
if pcall(function () require("colorizer") end) then
	require("colorizer").setup()
end
require("Comment").setup()

-- appearance and vim-airline
vim.cmd.colorscheme "catppuccin-mocha"
vim.g.airline_theme = "catppuccin"
vim.g["airline#extensions#tabline#enabled"] = 1
require("samporapeli.toggle_background")
require("samporapeli.trim_trailing_whitespace")

-- load ide-config if NVIM_IDE is set
if ide_mode then require("samporapeli.ide") end
