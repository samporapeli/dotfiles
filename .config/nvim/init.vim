set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:vimtex_compiler_progname = 'nvr'
source ~/.vim/vimrc

set termguicolors

lua << EOF
  -- disable copilot
  vim.g.copilot_enabled = false
  vim.g.copilot_filetypes = {
    markdown = true,
    yaml = true,
    json = true,
    toml = true,
    gitcommit = true,
  }
  -- setup packer and load plugins
  local packer = require("packer")
  packer.startup(function (use)
    use 'norcalli/nvim-colorizer.lua'
    use 'numToStr/Comment.nvim'
    use 'catppuccin/nvim'
  end)
  -- configure plugins
  -- on lua error handling: https://www.lua.org/pil/8.4.html
  if pcall(function () require'colorizer' end) then
    require'colorizer'.setup()
  end
  require('Comment').setup()
  vim.cmd.colorscheme "catppuccin-mocha"

  -- load ide-config if NVIM_IDE is set
  if os.getenv('NVIM_IDE') then require('ide') end
EOF
