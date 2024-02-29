function! CtrlXA#SingleInc(key) abort
  " Determine the increment or decrement (1 for Ctrl-A, -1 for Ctrl-X), and apply any [count]
  let increment = v:count1 * (a:key is? "\<C-A>" ? 1 : -1)

  " Commands to move the cursor to the beginning of the word or to the previous toggle
  let jump_to_beginning_cmd = "m`viwo\<esc>"
  let jump_to_mark_cmd = g:CtrlXA_move ? '' : ":if col('.') > col(\"'`\") | exe 'normal! g``' | endif\<cr>"

  " Set up the '.' command via vim-repeat plugin
  let repeat_key = a:key is? "\<C-A>" ? '\<Plug>(CtrlXA-CtrlA)' : '\<Plug>(CtrlXA-CtrlX)'
  let repeat_cmd = ':silent! call repeat#set("' . repeat_key . '",' . v:count . "\")\<cr>"

  " Save and temporarily override the 'iskeyword' setting if it's customized
  let b:CtrlXA_waskeyword = &l:iskeyword
  let &l:iskeyword = get(b:, 'CtrlXA_iskeyword', g:CtrlXA_iskeyword)
  let waskeyword_cmd = ":\<c-u>let &l:iskeyword=b:CtrlXA_waskeyword | unlet b:CtrlXA_waskeyword\<cr>"

  " Capture the current word and WORD under the cursor
  let cword = expand('<cword>')
  let cWORD = expand('<cWORD>')

  " Get the current line and the cursor column, as well as surrounding characters
  let line = getline('.')
  let line_length = len(line)
  let cursor_col = getcurpos()[2]
  let cursor_char = line[cursor_col - 1]
  let cursor_char_prev = cursor_col > 1 ? line[cursor_col-2] : ''
  let cursor_char_next = cursor_col <= line_length ? line[cursor_col] : ''

  " Compile a regex pattern to match numbers, considering binary and hex formats
  let num_regex = '\v<%(\d+' .
        \ (&nrformats =~# '\<bin\>' ? '|0[bB][01]+' : '') .
        \ (&nrformats =~# '\<hex\>' ? '|0[xX]\x+' : '') .
        \ ')>'

  " Determine if the cursor is over a number or toggle
  if cword =~# '\v^' . num_regex . '\v$' && cursor_char =~# '\k'
        \ || cursor_char =~# '\d' || (cursor_char ==# '-') && (cursor_char_next =~# '\d')
        \ || (&nrformats =~# '\<bin\>') && (cursor_char =~# '[bB]' && cursor_char_next =~# '[01]' && cursor_char_prev ==# '0')
        \ || &nrformats =~# '\<hex\>' && (cursor_char =~# '[xX]' && cursor_char_next =~# '\x' && cursor_char_prev ==# '0')
    " Construct the increment/decrement command string for repeat
    let cmd = a:key . waskeyword_cmd . repeat_cmd
    return cmd
  else
    " Search for valid toggles in the current line
    let min_col = line_length + 1
    let toggles_lists = get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    for [i, toggles] in items(toggles_lists)
      for [j, toggle] in items(toggles)
        let is_word = s:is_word(toggle)

        if  (!is_word && (cWORD is# toggle) && (cursor_char =~# '\S')) ||
          \ ( is_word && (cword is# toggle) && (cursor_char =~# '\k'))
          let min_col = cursor_col
          let current_index = [i, j]
        else
          let toggle_regex = '\V\C' . (is_word ?
                \ '\<\zs' . escape(toggle, '\') . '\ze\>' :
                \ '\%(\s\|\^\)\zs' . escape(toggle, '\') . '\ze\%(\s\|\$\)')
          let col = searchpos(toggle_regex, 'czn', line('.'))[1]
          if col > 0 && col < min_col
            let min_col = col
            let current_index = [i, j]
          endif
        endif

        if min_col == cursor_col
          break
        endif
      endfor
      if min_col == cursor_col
        break
      endif
    endfor

    " If a toggle is found, replace it
    if exists('current_index')
      let [min_i, min_j] = current_index
      let toggles = toggles_lists[min_i]
      let len = len(toggles)
      let current_toggle = toggles[min_j]
      let next_toggle = toggles[(min_j + increment) % len]
      let is_word = s:is_word(current_toggle)

      " Construct the command to replace the toggle
      let cmd = "\"_c" . (is_word ? "iw" : "iW") . next_toggle . "\<esc>"
      " Build a regex pattern for toggling a word
      let toggle_regex = '\V\C' .
            \ (is_word ?
            \ '\<\zs' . escape(current_toggle, '\') . '\ze\>' :
            \ '\%(\s\|\^\)\zs' . escape(current_toggle, '\') . '\ze\%(\s\|\$\)')
      " Construct the search command using the built regex
      let search_cmd = ":\<c-u>call search(" . "'" . toggle_regex . "'" . ",'cz', line('.'))\<cr>"
      " Return the toggle command sequence including cleanup and repeat
      return  jump_to_beginning_cmd . search_cmd . cmd .
            \ waskeyword_cmd . jump_to_mark_cmd . repeat_cmd
    else
      " If no toggle found, simply increment/decrement the character under cursor
      let cmd = a:key . waskeyword_cmd . repeat_cmd
      return cmd
    endif
  endif
endfunction

function! s:is_word(s) abort
  return a:s =~# '\v^\k+$'
endfunction

function! CtrlXA#MultipleInc(key, successive) abort
  " Get the start and end lines and columns of the visual selection.
  let [start_row, end_row] = [line("'<"), line("'>")]
  let [start_column, end_column] = [col("'<"), col("'>")]

  " Swap start and end columns if selection is backwards in block mode.
  let is_blockmode = visualmode() ==# "\<C-v>"
  if is_blockmode && start_column > end_column
    let [start_column, end_column] = [end_column, start_column]
  endif

  " Move cursor to the first non-blank character of the start line.
  call setpos('.', [0, nextnonblank(start_row), start_column, 0])

  " Loop through the lines in the visual selection.
  let [inc, cnt] = [v:count1, v:count1]
  while line('.') <= end_row
    " Check if we're not in block mode or if the column is before the end of the line.
    if !is_blockmode || start_column < col('$')
      " Store the current change count to detect changes.
      let ct = b:changedtick
      " Execute the increment/decrement command.
      execute "normal " . cnt . a:key
      " Join this change with the previous undo block.
      undojoin
      " If successive incrementing is enabled and a change occurred, increase the count.
      if a:successive && b:changedtick > ct
        let cnt += inc
      endif
    endif

    " Find the next non-blank line after the current line.
    let next_line = nextnonblank(line('.') + 1)
    " Break the loop if there are no more lines or if we've passed the last line.
    if next_line == 0 || next_line > line('$')
      break
    endif
    " Move cursor to the first non-blank character of the next line.
    call setpos('.', [0, next_line, start_column, 0])
  endwhile

  " Set up the '.' command via vim-repeat plugin
  let repeat_key = a:successive ?
        \ (a:key is? "\<Plug>(CtrlXA-CtrlA)" ? "\<Plug>(CtrlXA-gCtrlA)" : "\<Plug>(CtrlXA-gCtrlX)") :
        \ a:key
  silent! call repeat#set(repeat_key, v:count)
endfunction
