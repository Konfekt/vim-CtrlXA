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
  let cursor_col = col('.')
  " whole (possibly multibyte) characters at, before and after the cursor
  let cursor_char = matchstr(line, '\%' . cursor_col . 'c.')
  let cursor_char_prev = matchstr(line, '.\%' . cursor_col . 'c')
  let cursor_char_next = matchstr(line, '\%>' . cursor_col . 'c.')

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
    return a:key . waskeyword_cmd . repeat_cmd
  else
    " Search for valid toggles in the current line
    let min_col = line_length + 1
    let toggles_lists = get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
    let i = 0
    for toggles in toggles_lists
      let j = 0
      for toggle in toggles
        let is_word = s:is_word(toggle)

        if  (!is_word && (cWORD is# toggle) && (cursor_char =~# '\S')) ||
          \ ( is_word && (cword is# toggle) && (cursor_char =~# '\k'))
          let min_col = cursor_col
          let current_index = [i, j]
        else
          let col = searchpos(s:toggle_regex(toggle, is_word), 'czn', line('.'))[1]
          if col > 0 && col < min_col
            let min_col = col
            let current_index = [i, j]
          endif
        endif

        if min_col == cursor_col
          break
        endif
        let j += 1
      endfor
      if min_col == cursor_col
        break
      endif
      let i += 1
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
      let cmd = '"_c' . (is_word ? 'iw' : 'iW') . next_toggle . "\<esc>"
      " Construct the command to jump to the toggle; string() quotes the regex safely
      let search_cmd = ":\<c-u>call search(" . string(s:toggle_regex(current_toggle, is_word)) . ", 'cz', line('.'))\<cr>"
      " Return the toggle command sequence including cleanup and repeat
      return  jump_to_beginning_cmd . search_cmd . cmd .
            \ waskeyword_cmd . jump_to_mark_cmd . repeat_cmd
    else
      " If no toggle found, fall back to Vim's increment/decrement
      return a:key . waskeyword_cmd . repeat_cmd
    endif
  endif
endfunction

function! s:is_word(s) abort
  return a:s =~# '\v^\k+$'
endfunction

" Match a word toggle as a whole keyword and any other toggle as a whole WORD
function! s:toggle_regex(toggle, is_word) abort
  let toggle = escape(a:toggle, '\')
  return '\V\C' . (a:is_word ?
        \ '\<\zs' . toggle . '\ze\>' :
        \ '\%(\s\|\^\)\zs' . toggle . '\ze\%(\s\|\$\)')
endfunction

function! CtrlXA#MultipleInc(key, successive) abort
  " Get the start and end lines and columns of the visual selection.
  let [start_row, end_row] = [line("'<"), line("'>")]
  let [start_column, end_column] = [col("'<"), col("'>")]

  " Swap start and end columns if selection is backwards in block mode.
  let mode = visualmode()
  let is_blockmode = mode ==# "\<C-v>"
  if is_blockmode && start_column > end_column
    let [start_column, end_column] = [end_column, start_column]
  endif

  " Loop through the non-blank lines in the visual selection.
  let [inc, cnt] = [v:count1, v:count1]
  let tick = b:changedtick
  let column = start_column
  let lnum = nextnonblank(start_row)
  while lnum > 0 && lnum <= end_row
    call cursor(lnum, column)
    " In block mode, skip lines that end before the block.
    if !is_blockmode || column < col('$')
      " Join this change with the previous ones into a single undo block.
      if b:changedtick != tick
        silent! undojoin
      endif
      let ct = b:changedtick
      " Execute the increment/decrement command.
      execute 'normal ' . cnt . a:key
      " If successive incrementing is enabled and a change occurred, increase the count.
      if a:successive && b:changedtick > ct
        let cnt += inc
      endif
    endif
    " As for Vim's v_CTRL-A, a characterwise selection covers all of the following lines.
    if mode ==# 'v'
      let column = 1
    endif
    let lnum = nextnonblank(lnum + 1)
  endwhile

  " Set up the '.' command via vim-repeat plugin
  let repeat_key = a:successive ?
        \ (a:key is? "\<Plug>(CtrlXA-CtrlA)" ? "\<Plug>(CtrlXA-gCtrlA)" : "\<Plug>(CtrlXA-gCtrlX)") :
        \ a:key
  silent! call repeat#set(repeat_key, v:count)
endfunction
