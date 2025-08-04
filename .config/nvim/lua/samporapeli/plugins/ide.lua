local ide_mode = require("samporapeli.config.ide_mode")
local ct = require("samporapeli.utils.concatable")

local plugin_list = {
	-- Setup of lsp plugins takes place at samporapeli/ide/lsp.lua
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = function ()
			local icon_font = require("samporapeli.config.icon_font")
			-- Default is "◍" for all
			local mason_icons = {
				package_installed = "●",
				package_pending = "◍",
				package_uninstalled = "◌",
			}
			if not icon_font.enabled then
				mason_icons.package_installed = "[x]"
				mason_icons.package_pending = "[/]"
				mason_icons.package_uninstalled = "[ ]"
			end
			require("mason").setup({
				ui = {
					icons = mason_icons
				},
			})
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"hrsh7th/nvim-cmp",
		config = function ()
			local cmp = require("cmp")
			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "github/copilot.vim" },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua", "query", "vim", "vimdoc", -- Core
					"markdown", "markdown_inline", -- Documentation and writing
					"bash", "cmake", "json", "json5", "jsonc", "make", "toml", "yaml", -- Shell and config
					"css", "html", "javascript", "jsdoc", "scss", "tsx", "typescript", -- Web
					"dockerfile", "gitcommit", "gitignore", "python", "sql", "xml", -- Common
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "grc",
						node_decremental = "<bs>",
					},
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					if require("nvim-treesitter.parsers").has_parser() then
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
					end
				end
			})
		end,
	},
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
			vim.g.vimtex_compiler_progname = "nvr"
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
