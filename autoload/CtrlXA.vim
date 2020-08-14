function! CtrlXA#SingleInc(key) abort
  let increment = v:count1 * (a:key is? "\<C-A>" ? 1 : -1)

  " to repeat toggles, only jump the cursor back if before end of new word
  let jump_back = ":if col('.') > col(\"'`\") | exe 'normal! g``' | endif\<cr>"
  " use vim-repeat to ensure @. = <C-A/X>
  let repeat = ":silent! call repeat#set('" . a:key . "','" . v:count . "')\<cr>"

  let cword = expand('<cword>')
  let cWORD = expand('<cWORD>')

  let toggles_list = get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
  let line_length = len(getline('.'))
  let cur_col = getcurpos()[2]
  let cur_char = getline('.')[cur_col - 1]
  let min_col = line_length + 1

  let i = 0
  while i < len(toggles_list)
    let toggles = toggles_list[i]
    let j = 0
    while j < len(toggles)
      let toggle = toggles[j]
      let is_word = s:is_word(toggle)

      if (!is_word && (cWORD is# toggle) && (cur_char =~# '\S')) || (is_word && (cword is# toggle) && (cur_char =~# '\k'))
        let min_col = cur_col
        let min_i   = i
        let min_j   = j
      endif

      let toggle_regex = '\V\C' . 
            \ (is_word ?
            \ '\<\zs' . escape(toggle, '\') . '\ze\>' :
            \ '\(\s\|\^\)\zs' . escape(toggle, '\') . '\ze\(\s\|\$\)')
      let col = searchpos(toggle_regex, 'czn', line('.'))[1]
      if col > 0 && col < min_col
        let min_col = col
        let min_i   = i
        let min_j   = j
      endif

      if min_col == cur_col
        break
      endif

      let j = j+1
    endwhile
    if min_col == cur_col
      break
    endif

    let i = i+1
  endwhile

  let num_regex = '\v<(\d+' .
        \ (&nrformats =~# '\<bin\>' ? '|0[bB][01]+' : '') .
        \ (&nrformats =~# '\<hex\>' ? '|0[xX]\x+' : '') .
        \ (&nrformats =~# '\<octal\>' ? '|0\o+' : '') .
        \ ')>'

  let word_min_col = min_col
  if min_col > cur_col 
    if (cword =~# '\m^' . num_regex . '\m$') && cur_char =~# '\k'
      let min_col = cur_col
    else
      let col = searchpos(num_regex, 'czn', line('.'))[1]
      if col > 0 && col < min_col
        let min_col = col
      endif
    endif
  endif

  if min_col <= line_length
    if min_col == word_min_col
      let toggles = toggles_list[min_i]
      let len = len(toggles)
      let current_toggle = toggles[min_j]
      let next_toggle = toggles[(min_j + increment) % len]
      let is_word = s:is_word(current_toggle)

      let regex = '\V\C' . 
            \ (is_word ?
            \ '\<\zs' . escape(current_toggle, '\') . '\ze\>' :
            \ '\(\s\|\^\)\zs' . escape(current_toggle, '\') . '\ze\(\s\|\$\)')
      let cmd = "\"_c" . (is_word ? "iw" : "iW") . next_toggle . "\<esc>"
    else
      let regex = num_regex
      let cmd = v:count . a:key
    endif

    return  "m`viwo\<esc>" .
          \ ":\<c-u>call search(" . "'" . regex  . "'" . ",'cz', line('.'))\<cr>" .
          \ cmd .
          \ jump_back . repeat
  else
    return a:key . repeat
  endif
endfunction

function! s:is_word(s) abort
  return a:s =~# '\v^\k+$'
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
