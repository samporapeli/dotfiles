-- Declare plugins
return {
	{
		"catppuccin/nvim",
		name = "catppuccin"
	},
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		"catgoose/nvim-colorizer.lua",
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
