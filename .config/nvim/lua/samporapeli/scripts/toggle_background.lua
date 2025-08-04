local function toggle_background()
	if vim.opt.background:get() == "dark" then
		vim.opt.background = "light"
		print("background is set to light")
	else
		vim.opt.background = "dark"
		print("background is set to dark")
	end
end

vim.keymap.set({"i", "n", "c", "v"}, "<F12>", toggle_background)
vim.api.nvim_create_user_command("ToggleBackground", toggle_background, {})

return toggle_background
