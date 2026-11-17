" Count words without LaTeX commands; visual mode counts the selected lines.
nnoremap <buffer> <Leader>wc :w !detex \| wc -w<CR>
xnoremap <buffer> <Leader>wc :w !detex \| wc -w<CR>

" Use gq to format text to 80 columns.
setlocal textwidth=80

let b:undo_ftplugin = (empty(get(b:, 'undo_ftplugin', '')) ? '' : b:undo_ftplugin . ' | ')
      \ . 'setlocal textwidth<'
      \ . '| execute "silent! nunmap <buffer> <Leader>wc"'
      \ . '| execute "silent! xunmap <buffer> <Leader>wc"'
