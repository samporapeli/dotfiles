require("mason").setup()
require("mason-lspconfig").setup({})

local cmp = require("cmp")
cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{
			{ name = "buffer" },
		},
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
vim.keymap.set("n", "<Leader>do", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader><F2>", vim.lsp.buf.rename)

local lspconfig = require("lspconfig")
for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
	lspconfig[server_name].setup({
		on_attach = lsp_attach,
		capabilities = lsp_capabilities,
	})
end

if vim.bo.filetype == "dart" then
	require("samporapeli.ide.dart")
	lspconfig.dartls.setup({
		cmd = { "/usr/bin/env", "dart", "language-server", "--protocol=lsp" },
	})
end

-- arduino
-- if file doesn't exist, run `arduino-cli config init`
-- vim.env.ARDUINOCLI_CONFIG_PATH = os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml"
