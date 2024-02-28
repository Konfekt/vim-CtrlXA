let b:CtrlXA_Toggles = [
      \ ['if', 'then', 'else', 'elif', 'fi', 'case', 'esac', 'for', 'while', 'until', 'do', 'done'],
      \ ['declare', 'typeset'],
      \ ['export', 'readonly'],
      \ ['alias', 'unalias'],
      \ ['set', 'unset'],
      \ ['shopt', 'caller'],
      \ ['echo', 'printf'],
      \ ['read', 'readarray', 'mapfile'],
      \ ['eval', 'source', 'exec'],
      \ ['return', 'exit'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'

