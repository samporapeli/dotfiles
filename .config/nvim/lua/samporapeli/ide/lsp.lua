require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "eslint", "ts_ls" },
	automatic_installation = true,
	automatic_enable = true,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
	-- custom keybindings here
end

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
	local lspconfig = require("lspconfig")
	lspconfig.dartls.setup({
		cmd = { "/usr/bin/env", "dart", "language-server", "--protocol=lsp" },
	})
end
