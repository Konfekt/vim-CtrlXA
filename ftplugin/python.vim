let b:CtrlXA_Toggles = [
      \ ['None', 'int', 'float', 'str', 'bool', 'char', 'byte', 'short', 'long', 'double'],
      \ ['for', 'while'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'elif'],
      \ ['try', 'except', 'finally', 'raise'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin =
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
