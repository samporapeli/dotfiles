require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "eslint", "ts_ls" },
	automatic_installation = true,
	automatic_enable = true,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
	-- custom keybindings here
end

-- Default config applied to all servers
vim.lsp.config('*', {
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
})

vim.lsp.config('lua_ls', {
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

vim.lsp.config('dartls', {
	cmd = { "/usr/bin/env", "dart", "language-server", "--protocol=lsp" },
})

vim.lsp.enable('dartls')
