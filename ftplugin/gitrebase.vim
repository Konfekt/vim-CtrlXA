let b:CtrlXA_Toggles = [ ['pick', 'fixup', 'squash', 'break', 'reword', 'edit', 'drop'] ]
      \ + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)

let b:undo_ftplugin =
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
