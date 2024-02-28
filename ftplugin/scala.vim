let b:CtrlXA_Toggles = [
      \ ['def', 'val', 'var', 'type', 'trait', 'object', 'class'],
      \ ['lazy', 'sealed', 'implicit', 'final'],
      \ ['for', 'while', 'do'],
      \ ['return', 'throw'],
      \ ['if', 'else', 'match'],
      \ ['try', 'catch', 'finally', 'throw'],
      \ ['private', 'protected'],
      \ ['class', 'trait'],
      \ ['this', 'super'],
      \ ['extends', 'with'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin = 
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
