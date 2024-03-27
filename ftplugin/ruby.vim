let b:CtrlXA_Toggles = [
                  \ ['void', 'nil', 'float', 'String', 'boolean', 'char', 'byte', 'short', 'long', 'double'],
                  \ ['for', 'while', 'until'],
                  \ ['break', 'next'],
                  \ ['if', 'else', 'case'],
                  \ ['begin', 'rescue', 'ensure', 'raise'],
                  \ ['public', 'private', 'protected'],
                  \ ['class', 'module'],
                  \ ['self', 'super'],
                  \ ['<', 'include'],
                  \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin =
                  \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
