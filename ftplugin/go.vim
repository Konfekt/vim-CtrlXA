let b:CtrlXA_Toggles = [
                  \ ['nil', 'int', 'float32', 'string', 'bool', 'byte', 'byte', 'int16', 'int64', 'float64'],
                  \ ['const', 'var'],
                  \ ['for', 'range'],
                  \ ['break', 'continue'],
                  \ ['if', 'else', 'switch'],
                  \ ['defer', 'go', 'select', 'panic', 'recover'],
                  \ ['public', 'private'],
                  \ ['struct', 'interface'],
                  \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin =
                  \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
