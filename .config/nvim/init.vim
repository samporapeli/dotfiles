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
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
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

" background
let g:is_light = 0
function! ToggleBackground()
    if g:is_light == 0
        set background=light
        AirlineTheme papercolor
        let g:is_light = 1
        echom "background is set to light"
    else
        set background=dark
        AirlineTheme catppuccin
        let g:is_light = 0
        echom "background is set to dark"
    endif
endfunction
" Execute ToggleBackground just after initializing vim
" https://stackoverflow.com/a/6821698
" autocmd VimEnter * silent call ToggleBackground()
nnoremap <F12> :call ToggleBackground()<CR>
inoremap <F12> <Esc>:call ToggleBackground()<CR>a

" vim-airline
let g:airline_theme='catppuccin'
" use tabline
let g:airline#extensions#tabline#enabled = 1
