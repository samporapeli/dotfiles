" Based on https://missing.csail.mit.edu/2020/editors/ example

" Not really necessary in .vimrc
set nocompatible

" Syntax hilighting
syntax on

" Disable startup message
"set shortmess+=I

" Show line numbers
set number
" Set relative line numbering for easier navigation
set relativenumber

" More intuitive backspace behaviour
set backspace=indent,eol,start

" Unbind some useless/annoying default key bindings.
nmap Q <Nop>

" Mouse support
set mouse+=a

" Search while typing + smart case matching
set incsearch
set ignorecase
set smartcase

" Do not use arrow keys :)
" normal mode
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Spaces instead of tabs and other indentation
filetype on
filetype plugin on
filetype indent on
set autoindent
set expandtab
set tabstop=4 shiftwidth=4
"set smarttab

" Make :W save (I hit this accidentally as ':' is produced with Shift key
command W w

" as vim-airline is used, the delay after pressing esc in insert mode is
" especially annoying
set timeoutlen=1000 ttimeoutlen=0

" Fix missing symbols
let g:airline_powerline_fonts = 1

" vimtex config
let g:tex_flavor = "latex"
nnoremap <F5> :VimtexCompile<CR>
