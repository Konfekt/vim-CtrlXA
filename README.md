*CtrlXA*
=========

This Vim plug-in makes the key bindings `<Ctrl-X/A>` additionally cycle through keywords in lists such as `true/false`, `yes/no`, `set/unset` or `yesterday/today/tomorrow`.

These keywords are configurable by the variable `g:CtrlXA_Toggles` which defaults to

```vim
    let g:CtrlXA_Toggles = [
        \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'] ,
        \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'] ,
        \ ['on', 'off'] ,
        \ ['set', 'unset'] ,
        \ ['up', 'down'] ,
        \ ['is', 'isnot'] ,
        \ ['right', 'wrong'], ['Right', 'Wrong'], ['rightly', 'wrongly'], ['Rightly', 'Wrongly'] ,
        \ ['enable', 'disable'], ['enabled', 'disabled'], ['Enable', 'Disable'], ['Enabled', 'Disabled'] ,
        \ ['if', 'elseif', 'else', 'endif'],
        \ ]
```

There is also its buffer-local analogue, which allows for file-type specific
keyword cycles by, for example for (ba)sh scripts by  

```vim
autocmd FileType sh let b:CtrlXA_Toggles = [
    \ ['case', 'esac'], ['if', 'elif', 'fi'],
    \ ]               + g:CtrlXA_Toggles
```
This will

- inherit the keyword cycles of the global variable override the cycling, and
- give precedence to the keyword cycles of the local variable.

