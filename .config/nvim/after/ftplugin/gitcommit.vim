setlocal spell

let b:undo_ftplugin = (empty(get(b:, 'undo_ftplugin', '')) ? '' : b:undo_ftplugin . ' | ')
      \ . 'setlocal spell<'
