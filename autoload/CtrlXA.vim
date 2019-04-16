function! CtrlXA#CtrlXA(key) abort
  " use vim-repeat to ensure @. = <C-A/X>
  let repeat = ":silent! call repeat#set('" . a:key . "','" . v:count . "')\<cr>"

  let increment = v:count1 * (a:key is# "\<C-A>" ? 1 : -1)

  " first try matching cWORD, then cword
  let cWORD = expand('<cWORD>')
  let cword = expand('<cword>')

  for toggles in get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    let len = len(toggles)
    let i = 0
    while i < len
      let current_toggle = toggles[i]

      if cWORD is# current_toggle
        let next_toggle = toggles[(i + increment) % len]

        return ":\<c-u>call search('\\S','cz', line('.'))\<cr>" .  "\"_ciW" . next_toggle . "\<esc>" . repeat
      endif

      if cword is# current_toggle
        let next_toggle = toggles[(i + increment) % len]

        return ":\<c-u>call search('[[:xdigit:][:keyword:]]','cz', line('.'))\<cr>" . "\"_ciw" . next_toggle . "\<esc>" . repeat
      endif

      let i = i+1
    endwhile
  endfor

  return a:key . repeat
endfunction
