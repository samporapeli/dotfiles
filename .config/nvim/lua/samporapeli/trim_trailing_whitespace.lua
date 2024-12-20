local function trim_trailing_whitespace()
	vim.cmd([[:%s/\s\+$//e]])
end

vim.keymap.set('n', '<Leader>tw', trim_trailing_whitespace)
vim.api.nvim_create_user_command('TrimTrailingWhitespace', trim_trailing_whitespace, {})

return trim_trailing_whitespace
