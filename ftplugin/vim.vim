let b:CtrlXA_Toggles = [
      \ ['if', 'elseif', 'else', 'endif'],
      \ ['while', 'for', 'endwhile', 'endfor'],
      \ ['continue', 'break'],
      \ ['try', 'endtry', 'catch', 'finally', 'throw'],
      \ ['silent', 'echo', 'echomsg', 'echoerr'], ['set', 'setlocal', 'setglobal'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'elseif', 'endif'],
      \ ['let', 'unlet'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
