let b:CtrlXA_Toggles = [
                  \ ['undef', 'scalar', 'array', 'hash', 'ref', 'glob', 'sub', 'package'],
                  \ ['my', 'local', 'our'],
                  \ ['foreach', 'while', 'until'],
                  \ ['last', 'next'],
                  \ ['if', 'else', 'elsif', 'unless'],
                  \ ['eval', 'die', 'warn'],
                  \ ['use', 'require'],
                  \ ['shift', 'pop'],
                  \ ['bless', 'overload'],
                  \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin =
                  \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
