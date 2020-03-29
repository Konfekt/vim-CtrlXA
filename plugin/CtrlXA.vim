scriptencoding utf-8

" LICENCE PUBLIQUE RIEN À BRANLER
" Version 1, Mars 2009
"
" Copyright (C) 2009 Sam Hocevar
" 14 rue de Plaisance, 75014 Paris, France
"
" La copie et la distribution de copies exactes de cette licence sont
" autorisées, et toute modification est permise à condition de changer
" le nom de la licence.
"
" CONDITIONS DE COPIE, DISTRIBUTON ET MODIFICATION
" DE LA LICENCE PUBLIQUE RIEN À BRANLER
"
" 0. Faites ce que vous voulez, j'en ai RIEN À BRANLER.

if exists('g:loaded_CtrlXA') || &cp
  finish
endif
let g:loaded_CtrlXA = 1

let s:keepcpo         = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

if !exists('g:CtrlXA_Toggles')
  let g:CtrlXA_Toggles = [
      \ ['&&', '||'],
      \ ['+', '-'], ['++', '--'],
      \ ['==', '!='] , ['=~', '!~'],
      \ ['<', '>'], ['<=', '>='], ['>>', '<<'],
      \ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'], 
      \ ['remote', 'local', 'base'],
      \ ['ours', 'theirs'],
      \ ['true', 'false'],
      \ ['yes', 'no'],
      \ ['on', 'off'],
      \ ['up', 'down'],
      \ ['set', 'unset'],
      \ ['is', 'isnot'] ,
      \ ['enable', 'disable'],
      \ ['enabled', 'disabled'],
      \ ['maximum', 'minimum'],
      \ ['maximal', 'minimal'],
      \ ['maximize', 'minimize'],
      \ ['upper', 'lower'],
      \ ['top', 'bottom'],
      \ ['above', 'below'],
      \ ['forward', 'backward'],
      \ ['right', 'middle', 'left'],
      \ ['next', 'previous'],
      \ ['first', 'last'],
      \ ['begin', 'end'],
      \ ['before', 'after'],
      \ ['more', 'less'],
      \ ['fast', 'slow'],
      \ ['light', 'dark'],
      \ ['good', 'bad'],
      \ ['alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta', 'eta', 'theta', 'iota', 'kappa', 'lambda', 'mu', 'nu', 'xi', 'omikron', 'pi', 'rho', 'sigma', 'tau', 'upsilon', 'phi', 'chi', 'psi', 'omega'],
      \ ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z'],
      \ ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix'],
      \ ]
endif

augroup CtrlXA
  autocmd!
  autocmd FileType vim if !exists('b:CtrlXA_Toggles') |
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'else', 'elseif', 'endif'],
              \ ] + g:CtrlXA_Toggles | endif
  autocmd FileType sh if !exists('b:CtrlXA_Toggles') |
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'elif', 'else', 'fi'],
              \ ] + g:CtrlXA_Toggles | endif
  autocmd FileType gitrebase if !exists('b:CtrlXA_Toggles') |
              \ let b:CtrlXA_Toggles = [
              \ ['pick', 'fixup', 'squash', 'break', 'reword', 'edit', 'drop'],
              \ ] + g:CtrlXA_Toggles | endif
  autocmd FileType vim,sh,gitrebase let b:undo_ftplugin = 
        \ exists('b:undo_ftplugin') ? b:undo_ftplugin . '| unlet b:CtrlXA_Toggles' : 'unlet b:CtrlXA_Toggles'
augroup end

set nrformats-=alpha

nnoremap <silent><expr> <Plug>(CtrlXA-CtrlA)  CtrlXA#SingleInc("\<C-A>")
nnoremap <silent><expr> <Plug>(CtrlXA-CtrlX)  CtrlXA#SingleInc("\<C-X>")
xnoremap <silent>       <Plug>(CtrlXA-CtrlA)  :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlA)")<CR>
xnoremap <silent>       <Plug>(CtrlXA-CtrlX)  :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlX)")<CR>
xnoremap <silent>       <Plug>(CtrlXA-gCtrlA) :<C-u>call CtrlXA#SuccessiveInc("\<Plug>(CtrlXA-CtrlA)")<CR>
xnoremap <silent>       <Plug>(CtrlXA-gCtrlX) :<C-u>call CtrlXA#SuccessiveInc("\<Plug>(CtrlXA-CtrlX)")<CR>

silent! nmap <unique>   <C-A> <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>   <C-X> <Plug>(CtrlXA-CtrlX)
silent! xmap <unique>   <C-A> <Plug>(CtrlXA-CtrlA)
silent! xmap <unique>   <C-X> <Plug>(CtrlXA-CtrlX)
silent! xmap <silent>   g<C-A> <Plug>(CtrlXA-gCtrlA)
silent! xmap <silent>   g<C-X> <Plug>(CtrlXA-gCtrlX)

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
