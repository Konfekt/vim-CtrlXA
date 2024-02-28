let b:CtrlXA_Toggles = [
      \ ['Unit', 'Int', 'Float', 'String', 'Boolean', 'Char', 'Byte', 'Short', 'Long', 'Double'],
      \ ['abstract', 'val'],
      \ ['for', 'while', 'do'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'when'],
      \ ['try', 'catch', 'finally', 'throw'],
      \ ['public', 'private', 'protected'],
      \ ['class', 'interface'],
      \ ['this', 'super'],
      \ ['extends', 'implements'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
