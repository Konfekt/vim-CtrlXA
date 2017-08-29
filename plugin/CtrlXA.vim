if exists('g:loaded_CtrlXA')
  finish
endif

if !exists('g:CtrlXA_Toggles')
  let g:CtrlXA_Toggles = [
      \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'] ,
      \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'] ,
      \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'] ,
      \ ['set', 'unset'] ,
      \ ['is', 'isnot'] ,
      \ ['up', 'down'] ,
      \ ['before', 'after'] ,
      \ ['right', 'wrong'], ['Right', 'Wrong'], ['rightly', 'wrongly'], ['Rightly', 'Wrongly'] ,
      \ ['enable', 'disable'], ['Enable', 'Disable'], ['enabled', 'disabled'], ['Enabled', 'Disabled'] ,
      \ ]
endif

augroup CtrlXA
  autocmd FileType vim if !exists('b:CtrlXA_Toggles') |
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'else', 'elseif', 'endif'],
              \ ] + g:CtrlXA_Toggles | endif
  autocmd FileType sh if !exists('b:CtrlXA_Toggles') |
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'elif', 'else', 'fi'],
              \ ] + g:CtrlXA_Toggles | endif
augroup end

set nrformats-=alpha

nnoremap <silent><expr> <Plug>(CtrlXA-CtrlA) CtrlXA#CtrlXA("\<C-A>")
nnoremap <silent><expr> <Plug>(CtrlXA-CtrlX) CtrlXA#CtrlXA("\<C-X>")

silent! nmap <unique>   <C-A>                <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>   <C-X>                <Plug>(CtrlXA-CtrlX)

let g:loaded_CtrlXA = 1
