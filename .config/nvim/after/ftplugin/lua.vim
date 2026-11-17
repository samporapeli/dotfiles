setlocal noexpandtab tabstop=3 shiftwidth=3 softtabstop=3

let b:undo_ftplugin = (empty(get(b:, 'undo_ftplugin', '')) ? '' : b:undo_ftplugin . ' | ')
      \ . 'setlocal expandtab< tabstop< shiftwidth< softtabstop<'
