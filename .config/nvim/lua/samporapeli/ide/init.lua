local icon_font = require("samporapeli.config.icon_font")

-- Mason (language server manager)
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
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "eslint", "ts_ls" },
	automatic_installation = true,
	automatic_enable = true,
})

-- Github Copilot
require("samporapeli.ide.copilot")

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

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
	-- custom keybindings here
end

vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>do", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<Leader>dl", vim.diagnostic.setqflist)
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader><F2>", vim.lsp.buf.rename)

-- Setup lua_ls with vim.lsp.config
vim.lsp.config('lua_ls', {
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Setup other servers with lspconfig
local lspconfig = require("lspconfig")
for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
	if server_name ~= "lua_ls" then -- Skip lua_ls, handled above
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end
end

-- Start LSP for existing buffers that were opened before config loaded
vim.schedule(function()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype ~= "" then
			vim.api.nvim_buf_call(bufnr, function()
				-- Trigger FileType event to start appropriate LSP
				vim.cmd("doautocmd FileType " .. vim.bo.filetype)
			end)
		end
	end
end)

if vim.bo.filetype == "dart" then
	require("samporapeli.ide.dart")
	lspconfig.dartls.setup({
		cmd = { "/usr/bin/env", "dart", "language-server", "--protocol=lsp" },
	})
end

-- arduino
-- if file doesn't exist, run `arduino-cli config init`
-- vim.env.ARDUINOCLI_CONFIG_PATH = os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml"
