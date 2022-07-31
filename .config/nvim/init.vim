set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:vimtex_compiler_progname = 'nvr'
source ~/.vim/vimrc

source ~/.local/share/nvim/site/autoload/vim-plug/plug.vim

call plug#begin(stdpath('data') . 'plugged')
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
set termguicolors
" on lua error handling: https://www.lua.org/pil/8.4.html
lua if pcall(function () require'colorizer' end) then require'colorizer'.setup() end
