let s:script_dir = expand('<sfile>:p:h')

function! CtrlXA#localization#init(spelllang) abort
  if matchstr(a:spelllang, '^\a\a') ==# 'en'
    return
  endif

  " split and remove regions from spelllangs
  let langs = split(a:spelllang, ',')
  call map(langs, "matchstr(v:val, '^\\a\\a')")

  for lang in langs
    let lang_file = s:script_dir . '/langs/' . lang . '.vim'
    if filereadable(lang_file)
      exe 'source ' . lang_file
    endif
  endfor
endf
