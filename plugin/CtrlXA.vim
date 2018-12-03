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
" 0. Faites ce que vous voulez, j’en ai RIEN À BRANLER.

if exists('g:loaded_CtrlXA') || &cp
  finish
endif
let g:loaded_CtrlXA = 1

let s:keepcpo         = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

if !exists('g:CtrlXA_Toggles')
  let g:CtrlXA_Toggles = [
      \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'],
      \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'],
      \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'],
      \ ['set', 'unset'],
      \ ['enable', 'disable'],
      \ ['is', 'isnot'] ,
      \ ['==', '!='] , ['<', '>'], ['<=', '>='], ['=~', '!~'],
      \ ['up', 'down'], ['Up', 'Down'] ,['UP', 'DOWN'],
      \ ['right', 'left'], ['Right', 'Left'], ['RIGHT', 'LEFT'] ,
      \ ['next', 'previous'],
      \ ['first', 'last'],
      \ ['before', 'after'],
      \ ['enabled', 'disabled'],
      \ ]
endif

set nrformats-=alpha

nnoremap <silent><expr> <Plug>(CtrlXA-CtrlA) CtrlXA#CtrlXA("\<C-A>")
nnoremap <silent><expr> <Plug>(CtrlXA-CtrlX) CtrlXA#CtrlXA("\<C-X>")

silent! nmap <unique>   <C-A>                <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>   <C-X>                <Plug>(CtrlXA-CtrlX)

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
