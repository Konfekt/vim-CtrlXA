function! CtrlXA#SingleInc(key) abort
  " use vim-repeat to ensure @. = <C-A/X>
  let repeat = ":silent! call repeat#set('" . a:key . "','" . v:count . "')\<cr>"
  " only jump the cursor back if it would leave it before the end of the new
  " word to allow repeat toggles.
  let jump_back = ":if col('.') > col(\"'`\") | exe 'normal! g``' | endif\<cr>"

  let increment = v:count1 * (a:key is? "\<C-A>" ? 1 : -1)

  let cWORD = expand('<cWORD>')
  let cword = expand('<cword>')

  for toggles in get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    let len = len(toggles)
    let i = 0
    while i < len
      let current_toggle = toggles[i]

      if cWORD is# current_toggle || search('\V\C\s' . escape(current_toggle, '\') . '\s', 'czn', line('.')) > 0
        let next_toggle = toggles[(i + increment) % len]

        return  "m`viWo\<esc>" .
              \ ":\<c-u>call search(" . "'" . "\\V\\C\\(\\s\\|\\^\\)\\zs" . escape(escape(current_toggle, '\'),'\') . "\\ze\\(\\s\\|\\$\\)" . "'" . ",'cz', line('.'))\<cr>" .
              \ "\"_ciW" . next_toggle . "\<esc>" .
              \ jump_back . repeat
      endif

      if cword is# current_toggle || search('\V\C\<' . escape(current_toggle, '\') . '\>', 'czn', line('.')) > 0
        let next_toggle = toggles[(i + increment) % len]

        return  "m`viwo\<esc>" .
              \ ":\<c-u>call search(" . "'" . "\\V\\C\\<\\zs" . escape(escape(current_toggle, '\'),'\') . "\\ze\\>" . "'" . ",'cz', line('.'))\<cr>" .
              \ "\"_ciw" . next_toggle . "\<esc>" .
              \ jump_back . repeat
      endif

      let i = i+1
    endwhile
  endfor

  return a:key . repeat
endfunction

" Adapted from https://github.com/triglav/vim-visual-increment/blob/f34abd2df6dfd29340fd0b14ad651949c8265a7f/plugin/visual-increment.vim
function! CtrlXA#MultipleInc(key, successive) abort
  let last_line = line('$')

  let start_row = line("'<")
  let end_row = line("'>")
  let start_column = col("'<")
  let end_column = col("'>")

  let is_blockmode = (visualmode() ==# "\<C-v>")
  if is_blockmode && start_column > end_column
    let start_column =  col("'>")
    let end_column =  col("'<")
  endif

  let cnt = v:count1
  let i = cnt
  " start at begin of selection
  call setpos('.', [0, nextnonblank(start_row), start_column, 0])
  while line('.') <= end_row
    " skip if selection is beyond cursor column
    let selection = (is_blockmode ? getline('.')[start_column-1 : end_column-1] : getline('.'))
    if !is_blockmode || start_column < col('$')
      " increment only if some keyword was incremented
      let ct = b:changedtick
      exe "normal " . i . a:key
      if a:successive && b:changedtick > ct
        let i += cnt 
      endif
    endif
    " move to the next line
    let next_line = line('.') + 1
    if next_line > last_line
      break
    endif
    let next_line = nextnonblank(next_line)
    if next_line == 0
      break
    endif
    call setpos('.', [0, next_line, start_column, 0])
  endwhile

  silent! call repeat#set(
        \ (a:succesive ? 
        \ (a:key is? "\<Plug>(CtrlXA-CtrlA)" ? \<Plug>(CtrlXA-gCtrlA)" : "\<Plug>(CtrlXA-gCtrlX)") :
        \ a:key),
        \ cnt)
endfunction
