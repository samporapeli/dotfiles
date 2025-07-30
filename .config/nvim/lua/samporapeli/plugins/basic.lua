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
			require('lualine').setup({
				tabline = {
					lualine_a = {'buffers'},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {'tabs'}
				}
			})
		end
	},
}
