function! CtrlXA#CtrlXA(CtrlAX) abort
  " uses vim-repeat to ensure @. = <C-A/X>
  let word = expand('<cword>')
  let repeat = ":silent! call repeat#set('" . a:CtrlAX . "','" . v:count . "')\<cr>"

  for toggle in get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    let len = len(toggle)
    let i = 0
    while i < len
      if word is# toggle[i]
        return ":\<c-u>call search('\\v(\\k|\\x)','cz')\<cr>" . "\"_ciw" . toggle[ (i + 1) % len] . "\<esc>" . repeat
      endif
      let i = i+1
    endwhile
  endfor

  return a:CtrlAX . repeat
endfunction
