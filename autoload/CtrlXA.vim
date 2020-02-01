function! CtrlXA#SingleInc(key) abort
  " use vim-repeat to ensure @. = <C-A/X>
  let repeat = ":silent! call repeat#set('" . a:key . "','" . v:count . "')\<cr>"

  let increment = v:count1 * (a:key is? "\<C-A>" ? 1 : -1)

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

function! CtrlXA#MultipleInc(key)
  " increment current line as in normal mode to make '< and '> work
  let cnt = v:count1
  exe "normal " . cnt . a:key
  if line("'<") < line("'>")
    " increment all subsequent lines
    exe "'<+1,'>normal " . cnt . a:key
  endif

  silent! call repeat#set(a:key , cnt)
endfunction

" Adapted from https://github.com/triglav/vim-visual-increment/blob/f34abd2df6dfd29340fd0b14ad651949c8265a7f/plugin/visual-increment.vim
function! CtrlXA#SuccessiveInc(key)
  let start_column = col("'<")
  let start_row = line("'<")
  let end_row = line("'>")

  " increment current line as in normal mode to make '< and '> work
  let cnt = v:count1
  exe "normal " . cnt . a:key
  " increment each following line i by i * cnt
  let i = cnt
  while line('.') < end_row
    " move to the next line, ...
    call setpos('.', [0, line('.') + 1, start_column, 0])
    " ... but skip it if shorter than cursor column
    if start_column < col('$')
      let i += cnt 
      " increment the current line i by i * cnt
      exe "normal " . i . a:key
    end
  endwhile

  silent! call repeat#set(
        \ (a:key is? "\<Plug>(CtrlXA-CtrlA)" ? "\<Plug>(CtrlXA-gCtrlA)" : "\<Plug>(CtrlXA-gCtrlX)"), cnt)
endfunction
