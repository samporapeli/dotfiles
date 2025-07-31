local ide_mode = require("samporapeli.config.ide_mode")
local ct = require("samporapeli.concatable")

local plugin_list = {
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "github/copilot.vim" },
	{
		"mattn/emmet-vim",
		init = function()
			-- default unless leader is set: Ctrl-Y + ,
			vim.g.user_emmet_leader_key = '<Leader>' -- ,, -> html completion
		end,
	},
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.tex_flavor = "latex"
			vim.keymap.set({"i", "n", "c", "v"}, "<F5>", function() vim.cmd("VimtexCompile") end)
		end,
	},
}

for _, plugin in ipairs(plugin_list) do
	plugin.enabled = ide_mode.enabled
end

return ct.new(plugin_list)
	.. require("samporapeli.plugins.dart")
