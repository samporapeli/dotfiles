-- Copilot
vim.g.copilot_enabled = false -- require `:Copilot enable` to start
vim.g.copilot_filetypes = {
	markdown = true,
	yaml = true,
	json = true,
	toml = true,
	gitcommit = true,
}

--Enable/disable with leader + co{e,d}
vim.api.nvim_set_keymap("n", "<Leader>coe", ":Copilot enable<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>cod", ":Copilot disable<CR>", { noremap = true })
