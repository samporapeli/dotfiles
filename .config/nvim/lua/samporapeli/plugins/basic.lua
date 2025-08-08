-- Declare plugins
return {
	-- Load ftplugins from ~/.vim
	{
		dir = "~/.vim",
		name = "vim-config",
		lazy = false,
		priority = 1000,
	},
	-- Actual plugins
	{
		"catppuccin/nvim",
		name = "catppuccin"
	},
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		"norcalli/nvim-colorizer.lua",
		config = function ()
			vim.opt.termguicolors = true
			require("colorizer").setup()
		end
	},
	{
		"numToStr/Comment.nvim",
		config = function ()
			require("Comment").setup()
		end
	},
}
