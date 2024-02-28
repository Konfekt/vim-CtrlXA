let b:CtrlXA_Toggles = [
      \ ['int', 'float', 'auto', 'bool', 'char', 'double', 'long', 'short',  'wchar_t', 'char16_t', 'char32_t', 'int8_t', 'int16_t', 'int32_t', 'int64_t', 'uint8_t', 'uint16_t', 'uint32_t', 'uint64_t'],
      \ ['unsigned', 'signed',],
      \ ['for', 'while', 'do'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'switch'],
      \ ['try', 'catch', 'throw'],
      \ ['class', 'struct', 'template'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
