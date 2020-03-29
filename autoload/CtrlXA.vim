function s:standardize(toggles) abort
  let std_toggles = []
  for toggles in a:toggles
    let c = 0
    for toggle in toggles
      let c += (toggle =~# '[[:lower:][:upper:]]')
    endfor
    if c == 0
      let std_toggles += [toggles]
      continue
    endif

    let lower_toggles = []
    for toggle in toggles
      let lower_toggles += [tolower(toggle)]
    endfor
    let std_toggles += [lower_toggles]

    let upper_toggles = []
    for toggle in toggles
      let upper_toggles += [toupper(toggle)]
    endfor
    let std_toggles += [upper_toggles]
    let title_toggles = []
    for toggle in toggles
      let title_toggles += [toupper(toggle[0]) . tolower(toggle[1:-1])]
    endfor
    let std_toggles += [title_toggles]
  endfor

  return std_toggles
endfunction

let g:CtrlXA_Toggles = s:standardize(g:CtrlXA_Toggles)
augroup CtrlXA
  autocmd!
  autocmd BufWinEnter * if exists('b:CtrlXA_Toggles') | let b:CtrlXA_Toggles = s:standardize(b:CtrlXA_Toggles) | endif
augroup end
silent doautoall CtrlXA BufWinEnter

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

        return "m`:\<c-u>call search('\\S','cz', line('.'))\<cr>" .  "\"_ciW" . next_toggle . "\<esc>g``" . repeat
      endif

      if cword is# current_toggle
        let next_toggle = toggles[(i + increment) % len]

        return "m`:\<c-u>call search('[[:xdigit:][:keyword:]]','cz', line('.'))\<cr>" . "\"_ciw" . next_toggle . "\<esc>g``" . repeat
      endif

      let i = i+1
    endwhile
  endfor

  return a:key . repeat
endfunction

function! CtrlXA#MultipleInc(key) abort
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
function! CtrlXA#SuccessiveInc(key) abort
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
    " skip if selection is beyond cursor column or blank
    let selection = (is_blockmode ? getline('.')[start_column-1 : end_column-1] : getline('.'))
    if (!is_blockmode || start_column < col('$')) && selection =~# '\S'
      " increment only if some keyword was incremented
      let ct = b:changedtick
      exe "normal " . i . a:key
      if b:changedtick > ct
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
        \ (a:key is? "\<Plug>(CtrlXA-CtrlA)" ? "\<Plug>(CtrlXA-gCtrlA)" : "\<Plug>(CtrlXA-gCtrlX)"), cnt)
endfunction
