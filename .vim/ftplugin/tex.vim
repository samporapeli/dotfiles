" Save file and calculate amount of words without latex commands
map <leader>wc :w !detex \| wc -w<CR>

" Set width to 80 characters
" In visual mode use `gq` to format selected text
set textwidth=80
