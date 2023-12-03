-- make sure to load plugins (simply requiring this file or plugins.lua is not enough)
vim.g.dart_trailing_comma_indent = true
vim.cmd("set shortmess-=F")
vim.keymap.set("n", "<Leader>ft", ":DartFmt<CR>")
