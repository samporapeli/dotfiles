local ct = require("samporapeli.concatable")

return ct.new({
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"github/copilot.vim",
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
}) .. require("samporapeli.plugins.dart")
