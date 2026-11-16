" Headless tests for vim-CtrlXA. Run with test/run.sh.
scriptencoding utf-8
" Never prompt to download spell files.
let g:loaded_spellfile_plugin = 1
silent! autocmd! nvim.spellfile
let s:root = fnamemodify(expand('<sfile>:p'), ':h:h')
let &runtimepath = s:root . ',' . &runtimepath . ',' . s:root . '/after'
filetype plugin on
for s:f in glob(s:root . '/plugin/**/*.vim', 0, 1)
  execute 'source' fnameescape(s:f)
endfor

function! s:buf(lines) abort
  enew!
  setlocal nospell spelllang=en
  call setline(1, a:lines)
  call cursor(1, 1)
endfunction

function! s:keys(keys) abort
  execute 'normal ' . a:keys
endfunction

function! Test_iskeyword_default() abort
  call assert_notmatch('\v(^|,)_(,|$)', g:CtrlXA_iskeyword)
endfunction

function! Test_toggle_word() abort
  call s:buf(['let flag = true'])
  call s:keys("\<C-A>")
  call assert_equal('let flag = false', getline(1))
  call s:keys("\<C-A>")
  call assert_equal('let flag = true', getline(1))
  " cursor stays put unless g:CtrlXA_move
  call assert_equal(1, col('.'))
endfunction

function! Test_toggle_count_and_decrement() abort
  call s:buf(['monday'])
  call s:keys("3\<C-A>")
  call assert_equal('thursday', getline(1))
  call s:keys("\<C-X>")
  call assert_equal('wednesday', getline(1))
  call s:keys("10\<C-X>")
  call assert_equal('sunday', getline(1))
endfunction

function! Test_number_still_increments() abort
  call s:buf(['val = 41'])
  call s:keys("\<C-A>")
  call assert_equal('val = 42', getline(1))
  call s:buf(['-1'])
  call s:keys("\<C-A>")
  call assert_equal('0', getline(1))
endfunction

function! Test_nonword_toggle() abort
  call s:buf(['a && b'])
  call cursor(1, 3)
  call s:keys("\<C-A>")
  call assert_equal('a || b', getline(1))
endfunction

function! Test_toggle_with_quote() abort
  let b:CtrlXA_Toggles = [["don't", 'do']]
  call setline(1, "x don't")
  call cursor(1, 1)
  call s:keys("\<C-A>")
  call assert_equal('x do', getline(1))
  unlet b:CtrlXA_Toggles
endfunction

function! Test_multibyte_toggle() abort
  call s:buf(['quarta sábado'])
  let b:CtrlXA_Toggles = [['sexta', 'sábado', 'domingo']]
  call cursor(1, 9)
  call s:keys("\<C-A>")
  call assert_equal('quarta domingo', getline(1))
  unlet b:CtrlXA_Toggles
endfunction

function! Test_visual_linewise() abort
  call s:buf(['1', '', 'yes', 'on'])
  call s:keys("VG\<C-A>")
  call assert_equal(['2', '', 'no', 'off'], getline(1, '$'))
  call s:buf(['1', '1', '1'])
  call s:keys("VGg\<C-A>")
  call assert_equal(['2', '3', '4'], getline(1, '$'))
endfunction

function! Test_visual_charwise_multiline() abort
  " Like Vim's v_CTRL-A, lines after the first start at column 1.
  call s:buf(['xxxx 1', '1 xxxxx 1'])
  call cursor(1, 5)
  call s:keys("vj\<C-A>")
  call assert_equal(['xxxx 2', '2 xxxxx 1'], getline(1, '$'))
endfunction

function! Test_visual_after_undo() abort
  call s:buf(['x', 'true'])
  let &undolevels = &undolevels
  call s:keys("j\<C-A>")
  silent undo
  call s:keys("ggVG\<C-A>")
  call assert_equal(['y', 'false'], getline(1, '$'))
endfunction

function! Test_ftplugin_gitrebase() abort
  " Vim's own gitrebase ftplugin maps CTRL-A and CTRL-X buffer-locally
  let g:no_gitrebase_maps = 1
  enew!
  setfiletype gitrebase
  call setline(1, 'pick 123 msg')
  call s:keys("\<C-A>")
  call assert_equal('fixup 123 msg', getline(1))
  set filetype=
  call assert_false(exists('b:CtrlXA_Toggles'))
endfunction

function! Test_ftplugin_tex_big() abort
  enew!
  setfiletype tex
  call setline(1, '\big(')
  call cursor(1, 2)
  call s:keys("\<C-A>")
  call assert_equal('\Big(', getline(1))
  call s:keys("\<C-A>")
  call assert_equal('\bigg(', getline(1))
endfunction

function! Test_lang_files_parse() abort
  for f in glob(s:root . '/autoload/CtrlXA/langs/*.vim', 0, 1)
    enew!
    unlet! b:CtrlXA_Toggles
    try
      execute 'source' fnameescape(f)
    catch
      call assert_report(f . ': ' . v:exception)
      continue
    endtry
    for l in get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)[len(g:CtrlXA_Toggles) :]
      call assert_equal(len(l), len(uniq(sort(copy(l)))), f . ': duplicate in ' . string(l))
    endfor
  endfor
endfunction

function! Test_localization_idempotent() abort
  call s:buf(['Montag'])
  setlocal spelllang=de spell
  doautocmd BufWinEnter
  let n = len(b:CtrlXA_Toggles)
  call assert_true(n > len(g:CtrlXA_Toggles))
  doautocmd BufWinEnter
  setlocal nospell
  setlocal spell
  doautocmd BufWinEnter
  call assert_equal(n, len(b:CtrlXA_Toggles))
  call s:keys("\<C-A>")
  call assert_equal('Dienstag', getline(1))
endfunction

function! Test_localization_secondary_lang() abort
  call s:buf(['Montag'])
  setlocal spelllang=en_us,de spell
  call CtrlXA#localization#init(&spelllang)
  call s:keys("\<C-A>")
  call assert_equal('Dienstag', getline(1))
endfunction

function! s:reload_plugin() abort
  unlet! g:loaded_CtrlXA
  execute 'source' fnameescape(s:root . '/plugin/CtrlXA.vim')
endfunction

function! Test_iskeyword_trailing_underscore() abort
  let save = [&g:iskeyword, g:CtrlXA_iskeyword]
  set iskeyword=@,48-57,_
  unlet g:CtrlXA_iskeyword
  call s:reload_plugin()
  call assert_equal('@,48-57', g:CtrlXA_iskeyword)
  let [&g:iskeyword, g:CtrlXA_iskeyword] = save
endfunction

function! Test_user_mapping_kept() abort
  xnoremap g<C-A> <Nop>
  call s:reload_plugin()
  call assert_equal('<Nop>', maparg('g<C-A>', 'x'))
  xunmap g<C-A>
  call s:reload_plugin()
  call assert_match('CtrlXA-gCtrlA', maparg('g<C-A>', 'x'))
endfunction

function! Test_visual_single_undo_block() abort
  call s:buf(['keep', 'x', '1'])
  let &undolevels = &undolevels
  call setline(1, 'kept')
  let &undolevels = &undolevels
  call s:keys("ggVG\<C-A>")
  call assert_equal(['kept', 'y', '2'], getline(1, '$'))
  silent undo
  call assert_equal(['kept', 'x', '1'], getline(1, '$'))
endfunction

function! Test_localization_autocmd_not_duplicated() abort
  call s:buf(['x'])
  doautocmd BufRead
  doautocmd BufRead
  let lines = filter(split(execute('autocmd CtrlXA_Localization BufWinEnter <buffer>'), "\n"), 'v:val =~# "localization"')
  call assert_equal(1, len(lines))
endfunction

function! Test_iskeyword_restored_without_toggle() abort
  " Vim's CTRL-A fails without a number, which aborts the rest of the mapping
  call s:buf(['qqq zzzq'])
  setlocal iskeyword=@,48-57,_,-
  call s:keys("\<C-A>")
  call s:keys("\<C-X>")
  call assert_equal('@,48-57,_,-', &l:iskeyword)
  call assert_false(exists('b:CtrlXA_waskeyword'))
  call s:keys("VG\<C-A>")
  call assert_equal('@,48-57,_,-', &l:iskeyword)
endfunction

function! Test_visual_marks_kept() abort
  call s:buf(['true 1', 'yes'])
  call s:keys("Vj\<Esc>gg\<C-A>")
  call assert_equal('false 1', getline(1))
  call assert_equal([1, 2], [line("'<"), line("'>")])
  " gv reselects the lines after a visual CTRL-A on toggles
  call s:keys("gvg\<C-A>gvd")
  call assert_equal([''], getline(1, '$'))
endfunction

function! Test_cursor_position() abort
  call s:buf(['val = true'])
  call s:keys("\<C-A>")
  call assert_equal(['val = false', 1], [getline(1), col('.')])
  call s:buf(['monday'])
  call cursor(1, 4)
  call s:keys("\<C-A>")
  call assert_equal(['tuesday', 4], [getline(1), col('.')])
  call s:buf(['false'])
  call cursor(1, 5)
  call s:keys("\<C-A>")
  call assert_equal(['true', 4], [getline(1), col('.')])
  let g:CtrlXA_move = 1
  try
    call s:buf(['val = true y'])
    call s:keys("\<C-A>")
    call assert_equal(['val = false y', 11], [getline(1), col('.')])
  finally
    let g:CtrlXA_move = 0
  endtry
endfunction

function! Test_nonword_toggle_after_cursor() abort
  call s:buf(['val \[ y \]'])
  setlocal filetype=tex
  call s:keys("\<C-A>")
  call assert_equal('val \begin{equation} y \]', getline(1))
  set filetype=
endfunction

" Runner
let s:failed = 0
let s:out = []
for s:t in sort(filter(map(split(execute('function /^Test_'), "\n"), 'matchstr(v:val, ''Test_\w\+'')'), '!empty(v:val)'))
  let v:errors = []
  try
    execute 'call ' . s:t . '()'
  catch
    call add(v:errors, s:t . ': ' . v:exception . ' @ ' . v:throwpoint)
  endtry
  if empty(v:errors)
    call add(s:out, 'ok   ' . s:t)
  else
    let s:failed += 1
    call extend(s:out, ['FAIL ' . s:t] + v:errors)
  endif
endfor
call add(s:out, s:failed ? s:failed . ' test(s) failed' : 'all tests passed')
call writefile(s:out, $CTRLXA_TEST_LOG)
execute (s:failed ? 'cquit!' : 'qall!')
