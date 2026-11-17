setlocal tabstop=4 shiftwidth=4

let b:undo_ftplugin = (empty(get(b:, 'undo_ftplugin', '')) ? '' : b:undo_ftplugin . ' | ')
      \ . 'setlocal tabstop< shiftwidth<'
