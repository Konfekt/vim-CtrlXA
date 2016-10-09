if exists('g:loaded_CtrlXA')
  finish
endif

if !exists('g:CtrlXA_Toggles')
  let g:CtrlXA_Toggles = [
      \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'] ,
      \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'] ,
      \ ['is', 'isnot'] ,
      \ ['up', 'down'] ,
      \ ['right', 'wrong'], ['Right', 'Wrong'], ['rightly', 'wrongly'], ['Rightly', 'Wrongly'] ,
      \ ['enable', 'disable'], ['enabled', 'disabled'], ['Enable', 'Disable'], ['Enabled', 'Disabled'] ,
      \ ['if', 'elseif', 'else', 'endif'],
      \ ]
endif

set nrformats-=alpha

nnoremap <silent><expr> <Plug>(CtrlXA-CtrlA) CtrlXA#CtrlXA("\<C-A>")
nnoremap <silent><expr> <Plug>(CtrlXA-CtrlX) CtrlXA#CtrlXA("\<C-X>")

silent! nmap <unique>   <C-A>                <Plug>(CtrlXA-CtrlA)
silent! nmap <unique>   <C-X>                <Plug>(CtrlXA-CtrlX)

let g:loaded_CtrlXA = 1
