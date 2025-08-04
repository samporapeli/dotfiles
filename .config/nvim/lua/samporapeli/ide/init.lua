-- Github Copilot
require("samporapeli.ide.copilot")
-- LSP setup
require("samporapeli.ide.lsp")

-- LSP keybinds
vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>do", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<Leader>dl", vim.diagnostic.setqflist)
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader><F2>", vim.lsp.buf.rename)

-- arduino
-- if file doesn't exist, run `arduino-cli config init`
-- vim.env.ARDUINOCLI_CONFIG_PATH = os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml"
