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

if !exists('g:CtrlXA_iskeyword')
    let g:CtrlXA_iskeyword = substitute(&g:iskeyword, '\v%(_,|_,)', '', '')
endif

if !exists('g:CtrlXA_move')
    let g:CtrlXA_move = 0
endif

if !exists('g:CtrlXA_localization')
    let g:CtrlXA_localization = 1
endif

if g:CtrlXA_localization
    augroup CtrlXA_Localization
        autocmd!
        " delay detection of &spelllang as long as possible
        autocmd BufNew,BufRead * autocmd BufWinEnter <buffer> if &l:spell | call CtrlXA#localization#init(&spelllang) | endif
        " detect changes of &spelllang
        if exists('##OptionSet')
            autocmd OptionSet spell     if v:option_new && !v:option_old | call CtrlXA#localization#init(&spelllang) | endif
            " &spelllang was already detected once on opening the buffer
            autocmd OptionSet spelllang if v:option_new !=# v:option_old && &l:spell | call CtrlXA#localization#init(&spelllang) | endif
        endif
    augroup end
    silent doautoall CtrlXA_Localization BufNew,BufRead
endif

set nrformats-=alpha

nnoremap <silent><expr> <Plug>(CtrlXA-CtrlA)  CtrlXA#SingleInc("\<C-A>")
nnoremap <silent><expr> <Plug>(CtrlXA-CtrlX)  CtrlXA#SingleInc("\<C-X>")
xnoremap <silent>       <Plug>(CtrlXA-CtrlA)  :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlA)", '0')<CR>
xnoremap <silent>       <Plug>(CtrlXA-CtrlX)  :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlX)", '0')<CR>
xnoremap <silent>       <Plug>(CtrlXA-gCtrlA) :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlA)", '1')<CR>
xnoremap <silent>       <Plug>(CtrlXA-gCtrlX) :<C-u>call CtrlXA#MultipleInc("\<Plug>(CtrlXA-CtrlX)", '1')<CR>

silent! nmap <unique>   <C-A> <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>   <C-X> <Plug>(CtrlXA-CtrlX)
silent! xmap <unique>   <C-A> <Plug>(CtrlXA-CtrlA)
silent! xmap <unique>   <C-X> <Plug>(CtrlXA-CtrlX)
silent! xmap <silent>   g<C-A> <Plug>(CtrlXA-gCtrlA)
silent! xmap <silent>   g<C-X> <Plug>(CtrlXA-gCtrlX)

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
