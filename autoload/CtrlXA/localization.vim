let s:script_dir = expand('<sfile>:p:h')

let s:vimfiles_dir = split(&runtimepath, ',')[0]
if !isdirectory(s:vimfiles_dir)
  if has('unix')
    let s:vimfiles_dir = expand('$HOME') . '/.vim'
  else
    let s:vimfiles_dir = expand('$HOME') . '\vimfiles'
  endif
endif

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
    let lang_file = s:vimfiles_dir . '/autoload/CtrlXA/langs/' . lang . '.vim'
    if filereadable(lang_file)
      exe 'source ' . lang_file
    endif
  endfor
endf
