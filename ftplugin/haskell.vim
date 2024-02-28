let b:CtrlXA_Toggles = [
      \ ['_', 'Int', 'Float', 'String', 'Bool', 'Char', 'Word8', 'Int16', 'Int64', 'Double'],
      \ ['foreign', 'newtype', 'deriving'],
      \ ['forM_', 'whileM', 'do'],
      \ ['if', 'else', 'case'],
      \ ['try', 'catch', 'finally', 'throwIO'],
      \ ['data', 'type'],
      \ ['class', 'instance'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
