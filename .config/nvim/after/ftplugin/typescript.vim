setlocal tabstop=2 shiftwidth=2

let b:undo_ftplugin = (empty(get(b:, 'undo_ftplugin', '')) ? '' : b:undo_ftplugin . ' | ')
      \ . 'setlocal tabstop< shiftwidth<'
