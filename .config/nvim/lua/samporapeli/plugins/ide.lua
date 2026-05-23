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
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			local parsers = {
				"lua", "query", "vim", "vimdoc",
				"markdown", "markdown_inline",
				"bash", "cmake", "json", "json5", "jsonc", "make", "toml", "yaml",
				"css", "html", "javascript", "jsdoc", "scss", "tsx", "typescript",
				"dockerfile", "gitcommit", "gitignore", "python", "sql", "xml",
			}

			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(parsers)
				:filter(function(p) return not vim.tbl_contains(installed, p) end)
				:totable()

			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local ok = pcall(vim.treesitter.get_parser)
					if ok then
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
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
