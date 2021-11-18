set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:vimtex_compiler_progname = 'nvr'
source ~/.vim/vimrc

source ~/.local/share/nvim/site/autoload/vim-plug/plug.vim

call plug#begin(stdpath('data') . 'plugged')
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
set termguicolors
lua require'colorizer'.setup()
