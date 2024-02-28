let b:CtrlXA_Toggles = [
      \ ['Void', 'Int', 'Float', 'String', 'Bool', 'Character', 'Int8', 'Int16', 'Int64', 'Double'],
      \ ['static', 'final'],
      \ ['for', 'while', 'repeat'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'switch'],
      \ ['do', 'catch', 'defer', 'throw'],
      \ ['public', 'private', 'internal', 'open'],
      \ ['class', 'protocol'],
      \ ['self', 'super'],
      \ ['inherit', 'conforms'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
