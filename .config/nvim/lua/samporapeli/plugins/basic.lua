return {
	"catppuccin/nvim",
	"norcalli/nvim-colorizer.lua",
	"numToStr/Comment.nvim",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup()
		end
	},
}
