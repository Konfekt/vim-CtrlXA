*CtrlXA*
=========

This Vim plug-in makes the key bindings `<Ctrl-X/A>` additionally cycle through keywords in lists such as `true/false`, `yes/no`, `set/unset` or `yesterday/today/tomorrow`.

These keywords are configurable by the variable `g:CtrlXA_Toggles` which defaults to

```vim
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
```

There is also its buffer-local analogue, which allows for file-type specific
keyword cycles by, for example

```vim
  autocmd FileType vim
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'else', 'elseif', 'endif'],
              \ ] + g:CtrlXA_Toggles
  autocmd FileType sh
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'elif', 'else', 'fi'],
              \ ] + g:CtrlXA_Toggles
  autocmd FileType tex
              \ let b:CtrlXA_Toggles = [
              \ ['final', 'draft'],
              \ ] + g:CtrlXA_Toggles
```
This will

- inherit the keyword cycles of the global variable override the cycling, and
- give precedence to the keyword cycles of the local variable.

The first two file-type specific keyword cycles are already included by default.
