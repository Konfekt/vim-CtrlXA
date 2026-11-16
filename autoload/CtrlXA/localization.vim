" Add the keyword cycles of the (spell) languages in a:spelllang, read from
" autoload/CtrlXA/langs/{lang}.vim in 'runtimepath', to b:CtrlXA_Toggles.
function! CtrlXA#localization#init(spelllang) abort
  " skip if the cycles in the buffer are already localized for a:spelllang
  let state = get(b:, 'CtrlXA_localized', [])
  if !empty(state) && state[0] ==# a:spelllang
        \ && exists('b:CtrlXA_Toggles') && state[1] is b:CtrlXA_Toggles
    return
  endif

  " languages without region, such as 'de' for 'de_ch'; English is the default
  let langs = []
  for lang in split(a:spelllang, ',')
    let lang = matchstr(lang, '^\a\a')
    if !empty(lang) && lang !=# 'en' && index(langs, lang) < 0
      call add(langs, lang)
    endif
  endfor

  for lang in langs
    execute 'runtime! autoload/CtrlXA/langs/' . lang . '.vim'
  endfor

  " drop cycles added more than once, for example when 'spelllang' changes back
  " and forth; as the first matching cycle is used, this keeps the behavior
  if exists('b:CtrlXA_Toggles')
    let toggles = []
    for cycle in b:CtrlXA_Toggles
      if index(toggles, cycle) < 0
        call add(toggles, cycle)
      endif
    endfor
    let b:CtrlXA_Toggles = toggles
    let b:CtrlXA_localized = [a:spelllang, b:CtrlXA_Toggles]
  endif
endfunction
