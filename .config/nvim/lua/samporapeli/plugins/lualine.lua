local icon_font = require("samporapeli.config.icon_font")

-- Default with Powerline icons (https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#default-configuration)
local separators = {
		component_separators = {
				left = '', right = ''
		},
		section_separators = {
			left = '', right = ''
		},
}

-- Override defaults when icons are disabled
if not icon_font.enabled then
	separators.component_separators.left = ""
	separators.component_separators.right = ""
	separators.section_separators.left = ""
	separators.section_separators.right = ""
end

return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = icon_font.enabled,
					component_separators = separators.component_separators,
					section_separators = separators.section_separators,
				},
				tabline = {
					lualine_a = {
						{
							'buffers',
							symbols = {
								modified = '*',
							},
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'tabs' },
				},
			})
		end
	}
}
