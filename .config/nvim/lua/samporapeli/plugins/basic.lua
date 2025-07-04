return {
	"catppuccin/nvim",
	"norcalli/nvim-colorizer.lua",
	"numToStr/Comment.nvim",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		"vim-airline/vim-airline",
		init = function()
			vim.g.airline_theme = "catppuccin"
			vim.g.airline_powerline_fonts = 1
			vim.g["airline#extensions#tabline#enabled"] = 1
		end
	},
	"vim-airline/vim-airline-themes",
}
