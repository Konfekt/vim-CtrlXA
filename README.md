*CtrlXA*
=========

This Vim plug-in makes the key bindings `<Ctrl-X/A>` additionally cycle through lists of keywords such as `true/false`, `yes/no`, `set/unset` or `yesterday/today/tomorrow`.
Useful, for example,

- for toggling settings in a configuration file, or
- for switching between `pick`, `squash`, `reword`, ... a `git` commit when rebasing.

# Configuration

These keywords are configurable by the variable `g:CtrlXA_Toggles` which defaults to

```vim
  let g:CtrlXA_Toggles = [
      \ ['&&', '||'],
      \ ['+', '-'], ['++', '--'],
      \ ['==', '!='] , ['=~', '!~'],
      \ ['<', '>'], ['<=', '>='], ['>>', '<<'],
      \ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'],
      \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'],
      \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'],
      \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'],
      \ ['up', 'down'], ['Up', 'Down'] ,['UP', 'DOWN'],
      \ ['set', 'unset'],
      \ ['is', 'isnot'] ,
      \ ['enable', 'disable'], ['Enable', 'Disable'],
      \ ['enabled', 'disabled'], ['Enabled', 'Disabled'],
      \ ['maximum', 'minimum'], ['Maximum', 'Minimum'],
      \ ['maximal', 'minimal'], ['Maximal', 'Minimal'],
      \ ['maximize', 'minimize'], ['Maximize', 'Minimize'],
      \ ['upper', 'lower'], ['Upper', 'Lower'],
      \ ['top', 'bottom'], ['Top', 'Bottom'],
      \ ['above', 'below'], ['Above', 'Below'],
      \ ['forward', 'backward'], ['Forward', 'Backward'],
      \ ['right', 'middle', 'left'], ['Right', 'Middle', 'Left'],
      \ ['next', 'previous'], ['Next', 'Previous'],
      \ ['first', 'last'], ['First', 'Last'],
      \ ['before', 'after'], ['Before', 'After'],
      \ ['more', 'less'], ['More', 'Less'],
      \ ['fast', 'slow'], ['Fast', 'Slow'],
      \ ['light', 'dark'] , ['Light', 'Dark'] ,
      \ ['alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta', 'eta', 'theta', 'iota', 'kappa', 'lambda', 'mu', 'nu', 'xi', 'omikron', 'pi', 'rho', 'sigma', 'tau', 'upsilon', 'phi', 'chi', 'psi', 'omega'],
      \ ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi', 'Omikron', 'Pi', 'Rho',  'Sigma', 'Tau', 'Upsilon', 'Phi', 'Chi', 'Psi', 'Omega'],
      \ ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z'],
      \ ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'X', 'Y', 'Z'],
      \ ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'viii', 'ix'],
      \ ['I', 'II', 'III', 'IV', 'V', 'VI', 'VIII', 'IX'],
      \ ]
```

If you prefer `i`, `v` and `I`, `V` to run through the letters of the Latin alphabet instead of the Roman numerals, move them from the last pair of arrays two the penultimate one.

There is also its buffer-local analogue, which allows for file-type specific
keyword cycles by, for example, as included by default,

```vim
  autocmd FileType gitrebase
              \ let b:CtrlXA_Toggles = [
              \ ['pick', 'fixup', 'squash', 'break', 'reword', 'edit', 'drop'],
              \ ] + g:CtrlXA_Toggles
  autocmd FileType vim
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'else', 'elseif', 'endif'],
              \ ] + g:CtrlXA_Toggles
  autocmd FileType sh
              \ let b:CtrlXA_Toggles = [
              \ ['if', 'elif', 'else', 'fi'],
              \ ] + g:CtrlXA_Toggles
```
This will

- include all keyword cycles of the global variable, and
- add (buffer-)local keyword cycles which have precedence over the global cycles.

There are many more toggles that could be useful, for example, to switch between the draft and final version of a `TeX` document, add:
```vim
  autocmd FileType tex
              \ let b:CtrlXA_Toggles = [
              \ ['final', 'draft'],
              \ ] + g:CtrlXA_Toggles
```

# Related Plug-ins

This plugin integrates with Tim Pope's [vim-speeddating](https://github.com/tpope/vim-speeddating) by adding to your `.vimrc` the lines

```vim
  nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
  nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
```

