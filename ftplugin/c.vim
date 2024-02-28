let b:CtrlXA_Toggles = [
      \ ['void', 'int', 'float', 'char', 'short', 'long', 'double', 'unsigned', 'signed', 'const'],
      \ ['static', 'extern', 'register'],
      \ ['for', 'while', 'do'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'switch'],
      \ ['extern', 'static', 'auto', 'register'],
      \ ['struct', 'union'],
      \ ['typedef', 'enum'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
