function ToggleBackground()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
    vim.cmd[[AirlineTheme papercolor]]
    print 'background is set to light'
  else
    vim.opt.background = 'dark'
    vim.cmd[[AirlineTheme catppuccin]]
    print 'background is set to dark'
  end
end

vim.keymap.set({'i', 'n', 'c'}, '<F12>', ToggleBackground)
vim.api.nvim_create_user_command('ToggleBackground', ToggleBackground, {})

return ToggleBackground
