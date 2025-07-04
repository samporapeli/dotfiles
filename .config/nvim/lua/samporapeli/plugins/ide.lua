local ct = require("samporapeli.concatable")
local conditionally = require("samporapeli.conditionally")

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
}) ..
conditionally(vim.bo.filetype == "dart")
	.if_true(require("samporapeli.plugins.dart"))
	.if_false({})
