let b:CtrlXA_Toggles = [
      \ ['let', 'mut'],
      \ ['i32', 'f32', 'str', 'bool', 'char', 'u8', 'i16', 'i64', 'f64'],
      \ ['static', 'const', 'final'],
      \ ['for', 'while', 'loop'],
      \ ['break', 'continue'],
      \ ['if', 'else', 'match'],
      \ ['Result', 'Option', 'panic', 'unwrap'],
      \ ['struct', 'enum'],
      \ ['self', 'super'],
      \ ['impl', 'trait'],
      \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
let b:undo_ftplugin =
      \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet! b:CtrlXA_Toggles' : 'unlet! b:CtrlXA_Toggles'
