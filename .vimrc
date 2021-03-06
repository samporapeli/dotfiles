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
set shiftround

" Make :W save (I often hit this accidentally as ':' is produced with Shift key)
command W w
command Wq wq
command WQ wq

" as vim-airline is used, the delay after pressing esc in insert mode is
" especially annoying
set timeoutlen=1000 ttimeoutlen=0

" Fix missing symbols
let g:airline_powerline_fonts = 1

" emmet-vim
let g:user_emmet_leader_key=','

" vimtex config
let g:tex_flavor = "latex"
nnoremap <F5> :VimtexCompile<CR>

" background
let t:is_light = 0
function! ToggleBackground()
    if t:is_light == 0
        set background=light
        let t:is_light = 1
        echom "background is set to light"
    else
        set background=dark
        let t:is_light = 0
        echom "background is set to dark"
    endif
endfunction
:silent call ToggleBackground()
nnoremap <F12> :call ToggleBackground()<CR>

" disable 'Press ENTER or type command to continue' when remote editing
:let g:netrw_silent=1

" syntax highlighting in markdown code blocks
let g:markdown_fenced_languages = ['sh', 'bash=sh', 'python', 'html', 'javascript']
