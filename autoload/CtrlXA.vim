function! CtrlXA#CtrlXA(CtrlAX) abort
  " use vim-repeat to ensure @. = <C-A/X>
  let repeat = ":silent! call repeat#set('" . a:CtrlAX . "','" . v:count . "')\<cr>"

  " first try matching cWORD, then cword
  let cWORD = expand('<cWORD>')
  let cword = expand('<cword>')

  for toggles in get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    let len = len(toggles)
    let i = 0
    while i < len
      let current_toggle = toggles[i]

      if a:CtrlAX is# "\<C-A>"
        let next_i = i + 1
        if next_i == len | let next_i = 0 | endif
      else
        let next_i = i - 1
        if next_i == -1 | let next_i = len-1 | endif
      endif
      let next_toggle = toggles[next_i]

      if cWORD is# current_toggle
        return ":\<c-u>call search('\\S','cz', line('.'))\<cr>" .  "\"_ciW" . next_toggle . "\<esc>" . repeat
      endif

      if cword is# current_toggle
        return ":\<c-u>call search('[[:xdigit:][:keyword:]]','cz', line('.'))\<cr>" . "\"_ciw" . next_toggle . "\<esc>" . repeat
      endif

      let i = i+1
    endwhile
  endfor

  return a:CtrlAX . repeat
endfunction
