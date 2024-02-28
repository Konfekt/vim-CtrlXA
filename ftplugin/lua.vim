let b:CtrlXA_Toggles = [
                  \ ['nil', 'number', 'string', 'boolean', 'table', 'function', 'userdata', 'thread'],
                  \ ['local', 'global'],
                  \ ['for', 'while', 'repeat'],
                  \ ['if', 'else', 'elseif', 'then', 'end'],
                  \ ['pcall', 'xpcall'],
                  \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
                  \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
